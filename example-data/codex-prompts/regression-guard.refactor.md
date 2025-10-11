<!-- $1=Regression Guard, $2=Regression Guard, $3=Trigger, $4=Purpose, $5=Steps, $6=Output format, $7=Notes -->

**Regression Guard**

Trigger: $1

Purpose: $2

$3

1. $4
2. $5
3. $6

$7

- **Affected files**: Identified via $1
- **Root cause**: Unrelated changes detected
- **Proposed fix**: Add tests to lock behavior
- **Tests**: Minimal and focused as per $7
- **Open questions**: How to prioritize tests for large diffs
- **CI checks**: Suggest checks to block large unrelated diffs
