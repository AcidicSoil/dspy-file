<!-- $1 = description of the check task -->
<!-- $2 = prompt instruction for AI agent -->
<!-- $3 = list of files to scan (e.g., via git ls-files) -->
<!-- $4 = number of files to limit the scan to (e.g., 400) -->
<!-- $5 = path or pattern to match .editorconfig files -->
<!-- $6 = root cause of inconsistency in config -->
<!-- $7 = proposed fix or action item -->

**EditorConfig Compliance Analysis**

This analysis checks for inconsistencies between `.editorconfig` configurations and actual file settings across the repository.

- **Affected files**: $1  
- **File list to scan**: $3 (limited to first $4 entries)  
- **Root cause of inconsistency**: $6  
- **Proposed fix**: $7  

Output format:  
Provide a structured response listing:
  - All inconsistent file paths
  - The specific configuration mismatch found
  - A clear, actionable fix for each case

Ensure the output is concise and directly usable by developers to resolve issues.
