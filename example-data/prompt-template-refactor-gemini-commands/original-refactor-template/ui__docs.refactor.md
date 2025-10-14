<!-- $1 = source markdown content (e.g., full prompt) -->
<!-- $2 = component name (free-form input) -->
<!-- $3 = normalized component name (lowercase, trimmed) -->
<!-- $4 = registry source of docs (e.g., shadcn/ui) -->
<!-- $5 = title line output format (e.g., "<name> — from <registry>") -->
<!-- $6 = short description or usage text -->
<!-- $7 = code snippet or example (verbatim fenced block) -->

**CLI Command Prompt Template**

This template defines the behavior of a CLI command that retrieves documentation for shadcn/ui components.

(Instructions with placeholders)
1) Normalize the component name to lowercase and trim whitespace. → Use `$3`
2) Call the MCP tool `get-component-docs` with the provided name. → Input: `$2`, Processed: `$3`
3) If docs are returned, display:
   - Title line: `$5`
   - Short description (if provided): `$6`
   - Code snippet or usage example (verbatim fenced block): `$7`
4) If not found, call `list-components`, compute close matches (Levenshtein-like), and suggest up to 5 similar names.

Error handling:
- If the server or tool is unavailable, reply: "shadcn MCP server not detected. Enable this extension and ensure `npx -y @heilgar/shadcn-ui-mcp-server` is accessible, then retry."

Safety:
- Do not execute shell commands.
- Do not install packages.

**Output format**
When responding to a user command:
- If component found: output the title line, description (if any), code snippet, and install hints (if provided).
- If not found: list up to 5 similar components with their names and brief descriptions (from `list-components` result).
