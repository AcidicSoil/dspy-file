# Command: /prompts:rank-prompts-with-code-context

# Usage: /prompts:rank-prompts-with-code-context "example user question" "~/.codex/prompts" "0.6"

# Args:

# - {{query}}: user question to match against prompts

# - {{path}}: prompt directory to search (defaults to ~/.codex/prompts if omitted)

# - {{threshold}}: minimum match score (0–1) to consider a prompt relevant

prompt = """
Goal: Find the best prompt(s) for $1 by first understanding the current codebase (cwd), then ranking prompts from $2 (or default "~/.codex/prompts") using both the query and code context.

Defaults:

* If $2 is empty or not provided, use "~/.codex/prompts".

Do this, in order:

A) Gather codebase context from the current working directory (recursively):

1. Recursively scan the cwd, ignoring common vendor/build folders: node_modules, .git, dist, build, .next, .venv, venv, target, bin, obj, **pycache**, .cache, vendor.
2. Summarize:

   * Primary languages/frameworks (e.g., Python/FastAPI, TS/Next.js, Go/Fiber, Java/Spring).
   * Key domains (e.g., CLI tooling, web API, data processing, ML, infra/IaC).
   * Notable entities: service names, repo/package names, common commands, config keys.
   * Any present prompt/AI patterns (e.g., JSON schemas, system prompts, RAG configs).
3. Produce a concise “Codebase Summary” (≤10 bullet points).

!{pwd}
!{printf "Scanning codebase…\n"}
!{find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/dist/*" -not -path "*/build/*" -not -path "*/.next/*" -not -path "*/.venv/*" -not -path "*/venv/*" -not -path "*/target/*" -not -path "*/bin/*" -not -path "*/obj/*" -not -path "*/**pycache**/*" -not -path "*/.cache/*" -not -path "*/vendor/*" | head -n 2000}

B) Collect candidate prompts (then analyze intents):
4) Determine prompt directory: if a user-supplied $2 is provided, use it; otherwise "~/.codex/prompts".
5) Recursively enumerate likely prompt definitions: extensions [.md, .toml, .yaml, .yml, .json].
6) For each file, parse text and extract a one-sentence intent and domain.

!{PROMPT_DIR="${PATH_ARG:-~/.codex/prompts}"; echo "Using prompt dir: $PROMPT_DIR"}
!{find "${PATH_ARG:-~/.codex/prompts}" -type f ( -iname "*.md" -o -iname "*.toml" -o -iname "*.yaml" -o -iname "*.yml" -o -iname "*.json" ) | head -n 2000}

C) Rank with blended relevance:
7) Form a “Matching Query” by blending $1 + the Codebase Summary.
8) Compute a semantic relevance score in [0,1] between each file’s (intent+domain) and the Matching Query.
9) Sort by score (desc).

D) Output:
10) If any file has score ≥ $3, print a table with columns exactly: filename | description | match_score (rounded to 2 decimals), sorted desc.
11) Otherwise, output exactly: "No prompt exceeds threshold $3 — recommend creating a new prompt."

Acceptance:

* The table appears only when ≥1 match meets $3, sorted by match_score desc.
* Otherwise, the single-line note appears.
  """

{
  "args": [
    {
      "id": "$1",
      "name": "query",
      "hint": "User question to match against prompts",
      "example": "How do I create a REST API in Python?",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "path",
      "hint": "Prompt directory to search (defaults to ~/.codex/prompts if omitted)",
      "example": "~/.codex/prompts",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$3",
      "name": "threshold",
      "hint": "Minimum match score (0–1) to consider a prompt relevant",
      "example": "0.6",
      "required": true,
      "validate": "^[0-9]+(\\.[0-9]+)?$"
    }
  ]
}
