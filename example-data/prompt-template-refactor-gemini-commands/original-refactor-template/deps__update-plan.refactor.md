<!-- $1=source Markdown text, $2=template name (optional), $3=max placeholders (default 7) -->
**{Update Dependency Plan}**

Analyze the provided dependency manifests and lockfiles to propose a safe and structured upgrade plan. Include:

1. **Grouped Upgrade Batches**: Identify logical groupings of dependencies based on version compatibility, transitive relationships, and update frequency.
2. **Testing Strategy**: Define a phased testing approach (e.g., unit → integration → staging → production) with specific test coverage targets.
3. **Rollback Plan**: Specify clear steps to revert changes if an upgrade introduces regressions or breaks functionality.

Input files:
- $1

Output format:
- List of dependency batches with version ranges and justification
- Testing phases and associated test suites
- Rollback procedure including recovery points and fallback versions

**Affected Packages:**  
$2  

**Risk Assessment:**  
$3  

**Rollback Steps:**  
$4  

**Test Coverage Targets:**  
$5  

**Upgrade Prioritization Criteria:**  
$6  

**Validation Checks:**  
$7
