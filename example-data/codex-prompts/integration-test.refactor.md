# Integration Test

Trigger: $1

Purpose: $2

## Steps

1. $3
2. $4
3. $5
4. $6

## Output format

- $7

## Examples

- $8

## Notes

- $9

<!-- Placeholder mapping -->

$1 = Trigger (e.g., \/integration-test)
$2 = Purpose (e.g., Generate E2E tests that simulate real user flows)
$3 = Detect framework from `package.json` or repo
$4 = Identify critical path scenarios from `PLAN.md`
$5 = Produce test files under `e2e/` with arrange/act/assert and selectors resilient to DOM changes
$6 = Include login helpers and data setup. Add CI commands
$7 = Test files with comments and a README snippet on how to run them
$8 = Login, navigate to dashboard, create record, assert toast
$9 = Prefer data-test-id attributes. Avoid brittle CSS selectors
