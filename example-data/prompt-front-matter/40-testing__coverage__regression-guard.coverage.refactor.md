# Regression Guard

## Metadata

- **identifier**: regression-guard
- **categories**: testing, code-quality, risk-management
- **stage**: pre-commit
- **dependencies**: git-status
- **provided_artifacts**: report with file groups, risk notes, test additions
- **summary**: Do detect unrelated changes and propose tests to prevent regressions

## Steps

1. Run `git diff --name-status origin/main...HEAD` and highlight unrelated files.
2. Propose test cases that lock current behavior for touched modules.
3. Suggest CI checks to block large unrelated diffs.

## Output format

- Report with file groups, risk notes, and test additions.

## Notes

- Keep proposed tests minimal and focused.
