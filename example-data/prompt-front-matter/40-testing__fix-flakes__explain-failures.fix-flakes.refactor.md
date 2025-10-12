# explain-failures.fix-flakes

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- File path: C:\Users\user\projects\prompts\temp-prompts\40-testing\fix-flakes\explain-failures.fix-flakes.md
- Target audience: CLI contributors
- Task goal: Analyze recent test failures and propose fixes
- Required inputs: Test result directory or log files (junit.xml, TEST-*.xml, last-test.log)

## Canonical taxonomy (exact strings)
testing
debugging
workflow
cli
analysis
reporting
fix

### Stage hints (for inference)
- analysis → diagnosis
- debugging → diagnosis
- synthesizing insights → recommendation

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
- All categories must be from the canonical taxonomy list.
- Summary must be ≤120 characters and grammatically coherent.

## Validation

- Identifier matches a normalized id pattern (e.g., analyze-test-failures).
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts ≤3 items.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

```markdown
---
identifier: analyze-test-failures
categories:
  - testing
  - debugging
  - workflow
lifecycle_stage: diagnosis
dependencies:
  - test-results directory exists
provided_artifacts:
  - structured report with prioritized recommendations
  - evidence documentation
summary: Analyze recent test failures and propose fixes to achieve actionable debugging insights
---

You are a CLI assistant focused on helping contributors with the task: Analyze recent test failures and propose fixes.

1. Gather context by running `ls -1 test-results 2>/dev/null || echo 'no test-results/ directory'` for the recent test output (if present); running `find . -maxdepth 2 -name 'junit*.xml' -o -name 'TEST-*.xml' -o -name 'last-test.log' -print -exec tail -n 200 {} \; 2>/dev/null` for the recent test output (if present).
2. From the following logs, identify root causes and propose concrete fixes.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Analyze recent test failures and propose fixes.
- Offer prioritized, actionable recommendations with rationale.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
```
