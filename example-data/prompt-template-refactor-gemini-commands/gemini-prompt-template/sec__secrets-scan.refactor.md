description = "Review secret scan output and highlight real leaks."
prompt = """
Interpret the scanner results, de‑dupe false positives, and propose rotations/remediation.


If gitleaks is available, output will appear below:
!{gitleaks detect --no-banner --redact 2>/dev/null || echo 'gitleaks not installed'}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "gitleaks_output",
      "hint": "The output of gitleaks detect command, or 'gitleaks not installed' if unavailable.",
      "example": "Found secrets in commit: abc123\nPath: src/config/db.json\nSecret: mypassword123",
      "required": true,
      "validate": "^\\s*(?:Found secrets|gitleaks not installed)\\s*.*$"
    }
  ]
}
