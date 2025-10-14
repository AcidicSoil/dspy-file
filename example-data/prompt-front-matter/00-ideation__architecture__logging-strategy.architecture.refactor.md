# Logging Strategy

## Metadata

- identifier: logging-strategy
- categories: [observability, operations, security]
- stage: design
- dependencies: []
- provided_artifacts: ["diff hunks", "short guideline section"]
- summary: Do add or remove diagnostic logs with privacy in mind to achieve structured observability.

## Steps

1. Identify hotspots from recent failures.
2. Insert structured logs with contexts and correlation IDs.
3. Remove noisy or PII-leaking logs.
4. Document log levels and sampling in `OBSERVABILITY.md`.

## Output format

- Diff hunks and a short guideline section.
