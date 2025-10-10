<!-- $1=Template title, $2=Command trigger, $3=Purpose statement, $4=Input parameters, $5=Data gathering command, $6=Heuristic mapping rules, $7=Output format structure -->
**Changelog Draft Generator**

Trigger: $2

Purpose: $3

Steps:

1. Inputs: $4
2. Gather data with:
   - $5
   - If available, `gh pr view` for merged PR titles by commit SHA; else rely on merge commit subjects.
3. Heuristics: $6
   - Shorten to 12–80 chars. Strip scope parentheses.

Output format:
- Range preface line
- $7

Open Questions:
- Does the generated changelog require finalization?
