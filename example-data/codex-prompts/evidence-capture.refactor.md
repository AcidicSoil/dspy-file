<!-- $1=claim text (e.g., "Next.js 15 requires React 19 RC"), $2=source metadata (URLs, titles), $3=publication date (ISO format) -->

# Evidence Logger

Trigger: $1

Purpose: Capture sources for a specified claim with dates, ≤25-word quotes, findings, relevance, and confidence.

Steps:

1. Read the claim text and optional URLs provided.
2. For each source, record metadata and a ≤25-word quote.
3. Add a brief Finding, Relevance (H/M/L), and Confidence (0.0–1.0).

Output format:

```
### Evidence Log
| SourceID | Title | Publisher | URL | PubDate | Accessed | Quote (≤25w) | Finding | Rel | Conf |
|---|---|---|---|---|---|---|---|---|---|
```

Examples:

- Input: `$1` with source metadata ($2)
- Output: Evidence table entries with dates.

Validation:
- Ensure $3 is valid ISO date or "n/a"
- Verify Quote ≤25 words
- Confirm Relevance is H/M/L and Confidence is 0.0–1.0

Notes:
- Mark missing PubDate as n/a. Prefer official documentation.
