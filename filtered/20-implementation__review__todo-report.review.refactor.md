```md
# TODO/FIXME/XXX Summary

## Overview
1. **Goal**: Summarize TODO/FIXME/XXX annotations across the codebase.
2. **Steps**:
   - Gather context by running `rg -n "TODO|FIXME|XXX" -g '!node_modules' . || grep -RInE 'TODO|FIXME|XXX' .`.
   - Aggregate and group TODO/FIXME/XXX by area and priority. Propose a triage plan.
   - Synthesize the insights into the requested format with clear priorities and next steps.

## Output Format
3. Begin with a concise summary that restates the goal: Summarize TODO/FIXME/XXX annotations across the codebase.
4. Offer prioritized, actionable recommendations with rationale.
5. Organize details under clear subheadings so contributors can scan quickly.

## Example Input/Output
6. Example Input: (none – command runs without arguments)
7. Expected Output:
   - Group: Platform backlog — 4 TODOs referencing auth migration (owner: @platform).

## Template Structure
8. **Summary**
   - [ ] Concise summary of the goal.
9. **Recommendations**
   - [ ] Prioritized, actionable recommendations with rationale.
10. **Subheadings**
    - [ ] Organized details under clear subheadings for quick scanning.
```
