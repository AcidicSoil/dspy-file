description = "Summarize third‑party licenses and risk flags."
prompt = """
Create a license inventory with notices of copyleft/unknown licenses.


If license tools are present, their outputs:
!{npx --yes $2 --summary 2>/dev/null || echo 'license-checker not available'}
@{package.json}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "package_json_path",
      "hint": "Path to the package.json file (e.g., ./src/package.json)",
      "example": "package.json",
      "required": true,
      "validate": "^\\S+$"
    },
    {
      "id": "$2",
      "name": "license_check_command",
      "hint": "Command to run for license checking (e.g., npx --yes license-checker --summary)",
      "example": "npx --yes license-checker --summary",
      "required": true,
      "validate": "^npx\\s+--yes\\s+\\S+\\s+--summary"
    }
  ]
}
