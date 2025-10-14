```md
# Logging Strategy

## Metadata

- identifier: {identifier}
- categories: [{categories}]
- stage: {stage}
- dependencies: {dependencies}
- provided_artifacts: ["{provided_artifacts}"]
- summary: {summary}

## Steps

1. Identify hotspots from recent failures.
2. Insert structured logs with contexts and correlation IDs.
3. Remove noisy or PII-leaking logs.
4. Document log levels and sampling in `OBSERVABILITY.md`.

## Output format

- Diff hunks and a short guideline section.
```
