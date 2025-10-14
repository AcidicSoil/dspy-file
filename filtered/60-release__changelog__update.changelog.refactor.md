```md
# Update CHANGELOG

Trigger: /update-changelog

Purpose: Generate a user-facing CHANGELOG entry for the latest merge range and insert under the correct version or Unreleased with the six standard sections.

Steps:

1. Inspect repo state:
   - Detect current branch and latest tag: `git describe --tags --abbrev=0`.
   - Identify range: `${SINCE:-<latest-tag>}..HEAD`. If a merge commit hash or tag is provided, use that.
2. Collect changes:
   - Prefer Conventional Commits in `git log --pretty=%s %b` over the range.
   - Map commit types to sections: feat→Added, perf/refactor→Changed, deprecate→Deprecated, remove→Removed, fix→Fixed, security→Security.
   - Merge PR titles: `git log --merges --pretty=%s` and include PR numbers.
3. De-dupe and rewrite:
   - Collapse internal-only chatter. Use terse, user-facing wording. No file paths unless end-user relevant.
   - Keep bullets short. One line each. Present tense. No trailing periods.
4. Emit Markdown snippet with the six sections. Omit empty sections.
5. Decide placement:
   - If a release tag was created in this merge, use `## [X.Y.Z] - YYYY-MM-DD`.
   - Else place under `## [Unreleased]`.
6. Provide a unified diff showing insertion into `CHANGELOG.md`. Do not run it; just output the patch.

Output format:

- Heading line with target section (Unreleased or version)
- Six-section block in Markdown with only non-empty sections in order: Added, Changed, Deprecated, Removed, Fixed, Security
- A short "Link references" block suggestion for `[Unreleased]` and new version comparison links
- A unified diff (context 3) for `CHANGELOG.md`

Examples:
Input →

```
/update-changelog since={{since}} notes={{notes}}
```

Output →

```
## [{{version}}]
### Added
- {{added}}

### Changed
- {{changed}}

### Deprecated
- {{deprecated}}

### Removed
- {{removed}}

### Fixed
- {{fixed}}

### Security
- {{security}}

[{{version}}]: https://github.com/{{owner}}/{{repo}}/compare/{{since}}...HEAD
```

Notes:

- Assumes git repository is available and tags follow SemVer.
- Keep content end-user focused. Avoid internal file names and refactor notes.
- If no Conventional Commits, infer section from message heuristics.
- Do not include secrets or internal ticket links.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
