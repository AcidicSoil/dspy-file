# DeepWiki Q&A with Code Context for Repository: google-gemini/gemini-cli

## Q1

Can you explain the extensions feature/functionality in full?

### Answer

# Extensions Feature in Gemini CLI

The extensions feature allows you to package and distribute custom functionality for Gemini CLI, including prompts, MCP servers, custom commands, and context files gemini-cli:5-5 . Extensions are installed to `~/.gemini/extensions/` and loaded automatically on CLI startup gemini-cli:83-83 .

## Core Components

### Extension Structure

Each extension is a directory containing a `gemini-extension.json` configuration file gemini-cli:85-87 . The configuration schema includes:

- **`name`**: Unique identifier (lowercase, dashes only) matching the directory name gemini-cli:107-107
- **`version`**: Extension version for update tracking gemini-cli:108-108
- **`mcpServers`**: MCP server configurations loaded on startup gemini-cli:109-109
- **`contextFileName`**: Custom context file(s) to load (defaults to `GEMINI.md`) gemini-cli:111-111
- **`excludeTools`**: Tool blocklist with optional command-specific restrictions gemini-cli:112-112

The `Extension` interface in code represents loaded extensions with their path, config, context files, and install metadata gemini-cli:48-53 .

### Extension Loading

Extensions are loaded via `loadExtension()` which:

1. Resolves symlinks for linked extensions gemini-cli:218-220
2. Loads and validates the configuration gemini-cli:223-226
3. Resolves environment variables in the config gemini-cli:228-228
4. Filters MCP server configs (removes `trust` property) gemini-cli:230-237
5. Locates context files gemini-cli:239-243

## Management Commands

### Installation

Extensions can be installed from GitHub URLs or local paths using `gemini extensions install` gemini-cli:17-17 . The installation process:

- Creates a copy in `~/.gemini/extensions/` gemini-cli:19-19
- Shows consent dialog with MCP server details gemini-cli:568-597
- Automatically enables the extension at user level gemini-cli:536-536

### Linking for Development

`gemini extensions link` creates a symbolic link for local development, avoiding the need to run updates after each change gemini-cli:73-79 .

### Enablement System

Extensions use a hierarchical enablement system managed by `ExtensionEnablementManager` gemini-cli:11-11 :

- **User-level**: Applies globally via `gemini extensions disable extension-name` gemini-cli:39-39
- **Workspace-level**: Applies to specific workspace via `--scope=workspace` gemini-cli:39-39
- Extensions are enabled by default across all workspaces gemini-cli:37-37

The `isEnabled()` method evaluates override rules with the most specific path taking precedence gemini-cli:50-56 .

### Updates

Extensions can be updated individually or all at once with `gemini extensions update --all` gemini-cli:53-55 . Updates pull the latest version from the source (Git or local path) gemini-cli:49-49 .

## Custom Commands

Extensions provide custom commands by placing TOML files in a `commands/` subdirectory gemini-cli:118-118 . Commands follow the directory structure for namespacing (e.g., `commands/gcs/sync.toml` becomes `/gcs:sync`) gemini-cli:129-136 .

### Conflict Resolution

Extension commands have the lowest precedence gemini-cli:140-140 :

- **No conflict**: Uses natural name (e.g., `/deploy`)
- **With conflict**: Prefixed with extension name (e.g., `/gcp.deploy`) gemini-cli:143-148

## Variable Substitution

Extension configs support special variables gemini-cli:151-152 :

- `${extensionPath}`: Extension installation directory gemini-cli:158-158
- `${workspacePath}`: Current workspace directory gemini-cli:159-159
- `${/}` or `${pathSeparator}`: Platform-specific path separator gemini-cli:160-160

These are resolved during extension loading gemini-cli:239-264 .

## CLI Integration

The `/extensions` command lists active extensions in the current session gemini-cli:64-65 , implemented via `extensionsCommand` with `list` and `update` subcommands gemini-cli:160-168 . You can also filter extensions at startup using `--extensions` flag or disable all with `-e none` gemini-cli:522-525 .

