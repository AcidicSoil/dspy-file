description = "Produce a README‑level summary of the repo."
prompt = """
Generate a high‑level summary (What, Why, How, Getting Started).


Repo map (first 400 files):
!{$1}


Key docs if present:
@{$2}
@{$3}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "repo_map_command",
      "hint": "Command to list first 400 files in repo",
      "example": "git ls-files | sed -n '1,400p'",
      "required": true,
      "validate": "^[^\\s]+.*"
    },
    {
      "id": "$2",
      "name": "readme_path",
      "hint": "Path to the README file",
      "example": "README.md",
      "required": true,
      "validate": "^.*\\.md$"
    },
    {
      "id": "$3",
      "name": "docs_directory",
      "hint": "Path to docs directory",
      "example": "docs",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-]+(?:/[a-zA-Z0-9_\\-]+)*$"
    }
  ]
}
