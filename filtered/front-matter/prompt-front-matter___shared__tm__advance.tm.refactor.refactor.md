```md
# Advance Task(s)

## Metadata

- **Identifier**: `{{1}}`
- **Categories**: {{2}}
- **Lifecycle/Stage**: {{3}}
- **Dependencies**: {{4}}
- **Provided Artifacts**: {{5}}
- **Summary**: Do {{6}} to achieve {{7}}.

## Inputs

- Task IDs (e.g., `{{1}}`)
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

- Identifier matches a normalized id pattern (e.g., `{{1}}`).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3 and match output sections.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Input: `/tm-advance {{1}}`  
  Output:
  ```
  ## {{1}} — Title of Task
  ### Plan
  {{2}}
  ### Files
  {{3}}
  ### Tests
  {{4}}
  ### Acceptance
  {{5}}
  ### Commit Message
  {{6}}
  ```

  - Input: `/tm-advance {{7}}`
  - Output:
    ```
    ## {{7}} — Title of Task
    ### Plan
    {{8}}
    ### Files
    {{9}}
    ### Tests
    {{10}}
    ### Acceptance
    {{11}}
    ### Commit Message
    {{12}}
    ```
```
