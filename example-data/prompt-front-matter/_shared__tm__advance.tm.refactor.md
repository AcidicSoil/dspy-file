# Advance Task(s)

## Metadata

- **Identifier**: `tm-42`, `tm-43`
- **Categories**: Planning, Testing, Commit, Acceptance
- **Lifecycle/Stage**: plan-and-prepare
- **Dependencies**: [related dependencies from tasks.json]
- **Provided Artifacts**: Plan, Tests, Acceptance Criteria, Conventional Commits Message
- **Summary**: Do advance tasks by producing a work plan, tests, and commit message to move toward done.

## Inputs

- Task IDs (e.g., `TM-42`, `TM-43`)
- Tasks.json file for reference (not mutated)

## Canonical taxonomy (exact strings)

Planning, Testing, Commit, Acceptance

### Stage hints (for inference)

advance → plan-and-prepare  
plan → planning  
test → testing  
commit → commit  
acceptance → acceptance  

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
- Do not mutate tasks.json. Emit proposed changes only.

## Validation

- Identifier matches a normalized id pattern (e.g., `tm-42`).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3 and match output sections.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Input: `/tm-advance TM-42 TM-43`  
  Output:
  ```
  ## tm-42 — Title of Task
  ### Plan
  ...
  ### Files
  ...
  ### Tests
  ...
  ### Acceptance
  ...
  ### Commit Message
  feat(parser): implement rule X
  ```

  - Input: `/tm-advance TM-43`
  - Output:
    ```
    ## tm-43 — Title of Task
    ### Plan
    ...
    ### Files
    ...
    ### Tests
    ...
    ### Acceptance
    ...
    ### Commit Message
    fix(ui): resolve layout issue
    ```
