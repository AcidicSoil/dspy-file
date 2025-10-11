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

  - `$1`: <reason>

- **Root cause:**

  - `$2`: <concise explanation>

- **Proposed fix:**

  - `$3`: <steps/patch outline>

  - **Tests:**

- **Documentation gaps:**

  - `$4`: <doc_section_what_to_update_add>

- **Open questions/assumptions:**

  - `$5`: <items>

**Note:** The problem description is captured in $1. The remaining fields are mapped to $2–$5 for the output structure. The template expects exactly 5 outputs (excluding $1) to match the 5 task outcomes.
