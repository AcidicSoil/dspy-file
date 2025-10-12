<!-- $1=description, $2=prompt, $3=audit_commands, $4=manifests_list, $5=affected_packages, $6=root_cause, $7=proposed_fix_steps -->
**Dependency Audit Prompt Template**

This prompt guides the analysis of dependency risks and proposes prioritized remediation steps based on audit outputs.

### Summary
$1

### Action Steps
- Run vulnerability checks using available package managers:
  $3
- Gather manifest files for dependency resolution:
  $4

### Affected Packages
List all packages with known vulnerabilities or outdated versions.  
$5

### Root Cause
Identify the origin of high-risk dependencies (e.g., direct, transitive, outdated version).  
$6

### Proposed Fix Steps
Provide a prioritized list of minimal upgrades or replacements to mitigate risks.  
$7

### Output Format
- Prioritize fixes by severity and impact.
- Recommend only minimal version upgrades where possible.
- Include rationale for each change.
