**License Report Template**

This template is designed to generate a structured license inventory report from third-party dependencies, identifying copyleft and unknown licenses. It includes integration with license-checker tooling when available.

- **Purpose**: Summarize third-party licenses and flag potential risk areas.
- **Input Sources**:
  - Package manifest ($1)
  - License detection output via $2
- **Execution Steps**:
  1. Run `$3` to gather license data (or return message if unavailable).
  2. Extract relevant license notices and risk flags from the tool's output.
  3. Aggregate findings into a structured report.

**Output Format (for analysis or planning)**  
- Field: `description` → Summary of license inventory and risks  
- Field: `prompt` → Full prompt used to generate the report  
- Field: `license_inventory` → List of packages with their licenses, including copyleft or unknown flags  
- Field: `risk_flags` → Array of high-risk entries (e.g., copyleft, permissive, ambiguous)  
- Field: `tool_output` → Raw output from license-checker (if available)  

**Affected Files**:  
$1  

**Root Cause (if applicable)**:  
Missing or incomplete license data in dependency manifests may lead to unflagged risks.  

**Proposed Fix**:  
Integrate automated license scanning tools into CI/CD pipelines and enforce license review for all dependencies.  

**Tests**:  
- Verify that `$3` runs successfully in a clean environment.  
- Validate output parsing logic against known good license sets.  

**Documentation Gaps**:  
- No standardized format for reporting license risks across teams.  
- Missing guidance on handling copyleft licenses in open-source projects.  

**Open Questions**:  
- How should unknown licenses be categorized?  
- What thresholds define a "high-risk" license?
