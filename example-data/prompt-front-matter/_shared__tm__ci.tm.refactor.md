# CI/Test Checklist from Tasks

## Inputs
- Identifier: /tm-ci  
- Dependencies: /tm-next  
- Output Format: 
  - "# CI Plan"
  - Tables: jobs (name | trigger | commands | est_time) and tests (scope | command | expected_artifacts)
  - "## Risk Areas" bullets and "## Follow-ups"

## Canonical taxonomy (exact strings)
- CI Plan
- Testing
- Risk Areas
- Follow-ups

### Stage hints (for inference)
- Planning: When deriving a near-term plan from task data.
- Execution: If actual jobs are triggered or run.

## Algorithm
1. Extract signals from the input text  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.  

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  
   → Identifier: `/tm-ci`  

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).  
   → Categories: CI Plan, Testing, Risk Areas, Follow-ups  

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.  
   → Stage: Planning  

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).  
   → Dependencies: /tm-next  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.  
   → Artifacts: CI jobs table, test table, risk bullets, follow-up items  

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”  
   → Summary: Do derive a near-term CI and test checklist from ready and in-progress tasks to achieve structured planning for automated testing.  

8. Produce metadata in the requested format  
   * Default to human-readable serialization; honor any requested alternative.  

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.  

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤7.

## Validation
- Identifier matches normalized id pattern (kebab-case, starts with letter). ✅
- Categories non-empty and drawn from canonical taxonomy (≤4) → valid. ✅
- Stage present and implied by "Planning" hint. ✅
- Dependencies are id-shaped and within limit. ✅
- Artifacts are concise and relevant. ✅
- Summary ≤120 chars; punctuation coherent. ✅
- Body text is not altered. ✅

## Output format examples
- Identifier: /tm-ci  
- Categories: CI Plan, Testing, Risk Areas, Follow-ups  
- Stage: Planning  
- Dependencies: /tm-next  
- Artifacts: CI jobs table, test table, risk bullets, follow-up items  
- Summary: Do derive a near-term CI and test checklist from ready and in-progress tasks to achieve structured planning for automated testing.

---

# CI/Test Checklist from Tasks

Trigger: /tm-ci

Purpose: Derive a near-term CI and test checklist from ready and in-progress tasks.

Steps:

1. Compute ready tasks (see /tm-next) and collect any testStrategy fields.
2. Group by component or tag if available; otherwise by path keywords in titles.
3. Propose CI jobs and test commands with approximate runtimes and gating rules.
4. Include a smoke-test matrix and minimal code coverage targets if relevant.

Output format:

- "# CI Plan"
- Tables: jobs (name | trigger | commands | est_time) and tests (scope | command | expected_artifacts).
- "## Risk Areas" bullets and "## Follow-ups".

Examples:

- Input: /tm-ci
- Output: one CI plan with 3–8 jobs and a test table.

Notes:

- Non-binding guidance. Adapt to the repo’s actual CI system.
