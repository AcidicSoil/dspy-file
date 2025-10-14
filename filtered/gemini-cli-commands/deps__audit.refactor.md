```toml
description = "Summarize dependency risks and remediation steps."
prompt = """
Review the audit outputs (if available) and propose prioritized fixes. Prefer minimal upgrades.


@{package.json}
@{package-lock.json}
@{pnpm-lock.yaml}
@{yarn.lock}


!{($1 audit --json || true) 2>/dev/null}

"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
{
  "args": [
    {
      "id": "$1",
      "name": "package_manager",
      "hint": "The package manager to use (npm, pnpm, yarn)",
      "example": "npm",
      "required": true,
      "validate": "^(npm|pnpm|yarn)$"
    },
    {
      "id": "$2",
      "name": "manifest_file",
      "hint": "The manifest file to audit (e.g., package.json, package-lock.json)",
      "example": "package.json",
      "required": true,
      "validate": "^(package\\.json|package-lock\\.json|pnpm-lock\\.yaml|yarn\\.lock)$"
    },
    {
      "id": "$3",
      "name": "audit_flags",
      "hint": "Audit flags (e.g., --json)",
      "example": "--json",
      "required": false,
      "validate": "^--json$"
    }
  ]
}
```
