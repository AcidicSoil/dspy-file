<!-- $1=description, $2=prompt, $3=coverage hints, $4=repo map, $5=affected files, $6=root cause, $7=proposed fix -->
**Coverage Improvement Plan**

This prompt proposes a high-ROI test addition strategy based on uncovered areas in the codebase.

$1

Use the following inputs to generate actionable recommendations:

- Coverage hints: $3  
- Repository map: $4  

Identify and analyze:
- $5 (list of files with low or missing coverage)
- $6 (underlying reasons for uncovered areas)

Propose a clear, prioritized action plan including:
- $7 (specific tests to add or modify)
- A brief rationale for each test selection

Optional output format:  
> "Prioritize the following test additions based on impact and feasibility:  
> 1. [Test name] – affects [file], covers [feature], ROI = X%  
> 2. [Test name] – affects [file], covers [feature], ROI = Y%"  

**Output format (if applicable)**  
[Optional structured response as above]
