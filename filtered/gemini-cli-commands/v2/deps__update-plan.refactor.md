description = "Plan safe dependency updates and grouping."
prompt = """
From the manifests and lockfiles, propose grouped upgrade batches, testing strategy, and rollback plan.


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
      "name": "manifest_file_1",
      "hint": "First manifest file (e.g., package.json)",
      "example": "package.json",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+\\.(json|yaml|yml)$"
    },
    {
      "id": "$2",
      "name": "lock_file_1",
      "hint": "First lockfile (e.g., package-lock.json)",
      "example": "package-lock.json",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+\\.(json|yaml|yml)$"
    },
    {
      "id": "$3",
      "name": "lock_file_2",
      "hint": "Second lockfile (e.g., pnpm-lock.yaml)",
      "example": "pnpm-lock.yaml",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+\\.(json|yaml|yml)$"
    },
    {
      "id": "$4",
      "name": "lock_file_3",
      "hint": "Third lockfile (e.g., yarn.lock)",
      "example": "yarn.lock",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+\\.(json|yaml|yml)$"
    }
  ]
}
