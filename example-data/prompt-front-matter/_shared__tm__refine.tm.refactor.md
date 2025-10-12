# Refine Task into Subtasks

Task: Given a task ID and description, expand it into actionable subtasks with clear acceptance criteria.

## Inputs

- `task_id`: A string identifier (e.g., TM-09) for the original task.
- `description`: The full text of the original task to refine.

## Canonical taxonomy (exact strings)

- task refinement
- planning
- subtask decomposition
- acceptance criteria
- dependency mapping
- output formatting

### Stage hints (for inference)

- planning → when analyzing scope and breaking down tasks
- design → when defining structure or templates
- execution → when implementing actions directly

## Algorithm

1. Extract signals from input  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.*

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.*  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).*  
   * De-duplicate.*

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.*  
   * Validate, sort deterministically, and de-dupe (≤3).*

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.*  
   * Omit if uncertain.*

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).*  

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.*

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”*

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.*

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.*  
   * Validate lists; move unknowns to an extension field if needed.*  
   * Remove empty keys.*

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
- Do not assume authority to change files; provide patches the user can apply.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts are among: table, JSON patch, summary.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples

- Identifier: `tm-refine-tm-09`  
- Categories: ["task refinement", "planning", "subtask decomposition"]  
- Stage: planning  
- Dependencies: ["tm-refine-tm-08"]  
- Artifacts: ["Markdown table of subtasks", "JSON Patch array"]  
- Summary: "Refine a vague task into actionable subtasks with acceptance criteria and suggest edits."
