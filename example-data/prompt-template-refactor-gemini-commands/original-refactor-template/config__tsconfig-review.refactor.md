<!-- $1=description, $2=prompt, $3=file_path, $4=recommendations_list, $5=input_file_ref, $6=affected_files, $7=open_questions -->
**Tsconfig Review Analysis**

This prompt is used to analyze and improve the correctness and developer experience (DX) of a TypeScript configuration.

- **Summary**: $1  
- **Input File**: $3  
- **Reference Content**: $5  

### Recommendations
Provide recommendations for:
- Module/target settings: $4  
- Strictness level  
- Paths resolution  
- Incremental builds  

### Affected Files
$6

### Root Cause (if any)
- Missing or incorrect module resolution paths  
- Inconsistent strictness across files  
- Misconfigured incremental build flags  

### Proposed Fix
- Adjust `module` and `target` to match project requirements  
- Set `strict: true` where appropriate  
- Use relative paths for `paths` mapping  
- Enable incremental builds with proper configuration  

### Tests (to validate changes)
- Verify that all files compile without errors  
- Confirm correct resolution of imported modules  
- Ensure no type errors occur in strict mode  

### Documentation Gaps
- No clear guidance on best practices for path mappings  
- Missing examples for incremental build setup  

### Open Questions
$7

**Output format**
- List of actionable recommendations with justification  
- Clearly marked changes to config sections  
- Optional: include a summary table of before/after values
