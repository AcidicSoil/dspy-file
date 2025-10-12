<!-- path: ~/projects/dspy-file/AGENTS.md -->

# AGENTS.md — Tool Selection (Python)

## Pre-work: DSPy Build Checklist (for Codex)

**When to apply:** Use this section whenever generating or editing DSPy code, Signatures, Modules, Optimizers, Metrics, or RAG components for this repository.

**Canonical docs:** Signatures · Modules · Optimizers (MIPROv2, BootstrapFewShot) · Assertions · Metrics · RAG Tutorial

- Signatures: <https://dspy.ai/learn/programming/signatures/>
- Modules (Predict / ChainOfThought): <https://dspy.ai/learn/programming/modules/>
- Optimizers overview: <https://dspy.ai/learn/optimization/optimizers/>
- MIPROv2: <https://dspy.ai/api/optimizers/MIPROv2/>
- BootstrapFewShot: <https://dspy.ai/api/optimizers/BootstrapFewShot/>
- Assertions: <https://dspy.ai/learn/programming/7-assertions/>
- Metrics: <https://dspy.ai/learn/evaluation/metrics/>
- RAG tutorial: <https://dspy.ai/tutorials/rag/>

### Order of operations

1. **Define Signature(s)** — Encode task instructions in the Signature **docstring**; declare inputs via `dspy.InputField` and outputs via `dspy.OutputField`. (Docs: Signatures)
2. **Compose Modules** — Start with `dspy.Predict` (and `dspy.ChainOfThought` when needed) wired to your Signatures; keep modules small and composable. (Docs: Modules)
3. **Wire a Metric** — Choose a concrete metric for your task (e.g., `accuracy`/`F1` for classification; `nDCG@k` for ranking). (Docs: Metrics)
4. **Add Assertions** — Specify output schema/constraints and automatic retries to enforce shape/correctness. (Docs: Assertions)
5. **(Optional) Add Retrieval** — Introduce a retriever for task context and integrate into your program. (Docs: RAG tutorial)
6. **Optimize** — Run `BootstrapFewShot` (demos) → then `MIPROv2` (instructions + demos) to tune prompts/weights against your metric. (Docs: Optimizers/MIPROv2/BootstrapFewShot)

### Minimum rules Codex must follow

- **Instruction location:** Put all task instructions in the **Signature docstring**, not in ad‑hoc string prompts inside modules.
- **LM config timing:** Call `dspy.settings.configure(lm=...)` **before** constructing modules so compiles/optimizers see the correct LM.
- **Schema guard (example):** When producing ranked outputs, return a 3‑column Markdown table with headers: `prompt | score | rationale`. `score` must be a float in `[0, 1]`.
- **Metrics examples:** Prefer `accuracy`/`F1` for classification, `nDCG@k` for ranking; explain any custom metric in one line.
- **Tracing & persistence:** Enable tracing during iteration and persist optimized programs after compile.
- **Modularity:** Favor many small, composable modules; inject dependencies; avoid monolith modules.

### Long-form version (for humans)

See **docs/pre-work-dspy.md** for the expanded checklist and examples.

-------

When you need to call tools from the shell, use this rubric:

File & Text

-------

- Find files by file name: `fd`

- Find files with path name: `fd -p <file-path>`

- List files in a directory: `fd . <directory>`

- Find files with extension and pattern: `fd -e <extension> <pattern>`

- Find Text: `rg` (ripgrep)

- Find Code Structure: `ast-grep`

  - Common languages:

    - Python → `ast-grep --lang python -p '<pattern>'`

    - TypeScript → `ast-grep --lang ts -p '<pattern>'`

    - Bash → `ast-grep --lang bash -p '<pattern>'`

    - TSX (React) → `ast-grep --lang tsx -p '<pattern>'`

    - JavaScript → `ast-grep --lang js -p '<pattern>'`

    - Rust → `ast-grep --lang rust -p '<pattern>'`

    - JSON → `ast-grep --lang json -p '<pattern>'`

  - Prefer `ast-grep` over ripgrep/grep unless a plain-text search is explicitly requested.

- Select among matches: pipe to `fzf`

Data
----

- JSON: `jq`

- YAML/XML: `yq`

Python Tooling
--------------

- Package Management & Virtual Envs: `uv`
    (fast replacement for pip/pip-tools/virtualenv; use `uv pip install ...`, `uv run ...`)

- Linting & Formatting: `ruff`
    (linter + formatter; use `ruff check .`, `ruff format .`)

- Static Typing: `mypy`
    (type checking; use `mypy .`)

- Security: `bandit`
    (Python security linter; use `bandit -r .`)

- Testing: `pytest`
    (test runner; use `pytest -q`, `pytest -k <pattern>` to filter tests)

- Logging: `loguru`
    (runtime logging utility; import in code:)

        from loguru import logger
        logger.info("message")

Notes
-----

- Prefer `uv` for Python dependency and environment management instead of pip/venv/poetry/pip-tools.

MCP\_SERVERS
------------

- Use the `dspy_Docs` MCP server to get latest docs for DSPy usage.

- Use the `lmstudio_docs` MCP server to get latest docs for LM Studio API usage.

-------

## Proactive TODO/FIXME Annotations

