description = "Produce a README‑level summary of the repo."
prompt = """
Generate a high‑level summary (What, Why, How, Getting Started).


Repo map (first 400 files):
!$2


Key docs if present:
@{$1}
"""

[
  {
    "args": [
      {
        "id": "$1",
        "name": "key_docs_path",
        "hint": "Path to the main documentation file (e.g., README.md or docs/)",
        "example": "README.md",
        "required": true,
        "validate": "^\\w+(\\.md|\\/)?$"
      },
      {
        "id": "$2",
        "name": "repo_file_list",
        "hint": "List of the first 400 files in the repository as output from git ls-files",
        "example": "src/main.py\nlib/utils.py\ndocs/README.md",
        "required": true,
        "validate": "^\\S+(\\n\\s*\\S+)*$"
      }
    ]
  }
]
