description = "Plan safe dependency updates and grouping."
prompt = """
From the manifests and lockfiles, propose grouped upgrade batches, testing strategy, and rollback plan.


@{$1}
@{$2}
@{$3}
@{$4}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
