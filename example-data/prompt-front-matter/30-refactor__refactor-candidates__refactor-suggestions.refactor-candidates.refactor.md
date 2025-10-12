# Refactor Suggestions

Task: Given the following source text, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the source text.

## Inputs
- Source file path: C:\Users\user\projects\prompts\temp-prompts\30-refactor\refactor-candidates\refactor-suggestions.refactor-candidates.md
- Source content: # Refactor Suggestions\n\nTrigger: /refactor-suggestions\n\nPurpose: Propose repo-wide refactoring opportunities after tests exist.\n\n## Steps\n1. Map directory structure and large files.\n2. Identify duplication, data clumps, and god objects.\n3. Suggest phased refactors with safety checks and tests.\n\n## Output format\n- Ranked list with owners and effort estimates.

## Canonical taxonomy (exact strings)
- refactoring
- code quality
- analysis
- testing
- architecture
- documentation
- maintenance

### Stage hints (for inference)
- proposal
- analysis
- implementation
- review
- deployment
- monitoring

## Algorithm
1. Extract signals from the source text  
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
- Emit exactly one document: metadata, a single blank line, then the source text.
- Limit distinct placeholders to ≤ 7.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts, if present, are short and relevant (≤3).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- {"identifier": "refactor-suggestions", "category": ["refactoring", "code quality"], "stage": "analysis", "dependencies": ["tests"], "artifacts": ["ranked list with owners and effort estimates"], "summary": "Do propose repo-wide refactors to achieve structured, safe code improvements."}
- {"identifier": "code-review", "category": ["review", "quality"], "stage": "proposal", "dependencies": [], "artifacts": ["feedback report"], "summary": "Do conduct code reviews to achieve consistent coding standards."}
