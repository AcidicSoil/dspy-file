# pr-desc

## Inputs
- Base branch: origin/main
- User context: <args>
- Changed files: from `git diff --name-status origin/main...HEAD`
- Diff stats: from `git diff --shortstat origin/main...HEAD`

## Canonical taxonomy (exact strings)
- drafting
- validation
- test coverage
- risk assessment

### Stage hints (for inference)
- implementation
- development
- review

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
- All outputs must align with the prompt structure and user intent.

## Validation
- Identifier matches a normalized id pattern (e.g., pr-desc).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: implementation, development, review.
- Dependencies are id-shaped (e.g., git diff commands) and ≤5.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- Identifier: pr-desc  
- Categories: drafting, validation, test coverage, risk assessment  
- Stage: implementation  
- Dependencies: git diff --name-status, git diff --shortstat  
- Artifacts: structured PR description, actionable recommendations, test gap report  
- Summary: "Draft a PR description from branch diff to achieve actionable insights and validation."
