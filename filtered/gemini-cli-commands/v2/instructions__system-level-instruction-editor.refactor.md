description = "Research guidance and public examples for maintaining a canonical AGENTS.md and generating GEMINI.md/CLAUDE.md variants via exact substitutions, with minimal-edit rules and full-file rendering/fallback policies."
prompt = """

Research and compile authoritative public documentation, guidelines, and examples that support the following policy: maintain a canonical instruction file named “$1” as the single source of truth; produce platform variants “$2.md” and “$3.md” strictly via exact word-boundary substitutions (replace the whole word “codex-cli” with “$4” or “$5” respectively, and replace the literal filename token “$1” with the variant filename, including inline links), with all other content preserved byte-for-byte. Find best practices for (a) minimal, targeted edits that only modify relevant sections, (b) preserving complete files with no truncation, summaries, or placeholders, (c) deterministic variants that differ only by the specified substitutions, (d) coherent insertion-point strategies when incorporating user-provided docs (e.g., README.md, PRD.txt, tasks.json) into $1, (e) validation checklists to verify formatting and internal references, and (f) fallback behavior when a document-rendering surface cannot display the entire file (output the full text directly and note the limitation). Prioritize authoritative project documentation sites, technical writing and editing style guides, and public examples of instruction files or policies that mirror these requirements; collect at least five high-quality citations with publication dates and short supporting quotes (≤25 words), and note any conflicts or divergent practices you encounter. Exclude any steps involving coding, command lines, or non-web tools; rely solely on standard web search and reading public web pages.

"""

{
  "args": [
    {
      "id": "$1",
      "name": "canonical_filename",
      "hint": "Name of the canonical instruction file (e.g., AGENTS.md)",
      "example": "AGENTS.md",
      "required": true,
      "validate": "^[A-Za-z0-9_.-]+\\.md$"
    },
    {
      "id": "$2",
      "name": "platform_variant_1",
      "hint": "First platform name for variant replacement (e.g., gemini)",
      "example": "gemini",
      "required": true,
      "validate": "^[a-zA-Z]+$"
    },
    {
      "id": "$3",
      "name": "platform_variant_2",
      "hint": "Second platform name for variant replacement (e.g., claude)",
      "example": "claude",
      "required": true,
      "validate": "^[a-zA-Z]+$"
    },
    {
      "id": "$4",
      "name": "replacement_platform_1",
      "hint": "Platform to replace 'codex-cli' with (e.g., gemini)",
      "example": "gemini",
      "required": true,
      "validate": "^[a-zA-Z]+$"
    },
    {
      "id": "$5",
      "name": "replacement_platform_2",
      "hint": "Platform to replace 'codex-cli' with (e.g., claude)",
      "example": "claude",
      "required": true,
      "validate": "^[a-zA-Z]+$"
    }
  ]
}
