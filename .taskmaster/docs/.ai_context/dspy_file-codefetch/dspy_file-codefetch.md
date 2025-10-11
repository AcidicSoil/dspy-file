Project Structure:
├── analyze_file_cli.py
├── data
├── file_analyzer.py
├── file_helpers.py
├── prompts
│   ├── gemini-cli_extension-command_prompt-template.md
│   ├── refactor_prompt_template.md
│   ├── __init__.py
│   └── __pycache__
│       └── __init__.cpython-311.pyc
├── refactor_analyzer.py
├── signatures.py
├── __init__.py
└── __pycache__
    ├── analyze_file_cli.cpython-311.pyc
    ├── file_analyzer.cpython-311.pyc
    ├── file_helpers.cpython-311.pyc
    ├── refactor_analyzer.cpython-311.pyc
    ├── signatures.cpython-311.pyc
    └── __init__.cpython-311.pyc


analyze_file_cli.py
```
1 | # analyze_file_cli.py - command line entry point for DSPy file analyzer
2 | from __future__ import annotations
3 | 
4 | import argparse
5 | import os
6 | import subprocess
7 | import sys
8 | from enum import Enum
9 | from urllib import error as urlerror
10 | from urllib import request
11 | from pathlib import Path
12 | from typing import Any, Final
13 | 
14 | import dspy
15 | from dotenv import load_dotenv
16 | 
17 | from .file_analyzer import FileTeachingAnalyzer
18 | from .file_helpers import collect_source_paths, read_file_content, render_prediction
19 | from .prompts import PromptTemplate, list_bundled_prompts, load_prompt_text
20 | from .refactor_analyzer import FileRefactorAnalyzer
21 | 
22 | try:  # dspy depends on litellm; guard in case import path changes.
23 |     from litellm.exceptions import InternalServerError as LiteLLMInternalServerError
24 | except Exception:  # pragma: no cover - defensive fallback if litellm API shifts
25 |     LiteLLMInternalServerError = None  # type: ignore[assignment]
26 | 
27 | 
28 | class Provider(str, Enum):
29 |     """Supported language model providers."""
30 | 
31 |     OLLAMA = "ollama"
32 |     OPENAI = "openai"
33 |     LMSTUDIO = "lmstudio"
34 | 
35 |     @property
36 |     def is_openai_compatible(self) -> bool:
37 |         return self in {Provider.OPENAI, Provider.LMSTUDIO}
38 | 
39 | 
40 | DEFAULT_PROVIDER: Final[Provider] = Provider.OLLAMA
41 | DEFAULT_OUTPUT_DIR = Path(__file__).parent / "data"
42 | DEFAULT_OLLAMA_MODEL = "hf.co/unsloth/Qwen3-4B-Instruct-2507-GGUF:Q6_K_XL"
43 | DEFAULT_LMSTUDIO_MODEL = "qwen3-4b-instruct-2507@q6_k_xl"
44 | DEFAULT_OPENAI_MODEL = "gpt-5"
45 | OLLAMA_BASE_URL = "http://localhost:11434"
46 | LMSTUDIO_BASE_URL = "http://localhost:1234/v1"
47 | 
48 | PROVIDER_DEFAULTS: Final[dict[Provider, dict[str, Any]]] = {
49 |     Provider.OLLAMA: {"model": DEFAULT_OLLAMA_MODEL, "api_base": OLLAMA_BASE_URL},
50 |     Provider.LMSTUDIO: {"model": DEFAULT_LMSTUDIO_MODEL, "api_base": LMSTUDIO_BASE_URL},
51 |     Provider.OPENAI: {"model": DEFAULT_OPENAI_MODEL, "api_base": None},
52 | }
53 | 
54 | 
55 | def _resolve_option(cli_value: str | None, env_var: str, default: str | None = None) -> str | None:
56 |     """Return the CLI value if provided, otherwise fall back to env or default."""
57 | 
58 |     if cli_value is not None:
59 |         return cli_value
60 |     env_value = os.getenv(env_var)
61 |     if env_value not in ("", None):
62 |         return env_value
63 |     return default
64 | 
65 | 
66 | def _normalize_model_name(provider: Provider, raw_model: str) -> str:
67 |     """Attach the appropriate provider prefix to the model identifier."""
68 | 
69 |     if provider is Provider.OLLAMA:
70 |         return raw_model if raw_model.startswith("ollama_chat/") else f"ollama_chat/{raw_model}"
71 | 
72 |     if raw_model.startswith("openai/"):
73 |         return raw_model
74 |     return f"openai/{raw_model}"
75 | 
76 | 
77 | def configure_model(
78 |     provider: Provider,
79 |     model_name: str,
80 |     *,
81 |     api_base: str | None,
82 |     api_key: str | None,
83 | ) -> None:
84 |     """Configure DSPy with the selected provider and model."""
85 | 
86 |     lm_kwargs: dict[str, Any] = {"streaming": False, "cache": False}
87 |     if provider is Provider.OLLAMA:
88 |         lm_kwargs["api_base"] = api_base or OLLAMA_BASE_URL
89 |         # Ollama's OpenAI compatibility ignores api_key, so pass an empty string.
90 |         lm_kwargs["api_key"] = ""
91 |     else:
92 |         if api_base:
93 |             lm_kwargs["api_base"] = api_base
94 |         if api_key:
95 |             lm_kwargs["api_key"] = api_key
96 | 
97 |     identifier = _normalize_model_name(provider, model_name)
98 |     lm = dspy.LM(identifier, **lm_kwargs)
99 |     dspy.configure(lm=lm)
100 |     provider_label = "LM Studio" if provider is Provider.LMSTUDIO else provider.value
101 |     suffix = f" via {api_base}" if provider.is_openai_compatible and api_base else ""
102 |     print(f"Configured DSPy LM ({provider_label}): {model_name}{suffix}")
103 | 
104 | 
105 | class ProviderConnectivityError(RuntimeError):
106 |     """Raised when a provider cannot be reached before running analysis."""
107 | 
108 | 
109 | def _probe_openai_provider(api_base: str, api_key: str | None, *, timeout: float = 3.0) -> None:
110 |     """Make a lightweight request against an OpenAI-compatible endpoint."""
111 | 
112 |     endpoint = api_base.rstrip("/") + "/models"
113 |     headers = {"Authorization": f"Bearer {api_key or ''}"}
114 |     request_obj = request.Request(endpoint, headers=headers, method="GET")
115 | 
116 |     try:
117 |         with request.urlopen(request_obj, timeout=timeout):
118 |             return
119 |     except urlerror.HTTPError as exc:
120 |         raise ProviderConnectivityError(
121 |             f"Endpoint {endpoint} responded with HTTP {exc.code}: {exc.reason}"
122 |         ) from exc
123 |     except urlerror.URLError as exc:
124 |         reason = getattr(exc, "reason", exc)
125 |         raise ProviderConnectivityError(f"Failed to reach {endpoint}: {reason}") from exc
126 | 
127 | 
128 | def stop_ollama_model(model_name: str) -> None:
129 |     """Stop the Ollama model to free server resources."""
130 | 
131 |     try:
132 |         subprocess.run(
133 |             ["ollama", "stop", model_name],
134 |             check=True,
135 |             capture_output=True,
136 |         )
137 |     except subprocess.CalledProcessError as exc:  # pragma: no cover - warn only
138 |         print(f"Warning: Failed to stop model {model_name}: {exc}")
139 |     except FileNotFoundError:
140 |         print("Warning: ollama command not found while attempting to stop the model.")
141 | 
142 | 
143 | class AnalysisMode(str, Enum):
144 |     TEACH = "teach"
145 |     REFACTOR = "refactor"
146 | 
147 |     @property
148 |     def render_key(self) -> str:
149 |         return self.value
150 | 
151 |     @property
152 |     def output_description(self) -> str:
153 |         return "teaching report" if self is AnalysisMode.TEACH else "refactor template"
154 | 
155 |     @property
156 |     def file_suffix(self) -> str:
157 |         return ".teaching.md" if self is AnalysisMode.TEACH else ".refactor.md"
158 | 
159 | 
160 | def _prompt_for_template_selection(prompts: list[PromptTemplate]) -> PromptTemplate:
161 |     while True:
162 |         print("Available prompt templates:")
163 |         for idx, template in enumerate(prompts, 1):
164 |             print(f"  [{idx}] {template.name} ({template.path.name})")
165 |         try:
166 |             choice = input(f"Select a template [1-{len(prompts)}] (default 1): ")
167 |         except EOFError:
168 |             print("No selection provided; using first template.")
169 |             return prompts[0]
170 | 
171 |         stripped = choice.strip()
172 |         if not stripped:
173 |             return prompts[0]
174 |         if stripped.isdigit():
175 |             idx = int(stripped)
176 |             if 1 <= idx <= len(prompts):
177 |                 return prompts[idx - 1]
178 |         print(f"Please enter a number between 1 and {len(prompts)}.")
179 | 
180 | 
181 | def _resolve_prompt_text(prompt_arg: str | None) -> str:
182 |     if prompt_arg:
183 |         return load_prompt_text(prompt_arg)
184 | 
185 |     prompts = list_bundled_prompts()
186 |     if not prompts:
187 |         raise FileNotFoundError("No prompt templates found in prompts directory.")
188 |     if len(prompts) == 1:
189 |         return prompts[0].path.read_text(encoding="utf-8")
190 | 
191 |     selected = _prompt_for_template_selection(prompts)
192 |     return selected.path.read_text(encoding="utf-8")
193 | 
194 | 
195 | def _write_output(
196 |     source_path: Path,
197 |     content: str,
198 |     *,
199 |     root: Path | None = None,
200 |     output_dir: Path = DEFAULT_OUTPUT_DIR,
201 |     suffix: str = ".teaching.md",
202 | ) -> Path:
203 |     """Persist analyzer output under the data directory with de-duplicated file names."""
204 | 
205 |     output_dir.mkdir(parents=True, exist_ok=True)
206 | 
207 |     try:
208 |         relative_path = source_path.relative_to(root) if root else Path(source_path.name)
209 |     except ValueError:
210 |         relative_path = Path(source_path.name)
211 | 
212 |     slug_parts = [part.replace("/", "_") for part in relative_path.with_suffix("").parts]
213 |     slug = "__".join(slug_parts) if slug_parts else source_path.stem
214 |     base_name = f"{slug}{suffix}"
215 |     output_path = output_dir / base_name
216 | 
217 |     counter = 1
218 |     while output_path.exists():
219 |         stem = Path(base_name).stem
220 |         extension = Path(base_name).suffix
221 |         output_path = output_dir / f"{stem}-{counter}{extension}"
222 |         counter += 1
223 | 
224 |     if not content.endswith("\n"):
225 |         content = content + "\n"
226 |     output_path.write_text(content, encoding="utf-8")
227 |     return output_path
228 | 
229 | 
230 | 
231 | def _confirm_analyze(path: Path) -> bool:
232 |     """Prompt the user for confirmation before analyzing a file."""
233 | 
234 |     prompt = f"Analyze {path}? [Y/n]: "
235 |     while True:
236 |         try:
237 |             response = input(prompt)
238 |         except EOFError:
239 |             print("No input received; skipping.")
240 |             return False
241 | 
242 |         normalized = response.strip().lower()
243 |         if normalized in {"", "y", "yes"}:
244 |             return True
245 |         if normalized in {"n", "no"}:
246 |             return False
247 |         print("Please answer 'y' or 'n'.")
248 | 
249 | 
250 | def build_parser() -> argparse.ArgumentParser:
251 |     parser = argparse.ArgumentParser(
252 |         description="Analyze a single file using DSPy signatures and modules",
253 |     )
254 |     parser.add_argument("path", help="Path to the file to analyze")
255 |     parser.add_argument(
256 |         "--provider",
257 |         choices=[provider.value for provider in Provider],
258 |         default=None,
259 |         help=(
260 |             "Language model provider to use (env: DSPYTEACH_PROVIDER). "
261 |             "Choose from 'ollama', 'lmstudio', or 'openai'."
262 |         ),
263 |     )
264 |     parser.add_argument(
265 |         "--model",
266 |         dest="model_name",
267 |         default=None,
268 |         help=(
269 |             "Override the model identifier for the selected provider "
270 |             "(env: DSPYTEACH_MODEL)."
271 |         ),
272 |     )
273 |     parser.add_argument(
274 |         "--api-base",
275 |         dest="api_base",
276 |         default=None,
277 |         help=(
278 |             "Override the OpenAI-compatible API base URL "
279 |             "(env: DSPYTEACH_API_BASE)."
280 |         ),
281 |     )
282 |     parser.add_argument(
283 |         "--api-key",
284 |         dest="api_key",
285 |         default=None,
286 |         help=(
287 |             "API key for OpenAI-compatible providers (env: DSPYTEACH_API_KEY). "
288 |             "Falls back to OPENAI_API_KEY for the OpenAI provider."
289 |         ),
290 |     )
291 |     parser.add_argument(
292 |         "--keep-provider-alive",
293 |         action="store_true",
294 |         dest="keep_provider_alive",
295 |         help="Skip stopping the local Ollama model when execution completes.",
296 |     )
297 |     parser.add_argument(
298 |         "-r",
299 |         "--raw",
300 |         action="store_true",
301 |         help="Print raw DSPy prediction repr instead of formatted text",
302 |     )
303 |     parser.add_argument(
304 |         "-m",
305 |         "--mode",
306 |         choices=[mode.value for mode in AnalysisMode],
307 |         default=AnalysisMode.TEACH.value,
308 |         help="Select output mode: teaching report (default) or refactor prompt template.",
309 |     )
310 |     parser.add_argument(
311 |         "-nr",
312 |         "--non-recursive",
313 |         action="store_true",
314 |         help="When path is a directory, only analyze files in the top-level directory",
315 |     )
316 |     parser.add_argument(
317 |         "-g",
318 |         "--glob",
319 |         action="append",
320 |         dest="include_globs",
321 |         default=None,
322 |         help=(
323 |             "Optional glob pattern(s) applied relative to the directory. Repeat to combine."
324 |         ),
325 |     )
326 |     parser.add_argument(
327 |         "-p",
328 |         "--prompt",
329 |         dest="prompt",
330 |         default=None,
331 |         help=(
332 |             "Prompt template to use in refactor mode. Provide a name, bundled filename, or path."
333 |         ),
334 |     )
335 |     parser.add_argument(
336 |         "-i",
337 |         "--confirm-each",
338 |         "--interactive",
339 |         action="store_true",
340 |         dest="confirm_each",
341 |         help="Prompt for confirmation before analyzing each file.",
342 |     )
343 |     parser.add_argument(
344 |         "-ed",
345 |         "--exclude-dirs",
346 |         action="append",
347 |         dest="exclude_dirs",
348 |         default=None,
349 |         help=(
350 |             "Comma-separated relative directory paths to skip entirely when scanning."
351 |         ),
352 |     )
353 |     parser.add_argument(
354 |         "-o",
355 |         "--output-dir",
356 |         dest="output_dir",
357 |         default=None,
358 |         help=(
359 |             "Directory to write teaching reports into (default: module data directory)."
360 |         ),
361 |     )
362 |     return parser
363 | 
364 | 
365 | def analyze_path(
366 |     path: str,
367 |     *,
368 |     raw: bool,
369 |     recursive: bool,
370 |     include_globs: list[str] | None,
371 |     confirm_each: bool,
372 |     exclude_dirs: list[str] | None,
373 |     output_dir: Path,
374 |     mode: AnalysisMode,
375 |     prompt_text: str | None = None,
376 | ) -> int:
377 |     """Run the DSPy pipeline and render results to stdout for one or many files."""
378 | 
379 |     resolved = Path(path).expanduser().resolve()
380 |     targets = collect_source_paths(
381 |         path,
382 |         recursive=recursive,
383 |         include_globs=include_globs,
384 |         exclude_dirs=exclude_dirs,
385 |     )
386 | 
387 |     if not targets:
388 |         print(f"No files found under {resolved}")
389 |         return 0
390 | 
391 |     analyzer: dspy.Module
392 |     if mode is AnalysisMode.TEACH:
393 |         analyzer = FileTeachingAnalyzer()
394 |     else:
395 |         analyzer = FileRefactorAnalyzer(template_text=prompt_text)
396 |     root: Path | None = resolved if resolved.is_dir() else None
397 | 
398 |     exit_code = 0
399 |     for target in targets:
400 |         if confirm_each and not _confirm_analyze(target):
401 |             print(f"Skipping {target} at user request.")
402 |             continue
403 | 
404 |         try:
405 |             content = read_file_content(target)
406 |         except (FileNotFoundError, UnicodeDecodeError) as exc:
407 |             print(f"Skipping {target}: {exc}")
408 |             exit_code = 1
409 |             continue
410 | 
411 |         print(f"\n=== Analyzing {target} ===")
412 |         prediction = analyzer(file_path=str(target), file_content=content)
413 | 
414 |         if raw:
415 |             output_text = repr(prediction)
416 |             print(output_text)
417 |         else:
418 |             output_text = render_prediction(prediction, mode=mode.render_key)
419 |             print(output_text, end="")
420 | 
421 |         output_path = _write_output(
422 |             target,
423 |             output_text,
424 |             root=root,
425 |             output_dir=output_dir,
426 |             suffix=mode.file_suffix,
427 |         )
428 |         print(f"Saved {mode.output_description} to {output_path}")
429 | 
430 |     return exit_code
431 | 
432 | 
433 | def main(argv: list[str] | None = None) -> int:
434 |     load_dotenv()
435 | 
436 |     parser = build_parser()
437 |     args = parser.parse_args(argv)
438 | 
439 |     provider_value = _resolve_option(args.provider, "DSPYTEACH_PROVIDER", DEFAULT_PROVIDER.value)
440 |     try:
441 |         provider = Provider(provider_value)
442 |     except ValueError:  # pragma: no cover - argparse handles this
443 |         valid = ", ".join(p.value for p in Provider)
444 |         parser.error(f"Unsupported provider '{provider_value}'. Choose from: {valid}.")
445 | 
446 |     defaults = PROVIDER_DEFAULTS[provider]
447 |     model_name = _resolve_option(args.model_name, "DSPYTEACH_MODEL", defaults["model"])
448 |     api_base_default = defaults.get("api_base")
449 |     api_base = _resolve_option(args.api_base, "DSPYTEACH_API_BASE", api_base_default)
450 |     api_key = _resolve_option(args.api_key, "DSPYTEACH_API_KEY", None)
451 |     if provider is Provider.OPENAI and not api_key:
452 |         api_key = os.getenv("OPENAI_API_KEY")
453 |     if provider is Provider.LMSTUDIO and not api_key:
454 |         api_key = "lm-studio"
455 | 
456 |     if provider is Provider.LMSTUDIO and api_base:
457 |         try:
458 |             _probe_openai_provider(api_base, api_key)
459 |         except ProviderConnectivityError as exc:
460 |             print("Unable to reach the LM Studio server before starting analysis.")
461 |             print(f"Details: {exc}")
462 |             print(
463 |                 "Start LM Studio's local API server (Developer tab → Start Server or "
464 |                 "`lms server start`) and re-run, or pass --api-base to match the running port."
465 |             )
466 |             return 1
467 | 
468 |     configure_model(provider, model_name, api_base=api_base, api_key=api_key)
469 |     stop_model: str | None = model_name if provider is Provider.OLLAMA else None
470 | 
471 |     exit_code = 0
472 |     try:
473 |         analysis_mode = AnalysisMode(args.mode)
474 |         prompt_text: str | None = None
475 |         if analysis_mode is AnalysisMode.REFACTOR:
476 |             try:
477 |                 prompt_text = _resolve_prompt_text(args.prompt)
478 |             except (FileNotFoundError, ValueError) as exc:
479 |                 print(f"Error resolving prompt: {exc}")
480 |                 return 2
481 |         elif args.prompt:
482 |             print("Warning: --prompt is ignored outside refactor mode.")
483 |         output_dir = (
484 |             Path(args.output_dir).expanduser().resolve()
485 |             if args.output_dir
486 |             else DEFAULT_OUTPUT_DIR
487 |         )
488 |         print(f"Writing {analysis_mode.output_description}s to {output_dir}")
489 |         exclude_dirs = None
490 |         if args.exclude_dirs:
491 |             parsed: list[str] = []
492 |             for entry in args.exclude_dirs:
493 |                 parsed.extend(
494 |                     segment.strip()
495 |                     for segment in entry.split(",")
496 |                     if segment.strip()
497 |                 )
498 |             exclude_dirs = parsed or None
499 |         try:
500 |             exit_code = analyze_path(
501 |                 args.path,
502 |                 raw=args.raw,
503 |                 recursive=not args.non_recursive,
504 |                 include_globs=args.include_globs,
505 |                 confirm_each=args.confirm_each,
506 |                 exclude_dirs=exclude_dirs,
507 |                 output_dir=output_dir,
508 |                 mode=analysis_mode,
509 |                 prompt_text=prompt_text,
510 |             )
511 |         except Exception as exc:
512 |             if LiteLLMInternalServerError and isinstance(exc, LiteLLMInternalServerError):
513 |                 message = str(exc)
514 |                 if exc.__cause__:
515 |                     message = f"{message} (cause: {exc.__cause__})"
516 |                 print("Model request failed while generating the report.")
517 |                 print(f"Details: {message}")
518 |                 if provider is Provider.LMSTUDIO:
519 |                     print(
520 |                         "Confirm the LM Studio server is running and reachable at "
521 |                         f"{api_base}."
522 |                     )
523 |                 return 1
524 |             raise
525 |     except (FileNotFoundError, IsADirectoryError) as exc:
526 |         parser.print_usage(sys.stderr)
527 |         print(f"{parser.prog}: error: {exc}", file=sys.stderr)
528 |         exit_code = 2
529 |     except KeyboardInterrupt:
530 |         exit_code = 1
531 |     finally:
532 |         if provider is Provider.OLLAMA and not args.keep_provider_alive and stop_model:
533 |             stop_ollama_model(stop_model)
534 | 
535 |     return exit_code
536 | 
537 | 
538 | if __name__ == "__main__":  # pragma: no cover - CLI entry point
539 |     sys.exit(main())
```

