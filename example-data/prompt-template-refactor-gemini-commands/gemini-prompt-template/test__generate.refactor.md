description = "Generate unit tests for a given source file."
prompt = """
Given the file content, generate focused unit tests with clear arrange/act/assert and edge cases.


Framework hints (package.json):
@${2}


Source (first 400 lines):
!${1}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "source_content",
      "hint": "The first 400 lines of the source file to generate unit tests for.",
      "example": "function add(a, b) { return a + b; }\\n\\n// Test case with edge values\\nconsole.log(add(-1, 1));",
      "required": true,
      "validate": "^\\s*\\S.*$"
    },
    {
      "id": "$2",
      "name": "package_json",
      "hint": "Path or content of the package.json file specifying testing framework (e.g., Jest, Mocha).",
      "example": "{\\n  \"devDependencies\": {\\n    \"jest\": \"^29.0.0\"\\n  }\\n}",
      "required": true,
      "validate": "^\\s*{[^}]*}$"
    }
  ]
}
