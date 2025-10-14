```md
# Conflict Resolver

Trigger: /cross-check

Purpose: Compare conflicting findings and decide which source prevails with rationale.

Steps:

1. Accept a list of SourceIDs or URLs with short findings.
2. Evaluate publisher authority, recency, directness to primary data.
3. Select the prevailing source; note contradictions and rationale.

Output format:

```
### Contradictions
- {1 vs 2 → rationale}

### Prevails
- {SourceID} because {reason}
```

Examples:

- Input: `/cross-check {1}: blog vs {2}: RFC`
- Output: RFC prevails due to primary standard.

Notes:

- Always explain why one source prevails.
```
