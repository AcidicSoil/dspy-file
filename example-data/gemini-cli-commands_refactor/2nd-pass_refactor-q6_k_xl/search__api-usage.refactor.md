description = "Show how an internal API is used across the codebase."
prompt = """
Summarize common usage patterns and potential misuses for the symbol.


!{rg -n $1 . || grep -RIn $1 .}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "symbol",
      "hint": "The name of the symbol (e.g., function, variable, API endpoint) to search for in the codebase.",
      "example": "getUserProfile",
      "required": true,
      "validate": "^[a-zA-Z_][a-zA-Z0-9_]*$"
    }
  ]
}
