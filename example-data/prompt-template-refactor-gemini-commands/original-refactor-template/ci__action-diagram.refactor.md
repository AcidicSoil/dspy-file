<!-- $1=source Markdown text, $2=template name (optional), $3=max placeholder count (default 7) -->
**{Inferred Workflow Analysis Template}**

Generate a step-by-step outline suitable for a diagram (nodes and edges) based on the workflow structure:

- $1 = list of workflow files or paths to analyze  
- $2 = specific trigger or event being evaluated (e.g., push, pull request)  
- $3 = set of dependencies or conditions that influence execution flow  

### Affected Files
$4 = list of relevant workflow YAML files or directories

### Root Cause (if applicable)
$5 = reason for dependency chain or trigger behavior

### Proposed Fix / Improvement
$6 = suggested changes to streamline triggers, reduce redundancy, or improve clarity

### Tests & Validation
$7 = required checks or test cases to verify the diagram’s accuracy and completeness  

### Documentation Gaps
$8 = missing documentation on workflow logic, environment variables, or failure modes  

### Open Questions
$9 = unresolved aspects of dependency flow or event handling  

**Output format:**  
- Use clear node labels (e.g., "Push to main", "PR opened")  
- Define edges with directional arrows indicating dependencies or triggers  
- Avoid copying raw code; focus on logical flow and conditions
