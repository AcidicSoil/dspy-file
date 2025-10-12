## You asked

rank-root-prompts\_w-context.toml

File

How could I improve this further, so that based on the user's query/question, it will infer the stage of development of the user and list out all the prompts in order they should be executed to expedite the development cycle

---

## ChatGPT Replied

Thought for 8s

Output: Revised prompt spec (TOML snippet) | Constraints: single best-fit solution that infers a development stage from the user’s query + codebase signals, then outputs an ordered “run list” of prompts to accelerate the cycle | Acceptance criteria: defines a clear stage taxonomy, deterministic inference rules, mapping from stage→prompt categories, tie-break scoring, and a final ordered list with reasons

Primary answer

Below is a drop-in upgrade to your existing `/prompts:rank-prompts-with-code-context` spec that (1) infers the user’s development stage from both the query and repo signals, and (2) emits an execution plan—an ordered list of prompts to run with short rationales. It extends sections A–D you already have by adding E–G and tightening Acceptance. (Edits are additive and compatible with your current flow.) rank-root-prompts\_w-context

    # Command: /prompts:rank-prompts-with-code-context
    # Usage: /prompts:rank-prompts-with-code-context "example user question" "~/.codex/prompts" "0.6"

    # Args:
    # - {{query}}: user question to match against prompts
    # - {{path}}: prompt directory to search (defaults to ~/.codex/prompts if omitted)
    # - {{threshold}}: minimum match score (0–1) to consider a prompt relevant

    prompt = """
    Goal: Given {{query}}, first understand the current codebase (cwd), then 1) infer the user's DEVELOPMENT STAGE, 2) rank prompts from {{path}} (or "~/.codex/prompts"), and 3) output an EXECUTION PLAN—an ordered list of prompts to run that will most rapidly advance the development cycle.

    Defaults:
    * If {{path}} is empty or not provided, use "~/.codex/prompts".

    Do this, in order:

    A) Gather codebase context from the current working directory (recursively):
    1. Recursively scan the cwd, ignoring common vendor/build folders: node_modules, .git, dist, build, .next, .venv, venv, target, bin, obj, **pycache**, .cache, vendor.
    2. Summarize:
       * Primary languages/frameworks.
       * Key domains (CLI, web API, data/ML, infra/IaC, etc.).
       * Notable entities: service names, packages, common commands, config keys.
       * Any AI/prompt patterns (JSON schemas, system prompts, RAG configs).
       * Delivery signals: tests present? CI config? release tags? docs site?
    3. Produce a concise “Codebase Summary” (≤10 bullets).

    !{pwd}
    !{printf "Scanning codebase…\n"}
    !{find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/dist/*" -not -path "*/build/*" -not -path "*/.next/*" -not -path "*/.venv/*" -not -path "*/venv/*" -not -path "*/target/*" -not -path "*/bin/*" -not -path "*/obj/*" -not -path "*/**pycache**/*" -not -path "*/.cache/*" -not -path "*/vendor/*" | head -n 2000}

    B) Collect candidate prompts (then analyze intents):
    4) Determine prompt directory: if a user-supplied {{path}} is provided, use it; otherwise "~/.codex/prompts".
    5) Recursively enumerate likely prompt definitions: extensions [.md, .toml, .yaml, .yml, .json].
    6) For each file, parse text and extract a one-sentence INTENT and DOMAIN. Also detect CATEGORY tags if present in the file name or front matter (e.g., "scaffold", "impl", "refactor", "test", "docs", "release").

    !{PROMPT_DIR="${PATH_ARG:-~/.codex/prompts}"; echo "Using prompt dir: $PROMPT_DIR"}
    !{find "${PATH_ARG:-~/.codex/prompts}" -type f \( -iname "*.md" -o -iname "*.toml" -o -iname "*.yaml" -o -iname "*.yml" -o -iname "*.json" \) | head -n 2000}

    C) Rank with blended relevance:
    7) Form a “Matching Query” by blending {{query}} + the Codebase Summary.
    8) Compute a semantic relevance score in [0,1] between each file’s (intent+domain+category) and the Matching Query.
    9) Keep the top K=25 by score for later sequencing.

    D) Thresholded table:
    10) If any file has score ≥ {{threshold}}, prepare a table with columns exactly: filename | description | match_score (rounded to 2 decimals), sorted desc. Keep this for the final output.
    11) Otherwise, output exactly: "No prompt exceeds threshold {{threshold}} — recommend creating a new prompt."

    E) Infer DEVELOPMENT STAGE:
    12) Define stages and indicative signals (use both {{query}} terms and repo signals):
       * IDEATION: query mentions “ideas”, “architecture”, “capabilities”; repo sparse; no tests/CI.
       * SCAFFOLD: presence of manifest (package.json/pyproject), few modules; query asks “create project”, “bootstrap”.
       * IMPLEMENTATION: multiple modules present; query mentions “add feature”, “integrate X”.
       * REFACTOR: query includes “refactor”, “clean up”, “performance”, “modularize”; lints/TODOs present.
       * TESTING: tests folder or frameworks detected; query mentions “write tests”, “coverage”.
       * DOCS: README/docs site present or missing; query mentions “document”, “examples”.
       * RELEASE: changelog, version bump, CI/CD pipeline; query mentions “publish”, “release”, “package”.
    13) Score each stage in [0,1] using a simple additive heuristic:
       * Query keywords (+0.2 each, cap +0.6).
       * Repo signals (+0.15 each: tests/, ci config, changelog, docs, version tag).
       * Time-in-project hints: many files + no tests → IMPLEMENTATION bias (+0.1).
       * Choose the stage with the highest score; if tie, prefer the later stage in the sequence that is supported by repo signals.

    F) Map stage → PROMPT CATEGORIES and SEQUENCING:
    14) Define a canonical order per stage (earlier items run first):
       * IDEATION: (design/ideate) → (requirements) → (architecture) → (scaffold)
       * SCAFFOLD: (scaffold) → (conventions/linters) → (ci-setup)
       * IMPLEMENTATION: (spec-orient) → (impl) → (review) → (refactor-candidates)
       * REFACTOR: (hotspots) → (refactor) → (perf) → (review)
       * TESTING: (test-plan) → (gen-tests) → (fix-flakes) → (coverage)
       * DOCS: (doc-plan) → (examples) → (api-docs) → (site-sync)
       * RELEASE: (versioning) → (changelog) → (pack/publish) → (post-release-checks)
    15) For the top-K prompts, assign each a CATEGORY (from filename/front matter; if missing, infer from intent). Compute a SEQUENCE SCORE:
       * seq_score = 0.6*match_score + 0.3*stage_category_fit + 0.1*dependency_bonus
       * stage_category_fit: 1.0 if category matches the current step, 0.5 if adjacent step, 0 otherwise.
       * dependency_bonus: +0.1 if filename hints it unblocks another selected prompt (e.g., “plan” before “impl”).
    16) Sort by the canonical step order first, then by seq_score desc within each step. Keep the top 1–3 per step.

    G) Output EXECUTION PLAN:
    17) Print the inferred DEVELOPMENT STAGE and a brief rationale (≤2 sentences).
    18) Print the thresholded table from step D (if available).
    19) Then print the “Execution Plan” as an ordered list:
       * Format: step_number. category — filename (seq_score, 2 decimals): reason
       * Include 1 short reason (≤15 words) tying it to {{query}} or a repo signal.
    20) If no prompts meet {{threshold}}, still print the inferred stage and recommend which categories to create next (list 2–4 categories).

    Acceptance:
    * The table appears only when ≥1 match meets {{threshold}}, sorted by match_score desc.
    * The output includes an inferred DEVELOPMENT STAGE with a one-line rationale.
    * The “Execution Plan” lists steps in stage-canonical order with seq_score (2 decimals) and short reasons.
    * If nothing meets threshold, display the exact single-line message plus a short recommendation of categories to author next.
    """