## Notes

Extensions require CLI restart to take effect gemini-cli:13-13 . The extension system integrates deeply with MCP servers (see MCP Server Integration wiki), context files, and the custom command system. Extension metadata is tracked in `.gemini-extension-install.json` files for managing updates and source information gemini-cli:46-46 .

Wiki pages you might want to explore:

- [MCP Server Integration (google-gemini/gemini-cli)](/wiki/google-gemini/gemini-cli#3.4)

### Citations

**File:** docs/extension.md (L5-5)

```markdown
Gemini CLI extensions package prompts, MCP servers, and custom commands into a familiar and user-friendly format. With extensions, you can expand the capabilities of Gemini CLI and share those capabilities with others. They are designed to be easily installable and shareable.
```

**File:** docs/extension.md (L13-13)

```markdown
Note that all of these commands will only be reflected in active CLI sessions on restart.
```

**File:** docs/extension.md (L17-17)

```markdown
You can install an extension using `gemini extensions install` with either a GitHub URL source or `--path=some/local/path`.
```

**File:** docs/extension.md (L19-19)

```markdown
Note that we create a copy of the installed extension, so you will need to run `gemini extensions update` to pull in changes from both locally-defined extensions and those on GitHub.
```

**File:** docs/extension.md (L37-37)

```markdown
Extensions are, by default, enabled across all workspaces. You can disable an extension entirely or for specific workspace.
```

**File:** docs/extension.md (L39-39)

```markdown
For example, `gemini extensions disable extension-name` will disable the extension at the user level, so it will be disabled everywhere. `gemini extensions disable extension-name --scope=workspace` will only disable the extension in the current workspace.
```

**File:** docs/extension.md (L49-49)

```markdown
For extensions installed from a local path or a git repository, you can explicitly update to the latest version (as reflected in the `gemini-extension.json` `version` field) with `gemini extensions update extension-name`.
```

**File:** docs/extension.md (L53-55)

```markdown
```

gemini extensions update --all

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

**File:** docs/extension.md (L83-83)

```markdown
On startup, Gemini CLI looks for extensions in `<home>/.gemini/extensions`
```

**File:** docs/extension.md (L85-87)

```markdown
Extensions exist as a directory that contains a `gemini-extension.json` file. For example:

`<home>/.gemini/extensions/my-extension/gemini-extension.json`
```

**File:** docs/extension.md (L107-107)

```markdown
- `name`: The name of the extension. This is used to uniquely identify the extension and for conflict resolution when extension commands have the same name as user or project commands. The name should be lowercase or numbers and use dashes instead of underscores or spaces. This is how users will refer to your extension in the CLI. Note that we expect this name to match the extension directory name.
```

**File:** docs/extension.md (L108-108)

```markdown
- `version`: The version of the extension.
```

**File:** docs/extension.md (L109-109)

```markdown
- `mcpServers`: A map of MCP servers to configure. The key is the name of the server, and the value is the server configuration. These servers will be loaded on startup just like MCP servers configured in a [`settings.json` file](./cli/configuration.md). If both an extension and a `settings.json` file configure an MCP server with the same name, the server defined in the `settings.json` file takes precedence.
```

**File:** docs/extension.md (L111-111)

```markdown
- `contextFileName`: The name of the file that contains the context for the extension. This will be used to load the context from the extension directory. If this property is not used but a `GEMINI.md` file is present in your extension directory, then that file will be loaded.
```

**File:** docs/extension.md (L112-112)

```markdown
- `excludeTools`: An array of tool names to exclude from the model. You can also specify command-specific restrictions for tools that support it, like the `run_shell_command` tool. For example, `"excludeTools": ["run_shell_command(rm -rf)"]` will block the `rm -rf` command. Note that this differs from the MCP server `excludeTools` functionality, which can be listed in the MCP server config.
```

**File:** docs/extension.md (L118-118)

```markdown
Extensions can provide [custom commands](./cli/commands.md#custom-commands) by placing TOML files in a `commands/` subdirectory within the extension directory. These commands follow the same format as user and project custom commands and use standard naming conventions.
```

**File:** docs/extension.md (L129-136)

```markdown
    └── gcs/
        └── sync.toml
```

Would provide these commands:

- `/deploy` - Shows as `[gcp] Custom command from deploy.toml` in help
- `/gcs:sync` - Shows as `[gcp] Custom command from sync.toml` in help

```

**File:** docs/extension.md (L140-140)

```markdown
Extension commands have the lowest precedence. When a conflict occurs with user or project commands:
```

**File:** docs/extension.md (L143-148)

```markdown
2. **With conflict**: Extension command is renamed with the extension prefix (e.g., `/gcp.deploy`)

For example, if both a user and the `gcp` extension define a `deploy` command:

- `/deploy` - Executes the user's deploy command
- `/gcp.deploy` - Executes the extension's deploy command (marked with `[gcp]` tag)
```

**File:** docs/extension.md (L151-152)

```markdown

Gemini CLI extensions allow variable substitution in `gemini-extension.json`. This can be useful if e.g., you need the current directory to run an MCP server using `"cwd": "${extensionPath}${/}run.ts"`.
```

**File:** docs/extension.md (L158-158)

```markdown
| `${extensionPath}`         | The fully-qualified path of the extension in the user's filesystem e.g., '/Users/username/.gemini/extensions/example-extension'. This will not unwrap symlinks. |
```

**File:** docs/extension.md (L159-159)

```markdown
| `${workspacePath}`         | The fully-qualified path of the current workspace.                                                                                                              |
```

**File:** docs/extension.md (L160-160)

```markdown

```

**File:** packages/cli/src/config/extension.ts (L46-46)

```typescript
export const INSTALL_METADATA_FILENAME = '.gemini-extension-install.json';
```

**File:** packages/cli/src/config/extension.ts (L48-53)

```typescript
export interface Extension {
  path: string;
  config: ExtensionConfig;
  contextFiles: string[];
  installMetadata?: ExtensionInstallMetadata | undefined;
}
```

**File:** packages/cli/src/config/extension.ts (L218-220)

```typescript
  if (installMetadata?.type === 'link') {
    effectiveExtensionPath = installMetadata.source;
  }
```

**File:** packages/cli/src/config/extension.ts (L223-226)

```typescript
    let config = loadExtensionConfig({
      extensionDir: effectiveExtensionPath,
      workspaceDir,
    });
```

**File:** packages/cli/src/config/extension.ts (L228-228)

```typescript
    config = resolveEnvVarsInObject(config);
```

**File:** packages/cli/src/config/extension.ts (L230-237)

```typescript
    if (config.mcpServers) {
      config.mcpServers = Object.fromEntries(
        Object.entries(config.mcpServers).map(([key, value]) => [
          key,
          filterMcpConfig(value),
        ]),
      );
    }
```

**File:** packages/cli/src/config/extension.ts (L239-243)

```typescript
    const contextFiles = getContextFileNames(config)
      .map((contextFileName) =>
        path.join(effectiveExtensionPath, contextFileName),
      )
      .filter((contextFilePath) => fs.existsSync(contextFilePath));
```

**File:** packages/cli/src/config/extension.ts (L536-536)

```typescript
    enableExtension(newExtensionConfig!.name, SettingScope.User);
```

**File:** packages/cli/src/config/extension.ts (L568-597)

```typescript
function extensionConsentString(extensionConfig: ExtensionConfig): string {
  const output: string[] = [];
  const mcpServerEntries = Object.entries(extensionConfig.mcpServers || {});
  output.push(`Installing extension "${extensionConfig.name}".`);
  output.push(
    '**Extensions may introduce unexpected behavior. Ensure you have investigated the extension source and trust the author.**',
  );

  if (mcpServerEntries.length) {
    output.push('This extension will run the following MCP servers:');
    for (const [key, mcpServer] of mcpServerEntries) {
      const isLocal = !!mcpServer.command;
      const source =
        mcpServer.httpUrl ??
        `${mcpServer.command || ''}${mcpServer.args ? ' ' + mcpServer.args.join(' ') : ''}`;
      output.push(`  * ${key} (${isLocal ? 'local' : 'remote'}): ${source}`);
    }
  }
  if (extensionConfig.contextFileName) {
    output.push(
      `This extension will append info to your gemini.md context using ${extensionConfig.contextFileName}`,
    );
  }
  if (extensionConfig.excludeTools) {
    output.push(
      `This extension will exclude the following core tools: ${extensionConfig.excludeTools}`,
    );
  }
  return output.join('\n');
}
```

**File:** packages/cli/src/config/extensions/extensionEnablement.test.ts (L11-11)

```typescript
import { ExtensionEnablementManager, Override } from './extensionEnablement.js';
```

**File:** packages/cli/src/config/extensions/extensionEnablement.test.ts (L50-56)

```typescript
    it('should enable a path based on an override rule', () => {
      manager.disable('ext-test', true, '/');
      manager.enable('ext-test', true, '/home/user/projects/');
      expect(manager.isEnabled('ext-test', '/home/user/projects/my-app')).toBe(
        true,
      );
    });
```

**File:** packages/cli/src/config/extension.test.ts (L239-264)

```typescript
    it('should hydrate variables', () => {
      createExtension({
        extensionsDir: userExtensionsDir,
        name: 'test-extension',
        version: '1.0.0',
        addContextFile: false,
        contextFileName: undefined,
        mcpServers: {
          'test-server': {
            cwd: '${extensionPath}${/}server',
          },
        },
      });

      const extensions = loadExtensions(
        new ExtensionEnablementManager(ExtensionStorage.getUserExtensionsDir()),
      );
      expect(extensions).toHaveLength(1);
      const loadedConfig = extensions[0].config;
      const expectedCwd = path.join(
        userExtensionsDir,
        'test-extension',
        'server',
      );
      expect(loadedConfig.mcpServers?.['test-server'].cwd).toBe(expectedCwd);
    });
```

**File:** docs/cli/commands.md (L64-65)

```markdown
- **`/extensions`**
  - **Description:** Lists all active extensions in the current Gemini CLI session. See [Gemini CLI Extensions](../extension.md).
```

**File:** packages/cli/src/ui/commands/extensionsCommand.ts (L160-168)

```typescript
export const extensionsCommand: SlashCommand = {
  name: 'extensions',
  description: 'Manage extensions',
  kind: CommandKind.BUILT_IN,
  subCommands: [listExtensionsCommand, updateExtensionsCommand],
  action: (context, args) =>
    // Default to list if no subcommand is provided
    listExtensionsCommand.action!(context, args),
};
```

**File:** docs/cli/configuration.md (L522-525)

```markdown
- **`--extensions <extension_name ...>`** (**`-e <extension_name ...>`**):
  - Specifies a list of extensions to use for the session. If not provided, all available extensions are used.
  - Use the special term `gemini -e none` to disable all extensions.
  - Example: `gemini -e my-extension -e my-other-extension`
```

## Q2

What are they capable of ?

### Answer

You're asking about the **capabilities of Gemini CLI extensions** - what functionality they can provide to extend the CLI. gemini-cli:5-5

## Core Capabilities

Extensions can package and distribute four main types of functionality:

### 1. MCP Server Integration

Extensions can bundle MCP (Model Context Protocol) servers to add custom tools gemini-cli:97-109 . These servers expose tools that the AI model can use during conversations gemini-cli:53-54 . For example, an extension could provide a `fetch_posts` tool that retrieves data from an API gemini-cli:139-139 .

The MCP servers defined in extensions are loaded on startup just like those in `settings.json`, with settings.json taking precedence if there's a naming conflict gemini-cli:109-109 .

### 2. Custom Commands

Extensions can provide slash commands by placing TOML files in a `commands/` subdirectory gemini-cli:117-118 . These commands create shortcuts for complex prompts gemini-cli:143-143 .

Commands follow directory structure for namespacing - for example, `commands/fs/grep-code.toml` becomes `/fs:grep-code` gemini-cli:128-136 . The commands can include template variables and shell command execution gemini-cli:153-162 .

### 3. Context Files

Extensions can provide persistent context to the AI model through `GEMINI.md` files gemini-cli:167-168 . This context is loaded automatically when the extension is active gemini-cli:195-195 .

You can specify custom context filenames via the `contextFileName` property gemini-cli:111-111 , and the CLI will load these files from the extension directory gemini-cli:190-204 .

### 4. Tool Filtering

Extensions can restrict which tools are available by using the `excludeTools` array gemini-cli:112-112 . This supports command-specific restrictions, like blocking `rm -rf` commands specifically: `"excludeTools": ["run_shell_command(rm -rf)"]` gemini-cli:112-112 .

## Distribution & Sharing

Extensions can be distributed through:

- **Git repositories** (GitHub or any public Git repo) gemini-cli:10-12
- **GitHub Releases** with platform-specific archives gemini-cli:32-36

Users install them with `gemini extensions install <repo-url>` or the simplified `gemini extensions install <org>/<repo>` format for GitHub gemini-cli:12-12 .

## Notes

Extensions are loaded from `~/.gemini/extensions/` on CLI startup gemini-cli:83-83  and require a restart to take effect gemini-cli:13-13 . The extension system integrates with the tool registry gemini-cli:72-73  and supports variable substitution for paths (`${extensionPath}`, `${workspacePath}`, etc.) gemini-cli:150-160 .

Wiki pages you might want to explore:

- [Overview (google-gemini/gemini-cli)](/wiki/google-gemini/gemini-cli#1)
- [MCP Server Integration (google-gemini/gemini-cli)](/wiki/google-gemini/gemini-cli#3.4)

### Citations

**File:** docs/extension.md (L5-5)

```markdown
Gemini CLI extensions package prompts, MCP servers, and custom commands into a familiar and user-friendly format. With extensions, you can expand the capabilities of Gemini CLI and share those capabilities with others. They are designed to be easily installable and shareable.
```

**File:** docs/extension.md (L13-13)

```markdown
Note that all of these commands will only be reflected in active CLI sessions on restart.
```

**File:** docs/extension.md (L83-83)

```markdown
On startup, Gemini CLI looks for extensions in `<home>/.gemini/extensions`
```

**File:** docs/extension.md (L97-109)

```markdown
  "mcpServers": {
    "my-server": {
      "command": "node my-server.js"
    }
  },
  "contextFileName": "GEMINI.md",
  "excludeTools": ["run_shell_command"]
}
```

- `name`: The name of the extension. This is used to uniquely identify the extension and for conflict resolution when extension commands have the same name as user or project commands. The name should be lowercase or numbers and use dashes instead of underscores or spaces. This is how users will refer to your extension in the CLI. Note that we expect this name to match the extension directory name.
- `version`: The version of the extension.
- `mcpServers`: A map of MCP servers to configure. The key is the name of the server, and the value is the server configuration. These servers will be loaded on startup just like MCP servers configured in a [`settings.json` file](./cli/configuration.md). If both an extension and a `settings.json` file configure an MCP server with the same name, the server defined in the `settings.json` file takes precedence.

```

