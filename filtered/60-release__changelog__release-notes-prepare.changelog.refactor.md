```md
# Prepare Release Notes From CHANGELOG

Trigger: /release-notes-prepare

Purpose: Convert the latest CHANGELOG section into release notes suitable for GitHub Releases with the six-section layout.

Steps:

1. Detect latest version heading and extract its section.
2. Normalize bullets to sentence fragments without trailing periods.
3. Add short highlights at top (3 bullets max) derived from Added/Changed.
4. Emit a "copy-ready" Markdown body.

Output format:

- Title line: `Release X.Y.Z — YYYY-MM-DD`
- Highlights list
- Six sections with bullets

Examples:
Input → `/release-notes-prepare`
Output →

```
Release {{version}} — {{date}}

**Highlights**
- {{highlight_1}}
- {{highlight_2}}
- {{highlight_3}}

### Added
- {{added_bullet_1}}
- {{added_bullet_2}}

### Changed
- {{changed_bullet_1}}
- {{changed_bullet_2}}

### Fixed
- {{fixed_bullet_1}}
- {{fixed_bullet_2}}

### Removed
- {{removed_bullet_1}}
- {{removed_bullet_2}}

### Deprecated
- {{deprecated_bullet_1}}
- {{deprecated_bullet_2}}

### Security
- {{security_bullet_1}}
- {{security_bullet_2}}
```

Notes:

- Strictly derived from `CHANGELOG.md`. Do not invent content.
- If no version is found, fall back to Unreleased with a warning.
```
