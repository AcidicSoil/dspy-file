description = "Plan safe dependency updates and grouping."
prompt = """
From the manifests and lockfiles, propose grouped upgrade batches, testing strategy, and rollback plan.


@{package.json}
@{package-lock.json}
@{pnpm-lock.yaml}
@{yarn.lock}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
