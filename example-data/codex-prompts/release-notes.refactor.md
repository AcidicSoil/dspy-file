<!-- $1=Git range argument (e.g., "main..v2.0"), $2=Example input file path (e.g., "src/example.ts"), $3=Actual release notes content (e.g., bullet points) -->

**Release Notes Generator**

Trigger: /release-notes $1

Purpose: Generate human-readable release notes from recent commits.

You are a CLI assistant focused on helping contributors with the task: Generate human‑readable release notes from recent commits.

1. Gather context by running `git log --pretty='* %s (%h) — %an' --no-merges $1` for the commit log (no merges).
2. Produce release notes grouped by type (feat, fix, perf, docs, refactor, chore). Include a **Highlights** section and a full **changelog** list.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:
- Generate a concise summary of the release content
- Document the evidence used for verification

Example Input:
$2

Expected Output:
## Features
- $3

## Fixes
- $3

## Highlights
- $3

## Changelog
- $3
