/* Placeholder mapping:
- $1: Task IDs (e.g., TM-42, TM-43)
- $2: Task Title
- $3: Task Goals
- $4: Task Dependencies
- $5: Step-by-Step Plan (including file touch-points and test hooks)
- $6: File Touch-Points
- $7: Test Hooks */

# Advance Task(s)

Trigger: $1

Purpose: For given $1, produce a concrete work plan, acceptance criteria, tests, and a Conventional Commits message to move status toward done.

Steps:

1. Read tasks.json; resolve each provided $1. If none provided, pick the top item from /tm-next.
2. For each task: restate $2, $3, and $4.
3. Draft a step-by-step $5.
4. Provide a minimal commit plan and a Conventional Commits message with scope and short body.
5. List measurable acceptance criteria.

Output format:

- One section per task: "## $1 — $2"
- Subsections: Plan, Files, Tests, Acceptance, Commit Message (fenced)

Examples:

- Input: $1
- Output: structured sections with a commit message like `feat($2): implement $3`.

Notes:

- Do not mutate tasks.json. Emit proposed changes only.
