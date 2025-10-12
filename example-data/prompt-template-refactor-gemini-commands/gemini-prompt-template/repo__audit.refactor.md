description = "Audit repository hygiene and suggest improvements."
prompt = """
Assess repo hygiene: docs, tests, CI, linting, security. Provide a prioritized checklist.


Top‑level listing:
!$1


Common config files (if present):
@{$2}
@{$3}
@{$4}
@{$5}
@{$6}
@{$7}
"""

{
  "args": [
    {
      "id": "$1",
      "name": "directory_listing",
      "hint": "Output of 'ls -la' command from the repository root.",
      "example": "total 20\n-rw-r--r-- 1 user group 1234 Jan 1 10:00 .gitignore\n-rw-r--r-- 1 user group 5678 Jan 1 10:00 .editorconfig",
      "required": true,
      "validate": "^\\s*total\\s+\\d+\n(\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\S+)\\n"
    },
    {
      "id": "$2",
      "name": "editorconfig",
      "hint": "Path to .editorconfig file, if present.",
      "example": ".editorconfig",
      "required": false,
      "validate": "^\\s*\\[.*\\]$"
    },
    {
      "id": "$3",
      "name": "gitignore",
      "hint": "Path to .gitignore file, if present.",
      "example": ".gitignore",
      "required": false,
      "validate": "^\\s*#.*$"
    },
    {
      "id": "$4",
      "name": "geminiignore",
      "hint": "Path to .geminiignore file, if present.",
      "example": ".geminiignore",
      "required": false,
      "validate": "^\\s*#.*$"
    },
    {
      "id": "$5",
      "name": "eslintrc_cjs",
      "hint": "Path to .eslintrc.cjs file, if present.",
      "example": ".eslintrc.cjs",
      "required": false,
      "validate": "^\\s*module\\.exports.*$"
    },
    {
      "id": "$6",
      "name": "eslintrc_js",
      "hint": "Path to .eslintrc.js file, if present.",
      "example": ".eslintrc.js",
      "required": false,
      "validate": "^\\s*module\\.exports.*$"
    },
    {
      "id": "$7",
      "name": "tsconfig_json",
      "hint": "Path to tsconfig.json file, if present.",
      "example": "tsconfig.json",
      "required": false,
      "validate": "^\\s*{.*}$"
    }
  ]
}
