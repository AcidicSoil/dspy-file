# $2

## Overview

Locate prompt files under "$3" that correspond to "$1". Use the comparison dimensions listed in **Match criteria** to decide relevance.

## Scope

* Search scope: files and paths rooted at "$3".
* File types to consider: prompt files and adjacent metadata (YAML/MD/JSON).
* Exclude: generated artifacts, build outputs, and vendor folders unless required.

## Match criteria

Compare each candidate prompt against the fields specified in "$4", typically:

* Intent / purpose
* Expected input shape or variables
* Observed behavior or output shape

## Output requirements

Return up to $5 results, ordered by "$7". For each result include the columns listed in "$6". Keep summaries to one or two sentences.

### Output format (analysis)

Provide results as JSON with this schema:
{
"matches": [
{
"filename": "<string>",
"short_summary": "<string>",
"match_reason": "<string>",
"score": "<number>"
}
],
"meta": {
"query": "$1",
"scanned_path": "$3",
"result_count": "<integer>"
}
}

## Process

1. Enumerate candidate prompt files under "$3".
2. For each file, extract the fields named in "$4".
3. Compute a relevance score per "$7".
4. Produce the top $5 matches formatted with "$6".

## Affected files

* Record the files inspected and any that triggered special handling.

## Root cause (when a match is unexpected)

* Briefly note why a match occurred or why no suitable prompt was found.

## Proposed fix / next action

* Suggest remediation: create a new prompt, refactor an existing one, or update metadata.

## Tests

* Minimal verification: spot-check N items and run semantic-similarity sanity checks.

## Documentation gaps

* Note any missing metadata that would ease future matching.

## Open questions

* Capture unresolved decisions or parameters needing clarification.

---

### Acceptance

* Returns ≤ $5 items.
* Results are ordered by "$7".
* Each item includes exactly the requested "$6".

{
  "args": [
    {
      "id": "$1",
      "name": "query",
      "hint": "text to match against prompt files",
      "example": "how to create a bash script",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$2",
      "name": "title",
      "hint": "title for the run/report",
      "example": "Prompt Discovery Report",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$3",
      "name": "path",
      "hint": "root directory to scan",
      "example": "/home/user/prompts",
      "required": true,
      "validate": "path"
    },
    {
      "id": "$4",
      "name": "fields",
      "hint": "comma-separated fields to compare (e.g., purpose,input,behavior)",
      "example": "purpose,input",
      "required": true,
      "validate": "csv"
    },
    {
      "id": "$5",
      "name": "limit",
      "hint": "maximum number of matches to return",
      "example": "10",
      "required": true,
      "validate": "integer"
    },
    {
      "id": "$6",
      "name": "columns",
      "hint": "comma-separated columns to include (e.g., filename,short_summary,match_reason)",
      "example": "filename,short_summary",
      "required": true,
      "validate": "csv"
    },
    {
      "id": "$7",
      "name": "ranking",
      "hint": "ranking strategy (e.g., semantic_similarity, exact_match_first)",
      "example": "semantic_similarity",
      "required": true,
      "validate": "string"
    }
  ]
}
