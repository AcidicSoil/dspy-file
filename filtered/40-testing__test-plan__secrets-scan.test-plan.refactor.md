```md
# Secret Scan Review Report

## Summary
Review secret scan output and highlight real leaks.

## Prioritized Recommendations
1. [ ] Gather context by running `gitleaks detect --no-banner --redact 2>/dev/null || echo 'gitleaks not installed'` for the if gitleaks is available, output will appear below.
2. [ ] Interpret the scanner results, de‑dupe false positives, and propose rotations/remediation.
3. [ ] Synthesize the insights into the requested format with clear priorities and next steps.

## Evidence Documentation
- [ ] Document the evidence you used so maintainers can trust the conclusion.

## Example Input
(none – command runs without arguments)

## Expected Output
- Structured report following the specified sections.
```
