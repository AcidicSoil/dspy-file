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
      "hint": "Path to the package.json file (e.g., ./src/package.json)",
      "example": "./package.json",
      "required": true,
      "validate": "^/\\.\\/|\\./|\\w+\\(\\)/$"
    }
  ]
}
