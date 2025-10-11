description = "Check adherence to .editorconfig across the repo."
prompt = """
From the listing and config, point out inconsistencies and propose fixes.


@{$1}
!{git ls-files | sed -n '1,400p'}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
