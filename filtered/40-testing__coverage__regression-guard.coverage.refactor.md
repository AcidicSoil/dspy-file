```md
# Regression Guard

Trigger: /regression-guard

Purpose: Detect unrelated changes and add tests to prevent regressions.

## Steps

1. Run `git diff --name-status origin/main...HEAD` and highlight unrelated files.
2. Propose test cases that lock current behavior for touched modules.
3. Suggest CI checks to block large unrelated diffs.

## Output format

- Report with file groups, risk notes, and test additions.

## Notes

- Keep proposed tests minimal and focused.

## Placeholder Template

1. {{file_path}} - Path to the source file for context
2. {{file_content}} - Full raw text of the file
3. {{reasoning}} - Explanation or rationale for actions taken
4. {{template_markdown}} - Markdown template with numbered placeholders and section scaffolding
5. {{completed}} - Marker indicating completion status

## Example Usage
