# Lists stale/merged local branches and proposes deletions
description = "Suggest safe local branch cleanup (merged/stale)."
prompt = """
Using the lists below, suggest local branches safe to delete and which to keep. Include commands to remove them if desired (DO NOT execute).


Merged into current upstream:
!{git branch --merged}


Branches not merged:
!{git branch --no-merged}


Recently updated (last author dates):
!{git for-each-ref --sort=-authordate --format='%(refname:short) — %(authordate:relative)' refs/heads}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "upstream_branch",
      "hint": "The name of the upstream branch (e.g., 'main', 'develop') to use as reference for merged/not merged branches.",
      "example": "main",
      "required": true,
      "validate": "^[a-zA-Z][a-zA-Z0-9._-]*$"
    }
  ]
}
