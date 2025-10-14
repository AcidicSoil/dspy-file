# Version Control Guide

## Metadata

- **Identifier**: version-control-guide
- **Categories**: development practice, workflow guide, code hygiene
- **Stage**: implementation
- **Dependencies**: none
- **Provided Artifacts**: checklist, suggested commands
- **Summary**: Enforce clean incremental commits and clean-room re-implementation to ensure reproducible and safe changes.

## Inputs

- Trigger: /version-control-guide
- Purpose: Enforce clean incremental commits and clean-room re-implementation when finalizing.
- Output format: Checklist plus suggested commands for the current repo state.
- Examples: Convert messy spike into three commits: setup, feature, tests.
- Notes: Never modify remote branches without confirmation.

## Canonical taxonomy (exact strings)

- development practice
- workflow guide
- code hygiene

### Stage hints (for inference)

- implementation
- commit workflow
- development lifecycle

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
- Output body unchanged.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Identifier: version-control-guide  
- Categories: development practice, workflow guide, code hygiene  
- Stage: implementation  
- Dependencies: none  
- Provided Artifacts: checklist, suggested commands  
- Summary: Enforce clean incremental commits and clean-room re-implementation to ensure reproducible and safe changes.

# Version Control Guide

Trigger: /version-control-guide

Purpose: Enforce clean incremental commits and clean-room re-implementation when finalizing.

## Steps

1. Start each feature from a clean branch: `git switch -c <feat>`.
2. Commit in vertical slices with passing tests: `git add -p && git commit`.
3. When solution is proven, recreate a minimal clean diff: stash or copy results, reset, then apply only the final changes.
4. Use `git revert` for bad commits instead of force-pushing shared branches.

## Output format

- Checklist plus suggested commands for the current repo state.

## Examples

- Convert messy spike into three commits: setup, feature, tests.

## Notes

- Never modify remote branches without confirmation.
