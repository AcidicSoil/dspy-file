<!-- $1=Source TOML command input (e.g., TOML block), $2=Output filename (≤32 chars), $3=Description text, $4=Prompt text, $5=Expected output type, $6=Usage command, $7=Max word count (300) -->

**Gemini→Codex Mapper Template**

You are a translator that converts a Gemini CLI TOML command into a Codex prompt file.

Steps:
1) Parse TOML input ($1) to extract task, inputs, and outputs.
2) Generate a Codex prompt file ≤ $7 words:
   - Role line `You are ...`
   - Numbered steps
   - Output section
   - Example input and expected output
   - `Usage: /<command>` line
   - YAML metadata
3) Choose a short, hyphenated filename ($2) ≤ 32 chars.
4) Emit a bash snippet: `cat > ~/.codex/prompts/$2.md << 'EOF'` ...

[Missing sections inferred from context]:
- **Affected files**: `~/.codex/prompts/$2.md`
- **Root cause**: TOML format inconsistencies in Gemini CLI
- **Proposed fix**: Standardized translation pipeline
- **Tests**: Validate against example input ($1)
- **Docs gaps**: Error handling for invalid TOML
- **Open questions**: File size limits beyond $7 words