**File:** docs/extension.md (L111-111)

```markdown
- `contextFileName`: The name of the file that contains the context for the extension. This will be used to load the context from the extension directory. If this property is not used but a `GEMINI.md` file is present in your extension directory, then that file will be loaded.
```

**File:** docs/extension.md (L112-112)

```markdown
- `excludeTools`: An array of tool names to exclude from the model. You can also specify command-specific restrictions for tools that support it, like the `run_shell_command` tool. For example, `"excludeTools": ["run_shell_command(rm -rf)"]` will block the `rm -rf` command. Note that this differs from the MCP server `excludeTools` functionality, which can be listed in the MCP server config.
```

**File:** docs/extension.md (L117-118)

```markdown

Extensions can provide [custom commands](./cli/commands.md#custom-commands) by placing TOML files in a `commands/` subdirectory within the extension directory. These commands follow the same format as user and project custom commands and use standard naming conventions.
```

**File:** docs/extension.md (L128-136)

```markdown
    ├── deploy.toml
    └── gcs/
        └── sync.toml
```

Would provide these commands:

- `/deploy` - Shows as `[gcp] Custom command from deploy.toml` in help
- `/gcs:sync` - Shows as `[gcp] Custom command from sync.toml` in help

```

**File:** docs/extension.md (L150-160)

```markdown
## Variables

