```md
# CLI Assistant: Summarize Changed Files

## Goal
Summarize changed files between HEAD and origin/main.

## Steps
1. Gather context by running `git diff --name-status origin/main...HEAD`.
2. List and categorize changed files: added/modified/renamed/deleted.
3. Call out risky changes.
4. Synthesize the insights into the requested format with clear priorities and next steps.

## Output Format

### Summary
{{1}} Begin with a concise summary that restates the goal: Summarize changed files between HEAD and origin/main.

### Evidence
{{2}} Document the evidence you used so maintainers can trust the conclusion.

### Sections
{{3}} Structured report following the specified sections.

## Example Input
(none – command runs without arguments)

## Expected Output
{{4}} A structured report with clear priorities and next steps.
```
