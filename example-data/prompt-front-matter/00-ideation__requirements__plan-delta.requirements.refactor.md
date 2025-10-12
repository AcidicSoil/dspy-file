# plan-delta

## Metadata

- **identifier**: plan-delta  
- **categories**: Planning, Task Management, Graph Maintenance  
- **lifecycle_stage**: Mid-Project Adjustment  
- **dependencies**: task graph history, user delta input  
- **provided_artifacts**: 
  - Updated tasks file (valid JSON)  
  - Delta document (Markdown with # Delta, ## Objectives, ## Constraints, ## Impacts, ## Decisions, ## Evidence)  
  - Readiness report (plain text: READY | BLOCKED | DEPRECATED)  
- **summary**: Orchestrate mid-project planning deltas to preserve history and update task graph readiness.

## Inputs

- User-provided delta text with objectives, constraints, findings
- Selection mode: Continue, Hybrid Rebaseline, Full Rebaseline
- Existing tasks file (tasks.json or equivalent)
- Repository context path for task and plan files

## Canonical taxonomy (exact strings)

Planning, Task Management, Graph Maintenance

### Stage hints (for inference)

Mid-project adjustment, delta update, planning revision, graph maintenance, readiness recalculation

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
- Limit distinct placeholders to ≤7.
- All outputs are strictly defined in the output format section.

## Validation

- Identifier matches a normalized id pattern (lowercase, kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped or context-based (≤5).
- Provided artifacts match exactly those listed in output format.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Input →  
  ```
  Mode: Continue
  New objectives: add offline export for tasks
  Constraints: no DB migrations
  Findings: existing export lib supports JSON only
  ```  

  Output →  
  - Updated `tasks.json` with new task `T-342` { title: "Add CSV export", dependencies: ["T-120"], source_doc: "delta-20250921.md", lineage: ["T-120"], supersedes: [] }.  
  - `artifacts/delta-20250921-160500.md` populated with objectives, constraints, impacts, decisions, evidence.  
  - Readiness report lists `T-342` under READY if deps done.

- Input →  
  ```
  Mode: Hybrid Rebaseline
  Changes: ~30% of scope affected by auth provider swap
  ```  

  Output →  
  - Minor-plan version bump recorded in Delta Doc.  
  - New tasks added for provider swap; prior tasks kept with `deprecated` or `blocked` and lineage links.
