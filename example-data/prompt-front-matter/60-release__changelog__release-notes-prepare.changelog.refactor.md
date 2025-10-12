# Prepare Release Notes From CHANGELOG

Task: Given the following prompt, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original prompt.

## Inputs

- Trigger: `/release-notes-prepare`
- Purpose: Convert the latest CHANGELOG section into release notes suitable for GitHub Releases with the six-section layout.
- Input source: `CHANGELOG.md`
- Output format:
  - Title line: `Release X.Y.Z — YYYY-MM-DD`
  - Highlights list
  - Six sections with bullets

## Canonical taxonomy (exact strings)
- Documentation
- Automation
- Release Engineering

### Stage hints (for inference)
- prepare
- pre-release
- build-time
- workflow

## Algorithm

1. Extract signals from the prompt:
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier:
   * Prefer explicit input; otherwise infer from main action + object.
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).
   * De-duplicate.
   → Identifier: `release-notes-prepare`

3. Determine categories:
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.
   * Validate, sort deterministically, and de-dupe (≤3).
   → Categories: ["release engineering", "automation", "documentation"]

4. Determine lifecycle/stage (optional):
   * Prefer explicit input; otherwise map categories via stage hints.
   * Omit if uncertain.
   → Stage: pre-release

5. Determine dependencies (optional):
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).
   → Dependency: `CHANGELOG.md`

6. Determine provided artifacts (optional):
   * Short list (≤3) of unlocked outputs.
   → Artifacts: ["copy-ready Markdown body for GitHub Releases"]

7. Compose summary:
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”
   → Summary: "Convert latest CHANGELOG into formatted release notes for GitHub Releases."

8. Produce metadata in the requested format:
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata:
   * Merge: explicit inputs > existing > inferred.
   * Validate lists; move unknowns to an extension field if needed.
   * Remove empty keys.

## Assumptions & Constraints
- Emit exactly one document: metadata, a single blank line, then the original prompt.
- Limit distinct placeholders to ≤ 7.
- Do not invent content — strictly derive from input.
- Output body must remain unchanged.

## Validation
- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Artifacts list ≤3.
- Summary ≤120 chars; punctuation coherent.
- Original body not altered.

## Output format examples
```yaml
identifier: release-notes-prepare
category: 
  - release engineering
  - automation
  - documentation
stage: pre-release
dependencies:
  - CHANGELOG.md
provided_artifacts:
  - copy-ready Markdown body for GitHub Releases
summary: Convert latest CHANGELOG into formatted release notes for GitHub Releases.
```

---

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
Release 1.6.0 — 2025-09-22

**Highlights**
- Custom roles and permissions
- Faster cold starts

### Added
- Role-based access control
```

Notes:

- Strictly derived from `CHANGELOG.md`. Do not invent content.
- If no version is found, fall back to Unreleased with a warning.
