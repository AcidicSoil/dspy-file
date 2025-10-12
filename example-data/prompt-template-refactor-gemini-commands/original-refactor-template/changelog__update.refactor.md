<!-- $1 = source Markdown content (e.g., current CHANGELOG.md) -->
<!-- $2 = repository URL (if any) -->
<!-- $3 = last tag (e.g., v1.2.0 or empty) -->
<!-- $4 = commit log since last tag (excludes merge commits) -->
<!-- $5 = merge commit log (for PR titles) -->
<!-- $6 = conventional commit mapping rules or parsing hints -->
<!-- $7 = output format instruction (e.g., only emit updated markdown, no commentary) -->

**{Changelog Update}**

### CANVAS

    description = "Update CHANGELOG.md with concise user-facing notes under Added/Changed/Deprecated/Removed/Fixed/Security using recent commits."
    prompt = """
    You update CHANGELOG.md in Keep a Changelog style, compatible with SemVer.
    Goal: On each merge, append concise, user-facing bullets into the **Unreleased** section, grouped under:
    - Added
    - Changed
    - Deprecated
    - Removed
    - Fixed
    - Security

    Rules:
    - Output ONLY the full, updated CHANGELOG.md file content. No commentary.
    - Preserve existing sections, links, and chronology.
    - If Unreleased section is missing, create it at the top after the H1 header.
    - Convert commit/PR noise into plain language. Avoid internal file paths and code jargon unless essential.
    - Prefer imperative bullets. 1 line each. No trailing periods.
    - Map conventional commit types to sections:
      - feat → Added
      - perf → Changed
      - refactor → Changed
      - deprecate → Deprecated
      - remove/chore(removal) → Removed
      - fix → Fixed
      - sec/security/deps with security impact → Security
    - Infer category from keywords if no conventional type appears.
    - Deduplicate similar bullets. If nothing user-facing, make no changes.
    - Keep markdown tidy. Use hyphen bullets under each subsection.
    - Do not invent versions or dates.

    Inputs below.

    Current CHANGELOG.md:

    $1

    Repository URL (if any):

    ```diff
    $2
    ```

    Last tag (preferring v* tags, may be empty):

    ```diff
    $3
    ```

    Commit log since last tag (or full history if none), excluding merge commits.
    Each entry is:
      SHA
      subject
      body
      ==END==

    ```diff
    $4
    ```

    Merge commits since last tag (for PR titles), format:
      SHA
      subject
      body
      ==END==

    ```diff
    $5
    ```

    Hints for parsing:
    - Detect PR titles like "Merge pull request #123 ..." or subjects like "feat(ui): add quick search".
    - Recognize trailers: "BREAKING CHANGE:", "Changelog:", "PR-Title:", "Issue: #123".
    - Convert module names or scopes to user-facing nouns when helpful.

    Editing steps you must perform:
    1) Parse the inputs and derive a minimal set of user-facing bullets, grouped into sections above.
    2) Insert or update the **Unreleased** section so it contains only the new bullets from this run at the top of each subsection. Keep any existing bullets beneath.
    3) If a subsection has no bullets at all after your additions, keep the subsection header but do not add placeholder text.

    Finally, emit the complete updated CHANGELOG.md content and nothing else.
    """

### Affected Files
- $6 (e.g., list of modules or files mentioned in commits)

### Root Cause
- Not applicable — this is a changelog update, not a bug fix

### Proposed Fix
- N/A — no technical fix required; only documentation change

### Tests
- No test updates required; changelog generation does not affect test coverage

### Docs Gaps
- None identified in the current workflow

### Open Questions
- Should all PRs with "BREAKING CHANGE" be highlighted in the changelog?
- How should ambiguous commit types (e.g., "docs: update readme") be categorized?

### Output Format
- Only emit the updated full content of CHANGELOG.md.
- Do not include any commentary, explanations, or metadata.
- The output must be valid Markdown with proper sectioning and bullet syntax.
