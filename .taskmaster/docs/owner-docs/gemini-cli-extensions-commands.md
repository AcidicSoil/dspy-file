# DeepWiki Q&A with Code Context for Repository: google-gemini/gemini-cli

You can add custom extensions or commands to Gemini CLI in two main ways: **custom commands** and **extensions**.<cite />

## Custom Commands

Custom commands allow you to save reusable prompts as shortcuts gemini-cli:145-147 . They are defined using TOML files in specific directories:

1. **User Commands (Global)**: `~/.gemini/commands/` - available across all projects gemini-cli:153-153
2. **Project Commands (Local)**: `<project-root>/.gemini/commands/` - project-specific, can be version controlled gemini-cli:154-154

**Creating a custom command:**

```bash
mkdir -p ~/.gemini/commands/refactor
touch ~/.gemini/commands/refactor/pure.toml
``` gemini-cli:350-353

The TOML file requires a `prompt` field and optionally a `description` gemini-cli:169-175 . Commands support argument substitution with `{{args}}`, shell command execution with `!{...}`, and file injection with `@{...}` gemini-cli:179-338 .

## Extensions

Extensions package prompts, MCP servers, and custom commands into a distributable format gemini-cli:5-5 .

**Creating an extension:**

```bash
gemini extensions new my-first-extension mcp-server
``` gemini-cli:15-17

This creates a directory with a `gemini-extension.json` manifest file gemini-cli:33-48 . The manifest can include:

- `mcpServers`: Configure MCP servers to add custom tools gemini-cli:109-110
- `contextFileName`: Specify a GEMINI.md file for persistent context gemini-cli:111-111
- `excludeTools`: Block specific tools gemini-cli:112-112

Extensions can include custom commands by placing TOML files in a `commands/` subdirectory gemini-cli:116-118 .

**Installing extensions:**

```bash
# From GitHub
gemini extensions install https://github.com/user/extension

# From local path
gemini extensions install --path ./my-extension

# Link for development (creates symlink)
gemini extensions link ./my-extension
``` gemini-cli:17-23 gemini-cli:73-79

Extensions are stored in `~/.gemini/extensions/` and loaded on CLI startup gemini-cli:83-87 .

# Notes

The key difference is that custom commands are simpler (just TOML files with prompts), while extensions are more powerful packages that can include MCP servers, multiple commands, and context files<cite />. Project commands take precedence over user commands, and both take precedence over extension commands gemini-cli:156-156 gemini-cli:140-143 . The `gemini extensions` command suite provides management tools for installing, updating, enabling/disabling, and linking extensions gemini-cli:17-31 .

