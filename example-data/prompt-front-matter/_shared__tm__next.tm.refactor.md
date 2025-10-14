# Next Ready Tasks

## Metadata

- **identifier**: task-id
- **category**: task-management
- **lifecycle-stage**: ready-to-start
- **dependencies**: [dependency-id]
- **provided-artifacts**: table-of-ready-tasks, notes-on-tie-breaks
- **summary**: List tasks ready to start by checking status and dependencies.

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
  | t1 | Fix login bug | 5 | Status is pending and dependency d2 is done | d2 |  
  | t2 | Deploy v2.0 | 4 | Blocked status resolved, all prereqs met | d3, d4 |  
  ## Notes  
  - Missing priority defaults to 0. Custom scales described in Notes.

- If no ready tasks:  
  "No ready tasks" followed by list of nearest-unblock candidates with their dependencies.
