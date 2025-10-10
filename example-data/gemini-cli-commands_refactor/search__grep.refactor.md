description = "Recursive text search with ripgrep/grep injection."
prompt = """
Show matched lines with file paths and line numbers.


!{rg -n $1 . || grep -RIn $1 .}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "search_term",
      "hint": "The text to search for in files",
      "example": "error",
      "required": true,
      "validate": "^[^\\s]+$"
    }
  ]
}
