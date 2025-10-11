description = "Draft an Architecture Decision Record with pros/cons."
prompt = """
Draft a concise ADR including Context, Decision, Status, Consequences. Title: $1


Project context:
@{$2}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "adr_title",
      "hint": "The title of the Architecture Decision Record (e.g., 'Use of JWT for Authentication')",
      "example": "Use of JWT for Authentication",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s\\-\\_\\.]$"
    },
    {
      "id": "$2",
      "name": "readme_path",
      "hint": "Path to the project's README.md file (e.g., /path/to/project/README.md)",
      "example": "/path/to/project/README.md",
      "required": true,
      "validate": "^/.*\\.md$"
    }
  ]
}
