<!-- $1=description of the task or goal, e.g., "Review secret scan output and highlight real leaks." -->
<!-- $2=name of the template (inferred: Secret Scan Analysis) -->
<!-- $3=maximum number of placeholders used (set to 7) -->

**Secret Scan Analysis**

- **Task**: $1
- **Objective**: Interpret scanner results, de-dupe false positives, and propose rotations or remediation actions.
- **Affected files**: $2
- **Root cause**: $3
- **Proposed fix**: $4
- **Remediation steps**: $5
- **Tests to validate**: $6
- **Documentation gaps**: $7

Output format (if applicable):
- List all identified secrets with their file paths and types.
- Classify each as "real leak" or "false positive".
- For real leaks, provide a recommended rotation period and action steps.
