<!-- $1 = input command (e.g., "/tm-next") -->
<!-- $2 = task data source (e.g., "tasks.json") -->
<!-- $3 = tie-break rules explanation (e.g., "Tie-breakers: tasks with fewer dependencies first") -->
<!-- $4 = priority handling note (e.g., "Missing priority treated as 0") -->

**Next Ready Tasks**

Trigger: $1

Purpose: List tasks that are ready to start now (no unmet dependencies), ordered by priority and dependency depth.

Steps:

1. Load $2 and build a map of id → task.
2. A task is ready if status ∈ {pending, blocked} AND all dependencies are done.
3. Order by: priority desc, then shortest path length to completion, then title.
4. For each ready task, include why it is ready and the prerequisites satisfied.

Output format:

- "# Ready Now"
- Table: id | title | priority | why_ready | prereqs
- "## Notes" for $3

Notes:
- Treat missing or null priority as 0. $4
