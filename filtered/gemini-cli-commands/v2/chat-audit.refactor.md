# Command: /user:error-runs-to-doc-resolution

# Usage: /user:error-runs-to-doc-resolution "$1" "$2"

# Args:

# - $1: session log file or directory to analyze

# - $2: max near-misses to list if none found (optional)

prompt = """
You are analyzing a conversational $3 located at $1.

Goal

* Report each instance where ≥3 consecutive assistant errors led to a user request to fetch docs and the issue was then resolved using those docs.

Definitions (defaults)

* Errors = assistant responses that are incorrect, repeated, or ignore explicit user corrections.
* Intervention keywords = phrases like "fetch docs", "read docs", "check docs", "consult documentation", "open {link}" (including variations and quoted links).
* Resolution = assistant cites docs (e.g., mentions documentation by name or includes a link/quote from docs) AND the user stops reporting the issue for ≥3 subsequent user turns.

Detection Steps

1. Scan chronologically and detect assistant error runs with length ≥3 (consecutive assistant turns counted across interleaving user turns responding to the same issue).
2. From the end of each error run, locate the next user intervention that matches any intervention keyword or includes a link to documentation.
3. Within the next 10 turns after the intervention, confirm resolution:

   * Assistant cites docs (explicit mention or URL/domain typical of docs; or "According to the docs…").
   * For the next ≥3 user turns, the user does not report the same issue (no complaints, corrections, or re-raising of the same error).
4. For each confirmed case, output one row with:

   * Window (time + turn indices covering from first error to resolution)
   * Error count
   * High-level issue (brief)
   * Low-level note (failure details, doc source, key fix steps)
   * Intervention turn (index)
   * Resolution turn (index)
   * Evidence quotes (≤3 short quotes) with turn indices
   * Confidence (0–1)

Output Format

* First, a Markdown table with the columns exactly:
  Window | Error count | High-level issue | Low-level note | Intervention turn | Resolution turn | Evidence quotes (≤3) | Confidence
* Then, a JSON appendix containing an array "cases" with the same information plus raw matched spans, and an array "near_misses" when applicable.

If None Found

* Print a one-line statement: "No qualifying cases found."
* Then list up to $2 near-misses (default 3) where:

  * Error run ≥3 and user intervention occurs, but the resolution criteria fail within 10 turns; OR
  * Resolution likely occurred but assistant did not clearly cite docs.

Method

* Normalize speaker roles and turn indices; preserve original timestamps when present.
* Use fuzzy matching for intervention keywords and doc citations (handle minor typos).
* De-duplicate overlapping windows by keeping the earliest complete resolution.
* Keep quotes concise (≤200 characters each) and include their turn indices like [U17], [A18].
* Compute confidence based on strength of signals: length/clarity of error run, explicitness of intervention, clarity of doc citation, stability over ≥3 turns.

Acceptance

* The Markdown table has exactly 8 columns with the specified headers.
* The JSON appendix includes keys: "cases", "near_misses", "config" (with evaluated intervention patterns and thresholds).
* Evidence quotes count ≤3 per row.
* Confidence values are decimals between 0 and 1 inclusive with two decimal places.
* If no cases, near_misses length ≤ $2.
  """

{
  "args": [
    {
      "id": "$1",
      "name": "path",
      "hint": "session log file or directory to analyze",
      "example": "/path/to/session.log",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "limit",
      "hint": "max near-misses to list if none found (optional)",
      "example": "3",
      "required": false,
      "validate": "^[0-9]+$"
    },
    {
      "id": "$3",
      "name": "session_log",
      "hint": "type of session log being analyzed",
      "example": "conversation log",
      "required": true,
      "validate": ".*"
    }
  ]
}
