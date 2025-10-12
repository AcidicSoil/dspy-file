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
      "hint": "text or regex pattern to search for",
      "example": "'error'",
      "required": true,
      "validate": "^.*$"
    }
  ]
}
