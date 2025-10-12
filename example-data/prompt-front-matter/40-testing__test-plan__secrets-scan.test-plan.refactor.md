# Secrets Scan Review Plan

## Inputs
- CLI command: `gitleaks detect --no-banner --redact 2>/dev/null`
- Input context: scanner output (if available)

## Canonical taxonomy (exact strings)
- security
- review
- remediation

### Stage hints (for inference)
- analysis → assessment
- scan → review → action

## Algorithm
1. Extract signals from the prompt:
   - Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   - De-duplicate.
   - → `secrets-scan`

3. Determine categories:
   - Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   - Validate, sort deterministically, and de-dupe (≤3).
   - → security, review, remediation

4. Determine lifecycle/stage (optional):
   - Prefer explicit input; otherwise map categories via stage hints.
   - → assessment

5. Determine dependencies (optional):
   - Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   - → gitleaks detect output

6. Determine provided artifacts (optional):
   - Short list (≤3) of unlocked outputs.
   - → prioritized recommendations, structured report, evidence documentation

7. Compose summary:
   - One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   - → Review secret scan output and highlight real leaks to achieve actionable remediation with clear rationale.

8. Produce metadata in the requested format:
   - Identifier: secrets-scan
   - Categories: security, review, remediation
   - Stage: assessment
   - Dependencies: gitleaks detect output
   - Artifacts: prioritized recommendations, structured report, evidence documentation
   - Summary: Review secret scan output and highlight real leaks to achieve actionable remediation with clear rationale.

9. Reconcile if input already contains metadata:
   - Merge: explicit inputs > existing > inferred.
   - Validate lists; move unknowns to an extension field if needed.
   - Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original body unchanged.
- Limit distinct placeholders to ≤7.
- All outputs must preserve original structure and content.

## Validation
- Identifier matches a normalized id pattern. ✅
- Categories non-empty and drawn from canonical taxonomy (≤3). ✅
- Stage, if present, is one of the allowed stages implied by stage hints. ✅
- Dependencies, if present, are id-shaped (≤5). ✅
- Summary ≤120 chars; punctuation coherent. ✅
- Body text is not altered. ✅

## Output format examples
- Identifier: secrets-scan  
- Categories: security, review, remediation  
- Stage: assessment  
- Dependencies: gitleaks detect output  
- Artifacts: prioritized recommendations, structured report, evidence documentation  
- Summary: Review secret scan output and highlight real leaks to achieve actionable remediation with clear rationale  

---

You are a CLI assistant focused on helping contributors with the task: Review secret scan output and highlight real leaks.

1. Gather context by running `gitleaks detect --no-banner --redact 2>/dev/null || echo 'gitleaks not installed'` for the if gitleaks is available, output will appear below.
2. Interpret the scanner results, de‑dupe false positives, and propose rotations/remediation.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Review secret scan output and highlight real leaks.
- Offer prioritized, actionable recommendations with rationale.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
(none – command runs without arguments)

Expected Output:

- Structured report following the specified sections.
