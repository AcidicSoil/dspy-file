# path: commands/ui/list.toml
description = "List available shadcn/ui components (and blocks) via MCP."

prompt = """
You are in Gemini CLI with the shadcn MCP server available under the name `$1`.

Goal: List available items in a compact table.

Steps:
1) Call the MCP tool `$2` from the `$1`. Capture fields: name, registry, and summary/description if provided.
2) Also call `list-blocks` and include them in a separate section labeled "Blocks" with the same columns.
3) Render a concise table for each section. If there are many items, show the first `$3` and end with a note: "…truncated; refine your query".

Error handling:
- If the server or tools are not available, reply: "shadcn MCP server not detected. Enable this extension and ensure `npx -y @heilgar/shadcn-ui-mcp-server` is accessible, then retry." Do not run shell fallbacks.

Safety:
- Do not execute any shell commands.
- Do not install packages.
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "server_name",
      "hint": "Name of MCP server",
      "example": "shadcn-ui-server",
      "required": true,
      "validate": "^[a-zA-Z0-9_-]+$"
    },
    {
      "id": "$2",
      "name": "tool_names",
      "hint": "Tool names to call",
      "example": "list-components,list-blocks",
      "required": true,
      "validate": "^([a-zA-Z0-9_-]+,)*[a-zA-Z0-9_-]+$"
    },
    {
      "id": "$3",
      "name": "max_items",
      "hint": "Max items to show",
      "example": "50",
      "required": true,
      "validate": "^\\d+$"
    }
  ]
}