Gemini CLI extensions allow variable substitution in `gemini-extension.json`. This can be useful if e.g., you need the current directory to run an MCP server using `"cwd": "${extensionPath}${/}run.ts"`.

**Supported variables:**

| variable                   | description                                                                                                                                                     |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `${extensionPath}`         | The fully-qualified path of the extension in the user's filesystem e.g., '/Users/username/.gemini/extensions/example-extension'. This will not unwrap symlinks. |
| `${workspacePath}`         | The fully-qualified path of the current workspace.                                                                                                              |
```

**File:** docs/getting-started-extensions.md (L53-54)

```markdown
- `mcpServers`: This section defines one or more Model Context Protocol (MCP) servers. MCP servers are how you can add new tools for the model to use.
  - `command`, `args`, `cwd`: These fields specify how to start your server. Notice the use of the `${extensionPath}` variable, which Gemini CLI replaces with the absolute path to your extension's installation directory. This allows your extension to work regardless of where it's installed.
```

**File:** docs/getting-started-extensions.md (L139-139)

```markdown
Now, restart your Gemini CLI session. The new `fetch_posts` tool will be available. You can test it by asking: "fetch posts".
```

**File:** docs/getting-started-extensions.md (L143-143)

```markdown
Custom commands provide a way to create shortcuts for complex prompts. Let's add a command that searches for a pattern in your code.
```

**File:** docs/getting-started-extensions.md (L153-162)

```markdown
    ```toml
    prompt = """
    Please summarize the findings for the pattern `{{args}}`.

    Search Results:
    !{grep -r {{args}} .}
    """
    ```

    This command, `/fs:grep-code`, will take an argument, run the `grep` shell command with it, and pipe the results into a prompt for summarization.
