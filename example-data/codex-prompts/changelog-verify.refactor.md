```
# Verify CHANGELOG Completeness

Trigger: $1

Purpose: $2

Steps:
$3

Output format:
$4

Examples:
$5

Notes:
$6

## Analysis
- Section order validation failed
- Missing security section stub

## Root cause
- Inconsistent section order in CHANGELOG

## Proposed fix
- Reorder sections to follow: Added, Changed, Deprecated, Removed, Fixed, Security

## Tests
- Verify section order matches policy
- Check for empty sections

## Docs gaps
- No example of fixed section ordering

## Open questions
- How to handle partial sections (e.g., only Added and Fixed present)?
```