file_analyzer.py
```
1 | # file_analyzer.py - DSPy module deriving a learning brief from a single file
2 | from __future__ import annotations
3 | 
4 | import json
5 | import re
6 | from collections.abc import Iterable, Mapping
7 | from dataclasses import dataclass, field
8 | from typing import Any
9 | 
10 | import dspy
11 | 
12 | from .signatures import FileOverview, TeachingPoints, TeachingReport
13 | 
14 | 
15 | @dataclass
16 | class TeachingConfig:
17 |     section_bullet_prefix: str = "- "
18 |     overview_max_tokens: int = 2000
19 |     teachings_max_tokens: int = 2000
20 |     report_max_tokens: int = 2000
21 |     temperature: float | None = 0.3
22 |     top_p: float | None = None
23 |     n_completions: int | None = None
24 |     extra_lm_kwargs: dict[str, Any] = field(default_factory=dict)
25 |     report_refine_attempts: int = 3
26 |     report_reward_threshold: float = 0.8
27 |     report_min_word_count: int = 400
28 |     report_max_word_count: int = 2800
29 |     report_target_ratio: float = 0.5
30 |     report_soft_cap_ratio: float = 0.8
31 | 
32 |     def lm_args_for(self, scope: str) -> dict[str, Any]:
33 |         """Return per-module LM kwargs without mutating shared config."""
34 |         scope_tokens = {
35 |             "overview": self.overview_max_tokens,
36 |             "teachings": self.teachings_max_tokens,
37 |             "report": self.report_max_tokens,
38 |         }
39 | 
40 |         kwargs: dict[str, Any] = {**self.extra_lm_kwargs}
41 |         kwargs["max_tokens"] = scope_tokens.get(scope, self.report_max_tokens)
42 | 
43 |         if self.temperature is not None:
44 |             kwargs["temperature"] = self.temperature
45 |         if self.top_p is not None:
46 |             kwargs["top_p"] = self.top_p
47 |         if self.n_completions is not None:
48 |             kwargs["n"] = self.n_completions
49 | 
50 |         return kwargs
51 | 
52 | 
53 | def _fallback_list(message: str) -> list[str]:
54 |     return [message]
55 | 
56 | 
57 | def _ensure_text(value: str | None, fallback: str) -> str:
58 |     if value and value.strip():
59 |         return value
60 |     return fallback
61 | 
62 | 
63 | def _ensure_list(
64 |     values: Iterable[str] | None,
65 |     fallback: str,
66 |     *,
67 |     strip_entries: bool = True,
68 |     field_name: str | None = None,
69 | ) -> list[str]:
70 |     coerced, used_fallback = _coerce_iterable(values, strip_entries=strip_entries)
71 | 
72 |     if coerced:
73 |         if used_fallback and field_name:
74 |             _structured_output_notice(field_name)
75 |         return coerced
76 | 
77 |     if used_fallback and field_name:
78 |         _structured_output_notice(field_name)
79 | 
80 |     return _fallback_list(fallback)
81 | 
82 | 
83 | def _clean_list(
84 |     values: Iterable[str] | None,
85 |     *,
86 |     strip_entries: bool = True,
87 |     field_name: str | None = None,
88 | ) -> list[str]:
89 |     if not values:
90 |         return []
91 | 
92 |     coerced, used_fallback = _coerce_iterable(values, strip_entries=strip_entries)
93 | 
94 |     if used_fallback and field_name:
95 |         _structured_output_notice(field_name)
96 | 
97 |     return coerced
98 | 
99 | 
100 | _STRUCTURED_NOTICE_CACHE: set[str] = set()
101 | 
102 | 
103 | def _structured_output_notice(field: str) -> None:
104 |     if field in _STRUCTURED_NOTICE_CACHE:
105 |         return
106 |     _STRUCTURED_NOTICE_CACHE.add(field)
107 |     print(
108 |         f"Structured output fallback applied for '{field}'. Parsed textual response."
109 |     )
110 | 
111 | 
112 | _LEADING_MARKER_PATTERN = re.compile(r"^[\s\-\*•·\u2022\d\.\)\(]+")
113 | 
114 | 
115 | def _coerce_iterable(
116 |     values: Iterable[str] | None,
117 |     *,
118 |     strip_entries: bool,
119 | ) -> tuple[list[str], bool]:
120 |     if values is None:
121 |         return [], False
122 | 
123 |     if isinstance(values, str):
124 |         return _coerce_string(values, strip_entries=strip_entries), True
125 | 
126 |     if isinstance(values, Mapping):
127 |         items: list[str] = []
128 |         for key, val in values.items():
129 |             key_text = str(key).strip()
130 |             val_text = str(val).strip()
131 |             combined = f"{key_text}: {val_text}" if val_text else key_text
132 |             candidate = combined.rstrip() if not strip_entries else combined.strip()
133 |             if candidate:
134 |                 items.append(candidate if strip_entries else candidate.rstrip())
135 |         return items, True
136 | 
137 |     if isinstance(values, Iterable):
138 |         cleaned: list[str] = []
139 |         used_fallback = not isinstance(values, (list, tuple, set))
140 |         for entry in values:
141 |             if entry is None:
142 |                 continue
143 |             if isinstance(entry, str):
144 |                 candidate = entry.rstrip() if not strip_entries else entry.strip()
145 |             else:
146 |                 candidate = str(entry).strip()
147 |             if strip_entries:
148 |                 candidate = _LEADING_MARKER_PATTERN.sub("", candidate).strip()
149 |             if candidate:
150 |                 cleaned.append(candidate if strip_entries else candidate.rstrip())
151 |         return cleaned, used_fallback
152 | 
153 |     return _coerce_string(str(values), strip_entries=strip_entries), True
154 | 
155 | 
156 | def _coerce_string(value: str, *, strip_entries: bool) -> list[str]:
157 |     text = value.strip()
158 |     if not text:
159 |         return []
160 | 
161 |     try:
162 |         parsed = json.loads(text)
163 |     except json.JSONDecodeError:
164 |         parsed = None
165 | 
166 |     if isinstance(parsed, list):
167 |         coerced: list[str] = []
168 |         for item in parsed:
169 |             candidate = str(item)
170 |             candidate = candidate.rstrip() if not strip_entries else candidate.strip()
171 |             if strip_entries:
172 |                 candidate = _LEADING_MARKER_PATTERN.sub("", candidate).strip()
173 |             if candidate:
174 |                 coerced.append(candidate if strip_entries else candidate.rstrip())
175 |         if coerced:
176 |             return coerced
177 |     elif isinstance(parsed, Mapping):
178 |         mapped: list[str] = []
179 |         for key, val in parsed.items():
180 |             key_text = str(key).strip()
181 |             val_text = str(val).strip()
182 |             candidate = f"{key_text}: {val_text}" if val_text else key_text
183 |             candidate = candidate.rstrip() if not strip_entries else candidate.strip()
184 |             if candidate:
185 |                 mapped.append(candidate if strip_entries else candidate.rstrip())
186 |         if mapped:
187 |             return mapped
188 | 
189 |     lines = value.replace("\r", "\n").split("\n")
190 |     normalized: list[str] = []
191 |     for raw_line in lines:
192 |         candidate = raw_line.rstrip() if not strip_entries else raw_line.strip()
193 |         if strip_entries:
194 |             candidate = _LEADING_MARKER_PATTERN.sub("", candidate).strip()
195 |         if candidate:
196 |             normalized.append(candidate if strip_entries else candidate.rstrip())
197 | 
198 |     if len(normalized) <= 1:
199 |         delimiters = [";", "•", "·", " | "]
200 |         for delimiter in delimiters:
201 |             if delimiter in value:
202 |                 parts = [part.strip() for part in value.split(delimiter) if part.strip()]
203 |                 if parts:
204 |                     return [
205 |                         _LEADING_MARKER_PATTERN.sub("", part).strip()
206 |                         if strip_entries
207 |                         else part.rstrip()
208 |                     ]
209 | 
210 |     return normalized
211 | 
212 | 
213 | def _with_prefix(items: Iterable[str], prefix: str) -> list[str]:
214 |     if not prefix:
215 |         return [item for item in items if item.strip()]
216 | 
217 |     prefix_char = prefix.strip()[:1] if prefix.strip() else ""
218 |     prefixed: list[str] = []
219 | 
220 |     for item in items:
221 |         stripped = item.strip()
222 |         if not stripped:
223 |             continue
224 |         if prefix_char and stripped.startswith(prefix_char):
225 |             prefixed.append(stripped)
226 |         else:
227 |             prefixed.append(f"{prefix}{stripped}")
228 | 
229 |     return prefixed
230 | 
231 | 
232 | def _word_count(text: str) -> int:
233 |     return len(text.split())
234 | 
235 | 
236 | class FileTeachingAnalyzer(dspy.Module):
237 |     """Generate a teaching-focused summary using DSPy chains of thought."""
238 | 
239 |     def __init__(self, config: TeachingConfig | None = None) -> None:
240 |         super().__init__()
241 |         self.config = config or TeachingConfig()
242 | 
243 |         overview_signature = FileOverview.with_instructions(
244 |             """
245 |             Craft a thorough multi-section narrative that orients a senior learner.
246 |             Describe the file's purpose, high-level architecture, main responsibilities,
247 |             how data flows through each part, and any noteworthy patterns or dependencies.
248 |             Aim for around five paragraphs that highlight why each section exists and
249 |             how it contributes to the overall behavior.
250 |             """
251 |         )
252 | 
253 |         teachings_signature = TeachingPoints.with_instructions(
254 |             """
255 |             Extract every insight the learner would need for deep comprehension.
256 |             Provide generous bullet lists (>=6 items when possible) covering concepts,
257 |             workflows, pitfalls, integration guidance, and areas needing validation.
258 |             When referencing identifiers, include the role they play.
259 |             Prefer complete sentences that can stand alone in teaching materials.
260 |             """
261 |         )
262 | 
263 |         report_signature = TeachingReport.with_instructions(
264 |             """
265 |             Assemble a long-form teaching brief in Markdown. Include:
266 |             - An opening context block with file path and intent.
267 |             - Headed sections for overview, section walkthrough, key concepts, workflows,
268 |               pitfalls, integration notes, tests/validation, and references.
269 |             - Expand each bullet into full sentences or sub-bullets to help instructors
270 |               speak to the content without the source file open.
271 |             Ensure the report comfortably exceeds 400 words when source material allows.
272 |             """
273 |         )
274 | 
275 |         self.overview = dspy.ChainOfThought(
276 |             overview_signature, **self.config.lm_args_for("overview")
277 |         )
278 |         self.teachings = dspy.ChainOfThought(
279 |             teachings_signature, **self.config.lm_args_for("teachings")
280 |         )
281 | 
282 |         base_report = dspy.ChainOfThought(
283 |             report_signature, **self.config.lm_args_for("report")
284 |         )
285 | 
286 |         if self.config.report_refine_attempts > 1:
287 | 
288 |             def report_length_reward(args: dict[str, Any], pred: dspy.Prediction) -> float:
289 |                 text = getattr(pred, "report_markdown", "") or ""
290 |                 words = _word_count(text)
291 |                 source_words = max(int(args.get("source_word_count", 0)), 0)
292 | 
293 |                 dynamic_target = max(
294 |                     self.config.report_min_word_count,
295 |                     int(source_words * self.config.report_target_ratio),
296 |                 )
297 | 
298 |                 soft_cap = max(
299 |                     dynamic_target + 150,
300 |                     int(source_words * self.config.report_soft_cap_ratio),
301 |                 )
302 | 
303 |                 dynamic_cap = min(self.config.report_max_word_count, soft_cap)
304 | 
305 |                 if words < dynamic_target:
306 |                     return 0.0
307 | 
308 |                 if words >= dynamic_cap:
309 |                     return 1.0
310 | 
311 |                 span = max(dynamic_cap - dynamic_target, 1)
312 |                 progress = (words - dynamic_target) / span
313 |                 return min(1.0, 0.6 + 0.4 * progress)
314 | 
315 |             self.report = dspy.Refine(
316 |                 module=base_report,
317 |                 N=self.config.report_refine_attempts,
318 |                 reward_fn=report_length_reward,
319 |                 threshold=self.config.report_reward_threshold,
320 |             )
321 |         else:
322 |             self.report = base_report
323 | 
324 |     def forward(self, *, file_path: str, file_content: str) -> dspy.Prediction:
325 |         overview_pred = self.overview(
326 |             file_path=file_path,
327 |             file_content=file_content,
328 |         )
329 | 
330 |         teaching_pred = self.teachings(
331 |             file_content=file_content,
332 |         )
333 | 
334 |         overview_text = _ensure_text(
335 |             getattr(overview_pred, "overview", None),
336 |             "Overview unavailable.",
337 |         )
338 | 
339 |         section_notes = _with_prefix(
340 |             _ensure_list(
341 |                 getattr(overview_pred, "section_notes", None),
342 |                 "Section-level breakdown unavailable.",
343 |                 field_name="section_notes",
344 |             ),
345 |             self.config.section_bullet_prefix,
346 |         )
347 | 
348 |         key_concepts = _with_prefix(
349 |             _ensure_list(
350 |                 getattr(teaching_pred, "key_concepts", None),
351 |                 "Clarify core concepts manually.",
352 |                 field_name="key_concepts",
353 |             ),
354 |             self.config.section_bullet_prefix,
355 |         )
356 | 
357 |         practical_steps = _with_prefix(
358 |             _ensure_list(
359 |                 getattr(teaching_pred, "practical_steps", None),
360 |                 "Document workflow steps explicitly.",
361 |                 field_name="practical_steps",
362 |             ),
363 |             self.config.section_bullet_prefix,
364 |         )
365 | 
366 |         pitfalls = _with_prefix(
367 |             _ensure_list(
368 |                 getattr(teaching_pred, "pitfalls", None),
369 |                 "No pitfalls identified; review source for potential caveats.",
370 |                 field_name="pitfalls",
371 |             ),
372 |             self.config.section_bullet_prefix,
373 |         )
374 | 
375 |         references = _with_prefix(
376 |             _clean_list(
377 |                 getattr(teaching_pred, "references", None),
378 |                 field_name="references",
379 |             ),
380 |             self.config.section_bullet_prefix,
381 |         )
382 | 
383 |         usage_patterns = _with_prefix(
384 |             _ensure_list(
385 |                 getattr(teaching_pred, "usage_patterns", None),
386 |                 "Document how this file is applied in real flows.",
387 |                 field_name="usage_patterns",
388 |             ),
389 |             self.config.section_bullet_prefix,
390 |         )
391 | 
392 |         key_functions = _with_prefix(
393 |             _ensure_list(
394 |                 getattr(teaching_pred, "key_functions", None),
395 |                 "Identify primary interfaces and responsibilities manually.",
396 |                 field_name="key_functions",
397 |             ),
398 |             self.config.section_bullet_prefix,
399 |         )
400 | 
401 |         code_walkthroughs = _ensure_list(
402 |             getattr(teaching_pred, "code_walkthroughs", None),
403 |             "Prepare short code walkthroughs for learners.",
404 |             strip_entries=False,
405 |             field_name="code_walkthroughs",
406 |         )
407 | 
408 |         integration_notes = _with_prefix(
409 |             _ensure_list(
410 |                 getattr(teaching_pred, "integration_notes", None),
411 |                 "Outline integration touchpoints manually.",
412 |                 field_name="integration_notes",
413 |             ),
414 |             self.config.section_bullet_prefix,
415 |         )
416 | 
417 |         testing_focus = _with_prefix(
418 |             _ensure_list(
419 |                 getattr(teaching_pred, "testing_focus", None),
420 |                 "Highlight testing priorities in a follow-up review.",
421 |                 field_name="testing_focus",
422 |             ),
423 |             self.config.section_bullet_prefix,
424 |         )
425 | 
426 |         source_word_count = _word_count(file_content)
427 | 
428 |         report_pred = self.report(
429 |             file_path=file_path,
430 |             overview=overview_text,
431 |             section_notes=section_notes,
432 |             key_concepts=key_concepts,
433 |             practical_steps=practical_steps,
434 |             pitfalls=pitfalls,
435 |             references=references,
436 |             usage_patterns=usage_patterns,
437 |             key_functions=key_functions,
438 |             code_walkthroughs=code_walkthroughs,
439 |             integration_notes=integration_notes,
440 |             testing_focus=testing_focus,
441 |             source_word_count=source_word_count,
442 |         )
443 | 
444 |         return dspy.Prediction(
445 |             overview=overview_pred,
446 |             teachings=teaching_pred,
447 |             report=report_pred,
448 |             structured={
449 |                 "overview_text": overview_text,
450 |                 "section_notes": section_notes,
451 |                 "key_concepts": key_concepts,
452 |                 "practical_steps": practical_steps,
453 |                 "pitfalls": pitfalls,
454 |                 "references": references,
455 |                 "usage_patterns": usage_patterns,
456 |                 "key_functions": key_functions,
457 |                 "code_walkthroughs": code_walkthroughs,
458 |                 "integration_notes": integration_notes,
459 |                 "testing_focus": testing_focus,
460 |             },
461 |         )
```

