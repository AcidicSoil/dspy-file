# blame-summary

Task: Given a source file path, produce a summary of authorship hotspots using git blame to identify top contributors and suggest reviewers.

## Inputs
- `file_path`: Path to the target source file (e.g., src/components/Button.tsx)
- `args`: Arguments passed to `git blame` command (e.g., `--line-porcelain`)

## Canonical taxonomy (exact strings)
- ownership-hotspots
- reviewer-suggestions
- code-analysis

### Stage hints (for inference)
- analysis
- inspection
- synthesis

## Algorithm
1. Extract signals from the input
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
- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤7.
- All categories must be drawn from canonical taxonomy.
- Stage, if present, must match one of the stage hints.

## Validation
- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of: analysis, inspection, synthesis.
- Dependencies are id-shaped (e.g., git-blame) and ≤5.
- Provided artifacts are short (≤3) and relevant to output.
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Identifier: blame-summary
- Categories: ownership-hotspots, reviewer-suggestions, code-analysis
- Stage: analysis
- Dependencies: git-blame
- Artifacts: summary-of-authorship-hotspots, reviewer-suggestions, prioritized-insights
- Summary: Summarize authorship hotspots for a file using git blame to identify top contributors and suggest reviewers.
- Output body:
  - Begin with a concise summary that restates the goal: Summarize authorship hotspots for a file using git blame.
  - Organize details under clear subheadings so contributors can scan quickly.
  - Reference evidence from CODEOWNERS or git history for each owner suggestion.

Example Input:
src/components/Button.tsx

Expected Output:
- Refactor proposal extracting shared styling hook with before/after snippet.
