<!-- $1=Command trigger (e.g., /audit), $2=Purpose statement, $3=Example input description, $4=Expected output description, $5=Command to run (e.g., ls -la), $6=File patterns to inspect (e.g., .editorconfig, .gitignore), $7=Output section elements (e.g., test coverage gaps) -->

# Audit

Trigger: $1

Purpose: $2

## Steps

1. Gather context by running $5 for the top-level listing. Inspect $6 if present to understand shared conventions.
2. Assess repository hygiene across documentation, testing, CI, linting, and security. Highlight gaps and existing automation.
3. Synthesize the findings into a prioritized checklist with recommended next steps.

## Output format

- Begin with a concise summary that restates the goal: $2.
- Offer prioritized, actionable recommendations with rationale.
- Call out $7 and validation steps.
- Highlight workflow triggers, failing jobs, and proposed fixes.

## Example input
$3

## Expected output
$4

## Affected files
- [List of files to inspect]

## Root cause
- [Gaps identified in repository hygiene]

## Proposed fixes
- [Actionable steps to address issues]

## Tests
- [Coverage gaps and validation requirements]

## Docs gaps
- [Missing documentation]

## Open questions
- [Remaining uncertainties]