file_helpers.py
```
1 | # file_helpers.py - utilities for loading files and presenting DSPy results
2 | from __future__ import annotations
3 | 
4 | import os
5 | from pathlib import Path
6 | from typing import Iterable
7 | 
8 | import dspy
9 | 
10 | 
11 | # Directories that should never be traversed when collecting source files.
12 | ALWAYS_IGNORED_DIRS: set[str] = {
13 |     "__pycache__",
14 |     ".git",
15 |     ".hg",
16 |     ".mypy_cache",
17 |     ".pytest_cache",
18 |     ".ruff_cache",
19 |     ".svn",
20 |     ".tox",
21 |     ".venv",
22 |     ".vscode",
23 |     ".idea",
24 |     "venv",
25 | }
26 | 
27 | # Individual files or suffixes that should never be analyzed.
28 | ALWAYS_IGNORED_FILES: set[str] = {".DS_Store"}
29 | ALWAYS_IGNORED_SUFFIXES: set[str] = {".pyc", ".pyo"}
30 | 
31 | 
32 | def _normalize_relative_parts(value: Path | str) -> tuple[str, ...]:
33 |     """Return normalized path segments for relative comparisons."""
34 | 
35 |     text = str(value).replace("\\", "/").strip()
36 |     if not text:
37 |         return ()
38 |     text = text.strip("/")
39 |     if not text or text in {"", "."}:
40 |         return ()
41 | 
42 |     parts: list[str] = []
43 |     for segment in text.split("/"):
44 |         if not segment or segment == ".":
45 |             continue
46 |         if segment == "..":
47 |             if parts:
48 |                 parts.pop()
49 |             continue
50 |         parts.append(segment)
51 |     return tuple(parts)
52 | 
53 | 
54 | def _matches_excluded_parts(
55 |     parts: tuple[str, ...],
56 |     excluded_parts: set[tuple[str, ...]],
57 | ) -> bool:
58 |     for excluded in excluded_parts:
59 |         if len(parts) < len(excluded):
60 |             continue
61 |         if parts[: len(excluded)] == excluded:
62 |             return True
63 |     return False
64 | 
65 | 
66 | def _normalize_excluded_dirs(exclude_dirs: Iterable[str] | None) -> set[tuple[str, ...]]:
67 |     """Normalize raw exclude strings into comparable path segments."""
68 | 
69 |     normalized: set[tuple[str, ...]] = set()
70 |     if not exclude_dirs:
71 |         return normalized
72 | 
73 |     for raw in exclude_dirs:
74 |         cleaned = raw.strip()
75 |         if not cleaned:
76 |             continue
77 |         parts = _normalize_relative_parts(cleaned)
78 |         if parts:
79 |             normalized.add(parts)
80 |     return normalized
81 | 
82 | 
83 | def _relative_path_is_excluded(
84 |     relative_path: Path,
85 |     excluded_parts: set[tuple[str, ...]],
86 | ) -> bool:
87 |     if not excluded_parts:
88 |         return False
89 |     parts = _normalize_relative_parts(relative_path)
90 |     if not parts:
91 |         return False
92 |     return _matches_excluded_parts(parts, excluded_parts)
93 | 
94 | 
95 | def resolve_file_path(raw_path: str) -> Path:
96 |     """Expand user shortcuts and validate that the target file exists."""
97 | 
98 |     path = Path(raw_path).expanduser().resolve()
99 |     if not path.exists():
100 |         raise FileNotFoundError(f"File not found: {path}")
101 |     if not path.is_file():
102 |         raise IsADirectoryError(f"Expected a file path but received: {path}")
103 |     return path
104 | 
105 | 
106 | def _pattern_targets_hidden(pattern: str) -> bool:
107 |     pattern = pattern.strip()
108 |     if not pattern:
109 |         return False
110 |     normalized = pattern[2:] if pattern.startswith("./") else pattern
111 |     return normalized.startswith(".") or "/." in normalized
112 | 
113 | 
114 | def _should_skip_dir(name: str, *, ignore_hidden: bool) -> bool:
115 |     if name in ALWAYS_IGNORED_DIRS:
116 |         return True
117 |     if ignore_hidden and name.startswith("."):
118 |         return True
119 |     return False
120 | 
121 | 
122 | def _should_skip_file(name: str, *, ignore_hidden: bool) -> bool:
123 |     if name in ALWAYS_IGNORED_FILES:
124 |         return True
125 |     if any(name.endswith(suffix) for suffix in ALWAYS_IGNORED_SUFFIXES):
126 |         return True
127 |     if ignore_hidden and name.startswith("."):
128 |         return True
129 |     return False
130 | 
131 | 
132 | def _should_skip_relative_path(
133 |     relative_path: Path,
134 |     *,
135 |     ignore_hidden: bool,
136 |     excluded_parts: set[tuple[str, ...]] | None = None,
137 | ) -> bool:
138 |     parts = _normalize_relative_parts(relative_path)
139 |     if not parts:
140 |         return False
141 | 
142 |     if excluded_parts and _matches_excluded_parts(parts, excluded_parts):
143 |         return True
144 | 
145 |     # Check intermediate directories for ignore rules.
146 |     for segment in parts[:-1]:
147 |         if segment in ALWAYS_IGNORED_DIRS:
148 |             return True
149 |         if ignore_hidden and segment.startswith("."):
150 |             return True
151 | 
152 |     return _should_skip_file(parts[-1], ignore_hidden=ignore_hidden)
153 | 
154 | 
155 | def collect_source_paths(
156 |     raw_path: str,
157 |     *,
158 |     recursive: bool = True,
159 |     include_globs: Iterable[str] | None = None,
160 |     exclude_dirs: Iterable[str] | None = None,
161 | ) -> list[Path]:
162 |     """Resolve a single file or directory into an ordered list of file paths."""
163 | 
164 |     path = Path(raw_path).expanduser().resolve()
165 |     if not path.exists():
166 |         raise FileNotFoundError(f"Target not found: {path}")
167 | 
168 |     if path.is_file():
169 |         return [path]
170 | 
171 |     if not path.is_dir():
172 |         raise IsADirectoryError(f"Expected file or directory path but received: {path}")
173 | 
174 |     candidates: set[Path] = set()
175 |     patterns = list(include_globs) if include_globs else None
176 |     allow_hidden = any(_pattern_targets_hidden(pattern) for pattern in patterns) if patterns else False
177 |     ignore_hidden = not allow_hidden
178 |     excluded_parts = _normalize_excluded_dirs(exclude_dirs)
179 | 
180 |     if patterns:
181 |         for pattern in patterns:
182 |             for candidate in path.glob(pattern):
183 |                 if not candidate.is_file():
184 |                     continue
185 | 
186 |                 relative_candidate = candidate.relative_to(path)
187 |                 if _should_skip_relative_path(
188 |                     relative_candidate,
189 |                     ignore_hidden=ignore_hidden,
190 |                     excluded_parts=excluded_parts,
191 |                 ):
192 |                     continue
193 | 
194 |                 candidates.add(candidate.resolve())
195 |     else:
196 |         for root_dir, dirnames, filenames in os.walk(path):
197 |             root_path = Path(root_dir)
198 |             relative_root = Path(".") if root_path == path else root_path.relative_to(path)
199 | 
200 |             if not recursive and root_path != path:
201 |                 dirnames[:] = []
202 |                 continue
203 | 
204 |             if _relative_path_is_excluded(relative_root, excluded_parts):
205 |                 dirnames[:] = []
206 |                 continue
207 | 
208 |             dirnames[:] = sorted(
209 |                 name
210 |                 for name in dirnames
211 |                 if not _should_skip_dir(name, ignore_hidden=ignore_hidden)
212 |                 and not _relative_path_is_excluded(relative_root / name, excluded_parts)
213 |             )
214 | 
215 |             for filename in filenames:
216 |                 candidate = root_path / filename
217 |                 relative_candidate = candidate.relative_to(path)
218 | 
219 |                 if _should_skip_relative_path(
220 |                     relative_candidate,
221 |                     ignore_hidden=ignore_hidden,
222 |                     excluded_parts=excluded_parts,
223 |                 ):
224 |                     continue
225 | 
226 |                 candidates.add(candidate.resolve())
227 | 
228 |     return sorted(candidates)
229 | 
230 | 
231 | def _strip_front_matter(text: str) -> str:
232 |     if not text.startswith("---"):
233 |         return text
234 |     end_idx = text.find("\n---", 3)
235 |     if end_idx == -1:
236 |         return text
237 |     return text[end_idx + 4 :]
238 | 
239 | 
240 | def _trim_to_first_heading(text: str) -> str:
241 |     lines = text.splitlines()
242 |     for idx, line in enumerate(lines):
243 |         if line.lstrip().startswith("#"):
244 |             return "\n".join(lines[idx:])
245 |     return text
246 | 
247 | 
248 | def read_file_content(path: Path) -> str:
249 |     """Read file contents using utf-8 and fall back to latin-1 if needed."""
250 | 
251 |     try:
252 |         raw = path.read_text(encoding="utf-8")
253 |     except UnicodeDecodeError:
254 |         raw = path.read_text(encoding="latin-1")
255 | 
256 |     cleaned = _strip_front_matter(raw)
257 |     cleaned = _trim_to_first_heading(cleaned)
258 |     return cleaned
259 | 
260 | 
261 | def _ensure_trailing_newline(text: str) -> str:
262 |     return text if text.endswith("\n") else text + "\n"
263 | 
264 | 
265 | def _teaching_output(result: dspy.Prediction) -> str:
266 |     try:
267 |         report = result.report.report_markdown  # type: ignore[attr-defined]
268 |     except AttributeError:
269 |         report = "# Teaching Brief\n\nThe DSPy pipeline did not produce a report."
270 |     return _ensure_trailing_newline(report)
271 | 
272 | 
273 | def _refactor_output(result: dspy.Prediction) -> str:
274 |     template = getattr(result, "template_markdown", None)
275 |     if not template:
276 |         template = getattr(getattr(result, "template", None), "template_markdown", None)
277 |     text = str(template).strip() if template else ""
278 |     if not text:
279 |         text = "# Refactor Template\n\nTemplate generation failed."
280 |     return _ensure_trailing_newline(text)
281 | 
282 | 
283 | def render_prediction(result: dspy.Prediction, *, mode: str = "teach") -> str:
284 |     """Return the generated markdown for the selected analysis mode."""
285 | 
286 |     if mode == "refactor":
287 |         return _refactor_output(result)
288 |     return _teaching_output(result)
```

