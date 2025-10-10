<!-- $1=Trigger phrase (e.g., "/cross-check")
$2=Source IDs list (e.g., "S2: blog vs S5: RFC")
$3=Rationale phrase (e.g., "RFC prevails due to primary standard")
$4=Prevailing source ID (e.g., "S5")
$5=Reason for selection (e.g., "primary standard")
$6=Contradiction example (e.g., "S2 vs S5") -->

**Conflict Resolver**

Trigger: $1

Purpose: Compare conflicting findings and decide which source prevails with rationale.

Steps:

1. Accept a list of SourceIDs or URLs with short findings ($2).
2. Evaluate publisher authority, recency, directness to primary data.
3. Select the prevailing source; note contradictions and rationale.

Output format:

```
### Contradictions
- $6 → $3

### Prevails
- $4 because $5
```

Examples:

- Input: `$1 $2`
- Output: $3

Notes:

- Always explain why one source prevails.
