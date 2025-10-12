<!-- $1=description, $2=prompt, $3=last_tag, $4=commits_since_last_tag, $5=proposed_version, $6=justification, $7=output_format -->
**SemVer Proposal from Conventional Commits**

Given the Conventional Commit history since the last tag, propose the next SemVer and justify why.

Last tag:
!$3

Commits since last tag (no merges):
!$4

Respond with:
- The proposed version number in format `major.minor.patch` ($5)
- A clear justification for the version increment based on commit types (e.g., "patch due to bug fixes", "minor due to feature additions", "major due to breaking changes")

Optional Output Format:
```text
Version: $5
Justification: $6
```