Best-practice gap

* Add lightweight category tags to your prompt files (front matter or filename suffix like `*.impl.md`) so stage→category mapping is reliable.

---

## You asked

what do you mean for the category tags?

---

## ChatGPT Replied

Thought for 6s

Output: Category tagging guide (concise spec + examples) | Constraints: one solution; show exact conventions, detection rules, and examples the ranker can parse today | Acceptance criteria: clear taxonomy, filename pattern, front-matter schema, precedence rules, and a minimal migration checklist

Primary answer

By “category tags,” I mean lightweight labels you attach to each prompt so the ranker can (a) understand what kind of work the prompt does and (b) slot it into the stage-aware sequence. You can express these tags either in the filename or in front-matter (or both).

### 1) Canonical taxonomy (use these exact strings)

`design`, `requirements`, `architecture`, `scaffold`, `conventions`, `ci-setup`, `spec-orient`, `impl`, `review`, `refactor-candidates`, `refactor`, `perf`, `test-plan`, `gen-tests`, `fix-flakes`, `coverage`, `doc-plan`, `examples`, `api-docs`, `site-sync`, `versioning`, `changelog`, `pack-publish`, `post-release-checks`

### 2) Filename convention (zero-config parsing)

Pattern:
`{slug}.{category}.md`
Examples:

