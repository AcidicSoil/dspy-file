```md
# Summarize Authorship Hotspots Using Git Blame

## Goal
Summarize authorship hotspots for a file using git blame.

## Steps
1. Run the following command to gather top contributors:
   ```bash
   git blame -w --line-porcelain {{args}} | sed -n 's/^author //p' | sort | uniq -c | sort -nr | sed -n '1,25p'
   ```
2. Identify ownership hotspots and potential reviewers.
3. Synthesize insights into the requested format with clear priorities and next steps.

## Output Format
- Begin with a concise summary that restates the goal.
- Organize details under clear subheadings for quick scanning.
- Reference evidence from CODEOWNERS or git history for each owner suggestion.

## Example Input
`src/components/Button.tsx`

## Expected Output
- Refactor proposal extracting shared styling hook with before/after snippet.
```
