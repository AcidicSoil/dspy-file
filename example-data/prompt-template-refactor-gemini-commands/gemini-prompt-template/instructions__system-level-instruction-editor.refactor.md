description = "Research guidance and public examples for maintaining a canonical AGENTS.md and generating GEMINI.md/CLAUDE.md variants via exact substitutions, with minimal-edit rules and full-file rendering/fallback policies."
prompt = """

Research and compile authoritative public documentation, guidelines, and examples that support the following policy: maintain a canonical instruction file named “AGENTS.md” as the single source of truth; produce platform variants “GEMINI.md” and “CLAUDE.md” strictly via exact word-boundary substitutions (replace the whole word “codex-cli” with “$2” respectively, and replace the literal filename token “AGENTS.md” with the variant filename, including inline links), with all other content preserved byte-for-byte. Find best practices for (a) minimal, targeted edits that only modify relevant sections, (b) preserving complete files with no truncation, summaries, or placeholders, (c) deterministic variants that differ only by the specified substitutions, (d) coherent insertion-point strategies when incorporating user-provided docs (e.g., README.md, PRD.txt, tasks.json) into AGENTS.md, (e) validation checklists to verify formatting and internal references, and (f) fallback behavior when a document-rendering surface cannot display the entire file (output the full text directly and note the limitation). Prioritize authoritative project documentation sites, technical writing and editing style guides, and public examples of instruction files or policies that mirror these requirements; collect at least five high-quality citations with publication dates and short supporting quotes (≤25 words), and note any conflicts or divergent practices you encounter. Exclude any steps involving coding, command lines, or non-web tools; rely solely on standard web search and reading public web pages.

$1
"""

{
  "args": [
    {
      "id": "$1",
      "name": "research_citations",
      "hint": "A list of at least five publicly available sources with publication dates and short quotes (≤25 words each) that support the policy of minimal edits, deterministic substitutions, or file preservation.",
      "example": "[{\"title\": \"Official Gemini Documentation\", \"date\": \"2024-03-15\", \"quote\": \"Use exact word boundaries to avoid unintended replacements.\"}, {\"title\": \"Editing Style Guide\", \"date\": \"2023-11-01\", \"quote\": \"Preserve full content without summarization or truncation.\"}]",
      "required": true,
      "validate": "\\[\\{\\\"title\\\": \\S+, \\\"date\\\": \\d{4}-\\d{2}-\\d{2}, \\\"quote\\\": \\S+\\}.*\\]\\s*\\]"
    },
    {
      "id": "$2",
      "name": "platform_variant",
      "hint": "The platform name to substitute into the instruction file (e.g., 'gemini' or 'claude') — used to replace 'codex-cli' and the filename token.",
      "example": "gemini",
      "required": true,
      "validate": "^gemini|claude$"
    }
  ]
}
