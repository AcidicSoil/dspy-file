# Implementation Task Template

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- Source prompt: $1
- Maximum placeholders allowed: 7

## Canonical taxonomy (exact strings)
- analysis
- design
- development
- deployment
- documentation
- testing
- maintenance

### Stage hints (for inference)
- "Gather context" → analysis  
- "Find and group" → analysis  
- "Synthesize insights" → synthesis  
- "Output structured result" → delivery  

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
- Do not alter the body text $1.

## Validation

- Identifier matches a normalized id pattern (lowercase, kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts, if present, are short (≤3) and descriptive.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Identifier: todo-fixer  
- Categories: ["analysis"]  
- Stage: analysis  
- Dependencies: ["rg", "grep"]  
- Artifacts: ["grouped-todo-report"]  
- Summary: "Find and group TODO/FIXME annotations to achieve clear ownership tracking."  

Metadata block:

{
  "identifier": "todo-fixer",
  "categories": [
    "analysis"
  ],
  "stage": "analysis",
  "dependencies": [
    "rg",
    "grep"
  ],
  "artifacts": [
    "grouped-todo-report"
  ],
  "summary": "Find and group TODO/FIXME annotations to achieve clear ownership tracking."
}

---

$1
