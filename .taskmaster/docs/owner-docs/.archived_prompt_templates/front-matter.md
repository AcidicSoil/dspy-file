# dspy-file_front-matter_template

Task: Given a prompt Markdown body ($1), generate or fix **front-matter** so the file is machine-parsable by the ranker/sequencer. Then emit the **front-matter followed by the original body unchanged**.

Front-matter must expose: `id`, `categories` (or `category`), optional `stage`, `depends_on`, `provides`, `summary`. Use the canonical taxonomy and rules below.

Inputs

- $1 = source Markdown body (no existing front-matter assumed; if present, reconcile/normalize)
- $2 = preferred id/slug (optional; kebab-case). If empty, infer.
- $3 = preferred categories (optional; comma-separated from taxonomy). If empty, infer.
- $4 = default stage (optional; one of: ideation, scaffold, implementation, refactor, testing, docs, release). If empty, infer or omit.
- $5 = output format (optional; one of: yaml, toml, json). Default: yaml.

Canonical taxonomy (exact strings)

design, requirements, architecture, scaffold, conventions, ci-setup, spec-orient, impl, review, refactor-candidates, refactor, perf, test-plan, gen-tests, fix-flakes, coverage, doc-plan, examples, api-docs, site-sync, versioning, changelog, pack-publish, post-release-checks

Stage hints (for inference)

- ideation ↔ design/requirements/architecture
- scaffold ↔ scaffold/conventions/ci-setup
- implementation ↔ spec-orient/impl/review
- refactor ↔ refactor-candidates/refactor/perf
- testing ↔ test-plan/gen-tests/fix-flakes/coverage
- docs ↔ doc-plan/examples/api-docs/site-sync
- release ↔ versioning/changelog/pack-publish/post-release-checks

## Algorithm

1) Extract signals from $1
   - Title words, headings, imperative verbs.
   - File/task intent sentences (first paragraph).
   - Any explicit tags like “test plan”, “refactor”, “release”.
   - Dependencies implied by phrases: “after X”, “requires Y”, “prepares Z”.

2) Determine `id`
   - If $2 provided → use.
   - Else infer: take main action + object (e.g., “implement-endpoint”, “generate-test-plan”).
   - Normalize: lowercase, kebab-case, `[a-z0-9-]`, max 60 chars.
   - Must start with a letter; trim duplicates.

3) Determine `categories`
   - If $3 provided → split by comma, trim, validate against taxonomy.
   - Else infer by matching intent/verbs/headings to taxonomy.
   - If none match, use `["impl"]` as last resort.
   - Sort deterministically (taxonomy order), de-dupe.

4) Determine `stage` (optional)
   - If $4 provided → use if valid.
   - Else infer via category→stage mapping above.
   - Omit if uncertain.

5) Determine `depends_on` (optional)
   - Parse phrases in $1: “requires/after/before”, “precondition”, “assumes”.
   - Extract candidate ids (kebab-case). If none, omit.

6) Determine `provides` (optional free text)
   - Short list (≤3) of artifacts unlocked, e.g., “test-cases”, “CHANGELOG entry”, “API docs”.
   - Omit if not clear.

7) Compose `summary`
   - One sentence, ≤120 chars.
   - Format: “Do <verb> <object> to achieve <outcome>.”

8) Produce front-matter in requested format ($5)
   - **YAML (default)** keys in this order: id, categories, stage?, depends_on?, provides?, summary
   - TOML/JSON equivalents if $5 indicates.

9) Reconciliation (if input already had front-matter)
   - Merge: prefer explicit inputs $2–$4 > existing > inferred.
   - Validate taxonomy; move unknowns to `other` but keep them in a separate `x_tags` array.
   - Remove empty keys.

## Validation

- `id`: matches `^[a-z][a-z0-9-]{1,59}$`.
- `categories`: non-empty, all in taxonomy; ≤3 entries.
- `stage`: if present, in allowed set.
- `depends_on`: ≤5 items; each id-shaped.
- `summary`: ≤120 chars; no trailing period if already followed by punctuation.
- **Do not alter the body text ($1).** Only prepend the front-matter.
- Output exactly one document: front-matter, then a blank line, then the original body.

## Output format examples

**YAML (default)**
```yaml
---
id: $2-or-inferred
categories:
  - impl
  - review
stage: implementation
depends_on: [requirements-plan, api-architecture]
provides: [endpoint, tests]
summary: Implement a new REST endpoint from spec and submit for review
---
$1
```