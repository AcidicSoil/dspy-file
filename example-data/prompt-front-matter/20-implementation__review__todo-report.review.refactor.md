# todo-summary

## Inputs
- Command: `rg -n "TODO|FIXME|XXX" -g '!node_modules' . || grep -RInE 'TODO|FIXME|XXX' .`
- Input arguments: none

## Canonical taxonomy (exact strings)
- codebase analysis
- triage planning
- contributor guidance
- documentation review
- dependency resolution
- security audit
- performance optimization

### Stage hints (for inference)
- execution
- analysis
- reporting
- planning
- onboarding
- maintenance
- development

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
- Do not alter the original body content.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts are concise and relevant (≤3).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: todo-summary  
  Categories: codebase analysis, triage planning, contributor guidance  
  Stage: execution  
  Dependencies: none  
  Artifacts: prioritized triage plan, summary of TODO/FIXME/XXX groupings, actionable recommendations  
  Summary: Summarize TODO/FIXME/XXX annotations across the codebase to propose a prioritized triage plan.