refactor_analyzer.py
```
1 | # refactor_analyzer.py - DSPy module that prepares per-file refactor prompt templates
2 | from __future__ import annotations
3 | 
4 | from dataclasses import dataclass, field
5 | from functools import lru_cache
6 | from typing import Any
7 | 
8 | import dspy
9 | 
10 | from .prompts import load_prompt_text
11 | 
12 | 
13 | class RefactorTemplateSignature(dspy.Signature):
14 |     """Generate a reusable refactor prompt template from a source document."""
15 | 
16 |     file_path: str = dspy.InputField(desc="Path to the source file for context")
17 |     file_content: str = dspy.InputField(desc="Full raw text of the file")
18 | 
19 |     template_markdown: str = dspy.OutputField(
20 |         desc="Markdown template with numbered placeholders and section scaffolding"
21 |     )
22 | 
23 | 
24 | @dataclass
25 | class RefactorTeachingConfig:
26 |     """Configuration for the refactor template generator."""
27 | 
28 |     max_tokens: int = 8000
29 |     temperature: float | None = 0.7
30 |     top_p: float | None = 0.80
31 |     n_completions: int | None = None
32 |     extra_lm_kwargs: dict[str, Any] = field(default_factory=dict)
33 | 
34 |     def lm_kwargs(self) -> dict[str, Any]:
35 |         """Return the language model arguments for DSPy modules."""
36 | 
37 |         kwargs: dict[str, Any] = {**self.extra_lm_kwargs, "max_tokens": self.max_tokens}
38 |         if self.temperature is not None:
39 |             kwargs["temperature"] = self.temperature
40 |         if self.top_p is not None:
41 |             kwargs["top_p"] = self.top_p
42 |         if self.n_completions is not None:
43 |             kwargs["n"] = self.n_completions
44 |         return kwargs
45 | 
46 | 
47 | @lru_cache(maxsize=1)
48 | def _load_default_template() -> str:
49 |     """Load the bundled refactor prompt template text."""
50 | 
51 |     return load_prompt_text(None).strip()
52 | 
53 | 
54 | def _ensure_template_text(value: str | None) -> str:
55 |     if value and value.strip():
56 |         text = value.rstrip()
57 |     else:
58 |         text = "# Refactor Template\n\nTemplate generation failed."
59 |     return text if text.endswith("\n") else text + "\n"
60 | 
61 | 
62 | class FileRefactorAnalyzer(dspy.Module):
63 |     """Generate a refactor-focused prompt template for a single file."""
64 | 
65 |     def __init__(
66 |         self,
67 |         *,
68 |         template_text: str | None = None,
69 |         config: RefactorTeachingConfig | None = None,
70 |     ) -> None:
71 |         super().__init__()
72 |         self.config = config or RefactorTeachingConfig()
73 |         instructions = template_text.strip() if template_text else _load_default_template()
74 |         signature = RefactorTemplateSignature.with_instructions(instructions)
75 |         self.generator = dspy.ChainOfThought(signature, **self.config.lm_kwargs())
76 | 
77 |     def forward(self, *, file_path: str, file_content: str) -> dspy.Prediction:
78 |         raw_prediction = self.generator(
79 |             file_path=file_path,
80 |             file_content=file_content,
81 |         )
82 | 
83 |         template_markdown = _ensure_template_text(
84 |             getattr(raw_prediction, "template_markdown", None)
85 |         )
86 | 
87 |         return dspy.Prediction(
88 |             template=raw_prediction,
89 |             template_markdown=template_markdown,
90 |         )
```

