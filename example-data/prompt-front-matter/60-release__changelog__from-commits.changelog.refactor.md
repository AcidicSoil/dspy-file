# Draft CHANGELOG From Commits

## Inputs
- since=<ref or tag> (optional)
- until=<ref> (default HEAD)
- include_prs=true|false (default true)

## Canonical taxonomy (exact strings)
- Added
- Fixed
- Changed
- Deprecated
- Removed
- Security

### Stage hints (for inference)
- draft → pre-release stage
- finalized → final stage
- pre-release → pre-release stage

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
- All categories must be from the canonical taxonomy (exact strings).
- Stage, if present, is one of: draft, final, pre-release.
- Dependencies are id-shaped (e.g., since, until) and ≤5 items.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: draft, final, pre-release.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
Input → `/changelog-from-commits since=v2.0.0 until=HEAD`  
Output →  

```
Range: v2.0.0..HEAD

### Added
- Import data from XLSX (#612)

### Fixed
- Correct null check in OAuth callback (#615)
```

Notes:
- This is a draft; run `/update-changelog` to finalize and create links.
- Keep bullets user-facing; avoid internal refactor noise.
