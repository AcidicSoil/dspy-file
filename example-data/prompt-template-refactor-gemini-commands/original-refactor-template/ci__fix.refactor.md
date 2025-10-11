<!-- $1=source Markdown text, $2=template name (inferred as "CI Workflow Analysis"), $3=max placeholders (default: 7) -->
**{CI Workflow Analysis}**

This prompt enables an AI agent to diagnose and fix failing GitHub Actions or CI workflows by analyzing workflow configurations and recent commit history.

### Context
- Workflows under review: $1  
- Recent CI-related commits: $2  

### Affected Files
$3

### Root Cause Hypothesis
$4

### Proposed Fix
$5

### Verification Steps (Tests)
$6

### Documentation Gaps
$7

### Open Questions
$8

**Output format**
- Return structured JSON with the following keys:
  - "affected_files": list of file paths
  - "root_cause": concise explanation
  - "proposed_fix": actionable step(s)
  - "test_steps": steps to validate fix
  - "documentation_gaps": missing or unclear documentation items
  - "open_questions": unresolved uncertainties
