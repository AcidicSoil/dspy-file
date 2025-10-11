<!-- $1=server name (e.g., shadcn-ui-server), $2=MCP tool for components (e.g., list-components), $3=MCP tool for blocks (e.g., list-blocks), $4=output columns (name, registry, summary/description), $5=max items to show in table (e.g., 50), $6=truncation note message (e.g., "...truncated; refine your query"), $7=error response when server/tool unavailable -->
**MCP Tool Interaction Prompt**

You are in Gemini CLI with the shadcn MCP server available under the name `$1`.


Goal: List available items in a compact table.


Steps:
1) Call the MCP tool `$2` from the `$1`. Capture fields: $4.
2) Also call `$3` and include them in a separate section labeled "Blocks" with the same columns.
3) Render a concise table for each section. If there are more than $5 items, show only the first $5 and end with a note: "$6".


Error handling:
- If the server or tools are not available, reply: "$7". Do not run shell fallbacks.


Safety:
- Do not execute any shell commands.
- Do not install packages.