* `generate-test-plan.test-plan.md`

* `implement-endpoint.impl.md`

* `refactor-hotspots.refactor-candidates.md`

* `prepare-release.versioning.md`

Multi-category (rare):
`{slug}.{category1}+{category2}.md` → e.g., `stabilize-tests.fix-flakes+coverage.md`

Alternate prefix style (also supported):
`{category}-{slug}.md` → e.g., `impl-implement-endpoint.md`

### 3) Front-matter (overrides filename and is preferred for richness)

You can use YAML, TOML, or JSON. Fields:

* `category` (string) or `categories` (array of strings from the taxonomy)

* `stage` (optional hint): one of `ideation`, `scaffold`, `implementation`, `refactor`, `testing`, `docs`, `release`

* `depends_on` (optional): list of other prompt ids (see “id” rule below)

* `provides` (optional): outputs it unlocks (free text or ids)

* `summary` (1–2 lines): intent in plain English

**YAML**

    ---
    id: implement-endpoint
    category: impl
    stage: implementation
    depends_on: [requirements-plan, api-architecture]
    summary: Implement a new REST endpoint from the agreed spec with validation and logs.
    ---

**TOML**

    +++
    id = "refactor-hotspots"
    category = "refactor-candidates"
    stage = "refactor"
    summary = "Detect complexity and duplication hotspots to queue refactors."
    +++

**JSON**

    {
      "id": "prepare-release",
      "categories": ["versioning", "changelog"],
      "stage": "release",
      "summary": "Bump version, update CHANGELOG from commits."
    }

### 4) Detection & precedence rules (what your ranker should do)

1. If front-matter has `categories` → use it.

2. Else if front-matter has `category` → wrap as single category.

3. Else derive from filename:

    * Match suffix: `.(?<cats>[a-z+-]+)\.md` → split `+` for multi.

    * Or prefix: `^(?<cat>[a-z-]+)-.*\.md$`.

4. Validate each found category is in the taxonomy; unknowns → `other` (score lower).

5. If both front-matter and filename exist, **front-matter wins**.

### 5) Minimal migration checklist

* Pick one style (suffix or prefix) and stick to it.

* Add `id` to each prompt (kebab-case): defaults to filename without category part.

* Add `category` (or `categories`) in front-matter for high-leverage prompts.

* (Optional) Add `stage` to nudge placement if the content is stage-specific.

* Commit a CI check that:

  * Validates category strings against the taxonomy.

  * Ensures either filename pattern or front-matter category is present.

  * Fails on duplicates of `id`.

### 6) Tiny linter regex you can reuse

