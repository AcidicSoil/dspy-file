# Summarize Changed Files

Task: Given the following specification, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original body.

## Inputs
- Source: CLI assistant task to summarize changed files between HEAD and origin/main.
- Goal: Provide maintainers with a trustworthy, structured report of changes.

## Canonical taxonomy (exact strings)
- changed-file-summary
- git-diff-analysis
- risky-change-alert

### Stage hints (for inference)
- analysis
- inspection
- routine-review

## Algorithm
1. Extract signals from the specification  
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
- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤7.
- All categories must be from canonical taxonomy.
- Summary must not exceed 120 characters and use coherent punctuation.

## Validation
- Identifier matches a normalized id pattern (lowercase, kebab-case).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts list ≤3 items.
- Summary ≤120 chars; punctuation coherent.
- Body text remains unaltered.

## Output format examples
- Identifier: summarize-changed-files  
- Categories: changed-file-summary, git-diff-analysis, risky-change-alert  
- Stage: analysis  
- Dependencies: git diff  
- Artifacts: structured report, summary, risk callout  
- Summary: Do summarize changed files between HEAD and origin/main to achieve transparent, trustworthy change insights.
  
---

You are a CLI assistant focused on helping contributors with the task: Summarize changed files between HEAD and origin/main.

1. Gather context by running `git diff --name-status origin/main...HEAD`.
2. List and categorize changed files: added/modified/renamed/deleted. Call out risky changes.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Summarize changed files between HEAD and origin/main.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
