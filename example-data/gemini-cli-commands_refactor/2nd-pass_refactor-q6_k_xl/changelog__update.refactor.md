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
    !{git remote get-url origin 2>/dev/null || true}
    ```

    Last tag (preferring v* tags, may be empty):

    ```diff
    !{git describe --tags --abbrev=0 --match 'v*' 2>/dev/null || true}
    ```

    Commit log since last tag (or full history if none), excluding merge commits.
    Each entry is:
      SHA
      subject
      body
      ==END==

    ```diff
    !{bash -lc 'LAST_TAG=$(git describe --tags --abbrev=0 --match "v*" 2>/dev/null || echo ""); if [ -n "$LAST_TAG" ]; then git log --no-merges --pretty=format:"%H%n%s%n%b%n==END==" "$LAST_TAG"..HEAD; else git log --no-merges --pretty=format:"%H%n%s%n%b%n==END==" HEAD; fi'}
    ```

    Merge commits since last tag (for PR titles), format:
      SHA
      subject
      body
      ==END==

    ```diff
    !{bash -lc 'LAST_TAG=$(git describe --tags --abbrev=0 --match "v*" 2>/dev/null || echo ""); if [ -n "$LAST_TAG" ]; then git log --merges --pretty=format:"%H%n%s%n%b%n==END==" "$LAST_TAG"..HEAD; else git log --merges --pretty=format:"%H%n%s%n%b%n==END==" HEAD; fi'}
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