* Suffix category capture: `\.(design|requirements|architecture|scaffold|conventions|ci-setup|spec-orient|impl|review|refactor-candidates|refactor|perf|test-plan|gen-tests|fix-flakes|coverage|doc-plan|examples|api-docs|site-sync|versioning|changelog|pack-publish|post-release-checks)(\+[a-z-]+)*\.md$`

* Prefix category capture: `^(design|requirements|architecture|scaffold|conventions|ci-setup|spec-orient|impl|review|refactor-candidates|refactor|perf|test-plan|gen-tests|fix-flakes|coverage|doc-plan|examples|api-docs|site-sync|versioning|changelog|pack-publish|post-release-checks)-.+\.md$`

### 7) Example tree (good)

    prompts/
      implement-endpoint.impl.md
      generate-test-plan.test-plan.md
      detect-hotspots.refactor-candidates.md
      prepare-release.versioning+changelog.md
      write-api-docs.api-docs.md

That’s all “category tags” means here: explicit, machine-readable labels that let your ranker map prompts to the right step for the inferred stage—and then order them intelligently.

---

## You asked

refactor\_prompt\_template.md

File

I have a dspy program that uses this refactor template, perhaps you can create me another template that instructs how to create the front-matter for my prompts/\*.md ?

Thought for 12s

---

## ChatGPT Replied

Output: Front-matter generator prompt template (Markdown) | Constraints: one self-contained template your DSPy program can use to prepend YAML/TOML/JSON front-matter to `prompts/*.md` | Acceptance criteria: defines inputs, stage/category taxonomy, deterministic inference rules, validation checks, and outputs exactly “front-matter + unchanged body”; style and structure consistent with your existing refactor template

Primary answer

