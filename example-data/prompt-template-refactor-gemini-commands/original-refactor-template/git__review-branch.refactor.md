<!-- $1=description, $2=prompt, $3=diff stats command, $4=patch context command, $5=affected files, $6=root cause, $7=proposed fix -->

**Branch Review Template**

(Description)
$1

(Prompt)
$2

(Diff Stats)
$3

(Patch Context)
$4

(Affected Files)
- List of files modified in the branch.
- Include paths and changes (e.g., added, removed).

(Root Cause)
- What specific change or decision led to this feature/fix?
- Is it a new implementation, refactor, bug fix, or configuration change?

(Proposed Fix)
- Suggest what should be done to resolve any risks or issues.
- Include potential improvements or mitigations.

(Test Impact)
- How does this change affect existing tests?
- Are there any regressions or missing test cases?

(Open Questions)
- What questions remain unresolved?
- What further information is needed from the author?

(Output format)
Respond with a JSON object in the following order of fields: `reasoning`, then `template_markdown`.
