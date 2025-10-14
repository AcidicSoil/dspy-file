# problem-analyzer

<problem>
$1
</problem>

**Tasks:**
1. Locate all files/modules affected by the issue. List paths and why each is implicated.
2. Explain the root cause(s): what changed, how it propagates to the failure, and any environmental factors.
3. Propose the minimal, safe fix. Include code-level steps, side effects, and tests to add/update.
4. Flag any missing or outdated documentation/configs/schemas that should be updated or added (especially if code appears outdated vs. current behavior).

**Output format:**
- **Affected files:**
  - `$1`: `<reason>`
- **Root cause:**
  - `$2`: `<concise explanation>`
- **Proposed fix:**
  - `$3`: `<steps/patch outline>`
  - **Tests:**
- **Documentation gaps:**
  - `$4`: `<doc_section_what_to_update_add>`
- **Open questions/assumptions:**
  - `$5`: `<items>`

**DON'T CODE YET.**

{
  "args": [
    {
      "id": "$1",
      "name": "problem_statement",
      "hint": "Describe the issue or problem to analyze",
      "example": "A crash occurs when accessing a null pointer in the user session module.",
      "required": true,
      "validate": "regex"
    },
    {
      "id": "$2",
      "name": "root_cause_explanation",
      "hint": "Explain the underlying cause of the problem",
      "example": "The session manager does not initialize the user context before access.",
      "required": true,
      "validate": "regex"
    },
    {
      "id": "$3",
      "name": "proposed_fix_steps",
      "hint": "List minimal, safe steps to fix the problem",
      "example": "Initialize user context before accessing session data.",
      "required": true,
      "validate": "regex"
    },
    {
      "id": "$4",
      "name": "documentation_gaps",
      "hint": "Identify missing or outdated documentation/configs/schemas to update",
      "example": "User session initialization flow is not documented in the API spec.",
      "required": true,
      "validate": "regex"
    },
    {
      "id": "$5",
      "name": "open_questions_assumptions",
      "hint": "List assumptions or open questions that need clarification",
      "example": "Is there a fallback mechanism if user context fails to initialize?",
      "required": true,
      "validate": "regex"
    }
  ]
}
