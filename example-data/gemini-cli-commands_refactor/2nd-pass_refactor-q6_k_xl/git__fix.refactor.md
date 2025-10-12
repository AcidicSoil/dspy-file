description = "Generates a fix for a given issue."
prompt = "Please provide a code fix for the issue described here: $1."  

{
  "args": [
    {
      "id": "$1",
      "name": "issue_description",
      "hint": "A detailed description of the bug or issue to be fixed",
      "example": "The function fails to return a value when input is null",
      "required": true,
      "validate": "^(.+)$"
    }
  ]
}
