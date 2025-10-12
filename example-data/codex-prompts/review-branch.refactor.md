<!-- 
$1 = Goal statement (e.g., "Provide a high-level review of the current branch vs origin/main")
$2 = Diff stats output (e.g., "123 files changed, 456 insertions(+), 789 deletions(-)")
$3 = Diff snippet (first 200 lines of diff output)
$4 = Reviewer-friendly overview content (e.g., "Goals: ... Scope: ... Risky areas: ... Test impact: ...")
$5 = Output structure requirements (e.g., "Begin with a concise summary...")
$6 = Expected output format (e.g., bullet list with specific sections)
$7 = Trigger command (e.g., "/review-branch")
-->

# Review Branch

Trigger: $7

Purpose: $1

You are a CLI assistant focused on helping contributors with the task: $1.

1. Gather context by running `git diff --stat` for $2; running `git diff | sed -n '1,200p'` for $3.
2. Provide a reviewer-friendly overview: $4.
3. Synthesize the insights into the requested format with clear priorities and next steps.

Output:

- Begin with a concise summary that restates the goal: $1.
- Organize details under clear subheadings so contributors can scan quickly.
- Call out test coverage gaps and validation steps.

Example Input:
(none – command runs without arguments)

Expected Output:
- $6
