<!-- $1=User context command (e.g., "/pr-desc <context>"), $2=Affected file path (e.g., "src/example.ts"), $3=Git diff stats (e.g., "2 files changed, 15 insertions(+), 3 deletions(-)"), $4=Concise PR summary, $5=Context details (workflow triggers/failing jobs), $6=Changes summary, $7=Test coverage status (e.g., "Gap: 15%") -->

# PR Description Template

Trigger: $1

Purpose: Draft a PR description from the branch diff.

1. Gather context by running `git diff --name-status $2` for the changed files (name + status); running `git diff --shortstat $2` for the high‑level stats ($3).
2. Create a crisp PR description following this structure:
   - **Summary**: $4
   - **Context**: $5
   - **Changes**: $6
   - **Screenshots**: (if applicable)
   - **Test Coverage**: $7

Output requirements:
- Begin with a concise summary: $4
- Prioritized recommendations: $5
- Test coverage gaps: $7
- Workflow triggers/failing jobs: (implied in $5)
