# Blocker Diagnosis

## Inputs
- target_id (string): The unique identifier of the task to diagnose.
- tasks.json (file): JSON file containing task metadata and dependencies.

## Canonical taxonomy (exact strings)
- dependency
- ambiguity
- environment
- CI
- external

### Stage hints (for inference)
- diagnosis → assessment
- assessment → unblocking proposal

## Algorithm
1. Extract signals from the content:
   - Titles/headings: "Blocker Diagnosis", "Purpose", "Steps", "Output format"
   - Imperative verbs: "Diagnose", "Enumerate", "Classify", "Propose"
   - Explicit tags: "dependency", "ambiguity", "environment", "CI", "external"

2. Determine the primary identifier:
   - Prefer explicit input: `target_id`
   - Normalize to kebab-case, lowercase, and length-capped (e.g., TM-17 → tm-17)

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings.
   - Final list: dependency, ambiguity, environment, CI, external
   - Validated and de-duplicated

4. Determine lifecycle/stage (optional):
   - Map "diagnosis" to stage "assessment"
   - Omit if not explicitly stated

5. Determine dependencies (optional):
   - Required inputs: tasks.json, target_id
   - Id-shaped items only (e.g., TM-17)

6. Determine provided artifacts (optional):
   - Two tables: blockers (type | item | evidence), actions (step | owner | effort | success_criteria)
   - A narrative under "Findings"

7. Compose summary:
   - "Diagnose why a task is blocked and propose minimal unblocking paths."

8. Produce metadata in the requested format:
   - Identifier: tm-17
   - Categories: dependency, ambiguity, environment, CI, external
   - Stage: assessment
   - Dependencies: tasks.json, target_id
   - Artifacts: blockers table, actions table, findings narrative
   - Summary: Diagnose why a task is blocked and propose minimal unblocking paths.

9. Reconcile if input already contains metadata:
   - No explicit metadata present; all inferred from content.
   - Final output uses only valid, canonical values.

## Assumptions & Constraints
- Emit exactly one document: metadata block, blank line, then original body unchanged.
- Limit distinct placeholders to ≤7 (here: 6 used).
- All categories must be in the canonical list.
- Stage must map to a known stage via hints.

## Validation
- Identifier matches kebab-case pattern (e.g., tm-17)
- Categories non-empty and drawn from canonical taxonomy (≤5)
- Stage is "assessment" — valid per hint mapping
- Dependencies are id-shaped: tasks.json, target_id
- Artifacts: exactly two tables + narrative
- Summary ≤120 chars; punctuation coherent

## Output format examples
- Identifier: tm-17  
- Categories: dependency, ambiguity, environment, CI, external  
- Stage: assessment  
- Dependencies: tasks.json, target_id  
- Artifacts: blockers table, actions table, findings narrative  
- Summary: Diagnose why a task is blocked and propose minimal unblocking paths.  

---

# Blocker Diagnosis

Trigger: /tm-blockers

Purpose: Diagnose why a task is blocked and propose the shortest path to unblock it.

Steps:

1. Load tasks.json and the target id.
2. Enumerate unmet dependencies and missing artifacts (tests, docs, approvals).
3. Classify each blocker: dependency, ambiguity, environment, CI, external.
4. Propose 1–3 minimal unblocking actions, each with owner, effort, and success check.

Output format:

- "# Blocker Report: <id>"
- Tables: blockers (type | item | evidence), actions (step | owner | effort | success_criteria).

Examples:

- Input: /tm-blockers TM-17
- Output: two tables and a short narrative under "Findings".

Notes:

- If the task is not actually blocked, state why and redirect to /tm-advance.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
