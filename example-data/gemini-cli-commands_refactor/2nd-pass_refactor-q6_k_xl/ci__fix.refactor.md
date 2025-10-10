description = "Diagnose and fix a failing GitHub Actions/CI workflow."
prompt = """
Analyze workflows and recent run logs; hypothesize root causes and propose fixes.


Workflows:
@{$1}


Recent CI‑related commits:
!{$2}
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
