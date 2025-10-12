<!-- $1=description of prompts to create (purpose, triggers, filenames if given, examples, required behavior)  
$2=user-uploaded files (treated as content sources only; not parsed at runtime)  
$3=operating mode: 'script' | 'prompts' | 'passthrough'; default: 'script'  
$4=optional raw instruction text to emit verbatim when mode=passthrough  
$5=trigger in form /command-name (used to derive filename and prompt structure)  
$6=base filename derived from trigger by stripping leading slash, sanitized via slug rules  
$7=output directory path (e.g., $HOME/.codex/prompts) -->

**Codex Script Generator Prompt Template**

INPUTS

1. `$1` — free text describing the prompts to create (purpose, triggers, filenames if given, examples, required behavior).
2. `$2` — zero or more user-uploaded files. Treated as content sources at generation time only. The bash script does not parse uploads at runtime.
3. `$3` — one of `script` | `prompts` | `passthrough`. Default: `script`.
4. `$4` — optional raw instruction set to emit verbatim when `$3=passthrough`.

CORE BINDING: TRIGGER ↔ FILENAME

* Every prompt has a **Trigger** of the form `/command-name`.
* The prompt **filename MUST equal the trigger name without the leading slash**, plus `.md`.
  Example: `Trigger: /commit-message` ⇒ filename `commit-message.md`.
* The H1 title mirrors the command name in human-readable form. The title is not used for naming.
* The binding applies in all modes. In `prompts` and `passthrough`, headers and filenames must still match their triggers.

OPERATING MODES

* `$3=script` (default): Generate a Canvas bash script that writes prompt files to `$HOME/.codex/prompts` as currently specified.
* `$3=prompts`: Do not generate a bash script. Deliver the prompt files directly in Canvas as Markdown, one after another, each with a file header `# path: $HOME/.codex/prompts/<filename>.md`.
* `$3=passthrough`: Do not generate a bash script. Emit `$4` verbatim as a single prompt file. Requires a trigger input or derives `/instructions` if absent. Filename still bound to the trigger.

OUTPUT

* When `$3=script`: **Canvas bash script** (type `code/bash`) that creates files under `$HOME/.codex/prompts` (unchanged spec below).
* When `$3=prompts`: **Canvas document** containing the generated prompt files directly. Each file is emitted in full with this header line first:
  `# path: $HOME/.codex/prompts/<filename>.md`
  Then the file’s Markdown content per “FORMAT REQUIREMENTS FOR EACH PROMPT FILE.”
* When `$3=passthrough`: **Canvas document** with exactly one file:
  `# path: $HOME/.codex/prompts/<filename-from-trigger>.md`
  Followed by the literal `$4`.

OUTPUT (Canvas bash script)

* Begin with `set -euo pipefail` and `umask 022`. Assume POSIX shell on Linux/macOS/WSL. Resolve the home directory via `$HOME` only.
* Create `$HOME/.codex` and `$HOME/.codex/prompts` with `mkdir -p`.

Atomic build and move on the same filesystem:

* Use `$HOME/.codex` as the working root for atomic renames:
  * `WORKDIR="$HOME/.codex"; DEST="$WORKDIR/prompts"; TMPDIR="$WORKDIR/.tmp"`
  * `mkdir -p "$DEST" "$TMPDIR"`
  * `BUILD_DIR="$(mktemp -d "$TMPDIR/codex_prompts.XXXXXX")"`
  * `trap 'rm -rf "$BUILD_DIR"' EXIT INT TERM`
* Write every file into `$BUILD_DIR` using literal here-docs, then atomically `mv` each file into `$DEST`.

Filename generation and collision handling:

* Derive the **base filename from the trigger** by stripping the leading `/`. No other source may override this binding.
* Sanitize the base as a normalized slug:
  * Unicode NFKD and ASCII fold if available (`iconv`); lowercase; replace non-alphanumeric with `-`; collapse repeated `-`; trim leading/trailing `-`; cap base at 100 chars; avoid DOS reserved names (`con`, `prn`, `aux`, `nul`, `com1`–`com9`, `lpt1`–`lpt9`) by prefixing `prompt-`.
* Append `.md`.
* If a collision occurs, a new version is generated using sequential numbering (e.g., `filename-1.md`, `filename-2.md`). The exact handling depends on the system and should be specified in the implementation.
