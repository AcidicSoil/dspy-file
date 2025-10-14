Given the blame summary below, identify ownership hotspots and potential reviewers.

Blame authors (top contributors first):
!{git blame -w --line-porcelain $1 | sed -n 's/^author //p' | sort | uniq -c | sort -nr | sed -n '1,25p'}

{
  "args": [
    {
      "id": "$1",
      "name": "git_blame_args",
      "hint": "Arguments to pass to git blame command (e.g., -w --line-porcelain)",
      "example": "-w --line-porcelain",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\s]+$"
    },
    {
      "id": "$2",
      "name": "file_path",
      "hint": "Path to the file for which to generate blame summary",
      "example": "src/main.py",
      "required": true,
      "validate": "^[a-zA-Z0-9_\\-\\.\\/]+$"
    }
  ]
}
