# TaskMaster Overview

## Metadata

- **identifier**: tm-overview  
- **category**: summarization  
- **lifecycle_stage**: inspection  
- **dependencies**: tasks.json  
- **provided_artifacts**: overview bullets, totals table, top pending list, critical path list, issues list  
- **summary**: Summarize TaskMaster tasks.json by status, priority, and dependency health to orient work.

## Inputs

- `tasks.json` path (optional; defaults to repo root)

## Canonical taxonomy (exact strings)

- summarization
- analysis
- reporting

### Stage hints (for inference)

- inspection → summarizing state, reading data
- analysis → detecting cycles, computing paths
- reporting → outputting tables and lists

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.
- Body text is not altered.

## Validation

- Identifier matches a normalized id pattern (e.g., kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints (inspection, analysis, reporting).
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Input: `/tm-overview`  
  Output:  
    # Overview  
    - Bullet summary of status, priority, dependencies  
    ## Totals  
    | status       | count | percent | notes         |  
    |--------------|-------|---------|---------------|  
    | pending      | 5     | 40%     | high volume   |  
    | in_progress  | 3     | 25%     | active        |  
    | blocked      | 1     | 8%      | dependency    |  
    | done         | 6     | 50%     | completed     |  
    ## Top Pending  
    | id   | title               | priority | unblockers          |  
    |------|---------------------|----------|---------------------|  
    | t-12 | Fix login timeout   | high     | resolve API error   |  
    | t-34 | Deploy frontend     | medium   | wait for backend    |  
    ## Critical Path  
    - t-12 → t-34 → t-56  
    ## Issues  
    - Cycle detected: t-78 → t-90 → t-78  
    - Missing reference: t-11 (no dependencies)  
    - Duplicate entry: t-44 appears twice  

---

# TaskMaster Overview

Trigger: /tm-overview

Purpose: Summarize the current TaskMaster tasks.json by status, priority, dependency health, and critical path to orient work.

Steps:

1. Locate the active tasks.json at repo root or the path supplied in the user message. Do not modify it.
2. Parse fields: id, title, description, status, priority, dependencies, subtasks.
3. Compute counts per status and a table of top pending items by priority.
4. Detect dependency issues: cycles, missing ids, orphans (no deps and not depended on).
5. Approximate a critical path: longest dependency chain among pending→in_progress tasks.

Output format:

- "# Overview" then a bullets summary.
- "## Totals" as a 4-column table: status | count | percent | notes.
- "## Top Pending" table: id | title | priority | unblockers.
- "## Critical Path" as an ordered list of ids with short titles.
- "## Issues" list for cycles, missing references, duplicates.

Examples:

- Input (Codex TUI): /tm-overview
- Output: tables and lists as specified. Keep to <= 200 lines.

Notes:

- Read-only. Assume statuses: pending | in_progress | blocked | done.
- If tasks.json is missing or invalid, output an "## Errors" section with a concise diagnosis.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
