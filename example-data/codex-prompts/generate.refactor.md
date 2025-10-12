# Generate Unit Tests

Trigger: /generate $1

Purpose: Generate unit tests for a given source file.

## Steps

1. Inspect `package.json` to identify the unit test framework, runner scripts, and any helper utilities required for the suite.
2. Review the target source file with `sed -n '1,400p' $1` to catalog exported members, branching logic, and error handling paths that must be exercised.
3. Outline the test file structure (location, naming, setup/teardown) and propose arrange/act/assert cases that cover happy paths, edge cases, and failure scenarios.
4. Provide guidance on implementing the tests and how to validate them locally (e.g., `npm test -- $2` or framework-specific commands).

## Output

- Begin with a concise summary that restates the goal: Generate unit tests for a given source file.
- List the recommended test files, describe each test case, and highlight coverage gaps they close.
- Call out the command(s) to run the new tests and any fixtures or mocks required.
- Document the evidence you used (e.g., `package.json`, specific functions/branches in the source file) so maintainers can trust the conclusion.

## Example

**Input**
```
$3
```

**Output**
- Summary: Author $2 unit tests for $1 to cover rendering, disabled behavior, and click handling.
- Create `$4` that:
  - Renders the button label and asserts it matches `props.children`.
  - Verifies `$2` fires once when the button is enabled and is skipped when `disabled` is true.
  - Confirms the `$5` branch applies the `btn-primary` class.
- Validation: Run `$6` to execute the suite.
- Evidence: `package.json` (scripts.test uses $2), component branches in $1 (disabled guard, variant styling).
