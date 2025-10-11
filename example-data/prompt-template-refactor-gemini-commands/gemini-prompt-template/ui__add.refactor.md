# commands/ui/add.toml
description = "Add shadcn/ui components to the current project."

prompt = """
You are wiring shadcn/ui components into this workspace.

If the 'shadcn-ui-server' MCP server is available:
  - Call its 'install-component' tool for each $1 component.
Else:
  - Use run_shell_command to:
      1) If needed, run: npx shadcn@latest init -y
      2) Then run: npx shadcn@latest add $1 -y
Afterwards, verify the files exist under components/ui and print concise next steps.
Only run the explicit commands above. Do not execute other shell commands.
"""

{
  "args": [
    {
      "id": "$1",
      "name": "component_list",
      "hint": "List of shadcn UI component names (e.g., 'button', 'input') separated by commas",
      "example": "button,input,card",
      "required": true,
      "validate": "^\\s*(button|input|card|switch|select|textarea|checkbox|radio)\\s*(,\\s*(button|input|card|switch|select|textarea|checkbox|radio))*\\s*$"
    }
  ]
}
