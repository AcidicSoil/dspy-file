description = "Summarize dependency risks and remediation steps."
prompt = """
Review the audit outputs (if available) and propose prioritized fixes. Prefer minimal upgrades.


npm/pnpm/yarn audit (if present):
!{($1 || true) 2>/dev/null}
!{($2 || true) 2>/dev/null}
!{($3 || true) 2>/dev/null}


Manifests:
@{($4)}
@{($5)}
@{($6)}
@{($7)}
"""

```json
{
  "args": [
    {
      "id": "$1",
      "name": "npm_audit_command",
      "hint": "Command to run npm audit in JSON format",
      "example": "npm audit --json",
      "required": false,
      "validate": "shell_command"
    },
    {
      "id": "$2",
      "name": "pnpm_audit_command",
      "hint": "Command to run pnpm audit in JSON format",
      "example": "pnpm audit --json",
      "required": false,
      "validate": "shell_command"
    },
    {
      "id": "$3",
      "name": "yarn_audit_command",
      "hint": "Command to run yarn audit in JSON format",
      "example": "yarn audit --json",
      "required": false,
      "validate": "shell_command"
    },
    {
      "id": "$4",
      "name": "package_json_path",
      "hint": "Path to package.json file",
      "example": "package.json",
      "required": true,
      "validate": "file_path"
    },
    {
      "id": "$5",
      "name": "package_lock_json_path",
      "hint": "Path to package-lock.json file",
      "example": "package-lock.json",
      "required": false,
      "validate": "file_path"
    },
    {
      "id": "$6",
      "name": "pnpm_lock_yaml_path",
      "hint": "Path to pnpm-lock.yaml file",
      "example": "pnpm-lock.yaml",
      "required": false,
      "validate": "file_path"
    },
    {
      "id": "$7",
      "name": "yarn_lock_path",
      "hint": "Path to yarn.lock file",
      "example": "yarn.lock",
      "required": false,
      "validate": "file_path"
    }
  ]
}
```
