```md
# Next Ready Tasks

## Metadata

- **identifier**: {{identifier}}
- **category**: {{category}}
- **lifecycle-stage**: {{lifecycle_stage}}
- **dependencies**: [{{dependency_id}}]
- **provided-artifacts**: {{artifacts_list}}
- **summary**: {{summary}}

## Inputs

- Trigger: /tm-next
- Input format: command string or task list
- Output format: structured table with id, title, priority, why_ready, prereqs; includes "No ready tasks" if none exist

## Canonical taxonomy (exact strings)

- task-management
- workflow-automation
- dependency-tracking
- status-reporting

### Stage hints (for inference)

- pending → waiting for dependencies
- blocked → requires unmet prerequisites
- ready-to-start → all dependencies met, status in {pending, blocked}
- execution → being worked on

## Algorithm

{{step_number}}. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

{{step_number}}. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

{{step_number}}. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).

{{step_number}}. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
   * Omit if uncertain.

{{step_number}}. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

{{step_number}}. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

{{step_number}}. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

{{step_number}}. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

{{step_number}}. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤ 7.
- All stages must map to known stage hints.
- Dependencies must be id-shaped (e.g., task-id).

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- Input: /tm-next  
  Output:  
  # Ready Now  
  | id | title | priority | why_ready | prereqs |  
  | --- | --- | --- | --- | --- |  
  | {{task_id}} | {{task_title}} | {{priority}} | Status is pending and dependency {{dependency}} is done | {{dependency_list}} |  
  | {{task_id_2}} | {{task_title_2}} | {{priority_2}} | Blocked status resolved, all prereqs met | {{dependency_list_2}} |  
  ## Notes  
  - Missing priority defaults to 0. Custom scales described in Notes.

- If no ready tasks:  
  "No ready tasks" followed by list of nearest-unblock candidates with their dependencies.
```
