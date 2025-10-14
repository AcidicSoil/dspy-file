```md
# Planning Process

## Metadata

- identifier: {identifier}
- categories: 
  - {category_1}
  - {category_2}
  - {category_3}
- stage: {stage}
- dependencies: 
  - {dependency_1}
  - {dependency_2}
  - {dependency_3}
  - {dependency_4}
  - {dependency_5}
- provided-artifacts: 
  - {artifact_1}
  - {artifact_2}
  - {artifact_3}
- summary: {summary}

## Inputs

- Trigger: {trigger}
- Purpose: {purpose}
- Output format: {output_format}
- Examples:
  - Input: "{input_example}"
  - Output:
    - Goal: {goal}
    - Tasks: [ ] {task_1}, [ ] {task_2}, [ ] {task_3}, [ ] {task_4}.
    - Won't do: {won_t_do}
    - Ideas for later: {ideas_for_later}
- Notes:
  - {note_1}
  - {note_2}

## Canonical taxonomy (exact strings)

- planning
- task-management
- risk-assessment
- validation

### Stage hints (for inference)

- planning → planning
- task management → planning or execution
- validation → validation or testing
- risk assessment → planning or review

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs $5.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via $6.  
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
- Do not alter the body text.

## Validation

- Identifier matches a normalized id pattern (kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts ≤3 items.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- Metadata block:
  - identifier: {identifier}
  - categories: 
    - planning
    - task-management
    - risk-assessment
    - validation
  - stage: {stage}
  - dependencies: 
    - PLAN.md exists or is created
    - Git repository with test runner available
  - provided-artifacts: 
    - updated PLAN.md with structured sections and checklist
  - summary: {summary}

- Body text (unchanged):
  # Planning Process

  Trigger: {trigger}

  Purpose: {purpose}

  ## Steps

  1. If no plan file exists, create `PLAN.md`. If it exists, load it.
  2. Draft sections: **Goal**, **User Story**, **Milestones**, **Tasks**, **Won't do**, **Ideas for later**, **Validation**, **Risks**.
  3. Trim bloat. Convert vague bullets into testable tasks with acceptance criteria.
  4. Tag each task with an owner and estimate. Link to files or paths that will change.
  5. Maintain two backlogs: **Won't do** (explicit non-goals) and **Ideas for later** (deferrable work).
  6. Mark tasks done after tests pass. Append commit SHAs next to completed items.
  7. After each milestone: run tests, update **Validation**, then commit `PLAN.md`.

  ## Output format

  - Update or create `PLAN.md` with the sections above.
  - Include a checklist for **Tasks**. Keep lines under 100 chars.

  ## Examples
  **Input**: "{input_example}"

  **Output**:

  - Goal: {goal}
  - Tasks: [ ] {task_1}, [ ] {task_2}, [ ] {task_3}, [ ] {task_4}.
  - Won't do: {won_t_do}
  - Ideas for later: {ideas_for_later}

  ## Notes

  - {note_1}
  - {note_2}
```
