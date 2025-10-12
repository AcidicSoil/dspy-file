description = "Generates a fix for a given issue."
prompt = "Please provide a code fix for the issue described here: $1."  

{
  "args": [
    {
      "id": "$1",
      "name": "issue_description",
      "hint": "A clear description of the problem or bug in code.",
      "example": "The function returns null when input is empty.",
      "required": true,
      "validate": "^.*$"
    }
  ]
}
