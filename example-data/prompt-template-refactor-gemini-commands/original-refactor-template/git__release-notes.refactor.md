<!-- $1 = input commit range or tag (e.g., v1.2.0..HEAD) -->
<!-- $2 = description of the task to be performed -->
<!-- $3 = generated output format or structure guidance -->

**Release Notes Generator**

Generate human-readable release notes from recent commits grouped by type: feat, fix, perf, docs, refactor, chore.

Include:
- A Highlights section summarizing key changes.
- A full changelog list with commit details (author, message).

Input:
!{git log --pretty='* %s (%h) — %an' --no-merges $1}

Output format:
### Highlights
- Brief summary of major features and fixes.

### Changelog
- $2

*Note: The output should be formatted as plain text with clear section headers, avoiding markdown tables or code blocks.*
