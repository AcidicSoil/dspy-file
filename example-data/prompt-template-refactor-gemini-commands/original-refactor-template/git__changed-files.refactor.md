<!-- $1=Task description or goal  
$2=Git command to execute (e.g., git diff --name-status)  
$3=Categorization criteria (e.g., added/modified/renamed/deleted)  
$4=Instruction on how to evaluate risk in changes (e.g., call out risky changes) -->

**{Inferred Name: Git File Change Summary}**

Summarize changed files between HEAD and origin/main.

Run the following command to extract file status differences:

```bash
$2
```

Categorize each file into one or more of these types:
- $3

For each category, identify any changes that may introduce risk (e.g., removing critical files, modifying core logic, changing configuration).  
Explicitly call out risky changes using the following instruction:  
$4

Output format (if applicable):
- List of files with their status and path
- Highlighted risks in a separate section or bullet list
