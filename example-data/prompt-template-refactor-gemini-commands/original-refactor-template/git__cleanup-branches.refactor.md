<!-- $1 = description of the task or purpose -->  
<!-- $2 = list of merged branches (e.g., output of `git branch --merged`) -->  
<!-- $3 = list of unmerged branches (e.g., output of `git branch --no-merged`) -->  
<!-- $4 = recently updated branches by author date (e.g., sorted by authordate) -->  
<!-- $5 = suggested safe-to-delete branches with rationale -->  
<!-- $6 = proposed commands to remove branches (optional, if desired) -->  
<!-- $7 = output format instructions for structured response -->

**Git Branch Cleanup Suggestion Prompt**

Given the following branch information:

- Merged into current upstream:  
  $2

- Branches not merged:  
  $3

- Recently updated (last author dates):  
  $4

Suggest which local branches are safe to delete and which should be retained. Provide a rationale for each decision, focusing on safety (e.g., no uncommitted changes, already merged). If desired, include commands to remove the safe-to-delete branches.

**Output format:**
- List of branches safe to delete with brief justification.
- Optional: Include one or more Git commands to remove them (do not execute).
- Do not assume any branch is active or dirty.
