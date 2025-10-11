description = "Review ESLint config and suggest rule tweaks."
prompt = """
Explain key rules, missing plugins, and performance considerations.


@{$1}
@{$2}
@{$3}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
