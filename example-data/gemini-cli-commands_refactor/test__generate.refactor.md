description = "Generate unit tests for a given source file."
prompt = """
Given the file content, generate focused unit tests with clear arrange/act/assert and edge cases.


Framework hints (package.json):
@$1


Source (first 400 lines):
!{sed -n '1,400p' {{args}}}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "package_json_path",
      "hint": "Path to the package.json file containing framework configuration",
      "example": "src/package.json",
      "required": true,
      "validate": "^[a-zA-Z0-9._/-]+\\.(json)$"
    }
  ]
}
