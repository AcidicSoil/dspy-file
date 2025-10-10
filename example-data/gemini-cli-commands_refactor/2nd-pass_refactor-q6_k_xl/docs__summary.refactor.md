description = "Produce a README‑level summary of the repo."
prompt = """
Generate a high‑level summary (What, Why, How, Getting Started).


Repo map (first 400 files):
!$1


Key docs if present:
@{$2}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "repo_file_list",
      "hint": "List of the first 400 files in the repository, generated via git ls-files",
      "example": "src/main.py\nlib/utils.py\ndocs/README.md\ntests/unit.test",
      "required": true,
      "validate": "^\\n?$|^[\\S\\s]*$"
    },
    {
      "id": "$2",
      "name": "key_docs",
      "hint": "Path(s) to key documentation files, e.g., README.md or docs/ directory",
      "example": "README.md\ndocs/index.md",
      "required": true,
      "validate": "^\\n?$|^[\\S\\s]*$"
    }
  ]
}
