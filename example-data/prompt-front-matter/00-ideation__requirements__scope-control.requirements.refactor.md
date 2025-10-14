# Scope Control

Task: Given the following requirements text, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the input text.

## Inputs
- Source file path: C:\Users\user\projects\prompts\temp-prompts\00-ideation\requirements\scope-control.requirements.md
- Input content: # Scope Control\n\nTrigger: /scope-control\n\nPurpose: Enforce explicit scope boundaries and maintain \"won't do\" and \"ideas for later\" lists.\n\n## Steps\n1. Parse `PLAN.md` or create it if absent.\n2. For each open task, confirm linkage to the current milestone.\n3. Detect off-scope items and move them to **Won't do** or **Ideas for later** with rationale.\n4. Add a \"Scope Gate\" checklist before merging.\n\n## Output format\n- Patch to `PLAN.md` showing changes in sections and checklists.\n\n## Examples\nInput: off-scope request \"Add email templates\" during OAuth feature.\nOutput: Move to **Ideas for later** with reason \"Not needed for OAuth MVP\".\n\n## Notes\n- Never add new scope without recording tradeoffs.

## Canonical taxonomy (exact strings)
- Won't do
- Ideas for later

### Stage hints (for inference)
- review
- gatekeeping
- validation

## Algorithm
1. Extract signals from input text  
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
- Emit exactly one document: metadata, a single blank line, then the input text.
- Limit distinct placeholders to ≤ 7.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts, if present, are short (≤3) and specific.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Identifier: scope-control  
- Categories: Won't do, Ideas for later  
- Stage: review  
- Dependencies: plan.md  
- Artifacts: patch to PLAN.md  
- Summary: Do enforce scope boundaries by detecting off-scope items and moving them to Won't do or Ideas for later to achieve controlled feature development.
