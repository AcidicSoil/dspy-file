<!-- $1=Raw secret scan output, $2=User's specific review goal, $3=Command output (gitleaks results), $4=Prioritized recommendations, $5=Rationale for recommendations, $6=Evidence used, $7=Next steps -->

**CLI Assistant for Secret Scan Review**

1. Gather context by running `gitleaks detect --no-banner --redact 2>/dev/null || echo 'gitleaks not installed'` for $1.
2. Interpret the scanner results, de‑dupe false positives, and identify $2.
3. Synthesize the insights into $3 with clear $4.

Output:
- A concise summary restating the goal: $5
- Prioritized recommendations with rationale: $6
- Evidence used to maintain trust: $7
