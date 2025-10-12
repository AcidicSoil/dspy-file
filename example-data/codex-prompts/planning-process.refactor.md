# Planning Process

Trigger: $1

Purpose: $2

## Steps

1. If no plan file exists, create $3. If it exists, load it.
2. Draft sections: **Goal**, **User Story**, **Milestones**, **Tasks**, **Won't do**, **Ideas for later**, **Validation**, **Risks**.
3. Trim bloat. Convert vague bullets into testable tasks with acceptance criteria.
4. Tag each task with an owner and estimate. Link to files or paths that will change.
5. Maintain two backlogs: **Won't do** (explicit non-goals) and **Ideas for later** (deferrable work).
6. Mark tasks done after tests pass. Append commit SHAs next to completed items.
7. After each milestone: run tests, update **Validation**, then commit $4.

## Output format

- Update or create $5 with the sections above.
- Include a checklist for **Tasks**. Keep lines under 100 chars.

## Examples
**Input**: $6

**Output**:

- Goal: $7
- Tasks: $8
- Won't do: $9
- Ideas for later: $10

## Notes

- Planning only. No code edits.
- Assume a Git repo with test runner available.

<!-- Placeholder Mapping -->
- $1: Trigger phrase (e.g., "/planning-process")
- $2: Purpose statement
- $3: Plan file path (e.g., "PLAN.md")
- $4: Commit SHA to append
- $5: Plan file name (e.g., "PLAN.md")
- $6: Input feature request
- $7: Goal statement
- $8: Task checklist
- $9: Won't do items
- $10: Ideas for later
