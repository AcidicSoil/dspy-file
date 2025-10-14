Research and compile authoritative public documentation, guidelines, and examples that support the following policy: maintain a canonical instruction file named “$1” as the single source of truth; produce platform variants “$2” and “$3” strictly via exact word-boundary substitutions (replace the whole word “$4” with “$5” or “$6” respectively, and replace the literal filename token “$7” with the variant filename, including inline links), with all other content preserved byte-for-byte. Find best practices for (a) minimal, targeted edits that only modify relevant sections, (b) preserving complete files with no truncation, summaries, or placeholders, (c) deterministic variants that differ only by the specified substitutions, (d) coherent insertion-point strategies when incorporating user-provided docs (e.g., “$8”, “$9”, “$10”) into $1, (e) validation checklists to verify formatting and internal references, and (f) fallback behavior when a document-rendering surface cannot display the entire file (output the full text directly and note the limitation). Prioritize authoritative project documentation sites, technical writing and editing style guides, and public examples of instruction files or policies that mirror these requirements; collect at least five high-quality citations with publication dates and short supporting quotes (≤25 words), and note any conflicts or divergent practices you encounter. Exclude any steps involving coding, command lines, or non-web tools; rely solely on standard web search and reading public web pages.

{
  "args": [
    {
      "id": "$1",
      "name": "canonical_filename",
      "hint": "Name of the canonical instruction file (e.g., AGENTS.md)",
      "example": "AGENTS.md",
      "required": true,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$2",
      "name": "platform_variant_1",
      "hint": "First platform variant name (e.g., GEMINI.md)",
      "example": "GEMINI.md",
      "required": true,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$3",
      "name": "platform_variant_2",
      "hint": "Second platform variant name (e.g., CLAUDE.md)",
      "example": "CLAUDE.md",
      "required": true,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$4",
      "name": "platform_token",
      "hint": "Token to be replaced (e.g., codex-cli)",
      "example": "codex-cli",
      "required": true,
      "validate": "^[A-Za-z0-9_-]+$"
    },
    {
      "id": "$5",
      "name": "replacement_1",
      "hint": "Replacement for first platform (e.g., gemini)",
      "example": "gemini",
      "required": true,
      "validate": "^[A-Za-z0-9_-]+$"
    },
    {
      "id": "$6",
      "name": "replacement_2",
      "hint": "Replacement for second platform (e.g., claude)",
      "example": "claude",
      "required": true,
      "validate": "^[A-Za-z0-9_-]+$"
    },
    {
      "id": "$7",
      "name": "filename_token",
      "hint": "Filename token to replace in substitutions (e.g., AGENTS.md)",
      "example": "AGENTS.md",
      "required": true,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$8",
      "name": "doc_file_1",
      "hint": "User-provided doc file (e.g., README.md)",
      "example": "README.md",
      "required": false,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$9",
      "name": "doc_file_2",
      "hint": "User-provided doc file (e.g., PRD.txt)",
      "example": "PRD.txt",
      "required": false,
      "validate": "^[A-Za-z0-9_.-]+\\.(md|txt)$"
    },
    {
      "id": "$10",
      "name": "doc_file_3",
      "hint": "User-provided doc file (e.g., tasks.json)",
      "example": "tasks.json",
      "required": false,
      "validate": "^[A-Za-z0-9_.-]+\\.(json|md|txt)$"
    }
  ]
}
