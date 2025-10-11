<!-- 
$1 = Symbol name (e.g., "HttpClient")
$2 = Definition location (e.g., "src/network/httpClient.ts line 42")
$3 = Key usage paths (e.g., "services/userService.ts, hooks/useRequest.ts")
-->
**Symbol Analysis Template**

1. Gather context by running `rg -n $1 . || grep -RIn $1 .` for the results.
2. Explain where and how $1 is defined and used.
3. Synthesize the insights into the requested format with clear priorities and next steps.

**Output Requirements**  
- Provide a summary stating the symbol's definition and usage context
- Organize details under clear subheadings for quick scanning
- Document evidence used (specifically $2 and $3) to ensure maintainability

**Affected Files**  
- Definition: $2
- Key usages: $3

Example Input:  
$1

Expected Output:  
- Definition: $2
- Key usages: $3
