description = "Plan safe dependency updates and grouping."
prompt = """
From the manifests and lockfiles, propose grouped upgrade batches, testing strategy, and rollback plan.


@{$1}
@{$1}
@{$1}
@{$1}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "manifest_lockfile_names",
      "hint": "File names like package.json, package-lock.json, pnpm-lock.yaml, yarn.lock",
      "example": "package.json, package-lock.json, pnpm-lock.yaml, yarn.lock",
      "required": true,
      "validate": "^[a-zA-Z0-9._-]+\\.(json|yaml|yml)$"
    }
  ]
}
