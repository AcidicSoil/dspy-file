<!-- $1=description of the task (e.g., "Find and group TODO/FIXME annotations") -->
<!-- $2=search term pattern (e.g., "TODO|FIXME") -->
<!-- $3=exclusion pattern (e.g., "!node_modules") -->
<!-- $4=directory path (e.g., ".") -->
<!-- $5=command to use (e.g., "rg" or "grep") -->
<!-- $6=flags for search (e.g., "-n", "-R", "-I", "-E") -->
<!-- $7=output format (optional; e.g., "list of lines with context") -->

**{Inferred Name: Search for TODO/FIXME annotations}**

This prompt finds and groups all occurrences of TODO or FIXME comments in the codebase, excluding files within specified directories.

To use:
1. Replace `$2` with your desired search pattern (e.g., "TODO|FIXME").
2. Update `$3` to exclude unwanted paths (e.g., "!node_modules", "!dist").
3. Set `$4` to the root directory if different from current location.
4. Choose `$5` as either `rg` or `grep`, depending on availability.
5. Add relevant flags in `$6` (e.g., `-n`, `-R`, `-I`, `-E`) for context and recursion.

Command:
```bash
!{ $5 -n $2 -g '$3' $4 || grep -RInE $2 $4 }
```

Output format:  
List of file paths and line numbers where TODO/FIXME annotations are found, with full context lines included.  

**Note**: This template is designed for shell environments supporting `rg` or `grep`. Adjust based on system availability.
