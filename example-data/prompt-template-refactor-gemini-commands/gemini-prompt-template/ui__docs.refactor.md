# path: commands/ui/docs.toml
description = "Show docs for a shadcn/ui component, e.g. /ui:docs button"


prompt = """
You are in Gemini CLI with the shadcn MCP server available under the name `shadcn-ui-server`.


Arguments: Treat the entire free-form args after the command as the component name, e.g. $1.


Steps:
1) Normalize the component name to lowercase and trim whitespace.
2) Call the MCP tool `get-component-docs` with the provided name.
3) If docs are returned, display:
- Title line: <name> — from <registry>
- Short description (if provided)
- Code snippet or usage example (verbatim fenced block)
- Any install hints returned by the server (e.g., package names)
4) If not found, call `list-components`, compute close matches (Levenshtein-like; approximate string match is fine), and suggest up to 5 similar names.


Error handling:
- If the server or tool is unavailable, reply: "shadcn MCP server not detected. Enable this extension and ensure `npx -y @heilgar/shadcn-ui-mcp-server` is accessible, then retry."


Safety:
- Do not execute shell commands.
- Do not install packages.
"""

{
  "args": [
    {
      "id": "$1",
      "name": "component_name",
      "hint": "The name of the shadcn UI component (e.g., button, card, input-otp)",
      "example": "button",
      "required": true,
      "validate": "^\\w+(?:-\\w+)*$"
    }
  ]
}
