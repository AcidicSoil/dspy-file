<!-- $1=source Markdown text, $2=template name (inferred), $3=max placeholders (default 7) -->
**{Inferred Analysis Template}**

This prompt is designed for analyzing how a symbol (e.g., function, class, API endpoint) is used across a codebase.

- **Description**: 
  $1

- **Input Placeholder**: 
  $2

- **Search Command**:
  !{rg -n {{args}} . || grep -RIn {{args}} .}

- **Common Usage Patterns**:
  $3

- **Potential Misuses**:
  $4

- **Affected Files**:
  $5

- **Root Cause (if applicable)**:
  $6

- **Proposed Fix or Recommendation**:
  $7

---

**Output Format (for analysis)**  
Respond with a structured summary including:  
1. A brief overview of common usage patterns.  
2. Identification of potential misuse cases.  
3. List of files where the symbol appears, grouped by context.  
4. A concise root cause if misuses are detected.  
5. Suggested improvements or fixes (if any).  

Ensure all findings are grounded in actual code search results and avoid assumptions.
