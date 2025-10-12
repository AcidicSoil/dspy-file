description = "Summarize authorship hotspots for a file using git blame."
prompt = """
Given the blame summary below, identify ownership hotspots and potential reviewers.


Blame authors (top contributors first):
!{git blame -w --line-porcelain $1 | sed -n 's/^author //p' | sort | uniq -c | sort -nr | sed -n '1,25p'}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "file_path",
      "hint": "Path to the file to analyze via git blame",
      "example": "src/main.cpp",
      "required": true,
      "validate": "^[a-zA-Z0-9._/-]+$"
    }
  ]
}
