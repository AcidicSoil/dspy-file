<!-- $1=Search query string (e.g., "error") -->
<!-- $2=Template name, e.g., "Search Command Template" -->
<!-- $3=Maximum number of placeholders (default 7) -->

**{Search Command Template}**

This prompt enables recursive text search using ripgrep or grep with support for file paths and line numbers.

### Description
A reusable command template for performing text searches across directories with line number and path context.

### Prompt
Show matched lines with file paths and line numbers.

!{rg -n $1 . || grep -RIn $1 .}

### Output Format (Optional)
- List of matching lines, each prefixed with the full file path and line number.
- Example: `file.txt:42: This is a match.`
