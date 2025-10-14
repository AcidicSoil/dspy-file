# Lists stale/merged local branches and proposes deletions
description = "Suggest safe local branch cleanup (merged/stale)."
prompt = """
Using the lists below, suggest local branches safe to delete and which to keep. Include commands to remove them if desired (DO NOT execute).


Merged into current upstream:
!{$1}


Branches not merged:
!{$2}


Recently updated (last author dates):
!{$3}
"""
