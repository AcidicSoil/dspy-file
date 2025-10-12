description = "Summarize third‑party licenses and risk flags."
prompt = """
Create a license inventory with notices of copyleft/unknown licenses.


If license tools are present, their outputs:
!{npx --yes license-checker --summary 2>/dev/null || echo 'license-checker not available'}
@{$1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "package_json_path",
      "hint": "Path to the package.json file in the project root",
      "example": "./package.json",
      "required": true,
      "validate": "^/\\./"
    },
    {
      "id": "$2",
      "name": "license_checker_output",
      "hint": "Output from license-checker tool (if available)",
      "example": "{'licenses': [{'name': 'MIT', 'path': 'src/utils.js'}]}",
      "required": false,
      "validate": "^(\\{\\}|\\s*\\n\\s*\\}|\\s*\\n\\s*\\S\\s*\\n\\s*)$"
    }
  ]
}