Add TODO/FIXME notes as you work—don’t wait for a cleanup pass. Use them to mark: missing tests, unclear contracts, temporary workarounds, performance/security concerns, or places where design choices need follow-up.

**Format (single line):**

    TODO(scope|owner): short, imperative next step — why it matters [evidence: <source|cmd|ticket>]
    FIXME(scope|owner): what is broken — minimal repro or constraint [evidence: <source|cmd|ticket>]

- `scope|owner` is optional but encouraged (e.g., `ui`, `backend`, `deps`, or a handle like `@alice`).

- Keep it ≤120 chars when possible; link to issues for details.

**Examples (per language comment style):**

    # TODO(domain|@alice): replace naive parse with streaming parser — OOM on large inputs [evidence: profile.txt]
    # FIXME(api): 500 on empty payload — add validation + test [evidence: pytest -k empty_payload]


    // TODO(ui): debounce search — noisy network on fast typing [evidence: trace.log]
    // FIXME(auth|@bob): refresh token race — guard with mutex [evidence: unit test 'refresh-concurrency']


    # TODO(devex): switch to uv task for one-liners [evidence: uv run --help]

### Workflow (aligned with `todos.md`)

1. Gather evidence with the command you used during investigation and reference it in the note’s `[evidence: ...]`.

2. Add the TODO/FIXME in the code at the closest actionable location.

3. Commit with a concise message (e.g., `chore(todos): mark debounce + auth race with evidence`).

4. Before opening a PR, **find and group** all annotations as described in `todos.md` so maintainers can review them together.

### Discover & verify (standard commands)

- Plain-text sweep:

```bash
        rg -n "TODO|FIXME" | fzf
```

- Syntax-aware matches (prefer this when patterns are noisy):

```bash
        ast-grep --lang python -p "// TODO(_) (_) : (_)"
        ast-grep --lang ts -p "// FIXME(_) : (_)"
```

- File targeting:

```bash
        fd -e py -e ts | xargs rg -n "TODO|FIXME"
```

### PR checklist (copy into your PR template)

- Added TODO/FIXME where follow-ups are needed, with `[evidence: ...]`.

- Ran `rg`/`ast-grep` to list all annotations and grouped them per `todos.md` for reviewers.

- Linked or opened issues for any TODO expected to live >2 sprints.

### Retirement policy

- Convert TODO → issue if it will outlive the current PR.

- Remove the annotation when addressed; reference the commit/issue that resolves it.

-------

Rules for Best-Practice

-------

<file\_length\_and\_structure>

- Prefer maintainability signals over fixed line caps.

- Split when cognitive complexity > 15, cohesion drops, or fan-in/out spikes.

- Group by feature. Keep a file to one capability plus its close helpers.

- Use clear folder names and consistent naming.

</file\_length\_and\_structure>

<paradigm\_and\_style>

- Use OOP, functional, or data-oriented styles as idiomatic for the language.

- Favor composition. In OOP, model behavior behind small interfaces or protocols.

- Prefer pure functions and algebraic data types where natural.

</paradigm\_and\_style>

<single\_responsibility\_principle>

- Aim for one capability and its close helpers. Avoid micro-files.

- Enforce through module boundaries and public APIs, not line counts.

</single\_responsibility\_principle>

<modular\_design>

- Design modules to be interchangeable, testable, and isolated.

- Keep public surfaces small. Inject dependencies. Avoid tight coupling.

- Optimize for replaceability and test seams over premature reuse.

</modular\_design>

<roles\_by\_platform>

- UI stacks: ViewModel for UI logic, Manager for business logic, Coordinator for navigation and state flow.

- Backend and CLI: Service, Handler, Repository, Job, Workflow.

- Do not mix view code with business logic.

</roles\_by\_platform>

<function\_and\_class\_size>

- Size by behavior, not lines.

- Functions ≤ 20–30 cognitive steps.

- Split a class when it owns more than one lifecycle or more than one external dependency graph.

</function\_and\_class\_size>

<naming\_and\_readability>

- Use intention revealing names.

- Allow domain terms with qualifiers, for example `UserData`, `BillingInfo`.

- Forbid empty suffixes like `Helper` or `Utils` unless tightly scoped.

</naming\_and\_readability>

<scalability\_mindset>

- Build for extension points from day one, such as interfaces, protocols, and constructor injection.

- Prefer local duplication over unstable abstractions.

- Document contracts at module seams.

</scalability\_mindset>

<avoid\_god\_classes>

- Do not centralize everything in one file or class.

- Split into UI, State, Handlers, Networking, and other focused parts.

</avoid\_god\_classes>

<dependency\_injection>

- Backends: prefer constructor injection. Keep containers optional.

- Swift, Kotlin, TypeScript: use protocols or interfaces. Inject by initializer or factory.

- Limit global singletons. Provide test doubles at seams.

</dependency\_injection>

<testing>

- Require deterministic seams.

- Add contract tests for modules and layers.

- Use snapshot or golden tests for UI and renderers.

</testing>

<architecture\_boundaries>

- Feature oriented packaging with clear dependency direction: UI → app → domain → infra.

- Stabilize domain modules. Keep infra replaceable.

- Enforce imports with rules or module maps.

</architecture\_boundaries>

-------
