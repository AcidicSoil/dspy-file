# Command: /prompts:rank-prompts-with-code-context

# Usage: /prompts:rank-prompts-with-code-context "example user question" "~/.codex/prompts" "0.6"

#

# Args:

# - {{query}}: user question to match against prompts

# - {{path}}: prompt directory to search (defaults to ~/.codex/prompts if omitted)

# - {{threshold}}: minimum match score (0–1) to consider a prompt relevant

prompt = """
Goal: Given $1, first understand the current codebase (cwd), then 1) infer the user's DEVELOPMENT STAGE, 2) rank prompts from $2 (or "~/.codex/prompts"), and 3) output an EXECUTION PLAN—an ordered list of prompts to run that will most rapidly advance the development cycle.

Defaults:

* If $2 is empty or not provided, use "~/.codex/prompts".

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
4) Determine prompt directory: if a user-supplied $2 is provided, use it; otherwise "~/.codex/prompts".
5) Recursively enumerate likely prompt definitions: extensions [.md, .toml, .yaml, .yml, .json].
6) For each file, parse text and extract a one-sentence INTENT and DOMAIN. Also detect CATEGORY tags if present in the file name or front matter (e.g., "scaffold", "impl", "refactor", "test", "docs", "release").

!{PROMPT_DIR="${PATH_ARG:-~/.codex/prompts}"; echo "Using prompt dir: $PROMPT_DIR"}
!{find "${PATH_ARG:-~/.codex/prompts}" -type f ( -iname "*.md" -o -iname "*.toml" -o -iname "*.yaml" -o -iname "*.yml" -o -iname "*.json" ) | head -n 2000}

C) Rank with blended relevance:
7) Form a “Matching Query” by blending $1 + the Codebase Summary.
8) Compute a semantic relevance score in [0,1] between each file's (intent+domain+category) and the Matching Query.
9) Keep the top K=25 by score for later sequencing.

D) Thresholded table:
10) If any file has score ≥ $3, prepare a table with columns exactly: filename | description | match_score (rounded to 2 decimals), sorted desc. Keep this for the final output.
11) Otherwise, output exactly: "No prompt exceeds threshold $3 — recommend creating a new prompt."

E) Infer DEVELOPMENT STAGE:
12) Define stages and indicative signals (use both $1 terms and repo signals):

* IDEATION: query mentions “ideas”, “architecture”, “capabilities”; repo sparse; no tests/CI.
* SCAFFOLD: presence of manifest (package.json/pyproject), few modules; query asks “create project”, “bootstrap”.
* IMPLEMENTATION: multiple modules present; query mentions “add feature”, “integrate X”.
* REFACTOR: query includes “refactor”, “clean up”, “performance”, “modularize”; lints/TODOs present.
* TESTING: tests folder or frameworks detected; query mentions “write tests”, “coverage”.
* DOCS: README/docs site present or missing; query mentions “document”, “examples”.
* RELEASE: changelog, version bump, CI/CD pipeline; query mentions “publish”, “release”, “package”.

13. Score each stage in [0,1] using a simple additive heuristic:

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

15. For the top-K prompts, assign each a CATEGORY (from filename/front matter; if missing, infer from intent). Compute a SEQUENCE SCORE:

* seq_score = 0.6*match_score + 0.3*stage_category_fit + 0.1*dependency_bonus
* stage_category_fit: 1.0 if category matches the current step, 0.5 if adjacent step, 0 otherwise.
* dependency_bonus: +0.1 if filename hints it unblocks another selected prompt (e.g., “plan” before “impl”).

16. Sort by the canonical step order first, then by seq_score desc within each step. Keep the top 1–3 per step.

G) Output EXECUTION PLAN:
17) Print the inferred DEVELOPMENT STAGE and a brief rationale (≤2 sentences).
18) Print the thresholded table from step D (if available).
19) Then print the “Execution Plan” as an ordered list:

* Format: step_number. category — filename (seq_score, 2 decimals): reason
* Include 1 short reason (≤15 words) tying it to $1 or a repo signal.

20. If no prompts meet $3, still print the inferred stage and recommend which categories to create next (list 2–4 categories).

Acceptance:

* The table appears only when ≥1 match meets $3, sorted by match_score desc.
* The output includes an inferred DEVELOPMENT STAGE with a one-line rationale.
* The “Execution Plan” lists steps in stage-canonical order with seq_score (2 decimals) and short reasons.
* If nothing meets threshold, display the exact single-line message plus a short recommendation of categories to author next.
  """

{
  "args": [
    {
      "id": "$1",
      "name": "query",
      "hint": "user question to match against prompts",
      "example": "example user question",
      "required": true,
      "validate": ""
    },
    {
      "id": "$2",
      "name": "path",
      "hint": "prompt directory to search (defaults to ~/.codex/prompts if omitted)",
      "example": "~/.codex/prompts",
      "required": false,
      "validate": ""
    },
    {
      "id": "$3",
      "name": "threshold",
      "hint": "minimum match score (0–1) to consider a prompt relevant",
      "example": "0.6",
      "required": true,
      "validate": ""
    }
  ]
}
