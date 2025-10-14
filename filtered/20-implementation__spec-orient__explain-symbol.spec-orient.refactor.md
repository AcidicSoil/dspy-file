```md
# Explain Symbol Definition and Usage

## Summary
Explain where and how a symbol is defined and used.

## Steps
1. Gather context by running `rg -n {{args}} . || grep -RIn {{args}} .` for the results.
2. Explain where and how a symbol is defined and used.
3. Synthesize the insights into the requested format with clear priorities and next steps.

## Output Format
- Begin with a concise summary that restates the goal: Explain where and how a symbol is defined and used.
- Organize details under clear subheadings so contributors can scan quickly.
- Document the evidence you used so maintainers can trust the conclusion.

## Example Input
HttpClient

## Example Output
- Definition: src/network/httpClient.ts line 42
- Key usages: services/userService.ts, hooks/useRequest.ts
```
