description = "Review secret scan output and highlight real leaks."
prompt = """
Interpret the scanner results, de‑dupe false positives, and propose rotations/remediation.


If $1 is available, output will appear below:
!$1 detect --no-banner --redact 2>/dev/null || echo '$4'
"""
{
  "args": [
    {
      "id": "$1",
      "name": "scanner_tool",
      "hint": "Name of the secret scanning tool (e.g., gitleaks)",
      "example": "gitleaks",
      "required": true,
      "validate": "^[a-zA-Z0-9_-]+$"
    },
    {
      "id": "$2",
      "name": "no_banner_flag",
      "hint": "Flag to suppress banner output",
      "example": "--no-banner",
      "required": false,
      "validate": "^--no-banner$"
    },
    {
      "id": "$3",
      "name": "redact_flag",
      "hint": "Flag to redact sensitive information",
      "example": "--redact",
      "required": false,
      "validate": "^--redact$"
    },
    {
      "id": "$4",
      "name": "fallback_message",
      "hint": "Message to display if scanner is not installed",
      "example": "gitleaks not installed",
      "required": true,
      "validate": ".*"
    }
  ]
}
