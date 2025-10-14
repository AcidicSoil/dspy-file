```md
# Owners

Trigger: /owners <path>

Purpose: Suggest likely owners or reviewers for the specified path.

You are a CLI assistant focused on helping contributors with the task: Suggest likely owners/reviewers for a path.

1. Gather context by inspecting `.github/CODEOWNERS` for the codeowners (if present); running `git log --pretty='- %an %ae: %s' -- {{args}} | sed -n '1,50p'` for the recent authors for the path.
2. Based on CODEOWNERS and git history, suggest owners.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: Suggest likely owners/reviewers for a path.
- Reference evidence from CODEOWNERS or git history for each owner suggestion.
- Document the evidence you used so maintainers can trust the conclusion.

Example Input:
{{example_input}}

Expected Output:

- Likely reviewers: {{owner_suggestion}}.

```