signatures.py
```
1 | # signatures.py - DSPy signatures focused on extracting teachings from a single file
2 | from typing import List
3 | 
4 | import dspy
5 | 
6 | 
7 | class FileOverview(dspy.Signature):
8 |     """Summarize the file structure and core narrative with room for depth."""
9 | 
10 |     file_path: str = dspy.InputField(desc="Path to the source file")
11 |     file_content: str = dspy.InputField(desc="Full raw text of the file")
12 | 
13 |     overview: str = dspy.OutputField(
14 |         desc="Detailed multi-section overview (aim for 4-6 paragraphs capturing scope, intent, and flow)"
15 |     )
16 |     section_notes: List[str] = dspy.OutputField(
17 |         desc="Comprehensive bullet list summarizing each major section, include headings when possible"
18 |     )
19 | 
20 | 
21 | class TeachingPoints(dspy.Signature):
22 |     """Extract teachable concepts, workflows, and cautions."""
23 | 
24 |     file_content: str = dspy.InputField(desc="Full raw text of the file")
25 | 
26 |     key_concepts: List[str] = dspy.OutputField(desc="Essential ideas learners must retain")
27 |     practical_steps: List[str] = dspy.OutputField(desc="Actionable steps or workflows described")
28 |     pitfalls: List[str] = dspy.OutputField(desc="Warnings, gotchas, or misconceptions to avoid")
29 |     references: List[str] = dspy.OutputField(desc="Follow-up links, exercises, or related material")
30 |     usage_patterns: List[str] = dspy.OutputField(
31 |         desc="Common usage patterns, scenarios, or recipes that appear"
32 |     )
33 |     key_functions: List[str] = dspy.OutputField(
34 |         desc="Important functions, classes, or hooks with quick rationale"
35 |     )
36 |     code_walkthroughs: List[str] = dspy.OutputField(
37 |         desc="Short code snippets or walkthroughs learners should discuss"
38 |     )
39 |     integration_notes: List[str] = dspy.OutputField(
40 |         desc="Guidance for connecting this file with the rest of the system"
41 |     )
42 |     testing_focus: List[str] = dspy.OutputField(
43 |         desc="Areas that need tests, validations, or monitoring"
44 |     )
45 | 
46 | 
47 | class TeachingReport(dspy.Signature):
48 |     """Compose a concise but comprehensive markdown teaching brief."""
49 | 
50 |     file_path: str = dspy.InputField(desc="Original file path for context header")
51 |     overview: str = dspy.InputField()
52 |     section_notes: List[str] = dspy.InputField()
53 |     key_concepts: List[str] = dspy.InputField()
54 |     practical_steps: List[str] = dspy.InputField()
55 |     pitfalls: List[str] = dspy.InputField()
56 |     references: List[str] = dspy.InputField()
57 |     usage_patterns: List[str] = dspy.InputField()
58 |     key_functions: List[str] = dspy.InputField()
59 |     code_walkthroughs: List[str] = dspy.InputField()
60 |     integration_notes: List[str] = dspy.InputField()
61 |     testing_focus: List[str] = dspy.InputField()
62 | 
63 |     report_markdown: str = dspy.OutputField(desc="Final markdown document capturing key teachings")
```

__init__.py
```
1 | """DSPy file teaching analyzer package."""
2 | 
3 | from .file_analyzer import FileTeachingAnalyzer, TeachingConfig
4 | from .refactor_analyzer import FileRefactorAnalyzer, RefactorTeachingConfig
5 | 
6 | __all__ = [
7 |     "FileTeachingAnalyzer",
8 |     "TeachingConfig",
9 |     "FileRefactorAnalyzer",
10 |     "RefactorTeachingConfig",
11 | ]
```
