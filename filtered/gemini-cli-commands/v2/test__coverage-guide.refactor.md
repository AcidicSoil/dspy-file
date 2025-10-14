description = "Suggest a plan to raise coverage based on uncovered areas."
prompt = """
Using coverage artifacts (if available) and repository map, propose the highest‑ROI tests to add.


Coverage hints:
!$1


Repo map:
!$2
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "coverage_find_command",
      "hint": "Shell command to find coverage files",
      "example": "find . -name 'coverage*' -type f -maxdepth 3 -print -exec head -n 40 {} \\;",
      "required": true,
      "validate": "shell_command"
    },
    {
      "id": "$2",
      "name": "repo_map_command",
      "hint": "Shell command to list repository files",
      "example": "git ls-files | sed -n '1,400p'",
      "required": true,
      "validate": "shell_command"
    }
  ]
}
