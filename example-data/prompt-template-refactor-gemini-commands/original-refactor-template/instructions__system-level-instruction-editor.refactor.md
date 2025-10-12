<!-- $1 = source prompt text, $2 = template name (e.g., "Policy Analysis"), $3 = max placeholders (default 7) -->
**{$2 or Inferred Name}**

This document provides an analysis of best practices for maintaining a canonical instruction file and generating platform-specific variants through deterministic string substitutions.

### Objective
$1

### Core Policy
- Maintain a single source of truth: a canonical file named "AGENTS.md".
- Generate platform variants ("GEMINI.md", "CLAUDE.md") via exact word-boundary replacements:
  - Replace the whole word "codex-cli" with either "gemini" or "claude".
  - Replace the literal filename token "AGENTS.md" with the variant filename (e.g., "GEMINI.md"), including inline links.
- Preserve all other content byte-for-byte; no summarization, truncation, placeholders, or formatting changes.

### Key Requirements
$2

### Affected Files
- AGENTS.md (canonical source)
- GEMINI.md and CLAUDE.md (variant outputs)

### Root Cause of Challenges
- Risk of unintended substitutions due to partial matches.
- Potential loss of context when truncating files.
- Inconsistencies in insertion points for user-provided documents.

### Proposed Fix
Implement strict word-boundary matching using regex patterns (e.g., `\bcodex-cli\b`) and validate all substitutions against a reference set. Ensure no other content is altered during the rendering process.

### Tests & Validation
$3

### Docs Gaps
- Lack of public examples showing full file renders with embedded links.
- No standardized format for validation checklists in instruction files.
- Limited guidance on handling fallback scenarios when rendering surfaces are constrained.

### Open Questions
$4

### Citations (at least five)
$5

### Fallback Behavior
When a document-rendering surface cannot display the entire file, output the full text directly and include a note stating: "Full content rendered due to display limitations."

### Output Format
- Structured analysis with clear sections.
- Use numbered placeholders for dynamic input substitution (e.g., $1 through $7).
- No verbatim copying from source; all content is synthesized based on public guidance.