Here’s a drop-in sibling to your refactor template that builds/repairs front-matter for any `prompts/*.md`. It mirrors your style: Task → Inputs → Algorithm → Validation → Output-only. refactor\_prompt\_template

    # dspy-file_front-matter_template

    Task: Given a prompt Markdown body ($1), generate or fix **front-matter** so the file is machine-parsable by the ranker/sequencer. Then emit the **front-matter followed by the original body unchanged**.

    Front-matter must expose: `id`, `categories` (or `category`), optional `stage`, `depends_on`, `provides`, `summary`. Use the canonical taxonomy and rules below.

    Inputs

    - $1 = source Markdown body (no existing front-matter assumed; if present, reconcile/normalize)
    - $2 = preferred id/slug (optional; kebab-case). If empty, infer.
    - $3 = preferred categories (optional; comma-separated from taxonomy). If empty, infer.
    - $4 = default stage (optional; one of: ideation, scaffold, implementation, refactor, testing, docs, release). If empty, infer or omit.
    - $5 = output format (optional; one of: yaml, toml, json). Default: yaml.

    Canonical taxonomy (exact strings)

    design, requirements, architecture, scaffold, conventions, ci-setup, spec-orient, impl, review, refactor-candidates, refactor, perf, test-plan, gen-tests, fix-flakes, coverage, doc-plan, examples, api-docs, site-sync, versioning, changelog, pack-publish, post-release-checks

    Stage hints (for inference)

    - ideation ↔ design/requirements/architecture
    - scaffold ↔ scaffold/conventions/ci-setup
    - implementation ↔ spec-orient/impl/review
    - refactor ↔ refactor-candidates/refactor/perf
    - testing ↔ test-plan/gen-tests/fix-flakes/coverage
    - docs ↔ doc-plan/examples/api-docs/site-sync
    - release ↔ versioning/changelog/pack-publish/post-release-checks

    ## Algorithm

    1) Extract signals from $1
       - Title words, headings, imperative verbs.
       - File/task intent sentences (first paragraph).
       - Any explicit tags like “test plan”, “refactor”, “release”.
       - Dependencies implied by phrases: “after X”, “requires Y”, “prepares Z”.

    2) Determine `id`
       - If $2 provided → use.
       - Else infer: take main action + object (e.g., “implement-endpoint”, “generate-test-plan”).
       - Normalize: lowercase, kebab-case, `[a-z0-9-]`, max 60 chars.
       - Must start with a letter; trim duplicates.

    3) Determine `categories`
       - If $3 provided → split by comma, trim, validate against taxonomy.
       - Else infer by matching intent/verbs/headings to taxonomy.
       - If none match, use `["impl"]` as last resort.
       - Sort deterministically (taxonomy order), de-dupe.

    4) Determine `stage` (optional)
       - If $4 provided → use if valid.
       - Else infer via category→stage mapping above.
       - Omit if uncertain.

    5) Determine `depends_on` (optional)
       - Parse phrases in $1: “requires/after/before”, “precondition”, “assumes”.
       - Extract candidate ids (kebab-case). If none, omit.

    6) Determine `provides` (optional free text)
       - Short list (≤3) of artifacts unlocked, e.g., “test-cases”, “CHANGELOG entry”, “API docs”.
       - Omit if not clear.

    7) Compose `summary`
       - One sentence, ≤120 chars.
       - Format: “Do <verb> <object> to achieve <outcome>.”

    8) Produce front-matter in requested format ($5)
       - **YAML (default)** keys in this order: id, categories, stage?, depends_on?, provides?, summary
       - TOML/JSON equivalents if $5 indicates.

    9) Reconciliation (if input already had front-matter)
       - Merge: prefer explicit inputs $2–$4 > existing > inferred.
       - Validate taxonomy; move unknowns to `other` but keep them in a separate `x_tags` array.
       - Remove empty keys.

    ## Validation

    - `id`: matches `^[a-z][a-z0-9-]{1,59}$`.
    - `categories`: non-empty, all in taxonomy; ≤3 entries.
    - `stage`: if present, in allowed set.
    - `depends_on`: ≤5 items; each id-shaped.
    - `summary`: ≤120 chars; no trailing period if already followed by punctuation.
    - **Do not alter the body text ($1).** Only prepend the front-matter.
    - Output exactly one document: front-matter, then a blank line, then the original body.

    ## Output format examples

    **YAML (default)**
    ```yaml
    ---
    id: $2-or-inferred
    categories:
      - impl
      - review
    stage: implementation
    depends_on: [requirements-plan, api-architecture]
    provides: [endpoint, tests]
    summary: Implement a new REST endpoint from spec and submit for review
    ---
    $1

**TOML**

    +++
    id = "$2-or-inferred"
    categories = ["test-plan"]
    stage = "testing"
    depends_on = ["requirements-plan"]
    provides = ["cases", "fixtures"]
    summary = "Generate a test plan to increase coverage"
    +++

    $1

**JSON**

    {
      "id": "$2-or-inferred",
      "categories": ["versioning","changelog"],
      "stage": "release",
      "depends_on": ["lint-ci-setup"],
      "provides": ["tag","notes"],
      "summary": "Prepare a version bump and CHANGELOG from commits"
    }

    $1



    Best-practice gap
    - Add a CI check that fails if `categories` contain strings outside the taxonomy, or if `id` collides with another prompt file.

---

## You asked

codebase.md

File

here's a codebase snapshot of the frontmatter I have been using. Is it okay or should i consider changing it?

Thought for 9s

---

## ChatGPT Replied

Output: Review memo | Constraints: one solution; use only the provided snapshot; concise; include “Best-practice gap” only if concrete gaps exist | Acceptance criteria: calls out what’s OK vs what to change, grounded in the snapshot with specific, actionable fixes

Primary answer

Overall, your front-matter is coherent and already useful for orchestration: you consistently declare `phase`, `gate`, `status`, plus lightweight flow via `previous`/`next`, and many files include a clear **Trigger** and **Purpose** in the body. That’s a solid baseline for sequencing and gating. codebase

Best-practice gap

* **Schema drift / missing delimiters.** Some files have well-formed YAML blocks with `--- … ---`, e.g. `api-contract.md`, while others have keys without the opening block or place `---` mid-file (e.g., `logging-strategy.md`, `system-level-instruction-editor.md`). Normalize to a single, valid front-matter block at the top of every prompt. codebase

* **Inconsistent presence of front-matter.** Several prompts lack any front-matter (`adr-new.md`, `eslint-review.md`, `tsconfig-review.md`, etc.). Add a minimal header so the ranker can treat all prompts uniformly. codebase

* **No stable `id`.** Files rely on filenames only. Add `id` (kebab-case) so you can reference prompts in `depends_on` and in execution plans without path brittleness. Example from your own pattern needs it for cross-links like `previous`/`next`. codebase

* **Missing `category/categories` for stage-aware sequencing.** You use `phase: "P# …"` which is great for roadmap views, but the ranker needs machine-readable **work-type** tags (e.g., `impl`, `test-plan`, `versioning`) to order steps inside a phase. Add `categories` alongside `phase`. codebase

* **`phase` shape varies.** Sometimes a string (`"P2 App Scaffold & Contracts"`), elsewhere an array (in `prototype-feature.md`). Pick one shape (recommend: string) and add a separate optional `stages: [...]` only when multi-phase truly applies. codebase

* **Link semantics aren’t machine-enforced.** `previous`/`next` list raw command strings (e.g., `"/openapi-generate"`). Prefer `depends_on: [<ids>]` for prerequisites and reserve `next` for UX hints; this enables DAG checks (acyclicity, readiness). codebase

* **Lack of validation hooks.** Add small invariants: allowed `phase` values (`P0`…`P9`, `Support`, `Reset`), allowed `gate` values, category whitelist, and regex for `id`. This prevents silent drift you already have. codebase

Suggested normalized front-matter (drop-in)

    ---
    id: openapi-generate             # kebab-case, stable
    phase: "P2 App Scaffold & Contracts"  # enum/string; one value
    gate: "Test Gate lite"           # enum of known gates
    status: "generated code builds and CI checks cover the new scripts."
    categories: ["impl"]             # from the taxonomy you run in the ranker
    stage: implementation            # optional: maps phase→stage
    depends_on: ["api-contract"]     # prompt ids, not paths
    provides: ["server-stubs","client-sdk"]  # optional artifacts
    summary: "Generate server stubs or typed clients from an OpenAPI spec."
    ---

Minimal migration checklist (safe to automate)

1. **Add `id` to all prompts** using filename stem (kebab-case).

2. **Normalize `phase/gate/status`** into a single top block; move stray keys above the first heading.

3. **Introduce `categories`** for each file (e.g., `impl`, `test-plan`, `versioning`) while keeping your `phase` values intact.

4. **Replace `previous`/`next` with `depends_on`** (keep `previous`/`next` as optional hints if you like, but don’t rely on them for ordering).

5. **Lint**: fail CI if any prompt lacks `id`, has unknown `phase/gate/category`, or malformed YAML.

Why this change is worth it

* You keep your roadmap semantics (`phase`, `gate`, `status`) **and** gain deterministic, stage-aware sequencing via `categories` and `depends_on`. That directly enables the “infer stage → ordered run list” flow you’re building. codebase

---

## You asked

I'm going to organize them into subfolders, what should I name each parent directory?

---

## ChatGPT Replied

Thought for 4 seconds

Output: Folder naming scheme | Constraints: one best-fit scheme; assumes you’ll infer stage → sequence; concise | Acceptance criteria: clear parent dirs, mapping from categories→parents, naming rules, and a minimal tree example

Assumption: You want a stage-first layout that matches the sequencer (infer stage → order prompts).

Recommended parent directories (stage-first)
--------------------------------------------

Use zero-padded numeric prefixes so lexicographic order = lifecycle order:

* `00-ideation/`

* `10-scaffold/`

* `20-implementation/`

* `30-refactor/`

* `40-testing/`

* `50-docs/`

* `60-release/`

* `_shared/` (cross-stage utilities: conventions, CI, lint)

* `_templates/` (prompt skeletons, authoring guides)

* `_archive/` (retired prompts)

* `_experimental/` (WIP, not used by CI/ranker)

Category → parent mapping (canonical)
-------------------------------------

* ideation → `00-ideation/` (design, requirements, architecture)

* scaffold → `10-scaffold/` (scaffold, conventions, ci-setup)

* implementation → `20-implementation/` (spec-orient, impl, review)

* refactor → `30-refactor/` (refactor-candidates, refactor, perf)

* testing → `40-testing/` (test-plan, gen-tests, fix-flakes, coverage)

* docs → `50-docs/` (doc-plan, examples, api-docs, site-sync)

* release → `60-release/` (versioning, changelog, pack-publish, post-release-checks)

* shared → `_shared/` (house style, lint/format, repo ops used across stages)

Naming rules (files & subfolders)
---------------------------------

* Subfolders (optional) = category slugs; files keep `{slug}.{category}.md` (e.g., `implement-endpoint.impl.md`).

* IDs stay in front-matter (`id: implement-endpoint`) regardless of directory.

* If a prompt has multiple categories, keep it in the parent matching its **primary** stage and use filename like `prepare-release.versioning+changelog.md`.

Minimal example tree
--------------------

    prompts/
      00-ideation/
        requirements/
          capture-requirements.requirements.md
        architecture/
          choose-service-slice.architecture.md
      10-scaffold/
        scaffold/
          bootstrap-project.scaffold.md
        conventions/
          enforce-style.conventions.md
        ci-setup/
          setup-ci.ci-setup.md
      20-implementation/
        spec-orient/
          write-feature-spec.spec-orient.md
        impl/
          implement-endpoint.impl.md
        review/
          code-review-checklist.review.md
      30-refactor/
        refactor-candidates/
          detect-hotspots.refactor-candidates.md
        refactor/
          modularize-auth.refactor.md
        perf/
          profile-endpoints.perf.md
      40-testing/
        test-plan/
          generate-test-plan.test-plan.md
        gen-tests/
          add-api-tests.gen-tests.md
        fix-flakes/
          stabilize-ci-tests.fix-flakes.md
        coverage/
          raise-coverage.coverage.md
      50-docs/
        doc-plan/
          doc-scope.doc-plan.md
        api-docs/
          write-api-docs.api-docs.md
        examples/
          add-usage-examples.examples.md
        site-sync/
          sync-doc-site.site-sync.md
      60-release/
        versioning/
          bump-version.versioning.md
        changelog/
          curate-changelog.changelog.md
        pack-publish/
          publish-package.pack-publish.md
        post-release-checks/
          verify-release.post-release-checks.md
      _shared/
        conventions/
          repo-standards.conventions.md
      _templates/
        front-matter.template.md
      _archive/

CI/ranker globs (drop-in)
-------------------------

* Include: `prompts/{00-ideation,10-scaffold,20-implementation,30-refactor,40-testing,50-docs,60-release}/**/*.md`

* Exclude: `prompts/_archive/**`, `prompts/_experimental/**`, `prompts/_templates/**`, `prompts/_shared/**` (or include `_shared` only for linting, not sequencing)

This structure keeps your roadmap intuitive, makes sequencing deterministic, and stays compatible with the category taxonomy your ranker uses.

---

## ChatGPT Replied

Output: Folder naming scheme | Constraints: one best-fit scheme; stage-first; concise | Acceptance criteria: clear parent dir names, deterministic order, example tree, include globs

Here’s a stage-first layout that aligns with your sequencer (infer stage → ordered run list). Use zero-padded prefixes so lexical order matches lifecycle:

**Parent directories**

* `00-ideation/`

* `10-scaffold/`

* `20-implementation/`

* `30-refactor/`

* `40-testing/`

* `50-docs/`

* `60-release/`

* `_shared/` (cross-stage utilities)

* `_templates/` (authoring templates)

* `_experimental/` (WIP; excluded from runs)

* `_archive/` (retired)

**Optional subfolders (by category within each stage)**

* ideation → `requirements/`, `design/`, `architecture/`

* scaffold → `scaffold/`, `conventions/`, `ci-setup/`

* implementation → `spec-orient/`, `impl/`, `review/`

* refactor → `refactor-candidates/`, `refactor/`, `perf/`

* testing → `test-plan/`, `gen-tests/`, `fix-flakes/`, `coverage/`

* docs → `doc-plan/`, `examples/`, `api-docs/`, `site-sync/`

* release → `versioning/`, `changelog/`, `pack-publish/`, `post-release-checks/`

**File naming inside folders**

* `{slug}.{category}.md`
    e.g., `implement-endpoint.impl.md`, `prepare-release.versioning+changelog.md`

**Mini example**

    prompts/
      20-implementation/
        impl/
          implement-endpoint.impl.md
        review/
          code-review-checklist.review.md
      40-testing/
        test-plan/
          generate-test-plan.test-plan.md
      _shared/
        conventions/
          repo-standards.conventions.md
      _templates/
        front-matter.template.md
      _archive/

**CI / ranker globs**

* Include: `prompts/{00-ideation,10-scaffold,20-implementation,30-refactor,40-testing,50-docs,60-release}/**/*.md`

* Exclude: `prompts/_archive/**`, `prompts/_experimental/**`, `prompts/_templates/**` (optionally include `_shared` for linting only)

This gives you stable, readable parents and keeps your execution order deterministic.

---

## You asked

summarize this for an ai agent

---

## ChatGPT Replied

Thought for 4 seconds

Output: Agent-ready summary | Constraints: stage-first layout; deterministic order; minimal but actionable | Acceptance criteria: an agent can create/validate the tree, place files correctly from category/stage, and compute include/exclude globs

**Goal**
Organize `prompts/` so stage inference → deterministic execution order.

**Parent dirs (lexical order = lifecycle)**

* `00-ideation/`

* `10-scaffold/`

* `20-implementation/`

* `30-refactor/`

* `40-testing/`

* `50-docs/`

* `60-release/`

* `_shared/` (cross-stage utilities), `_templates/` (authoring), `_experimental/` (WIP), `_archive/` (retired)

**Optional subfolders by category**

* ideation → `requirements/`, `design/`, `architecture/`

* scaffold → `scaffold/`, `conventions/`, `ci-setup/`

* implementation → `spec-orient/`, `impl/`, `review/`

* refactor → `refactor-candidates/`, `refactor/`, `perf/`

* testing → `test-plan/`, `gen-tests/`, `fix-flakes/`, `coverage/`

* docs → `doc-plan/`, `examples/`, `api-docs/`, `site-sync/`

* release → `versioning/`, `changelog/`, `pack-publish/`, `post-release-checks/`

**File naming rule**

* `{slug}.{category}.md` (multi: `{slug}.{cat1}+{cat2}.md`)
    Examples: `implement-endpoint.impl.md`, `prepare-release.versioning+changelog.md`

**Placement logic**

1. Read front-matter: `categories` (or `category`) and optional `stage`.

2. Map `stage` → parent dir; if missing, infer from `categories`.

3. If multi-category, choose parent by primary stage; keep all categories in filename and front-matter.

4. Keep `id` in front-matter (kebab-case); directory location does not change `id`.

**Include/Exclude for ranking/sequencing**

* Include: `prompts/{00-ideation,10-scaffold,20-implementation,30-refactor,40-testing,50-docs,60-release}/**/*.md`

* Exclude: `prompts/_archive/**`, `prompts/_experimental/**`, `prompts/_templates/**` (optionally exclude `_shared/**` from sequencing but include for linting)

**Agent tasks checklist**

* Ensure all parent dirs exist (create if missing).

* Validate filenames match `{slug}.{category}.md`; fix if not.

* Verify front-matter has `id` and `categories`; add/normalize if missing.

* Move files into stage parent (and optional category subfolder) per rules above.

* Produce a report of moves/renames and any files excluded from sequencing.

---
