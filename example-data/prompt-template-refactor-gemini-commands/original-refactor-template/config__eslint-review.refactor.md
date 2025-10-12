<!-- $1=description, $2=prompt, $3=affected_files, $4=root_cause, $5=proposed_fix, $6=tests, $7=documentation_gaps -->
**ESLint Configuration Review**

This prompt is used to analyze an ESLint configuration and suggest rule improvements, plugin additions, or performance optimizations.

- **Affected files**:  
  $3

- **Root cause**:  
  $4  

- **Proposed fix**:  
  $5  

- **Tests**:  
  $6  

- **Documentation gaps**:  
  $7  

- **Open questions**:  
  What additional rules or configurations are required for project-specific standards? Are there performance bottlenecks in rule execution?

**Output format (if applicable)**:  
Provide a structured summary including:
- A list of recommended rule changes.
- Identification of missing plugins or core ESLint features.
- Performance considerations (e.g., rule cost, runtime impact).
- Suggested configuration adjustments with rationale.
