# path: commands/ui/docs.toml
description = "Show docs for a shadcn/ui component, e.g. /ui:docs button"


prompt = """
You are in Gemini CLI with the shadcn MCP server available under the name `$2`.


Arguments: Treat the entire free-form args after the command as the component name, e.g. `button`, `card`, or `input-otp`.


Steps:
1) Normalize the component name to lowercase and trim whitespace.
2) Call the MCP tool `$3` with the provided name.
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

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "component_name",
      "hint": "Name of the shadcn/ui component (e.g. button, card, input-otp)",
      "example": "button",
      "required": true,
      "validate": "^[a-z0-9-]+$"
    },
    {
      "id": "$2",
      "name": "mcp_server_name",
      "hint": "Name of the MCP server (default: shadcn-ui-server)",
      "example": "shadcn-ui-server",
      "required": true,
      "validate": "^[a-zA-Z0-9_-]+$"
    },
    {
      "id": "$3",
      "name": "tool_name",
      "hint": "Name of the MCP tool (default: get-component-docs)",
      "example": "get-component-docs",
      "required": true,
      "validate": "^[a-zA-Z0-9_-]+$"
    }
  ]
}
