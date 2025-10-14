<!-- $1=component list (e.g., button, card), $2=server availability check, $3=shell command fallback, $4=init command, $5=add command, $6=verification path, $7=output format -->

**Add shadcn/ui Components**

You are wiring shadcn/ui components into this workspace.

If the 'shadcn-ui-server' MCP server is available:
  - Call its 'install-component' tool for each $1.
Else:
  - Use run_shell_command to:
      1) If needed, run: npx shadcn@latest init -y
      2) Then run: npx shadcn@latest add $1 -y
Afterwards, verify the files exist under components/ui and print concise next steps.
Only run the explicit commands above. Do not execute other shell commands.

**Output format**
- A confirmation message indicating component installation status.
- A list of expected file paths (e.g., `components/ui/button.tsx`) if found.
- Concise next steps (e.g., "Run 'npx shadcn@latest preview' to see the result").
