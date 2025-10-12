description = "Summarize dependency risks and remediation steps."
prompt = """
Review the audit outputs (if available) and propose prioritized fixes. Prefer minimal upgrades.


npm/pnpm/yarn audit (if present):
!{(npm audit --json || true) 2>/dev/null}
!{(pnpm audit --json || true) 2>/dev/null}
!{(yarn npm audit --json || yarn audit --json || true) 2>/dev/null}


Manifests:
@{$1}
@{$2}
@{$3}
@{$4}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "package_json_content",
      "hint": "Content of package.json file",
      "example": "{\"name\": \"my-app\", \"version\": \"1.0.0\", \"dependencies\": {\"lodash\": \"^4.17.21\"}}",
      "required": true,
      "validate": "^\\{.*\\}$"
    },
    {
      "id": "$2",
      "name": "package_lock_json_content",
      "hint": "Content of package-lock.json file",
      "example": "{\\\"lockfileVersion\\\": 1, \\\"dependencies\\\": {\\\"lodash\\\": \\\"^4.17.21\\\"}}",
      "required": true,
      "validate": "^\\{.*\\}$"
    },
    {
      "id": "$3",
      "name": "pnpm_lock_yaml_content",
      "hint": "Content of pnpm-lock.yaml file",
      "example": "{\\n  \\\"dependencies\\\": {\\n    \\\"lodash\\\": \\\"^4.17.21\\\"\\n  }\\n}",
      "required": true,
      "validate": "^\\{.*\\}$"
    },
    {
      "id": "$4",
      "name": "yarn_lock_content",
      "hint": "Content of yarn.lock file",
      "example": "{\\n  \\\"lodash\\\": \\\"^4.17.21\\\"\\n}",
      "required": true,
      "validate": "^\\{.*\\}$"
    }
  ]
}
