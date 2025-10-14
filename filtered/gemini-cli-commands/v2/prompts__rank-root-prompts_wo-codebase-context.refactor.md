# Command: /prompts:rank-root-prompts

# Usage: /prompts:rank-root-prompts "$1" "$2" "$3"

# Args:

# - {{query}}: user question to match against prompts

# - {{path}}: project root directory containing prompt files (defaults to $2 if omitted)

# - {{threshold}}: minimum match score (0–1) to consider a prompt relevant

prompt = """
Task: Given a user question $1, analyze all prompt definitions located at the project root $2.

Defaults:

* If $2 is not provided or is empty, use "C:/Users/user/projects/WIP/prompts/temp-prompts-organized".

Do the following:

1. Enumerate files at $2 (non-recursive). Consider likely prompt definitions (e.g., .md, .toml, .yaml, .yml, .json).
2. For each candidate, parse its text and extract its intent and domain in one sentence.
3. Compute a semantic relevance score in [0,1] between the file’s intent and $1.
4. Rank files by score (desc).
5. Output a concise table with columns exactly: filename | description | match_score (rounded to 2 decimals).

Rules:

* Description = 1–2 sentences summarizing intent + domain.
* Only include files with match_score ≥ $3.
* If no files meet $3, output a single line note: "No prompt exceeds threshold $3 — recommend creating a new prompt."

Acceptance:

* Table is present when ≥1 match meets $3 and is sorted by match_score desc.
* Otherwise, the single-line note is present.

!{echo "Using path: ${PATH_ARG:-C:/Users/user/projects/WIP/prompts/temp-prompts-organized}"}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "query",
      "hint": "user question to match against prompts",
      "example": "How do I create a Dockerfile?",
      "required": true,
      "validate": ""
    },
    {
      "id": "$2",
      "name": "path",
      "hint": "project root directory containing prompt files",
      "example": "C:/Users/user/projects/WIP/prompts/temp-prompts-organized",
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
