```md
# E2E Runner Setup

## Metadata

- **Identifier**: {{identifier}}
- **Categories**: {{categories}}
- **Lifecycle Stage**: {{lifecycle_stage}}
- **Dependencies**: {{dependencies}}
- **Provided Artifacts**: {{artifacts}}
- **Summary**: {{summary}}

---

# E2E Runner Setup

Trigger: /e2e-runner-setup <{{runner_type}}>

Purpose: Configure an end-to-end test runner with fixtures and a data sandbox.

**Steps:**

1. Install runner and add config with baseURL, retries, trace/videos on retry only.
2. Create fixtures for auth, db reset, and network stubs. Add `test:serve` script.
3. Provide CI job that boots services, runs E2E, uploads artifacts.

**Output format:** file list, scripts, and CI snippet fenced code block.

**Examples:** `/e2e-runner-setup {{runner_type}}`.

**Notes:** Keep runs under 10 minutes locally; parallelize spec files.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
