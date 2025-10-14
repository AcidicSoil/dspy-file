"""
Summarize common usage patterns and potential misuses for the symbol.


!{rg -n $1 . || grep -RIn $1 .}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "symbol",
      "hint": "API function or symbol name",
      "example": "my_api_function",
      "required": true,
      "validate": "^[a-zA-Z0-9_]+$"
    }
  ]
}
