<!-- $1=PRD input command (e.g., "/tm-delta ./prd.txt"), $2=tasks.json path, $3=PRD content, $4=Delta Summary, $5=Adds table, $6=Updates table, $7=Removals table -->

**PRD Tasks Delta**

Trigger: $1

Purpose: Compare $3 against $2 and propose add/update/remove operations.

Steps:

1. Accept $3 pasted by user or $1. If absent, output template asking for input.
2. Extract objectives, constraints, deliverables, and milestones from $3.
3. Map them to tasks in $2 by fuzzy match; detect gaps.
4. Propose: new tasks, updates to titles/descriptions/priority, and deprecations.

Output format:

- $4
- Tables: $5 | $6 | $7
- "## JSON Patch" with ordered list of operations: add/replace/remove
- "## Assumptions" and "## Open Questions"
- "## Root cause" (detected gaps)
- "## Proposed fix" (delta operations)

Examples:

- Input: $1
- Output: $5, $6, $7 with minimal JSON Patch

Notes:

- Keep patches minimal and reversible. Flag destructive changes explicitly.
- Validate all changes through $7 (removals) before finalization.
