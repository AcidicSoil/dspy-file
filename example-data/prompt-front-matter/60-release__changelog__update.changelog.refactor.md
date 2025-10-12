# Update CHANGELOG Template

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs
- `since=tag` (optional): starting tag for change range (e.g., v1.4.2)
- `notes=include-prs` (optional): include PR numbers in output

## Canonical taxonomy (exact strings)
- Added
- Changed
- Deprecated
- Removed
- Fixed
- Security

### Stage hints (for inference)
- generate: triggered by user input, produces static output
- process: data flow from source to structured result
- action: performs a specific operation on repository state

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
   * Example: git describe, git log, merge commits.

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.  
   * Examples: Markdown snippet, unified diff, link references block.

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
- All content must be end-user focused — avoid internal file paths or refactor notes.
- No secrets or internal ticket links.
- If no Conventional Commits, infer section from message heuristics.

## Validation
- Identifier matches a normalized id pattern (e.g., update-changelog).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3 and match expected outputs.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
```
## [Unreleased]
### Added
- Export CSV from reports page (#482)

### Changed
- Speed up dashboard load times on first visit (#479)

### Fixed
- Resolve 500 error when saving profile with empty bio (#481)

[Unreleased]: https://github.com/OWNER/REPO/compare/v1.4.2...HEAD
```
