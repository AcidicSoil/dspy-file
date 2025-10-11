description = "Suggest a plan to raise coverage based on uncovered areas."
prompt = """
Using coverage artifacts (if available) and repository map, propose the highest‑ROI tests to add.


Coverage hints:
!{ $1 }


Repo map:
!{ $2 }
"""

{
  "args": [
    {
      "id": "$1",
      "name": "coverage_artifacts",
      "hint": "Output from 'find . -name coverage* -type f -maxdepth 3 -exec head -n 40 {} \\; 2>/dev/null'",
      "example": "coverage-report.json\ncoverage-html/index.html\ncoverage-branch.txt",
      "required": true,
      "validate": "^(\\S+\\s*(\\n\\s*\\S+)*$)"
    },
    {
      "id": "$2",
      "name": "repo_map",
      "hint": "First 400 files from git ls-files, formatted as a list of file paths",
      "example": "src/main.cpp\nsrc/utils/helpers.cpp\nsrc/test/unit_test.cpp",
      "required": true,
      "validate": "^\\S+(\\n\\S+)*$"
    }
  ]
}