Wiki pages you might want to explore:
- [MCP Server Integration (google-gemini/gemini-cli)](/wiki/google-gemini/gemini-cli#3.4)


### Citations


**File:** docs/cli/commands.md (L145-147)

```markdown
For a quick start, see the [example](#example-a-pure-function-refactoring-command) below.

Custom commands allow you to save and reuse your favorite or most frequently used prompts as personal shortcuts within Gemini CLI. You can create commands that are specific to a single project or commands that are available globally across all your projects, streamlining your workflow and ensuring consistency.
```

**File:** docs/cli/commands.md (L153-153)

```markdown
1.  **User Commands (Global):** Located in `~/.gemini/commands/`. These commands are available in any project you are working on.
```

**File:** docs/cli/commands.md (L154-154)

```markdown
2.  **Project Commands (Local):** Located in `<your-project-root>/.gemini/commands/`. These commands are specific to the current project and can be checked into version control to be shared with your team.
```

**File:** docs/cli/commands.md (L156-156)

```markdown
If a command in the project directory has the same name as a command in the user directory, the **project command will always be used.** This allows projects to override global commands with project-specific versions.
```

**File:** docs/cli/commands.md (L169-175)

```markdown
##### Required Fields

- `prompt` (String): The prompt that will be sent to the Gemini model when the command is executed. This can be a single-line or multi-line string.

##### Optional Fields

- `description` (String): A brief, one-line description of what the command does. This text will be displayed next to your command in the `/help` menu. **If you omit this field, a generic description will be generated from the filename.**
```

**File:** docs/cli/commands.md (L179-338)

```markdown
Custom commands support two powerful methods for handling arguments. The CLI automatically chooses the correct method based on the content of your command's `prompt`.

##### 1. Context-Aware Injection with `{{args}}`

If your `prompt` contains the special placeholder `{{args}}`, the CLI will replace that placeholder with the text the user typed after the command name.

The behavior of this injection depends on where it is used:

**A. Raw Injection (Outside Shell Commands)**

When used in the main body of the prompt, the arguments are injected exactly as the user typed them.

**Example (`git/fix.toml`):**

```toml
# Invoked via: /git:fix "Button is misaligned"

description = "Generates a fix for a given issue."
prompt = "Please provide a code fix for the issue described here: {{args}}."
```

The model receives: `Please provide a code fix for the issue described here: "Button is misaligned".`

**B. Using Arguments in Shell Commands (Inside `!{...}` Blocks)**

When you use `{{args}}` inside a shell injection block (`!{...}`), the arguments are automatically **shell-escaped** before replacement. This allows you to safely pass arguments to shell commands, ensuring the resulting command is syntactically correct and secure while preventing command injection vulnerabilities.

**Example (`/grep-code.toml`):**

```toml
prompt = """
Please summarize the findings for the pattern `{{args}}`.

Search Results:
!{grep -r {{args}} .}
"""
```

When you run `/grep-code It's complicated`:

1. The CLI sees `{{args}}` used both outside and inside `!{...}`.
2. Outside: The first `{{args}}` is replaced raw with `It's complicated`.
3. Inside: The second `{{args}}` is replaced with the escaped version (e.g., on Linux: `"It's complicated"`).
4. The command executed is `grep -r "It's complicated" .`.
5. The CLI prompts you to confirm this exact, secure command before execution.
6. The final prompt is sent.

##### 2. Default Argument Handling

If your `prompt` does **not** contain the special placeholder `{{args}}`, the CLI uses a default behavior for handling arguments.

If you provide arguments to the command (e.g., `/mycommand arg1`), the CLI will append the full command you typed to the end of the prompt, separated by two newlines. This allows the model to see both the original instructions and the specific arguments you just provided.

If you do **not** provide any arguments (e.g., `/mycommand`), the prompt is sent to the model exactly as it is, with nothing appended.

**Example (`changelog.toml`):**

This example shows how to create a robust command by defining a role for the model, explaining where to find the user's input, and specifying the expected format and behavior.

```toml
# In: <project>/.gemini/commands/changelog.toml
# Invoked via: /changelog 1.2.0 added "Support for default argument parsing."

description = "Adds a new entry to the project's CHANGELOG.md file."
prompt = """
# Task: Update Changelog

You are an expert maintainer of this software project. A user has invoked a command to add a new entry to the changelog.

**The user's raw command is appended below your instructions.**

Your task is to parse the `<version>`, `<change_type>`, and `<message>` from their input and use the `write_file` tool to correctly update the `CHANGELOG.md` file.

## Expected Format
The command follows this format: `/changelog <version> <type> <message>`
- `<type>` must be one of: "added", "changed", "fixed", "removed".

## Behavior
1. Read the `CHANGELOG.md` file.
2. Find the section for the specified `<version>`.
3. Add the `<message>` under the correct `<type>` heading.
4. If the version or type section doesn't exist, create it.
5. Adhere strictly to the "Keep a Changelog" format.
"""
```

When you run `/changelog 1.2.0 added "New feature"`, the final text sent to the model will be the original prompt followed by two newlines and the command you typed.

##### 3. Executing Shell Commands with `!{...}`

You can make your commands dynamic by executing shell commands directly within your `prompt` and injecting their output. This is ideal for gathering context from your local environment, like reading file content or checking the status of Git.

When a custom command attempts to execute a shell command, Gemini CLI will now prompt you for confirmation before proceeding. This is a security measure to ensure that only intended commands can be run.

**How It Works:**

1. **Inject Commands:** Use the `!{...}` syntax.
2. **Argument Substitution:** If `{{args}}` is present inside the block, it is automatically shell-escaped (see [Context-Aware Injection](#1-context-aware-injection-with-args) above).
3. **Robust Parsing:** The parser correctly handles complex shell commands that include nested braces, such as JSON payloads. **Note:** The content inside `!{...}` must have balanced braces (`{` and `}`). If you need to execute a command containing unbalanced braces, consider wrapping it in an external script file and calling the script within the `!{...}` block.
4. **Security Check and Confirmation:** The CLI performs a security check on the final, resolved command (after arguments are escaped and substituted). A dialog will appear showing the exact command(s) to be executed.
5. **Execution and Error Reporting:** The command is executed. If the command fails, the output injected into the prompt will include the error messages (stderr) followed by a status line, e.g., `[Shell command exited with code 1]`. This helps the model understand the context of the failure.

**Example (`git/commit.toml`):**

This command gets the staged git diff and uses it to ask the model to write a commit message.

````toml
# In: <project>/.gemini/commands/git/commit.toml
# Invoked via: /git:commit

description = "Generates a Git commit message based on staged changes."

# The prompt uses !{...} to execute the command and inject its output.
prompt = """
Please generate a Conventional Commit message based on the following git diff:

```diff
!{git diff --staged}
```

"""

````

When you run `/git:commit`, the CLI first executes `git diff --staged`, then replaces `!{git diff --staged}` with the output of that command before sending the final, complete prompt to the model.

##### 4. Injecting File Content with `@{...}`

You can directly embed the content of a file or a directory listing into your prompt using the `@{...}` syntax. This is useful for creating commands that operate on specific files.

**How It Works:**

- **File Injection**: `@{path/to/file.txt}` is replaced by the content of `file.txt`.
- **Multimodal Support**: If the path points to a supported image (e.g., PNG, JPEG), PDF, audio, or video file, it will be correctly encoded and injected as multimodal input. Other binary files are handled gracefully and skipped.
- **Directory Listing**: `@{path/to/dir}` is traversed and each file present within the directory and all subdirectories are inserted into the prompt. This respects `.gitignore` and `.geminiignore` if enabled.
- **Workspace-Aware**: The command searches for the path in the current directory and any other workspace directories. Absolute paths are allowed if they are within the workspace.
- **Processing Order**: File content injection with `@{...}` is processed _before_ shell commands (`!{...}`) and argument substitution (`{{args}}`).
- **Parsing**: The parser requires the content inside `@{...}` (the path) to have balanced braces (`{` and `}`).

**Example (`review.toml`):**

This command injects the content of a _fixed_ best practices file (`docs/best-practices.md`) and uses the user's arguments to provide context for the review.

```toml
# In: <project>/.gemini/commands/review.toml
# Invoked via: /review FileCommandLoader.ts

description = "Reviews the provided context using a best practice guide."
prompt = """
You are an expert code reviewer.

Your task is to review {{args}}.

Use the following best practices when providing your review:

@{docs/best-practices.md}
"""
```

When you run `/review FileCommandLoader.ts`, the `@{docs/best-practices.md}` placeholder is replaced by the content of that file, and `{{args}}` is replaced by the text you provided, before the final prompt is sent to the model.

```

**File:** docs/cli/commands.md (L350-353)

```markdown
```bash
mkdir -p ~/.gemini/commands/refactor
touch ~/.gemini/commands/refactor/pure.toml
```

```

**File:** docs/extension.md (L5-5)

```markdown
Gemini CLI extensions package prompts, MCP servers, and custom commands into a familiar and user-friendly format. With extensions, you can expand the capabilities of Gemini CLI and share those capabilities with others. They are designed to be easily installable and shareable.
```

**File:** docs/extension.md (L17-23)

```markdown
You can install an extension using `gemini extensions install` with either a GitHub URL source or `--path=some/local/path`.

Note that we create a copy of the installed extension, so you will need to run `gemini extensions update` to pull in changes from both locally-defined extensions and those on GitHub.

```

gemini extensions install <https://github.com/gemini-cli-extensions/security>

```
```

**File:** docs/extension.md (L73-79)

```markdown
The `gemini extensions link` command will create a symbolic link from the extension installation directory to the development path.

This is useful so you don't have to run `gemini extensions update` every time you make changes you'd like to test.

```

gemini extensions link path/to/directory

```
```

**File:** docs/extension.md (L83-87)

```markdown
On startup, Gemini CLI looks for extensions in `<home>/.gemini/extensions`

Extensions exist as a directory that contains a `gemini-extension.json` file. For example:

`<home>/.gemini/extensions/my-extension/gemini-extension.json`
```

**File:** docs/extension.md (L109-110)

```markdown
- `mcpServers`: A map of MCP servers to configure. The key is the name of the server, and the value is the server configuration. These servers will be loaded on startup just like MCP servers configured in a [`settings.json` file](./cli/configuration.md). If both an extension and a `settings.json` file configure an MCP server with the same name, the server defined in the `settings.json` file takes precedence.
  - Note that all MCP server configuration options are supported except for `trust`.
```

**File:** docs/extension.md (L111-111)

```markdown
- `contextFileName`: The name of the file that contains the context for the extension. This will be used to load the context from the extension directory. If this property is not used but a `GEMINI.md` file is present in your extension directory, then that file will be loaded.
```

**File:** docs/extension.md (L112-112)

```markdown
- `excludeTools`: An array of tool names to exclude from the model. You can also specify command-specific restrictions for tools that support it, like the `run_shell_command` tool. For example, `"excludeTools": ["run_shell_command(rm -rf)"]` will block the `rm -rf` command. Note that this differs from the MCP server `excludeTools` functionality, which can be listed in the MCP server config.
```

**File:** docs/extension.md (L116-118)

```markdown
### Custom commands

Extensions can provide [custom commands](./cli/commands.md#custom-commands) by placing TOML files in a `commands/` subdirectory within the extension directory. These commands follow the same format as user and project custom commands and use standard naming conventions.
```

**File:** docs/extension.md (L140-143)

```markdown
Extension commands have the lowest precedence. When a conflict occurs with user or project commands:

1. **No conflict**: Extension command uses its natural name (e.g., `/deploy`)
2. **With conflict**: Extension command is renamed with the extension prefix (e.g., `/gcp.deploy`)
```

**File:** docs/getting-started-extensions.md (L15-17)

```markdown
```bash
gemini extensions new my-first-extension mcp-server
```

```

**File:** docs/getting-started-extensions.md (L33-48)

```markdown
### `gemini-extension.json`

This is the manifest file for your extension. It tells Gemini CLI how to load and use your extension.

```json
{
  "name": "my-first-extension",
  "version": "1.0.0",
  "mcpServers": {
    "nodeServer": {
      "command": "node",
      "args": ["${extensionPath}${/}dist${/}example.js"],
      "cwd": "${extensionPath}"
    }
  }
}
```

**File:** packages/cli/src/commands/extensions.tsx (L17-31)

```typescript
export const extensionsCommand: CommandModule = {
  command: 'extensions <command>',
  describe: 'Manage Gemini CLI extensions.',
  builder: (yargs) =>
    yargs
      .command(installCommand)
      .command(uninstallCommand)
      .command(listCommand)
      .command(updateCommand)
      .command(disableCommand)
      .command(enableCommand)
      .command(linkCommand)
      .command(newCommand)
      .demandCommand(1, 'You need at least one command before continuing.')
      .version(false),
```
