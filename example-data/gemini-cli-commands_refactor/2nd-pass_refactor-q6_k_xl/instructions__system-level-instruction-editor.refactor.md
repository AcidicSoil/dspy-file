description = "Research guidance and public examples for maintaining a canonical AGENTS.md and generating GEMINI.md/CLAUDE.md variants via exact substitutions, with minimal-edit rules and full-file rendering/fallback policies."
prompt = """

Research and compile authoritative public documentation, guidelines, and examples that support the following policy: maintain a canonical instruction file named “$1” as the single source of truth; produce platform variants “$3.md” and “$3.md” strictly via exact word-boundary substitutions (replace the whole word “$2” with “gemini” or “claude” respectively, and replace the literal filename token “$1” with the variant filename, including inline links), with all other content preserved byte-for-byte. Find best practices for (a) minimal, targeted edits that only modify relevant sections, (b) preserving complete files with no truncation, summaries, or placeholders, (c) deterministic variants that differ only by the specified substitutions, (d) coherent insertion-point strategies when incorporating user-provided docs (e.g., README.md, PRD.txt, tasks.json) into $1, (e) validation checklists to verify formatting and internal references, and (f) fallback behavior when a document-rendering surface cannot display the entire file (output the full text directly and note the limitation). Prioritize authoritative project documentation sites, technical writing and editing style guides, and public examples of instruction files or policies that mirror these requirements; collect at least five high-quality citations with publication dates and short supporting quotes (≤25 words), and note any conflicts or divergent practices you encounter. Exclude any steps involving coding, command lines, or non-web tools; rely solely on standard web search and reading public web pages.

"""

{
  "args": [
    {
      "id": "$1",
      "name": "canonical_filename",
      "hint": "The base filename of the canonical instruction file (e.g., AGENTS.md)",
      "example": "AGENTS.md",
      "required": true,
      "validate": "^\\w+(\\.md)?$"
    },
    {
      "id": "$2",
      "name": "substitution_target",
      "hint": "The literal string to replace (e.g., 'codex-cli') in the source file",
      "example": "codex-cli",
      "required": true,
      "validate": "^\\w+(?:-\\w+)*$"
    },
    {
      "id": "$3",
      "name": "platform_variant",
      "hint": "The platform name for the variant (e.g., 'gemini' or 'claude')",
      "example": "gemini",
      "required": true,
      "validate": "^(gemini|claude)$"
    }
  ]
}
