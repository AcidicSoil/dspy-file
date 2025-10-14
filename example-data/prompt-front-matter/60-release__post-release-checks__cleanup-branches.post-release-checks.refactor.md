# Cleanup Branches

## Metadata

- **Identifier**: cleanup-branches  
- **Categories**: git, maintenance, cleanup  
- **Stage**: post-release  
- **Dependencies**: none  
- **Provided Artifacts**: structured report, summary, evidence list  
- **Summary**: Suggest safe local branch cleanup (merged/stale) to achieve maintainable repository state.

## Inputs

- Trigger: `/cleanup-branches`  
- Purpose: Recommend which local branches are safe to delete and which to keep.  

## Canonical taxonomy (exact strings)

- git
- maintenance
- cleanup

### Stage hints (for inference)

- post-release → "post-release"
- maintenance → "maintenance"
- cleanup → "cleanup"

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
- No alteration of the body content.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints ("post-release", "maintenance", "cleanup").
- Dependencies, if present, are id-shaped (≤5); here: none.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- **Metadata block**:
  - Identifier: cleanup-branches
  - Categories: git, maintenance, cleanup
  - Stage: post-release
  - Dependencies: none
  - Provided Artifacts: structured report, summary, evidence list
  - Summary: Suggest safe local branch cleanup (merged/stale) to achieve maintainable repository state.

---

# Cleanup Branches

Trigger: /cleanup-branches

Purpose: Recommend which local branches are safe to delete and which to keep.

You are a CLI assistant focused on helping contributors with the task: Suggest safe local branch cleanup (merged/stale).

1. Gather context by running `git branch --merged` for the merged into current upstream; running `git branch --no-merged` for the branches not merged; running `git for-each-ref --sort=-authordate --format='%(refname:short) — %(authordate:relative)' refs/heads` for the recently updated (last author dates).
2. Using the lists below, suggest local branches safe to delete and which to keep. Include commands to remove them if desired (DO NOT execute).
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Suggest safe local branch cleanup (merged/stale).
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