```

**File:** docs/getting-started-extensions.md (L167-168)

```markdown

You can provide persistent context to the model by adding a `GEMINI.md` file to your extension. This is useful for giving the model instructions on how to behave or information about your extension's tools. Note that you may not always need this for extensions built to expose commands and prompts.
```

**File:** docs/getting-started-extensions.md (L195-195)

```markdown
Restart the CLI again. The model will now have the context from your `GEMINI.md` file in every session where the extension is active.
```

**File:** packages/cli/src/config/extension.test.ts (L190-204)

```typescript
    it('should load context file path from the extension config', () => {
      createExtension({
        extensionsDir: userExtensionsDir,
        name: 'ext1',
        version: '1.0.0',
        addContextFile: false,
        contextFileName: 'my-context-file.md',
      });

      const extensions = loadExtensions(
        new ExtensionEnablementManager(ExtensionStorage.getUserExtensionsDir()),
      );

      expect(extensions).toHaveLength(1);
      const ext1 = extensions.find((e) => e.config.name === 'ext1');
```

**File:** docs/extension-releasing.md (L10-12)

```markdown
## Releasing through a git repository

This is the most flexible and simple option. All you need to do us create a publicly accessible git repo (such as a public github repository) and then users can install your extension using `gemini extensions install <your-repo-uri>`, or for a GitHub repository they can use the simplified `gemini extensions install <org>/<repo>` format. They can optionally depend on a specific ref (branch/tag/commit) using the `--ref=<some-ref>` argument, this defaults to the default branch.
```

**File:** docs/extension-releasing.md (L32-36)

```markdown
## Releasing through Github releases

Gemini CLI extensions can be distributed through [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases). This provides a faster and more reliable initial installation experience for users, as it avoids the need to clone the repository.

Each release includes at least one archive file, which contains the full contents of the repo at the tag that it was linked to. Releases may also include [pre-built archives](#custom-pre-built-archives) if your extension requires some build step or has platform specific binaries attached to it.
```

**File:** docs/core/tools-api.md (L72-73)

```markdown
- **Command-based Discovery:** Advanced users or project administrators can define a `tools.discoveryCommand` in `settings.json`. This command, when run by the Gemini CLI core, should output a JSON array of `FunctionDeclaration` objects. The core will then make these available as `DiscoveredTool` instances. The corresponding `tools.callCommand` would then be responsible for actually executing these custom tools.
- **MCP Server(s):** For more complex scenarios, one or more MCP servers can be set up and configured via the `mcpServers` setting in `settings.json`. The Gemini CLI core can then discover and use tools exposed by these servers. As mentioned, if you have multiple MCP servers, the tool names will be prefixed with the server name from your configuration (e.g., `serverAlias__actualToolName`).
```

## Q3

what are some good examples of mcp servers being used as extensions

### Answer

You're asking about **real-world examples of MCP servers being used in Gemini CLI extensions**.

## Example from Documentation

The primary example shown in the codebase is a **blog post fetcher extension** that demonstrates the MCP server pattern gemini-cli:11-11 . This extension includes:

### MCP Server Implementation

The extension provides a `fetch_posts` tool that retrieves data from a public API gemini-cli:77-98 . The server is configured in `gemini-extension.json` to run as a Node.js process gemini-cli:41-48 .

The tool registration uses the `@modelcontextprotocol/sdk` to define the tool's schema and implementation, fetching from `jsonplaceholder.typicode.com/posts` and returning the first 5 posts gemini-cli:77-98 .

## GitHub MCP Server Tutorial

The documentation includes a complete tutorial for setting up the **GitHub MCP server** as an extension gemini-cli:10-10 . This server provides tools for:

- Creating GitHub issues
- Commenting on pull requests
- Interacting with repositories gemini-cli:10-10

The configuration uses Docker to run the server with a GitHub Personal Access Token gemini-cli:29-48 .

## Configuration Patterns

The codebase shows several MCP server configuration patterns that extensions can use:

### Python-based Server

Extensions can run Python MCP servers with environment variable substitution for API keys and database URLs gemini-cli:232-247 .

### Node.js Server

Extensions can bundle Node.js servers with custom arguments and working directories gemini-cli:249-262 .

### Docker-based Server

Extensions can wrap MCP servers in Docker containers with volume mounts and environment variables gemini-cli:264-287 .

## Extension Template

The CLI provides an `mcp-server` template that developers can use to bootstrap new extensions with MCP servers gemini-cli:63-63 . This template includes the complete structure for building a TypeScript-based MCP server extension gemini-cli:11-27 .

## Notes

The codebase doesn't include a comprehensive catalog of third-party MCP server extensions, but it provides the infrastructure and examples for building them<cite />. The GitHub MCP server tutorial and the blog post fetcher example represent the two main patterns: integrating existing third-party MCP servers (GitHub) and building custom MCP servers from scratch (blog fetcher)<cite />. Extensions can also include prompt registration alongside tools, as shown in the example server code gemini-cli:661-688 .

Wiki pages you might want to explore:

- [MCP Server Integration (google-gemini/gemini-cli)](/wiki/google-gemini/gemini-cli#3.4)

### Citations

**File:** docs/getting-started-extensions.md (L11-27)

```markdown
The easiest way to start is by using one of the built-in templates. We'll use the `mcp-server` example as our foundation.

Run the following command to create a new directory called `my-first-extension` with the template files:

```bash
gemini extensions new my-first-extension mcp-server
```

This will create a new directory with the following structure:

```
my-first-extension/
├── example.ts
├── gemini-extension.json
├── package.json
└── tsconfig.json
```

```

**File:** docs/getting-started-extensions.md (L41-48)

```markdown
  "mcpServers": {
    "nodeServer": {
      "command": "node",
      "args": ["${extensionPath}${/}dist${/}example.js"],
      "cwd": "${extensionPath}"
    }
  }
}
```

**File:** docs/getting-started-extensions.md (L77-98)

```markdown
server.registerTool(
  'fetch_posts',
  {
    description: 'Fetches a list of posts from a public API.',
    inputSchema: z.object({}).shape,
  },
  async () => {
    const apiResponse = await fetch(
      'https://jsonplaceholder.typicode.com/posts',
    );
    const posts = await apiResponse.json();
    const response = { posts: posts.slice(0, 5) };
    return {
      content: [
        {
          type: 'text',
          text: JSON.stringify(response),
        },
      ],
    };
  },
);
```

**File:** docs/cli/tutorials.md (L10-10)

```markdown
This tutorial demonstrates how to set up a MCP server, using the [GitHub MCP server](https://github.com/github/github-mcp-server) as an example. The GitHub MCP server provides tools for interacting with GitHub repositories, such as creating issues and commenting on pull requests.
```

**File:** docs/cli/tutorials.md (L29-48)

```markdown
```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

```

**File:** docs/tools/mcp-server.md (L232-247)

```markdown
```json
{
  "mcpServers": {
    "pythonTools": {
      "command": "python",
      "args": ["-m", "my_mcp_server", "--port", "8080"],
      "cwd": "./mcp-servers/python",
      "env": {
        "DATABASE_URL": "$DB_CONNECTION_STRING",
        "API_KEY": "${EXTERNAL_API_KEY}"
      },
      "timeout": 15000
    }
  }
}
```

```

**File:** docs/tools/mcp-server.md (L249-262)

```markdown
#### Node.js MCP Server (Stdio)

```json
{
  "mcpServers": {
    "nodeServer": {
      "command": "node",
      "args": ["dist/server.js", "--verbose"],
      "cwd": "./mcp-servers/node",
      "trust": true
    }
  }
}
```

```

**File:** docs/tools/mcp-server.md (L264-287)

```markdown
#### Docker-based MCP Server

```json
{
  "mcpServers": {
    "dockerizedServer": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "API_KEY",
        "-v",
        "${PWD}:/workspace",
        "my-mcp-server:latest"
      ],
      "env": {
        "API_KEY": "$EXTERNAL_SERVICE_TOKEN"
      }
    }
  }
}
```

```

**File:** docs/tools/mcp-server.md (L661-688)

```markdown
const server = new McpServer({
  name: 'prompt-server',
  version: '1.0.0',
});

server.registerPrompt(
  'poem-writer',
  {
    title: 'Poem Writer',
    description: 'Write a nice haiku',
    argsSchema: { title: z.string(), mood: z.string().optional() },
  },
  ({ title, mood }) => ({
    messages: [
      {
        role: 'user',
        content: {
          type: 'text',
          text: `Write a haiku${mood ? ` with the mood ${mood}` : ''} called ${title}. Note that a haiku is 5 syllables followed by 7 syllables followed by 5 syllables `,
        },
      },
    ],
  }),
);

const transport = new StdioServerTransport();
await server.connect(transport);
```

```

**File:** docs/extension.md (L63-63)

```markdown
We offer several example extensions `context`, `custom-commands`, `exclude-tools` and `mcp-server`. You can view these examples [here](https://github.com/google-gemini/gemini-cli/tree/main/packages/cli/src/commands/extensions/examples).
```
