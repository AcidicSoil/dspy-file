# $1

## Overview

Locate prompt files under "$2" that correspond to "$3". Use the comparison dimensions listed in **Match criteria** to decide relevance.

## Scope

* Search scope: files and paths rooted at "$2".
* File types to consider: prompt files and adjacent metadata (YAML/MD/JSON).
* Exclude: generated artifacts, build outputs, and vendor folders unless required.

## Match criteria

Compare each candidate prompt against the fields specified in "$4", typically:

* Intent / purpose
* Expected input shape or variables
* Observed behavior or output shape

## Output requirements

Return up to $5 results, ordered by "$6". For each result include the columns listed in "$7". Keep summaries to one or two sentences.

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
"query": "$3",
"scanned_path": "$2",
"result_count": "<integer>"
}
}

## Process

1. Enumerate candidate prompt files under "$2".
2. For each file, extract the fields named in "$4".
3. Compute a relevance score per "$6".
4. Produce the top $5 matches formatted with "$7".

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
* Results are ordered by "$6".
* Each item includes exactly the requested "$7".
