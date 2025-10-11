<!--
$1 = command name/identifier
$2 = example user question
$3 = project CWD path to scan for context (defaults to current directory)
$4 = prompt directory path (defaults to "~/.codex/prompts")
$5 = minimum relevance threshold (0–1)
-->

# {Context-Aware Prompt Ranking Command}

```md
# Command: $1

# Usage: $1 "$2" "$3" "$4" "$5"

# Args:

# - {{query}}: $2
# - {{project_path}}: $3
# - {{prompt_path}}: $4
# - {{threshold}}: $5

prompt = """
Task:
Given a user inquiry ({{query}}) and the context of a software project located at {{project_path}}, your goal is to identify the most relevant prompt-definition file from the directory {{prompt_path}}.

Defaults:
* If {{project_path}} is missing or blank, use the current working directory.
* If {{prompt_path}} is missing or blank, use "~/.codex/prompts".

Do the following:
1) **Analyze Project Context**: Recursively scan {{project_path}} to understand its structure, languages, and purpose. Create a concise summary of the project context.
2) **Scan Prompts**: List all candidate prompt files in {{prompt_path}} (non-recursively).
3) **Evaluate Prompts**: For each candidate prompt file:
    a) Read its content.
    b) Create a one-sentence summary of its purpose and domain.
    c) Compute a relevance score from 0 to 1. This score must measure how well the prompt's purpose aligns with the user's {{query}}, considering the project context summary. A higher score means the prompt is a better fit for solving the query within the given project.
4) **Rank and Filter**: Order the prompts by their relevance score in descending order.
5) **Generate Output**: Emit a compact markdown table with the columns: `filename | description | match_score` (rounded to 2 decimals).

Rules:
* The description must be 1–2 sentences capturing the prompt's purpose and domain.
* Only include prompts in the table where `match_score` is greater than or equal to {{threshold}}.
* If no prompts meet the threshold, output a single line: "No prompt exceeds threshold {{threshold}} — recommend creating a new prompt."

Acceptance:
* If one or more matches meet the {{threshold}}, a markdown table sorted by descending `match_score` is produced.
* Otherwise, the single-line fallback message is produced.

!{echo "Scanning project: ${PROJECT_PATH_ARG:-.}"}
!{echo "Searching for prompts in: ${PROMPT_PATH_ARG:-~/.codex/prompts}"}
"""
```

## Output format

* **Preferred**: a markdown table with columns `filename | description | match_score` sorted by `match_score` (desc) and filtered by `{{threshold}}`.
* **Fallback**: the exact one-line message when no entries meet `{{threshold}}`.
