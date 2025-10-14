Show matched lines with file paths and line numbers.

!$1
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "search_term",
      "hint": "The text or regex pattern to search for",
      "example": "error.*500",
      "required": true,
      "validate": "regex"
    }
  ]
}
