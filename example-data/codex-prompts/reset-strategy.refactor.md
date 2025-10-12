# Reset Strategy

Trigger: $1

Purpose: $2

## Steps

1. Run: `git status -sb` and `git diff --stat` to assess $3.
2. If $4 or failing builds, propose: `git reset --hard HEAD` to discard working tree.
3. Save any valuable snippets to $5 before reset.
4. Re-implement the minimal correct fix from a clean state.

## Output format

- A short decision note and exact commands. Never execute resets automatically.

## Examples

- Recommend reset after repeated failing refactors touching $6 files.

## Notes

- Warn about destructive nature. Require $7.

### Affected files

- $8

### Root cause

- $9

### Proposed fix

- $10

### Tests

- $11

### Docs gaps

- $12

### Open questions

- $13
