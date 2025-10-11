Project Structure:
├── index.md
├── memport.md
└── tools-api.md


index.md
```
1 | # Gemini CLI Core
2 | 
3 | Gemini CLI's core package (`packages/core`) is the backend portion of Gemini
4 | CLI, handling communication with the Gemini API, managing tools, and processing
5 | requests sent from `packages/cli`. For a general overview of Gemini CLI, see the
6 | [main documentation page](../index.md).
7 | 
8 | ## Navigating this section
9 | 
10 | - **[Core tools API](./tools-api.md):** Information on how tools are defined,
11 |   registered, and used by the core.
12 | - **[Memory Import Processor](./memport.md):** Documentation for the modular
13 |   GEMINI.md import feature using @file.md syntax.
14 | 
15 | ## Role of the core
16 | 
17 | While the `packages/cli` portion of Gemini CLI provides the user interface,
18 | `packages/core` is responsible for:
19 | 
20 | - **Gemini API interaction:** Securely communicating with the Google Gemini API,
21 |   sending user prompts, and receiving model responses.
22 | - **Prompt engineering:** Constructing effective prompts for the Gemini model,
23 |   potentially incorporating conversation history, tool definitions, and
24 |   instructional context from `GEMINI.md` files.
25 | - **Tool management & orchestration:**
26 |   - Registering available tools (e.g., file system tools, shell command
27 |     execution).
28 |   - Interpreting tool use requests from the Gemini model.
29 |   - Executing the requested tools with the provided arguments.
30 |   - Returning tool execution results to the Gemini model for further processing.
31 | - **Session and state management:** Keeping track of the conversation state,
32 |   including history and any relevant context required for coherent interactions.
33 | - **Configuration:** Managing core-specific configurations, such as API key
34 |   access, model selection, and tool settings.
35 | 
36 | ## Security considerations
37 | 
38 | The core plays a vital role in security:
39 | 
40 | - **API key management:** It handles the `GEMINI_API_KEY` and ensures it's used
41 |   securely when communicating with the Gemini API.
42 | - **Tool execution:** When tools interact with the local system (e.g.,
43 |   `run_shell_command`), the core (and its underlying tool implementations) must
44 |   do so with appropriate caution, often involving sandboxing mechanisms to
45 |   prevent unintended modifications.
46 | 
47 | ## Chat history compression
48 | 
49 | To ensure that long conversations don't exceed the token limits of the Gemini
50 | model, the core includes a chat history compression feature.
51 | 
52 | When a conversation approaches the token limit for the configured model, the
53 | core automatically compresses the conversation history before sending it to the
54 | model. This compression is designed to be lossless in terms of the information
55 | conveyed, but it reduces the overall number of tokens used.
56 | 
57 | You can find the token limits for each model in the
58 | [Google AI documentation](https://ai.google.dev/gemini-api/docs/models).
59 | 
60 | ## Model fallback
61 | 
62 | Gemini CLI includes a model fallback mechanism to ensure that you can continue
63 | to use the CLI even if the default "pro" model is rate-limited.
64 | 
65 | If you are using the default "pro" model and the CLI detects that you are being
66 | rate-limited, it automatically switches to the "flash" model for the current
67 | session. This allows you to continue working without interruption.
68 | 
69 | ## File discovery service
70 | 
71 | The file discovery service is responsible for finding files in the project that
72 | are relevant to the current context. It is used by the `@` command and other
73 | tools that need to access files.
74 | 
75 | ## Memory discovery service
76 | 
77 | The memory discovery service is responsible for finding and loading the
78 | `GEMINI.md` files that provide context to the model. It searches for these files
79 | in a hierarchical manner, starting from the current working directory and moving
80 | up to the project root and the user's home directory. It also searches in
81 | subdirectories.
82 | 
83 | This allows you to have global, project-level, and component-level context
84 | files, which are all combined to provide the model with the most relevant
85 | information.
86 | 
87 | You can use the [`/memory` command](../cli/commands.md) to `show`, `add`, and
88 | `refresh` the content of loaded `GEMINI.md` files.
89 | 
90 | ## Citations
91 | 
92 | When Gemini finds it is reciting text from a source it appends the citation to
93 | the output. It is enabled by default but can be disabled with the
94 | ui.showCitations setting.
95 | 
96 | - When proposing an edit the citations display before giving the user the option
97 |   to accept.
98 | - Citations are always shown at the end of the model’s turn.
99 | - We deduplicate citations and display them in alphabetical order.
```

memport.md
```
1 | # Memory Import Processor
2 | 
3 | The Memory Import Processor is a feature that allows you to modularize your
4 | GEMINI.md files by importing content from other files using the `@file.md`
5 | syntax.
6 | 
7 | ## Overview
8 | 
9 | This feature enables you to break down large GEMINI.md files into smaller, more
10 | manageable components that can be reused across different contexts. The import
11 | processor supports both relative and absolute paths, with built-in safety
12 | features to prevent circular imports and ensure file access security.
13 | 
14 | ## Syntax
15 | 
16 | Use the `@` symbol followed by the path to the file you want to import:
17 | 
18 | ```markdown
19 | # Main GEMINI.md file
20 | 
21 | This is the main content.
22 | 
23 | @./components/instructions.md
24 | 
25 | More content here.
26 | 
27 | @./shared/configuration.md
28 | ```
29 | 
30 | ## Supported Path Formats
31 | 
32 | ### Relative Paths
33 | 
34 | - `@./file.md` - Import from the same directory
35 | - `@../file.md` - Import from parent directory
36 | - `@./components/file.md` - Import from subdirectory
37 | 
38 | ### Absolute Paths
39 | 
40 | - `@/absolute/path/to/file.md` - Import using absolute path
41 | 
42 | ## Examples
43 | 
44 | ### Basic Import
45 | 
46 | ```markdown
47 | # My GEMINI.md
48 | 
49 | Welcome to my project!
50 | 
51 | @./get-started.md
52 | 
53 | ## Features
54 | 
55 | @./features/overview.md
56 | ```
57 | 
58 | ### Nested Imports
59 | 
60 | The imported files can themselves contain imports, creating a nested structure:
61 | 
62 | ```markdown
63 | # main.md
64 | 
65 | @./header.md @./content.md @./footer.md
66 | ```
67 | 
68 | ```markdown
69 | # header.md
70 | 
71 | # Project Header
72 | 
73 | @./shared/title.md
74 | ```
75 | 
76 | ## Safety Features
77 | 
78 | ### Circular Import Detection
79 | 
80 | The processor automatically detects and prevents circular imports:
81 | 
82 | ```markdown
83 | # file-a.md
84 | 
85 | @./file-b.md
86 | 
87 | # file-b.md
88 | 
89 | @./file-a.md <!-- This will be detected and prevented -->
90 | ```
91 | 
92 | ### File Access Security
93 | 
94 | The `validateImportPath` function ensures that imports are only allowed from
95 | specified directories, preventing access to sensitive files outside the allowed
96 | scope.
97 | 
98 | ### Maximum Import Depth
99 | 
100 | To prevent infinite recursion, there's a configurable maximum import depth
101 | (default: 5 levels).
102 | 
103 | ## Error Handling
104 | 
105 | ### Missing Files
106 | 
107 | If a referenced file doesn't exist, the import will fail gracefully with an
108 | error comment in the output.
109 | 
110 | ### File Access Errors
111 | 
112 | Permission issues or other file system errors are handled gracefully with
113 | appropriate error messages.
114 | 
115 | ## Code Region Detection
116 | 
117 | The import processor uses the `marked` library to detect code blocks and inline
118 | code spans, ensuring that `@` imports inside these regions are properly ignored.
119 | This provides robust handling of nested code blocks and complex Markdown
120 | structures.
121 | 
122 | ## Import Tree Structure
123 | 
124 | The processor returns an import tree that shows the hierarchy of imported files,
125 | similar to Claude's `/memory` feature. This helps users debug problems with
126 | their GEMINI.md files by showing which files were read and their import
127 | relationships.
128 | 
129 | Example tree structure:
130 | 
131 | ```
132 | Memory Files
133 |  L project: GEMINI.md
134 |             L a.md
135 |               L b.md
136 |                 L c.md
137 |               L d.md
138 |                 L e.md
139 |                   L f.md
140 |             L included.md
141 | ```
142 | 
143 | The tree preserves the order that files were imported and shows the complete
144 | import chain for debugging purposes.
145 | 
146 | ## Comparison to Claude Code's `/memory` (`claude.md`) Approach
147 | 
148 | Claude Code's `/memory` feature (as seen in `claude.md`) produces a flat, linear
149 | document by concatenating all included files, always marking file boundaries
150 | with clear comments and path names. It does not explicitly present the import
151 | hierarchy, but the LLM receives all file contents and paths, which is sufficient
152 | for reconstructing the hierarchy if needed.
153 | 
154 | > [!NOTE] The import tree is mainly for clarity during development and has
155 | > limited relevance to LLM consumption.
156 | 
157 | ## API Reference
158 | 
159 | ### `processImports(content, basePath, debugMode?, importState?)`
160 | 
161 | Processes import statements in GEMINI.md content.
162 | 
163 | **Parameters:**
164 | 
165 | - `content` (string): The content to process for imports
166 | - `basePath` (string): The directory path where the current file is located
167 | - `debugMode` (boolean, optional): Whether to enable debug logging (default:
168 |   false)
169 | - `importState` (ImportState, optional): State tracking for circular import
170 |   prevention
171 | 
172 | **Returns:** Promise&lt;ProcessImportsResult&gt; - Object containing processed
173 | content and import tree
174 | 
175 | ### `ProcessImportsResult`
176 | 
177 | ```typescript
178 | interface ProcessImportsResult {
179 |   content: string; // The processed content with imports resolved
180 |   importTree: MemoryFile; // Tree structure showing the import hierarchy
181 | }
182 | ```
183 | 
184 | ### `MemoryFile`
185 | 
186 | ```typescript
187 | interface MemoryFile {
188 |   path: string; // The file path
189 |   imports?: MemoryFile[]; // Direct imports, in the order they were imported
190 | }
191 | ```
192 | 
193 | ### `validateImportPath(importPath, basePath, allowedDirectories)`
194 | 
195 | Validates import paths to ensure they are safe and within allowed directories.
196 | 
197 | **Parameters:**
198 | 
199 | - `importPath` (string): The import path to validate
200 | - `basePath` (string): The base directory for resolving relative paths
201 | - `allowedDirectories` (string[]): Array of allowed directory paths
202 | 
203 | **Returns:** boolean - Whether the import path is valid
204 | 
205 | ### `findProjectRoot(startDir)`
206 | 
207 | Finds the project root by searching for a `.git` directory upwards from the
208 | given start directory. Implemented as an **async** function using non-blocking
209 | file system APIs to avoid blocking the Node.js event loop.
210 | 
211 | **Parameters:**
212 | 
213 | - `startDir` (string): The directory to start searching from
214 | 
215 | **Returns:** Promise&lt;string&gt; - The project root directory (or the start
216 | directory if no `.git` is found)
217 | 
218 | ## Best Practices
219 | 
220 | 1. **Use descriptive file names** for imported components
221 | 2. **Keep imports shallow** - avoid deeply nested import chains
222 | 3. **Document your structure** - maintain a clear hierarchy of imported files
223 | 4. **Test your imports** - ensure all referenced files exist and are accessible
224 | 5. **Use relative paths** when possible for better portability
225 | 
226 | ## Troubleshooting
227 | 
228 | ### Common Issues
229 | 
230 | 1. **Import not working**: Check that the file exists and the path is correct
231 | 2. **Circular import warnings**: Review your import structure for circular
232 |    references
233 | 3. **Permission errors**: Ensure the files are readable and within allowed
234 |    directories
235 | 4. **Path resolution issues**: Use absolute paths if relative paths aren't
236 |    resolving correctly
237 | 
238 | ### Debug Mode
239 | 
240 | Enable debug mode to see detailed logging of the import process:
241 | 
242 | ```typescript
243 | const result = await processImports(content, basePath, true);
244 | ```
```

tools-api.md
```
1 | # Gemini CLI Core: Tools API
2 | 
3 | The Gemini CLI core (`packages/core`) features a robust system for defining,
4 | registering, and executing tools. These tools extend the capabilities of the
5 | Gemini model, allowing it to interact with the local environment, fetch web
6 | content, and perform various actions beyond simple text generation.
7 | 
8 | ## Core Concepts
9 | 
10 | - **Tool (`tools.ts`):** An interface and base class (`BaseTool`) that defines
11 |   the contract for all tools. Each tool must have:
12 |   - `name`: A unique internal name (used in API calls to Gemini).
13 |   - `displayName`: A user-friendly name.
14 |   - `description`: A clear explanation of what the tool does, which is provided
15 |     to the Gemini model.
16 |   - `parameterSchema`: A JSON schema defining the parameters that the tool
17 |     accepts. This is crucial for the Gemini model to understand how to call the
18 |     tool correctly.
19 |   - `validateToolParams()`: A method to validate incoming parameters.
20 |   - `getDescription()`: A method to provide a human-readable description of what
21 |     the tool will do with specific parameters before execution.
22 |   - `shouldConfirmExecute()`: A method to determine if user confirmation is
23 |     required before execution (e.g., for potentially destructive operations).
24 |   - `execute()`: The core method that performs the tool's action and returns a
25 |     `ToolResult`.
26 | 
27 | - **`ToolResult` (`tools.ts`):** An interface defining the structure of a tool's
28 |   execution outcome:
29 |   - `llmContent`: The factual content to be included in the history sent back to
30 |     the LLM for context. This can be a simple string or a `PartListUnion` (an
31 |     array of `Part` objects and strings) for rich content.
32 |   - `returnDisplay`: A user-friendly string (often Markdown) or a special object
33 |     (like `FileDiff`) for display in the CLI.
34 | 
35 | - **Returning Rich Content:** Tools are not limited to returning simple text.
36 |   The `llmContent` can be a `PartListUnion`, which is an array that can contain
37 |   a mix of `Part` objects (for images, audio, etc.) and `string`s. This allows a
38 |   single tool execution to return multiple pieces of rich content.
39 | 
40 | - **Tool Registry (`tool-registry.ts`):** A class (`ToolRegistry`) responsible
41 |   for:
42 |   - **Registering Tools:** Holding a collection of all available built-in tools
43 |     (e.g., `ReadFileTool`, `ShellTool`).
44 |   - **Discovering Tools:** It can also discover tools dynamically:
45 |     - **Command-based Discovery:** If `tools.discoveryCommand` is configured in
46 |       settings, this command is executed. It's expected to output JSON
47 |       describing custom tools, which are then registered as `DiscoveredTool`
48 |       instances.
49 |     - **MCP-based Discovery:** If `mcp.serverCommand` is configured, the
50 |       registry can connect to a Model Context Protocol (MCP) server to list and
51 |       register tools (`DiscoveredMCPTool`).
52 |   - **Providing Schemas:** Exposing the `FunctionDeclaration` schemas of all
53 |     registered tools to the Gemini model, so it knows what tools are available
54 |     and how to use them.
55 |   - **Retrieving Tools:** Allowing the core to get a specific tool by name for
56 |     execution.
57 | 
58 | ## Built-in Tools
59 | 
60 | The core comes with a suite of pre-defined tools, typically found in
61 | `packages/core/src/tools/`. These include:
62 | 
63 | - **File System Tools:**
64 |   - `LSTool` (`ls.ts`): Lists directory contents.
65 |   - `ReadFileTool` (`read-file.ts`): Reads the content of a single file. It
66 |     takes an `absolute_path` parameter, which must be an absolute path.
67 |   - `WriteFileTool` (`write-file.ts`): Writes content to a file.
68 |   - `GrepTool` (`grep.ts`): Searches for patterns in files.
69 |   - `GlobTool` (`glob.ts`): Finds files matching glob patterns.
70 |   - `EditTool` (`edit.ts`): Performs in-place modifications to files (often
71 |     requiring confirmation).
72 |   - `ReadManyFilesTool` (`read-many-files.ts`): Reads and concatenates content
73 |     from multiple files or glob patterns (used by the `@` command in CLI).
74 | - **Execution Tools:**
75 |   - `ShellTool` (`shell.ts`): Executes arbitrary shell commands (requires
76 |     careful sandboxing and user confirmation).
77 | - **Web Tools:**
78 |   - `WebFetchTool` (`web-fetch.ts`): Fetches content from a URL.
79 |   - `WebSearchTool` (`web-search.ts`): Performs a web search.
80 | - **Memory Tools:**
81 |   - `MemoryTool` (`memoryTool.ts`): Interacts with the AI's memory.
82 | 
83 | Each of these tools extends `BaseTool` and implements the required methods for
84 | its specific functionality.
85 | 
86 | ## Tool Execution Flow
87 | 
88 | 1.  **Model Request:** The Gemini model, based on the user's prompt and the
89 |     provided tool schemas, decides to use a tool and returns a `FunctionCall`
90 |     part in its response, specifying the tool name and arguments.
91 | 2.  **Core Receives Request:** The core parses this `FunctionCall`.
92 | 3.  **Tool Retrieval:** It looks up the requested tool in the `ToolRegistry`.
93 | 4.  **Parameter Validation:** The tool's `validateToolParams()` method is
94 |     called.
95 | 5.  **Confirmation (if needed):**
96 |     - The tool's `shouldConfirmExecute()` method is called.
97 |     - If it returns details for confirmation, the core communicates this back to
98 |       the CLI, which prompts the user.
99 |     - The user's decision (e.g., proceed, cancel) is sent back to the core.
100 | 6.  **Execution:** If validated and confirmed (or if no confirmation is needed),
101 |     the core calls the tool's `execute()` method with the provided arguments and
102 |     an `AbortSignal` (for potential cancellation).
103 | 7.  **Result Processing:** The `ToolResult` from `execute()` is received by the
104 |     core.
105 | 8.  **Response to Model:** The `llmContent` from the `ToolResult` is packaged as
106 |     a `FunctionResponse` and sent back to the Gemini model so it can continue
107 |     generating a user-facing response.
108 | 9.  **Display to User:** The `returnDisplay` from the `ToolResult` is sent to
109 |     the CLI to show the user what the tool did.
110 | 
111 | ## Extending with Custom Tools
112 | 
113 | While direct programmatic registration of new tools by users isn't explicitly
114 | detailed as a primary workflow in the provided files for typical end-users, the
115 | architecture supports extension through:
116 | 
117 | - **Command-based Discovery:** Advanced users or project administrators can
118 |   define a `tools.discoveryCommand` in `settings.json`. This command, when run
119 |   by the Gemini CLI core, should output a JSON array of `FunctionDeclaration`
120 |   objects. The core will then make these available as `DiscoveredTool`
121 |   instances. The corresponding `tools.callCommand` would then be responsible for
122 |   actually executing these custom tools.
123 | - **MCP Server(s):** For more complex scenarios, one or more MCP servers can be
124 |   set up and configured via the `mcpServers` setting in `settings.json`. The
125 |   Gemini CLI core can then discover and use tools exposed by these servers. As
126 |   mentioned, if you have multiple MCP servers, the tool names will be prefixed
127 |   with the server name from your configuration (e.g.,
128 |   `serverAlias__actualToolName`).
129 | 
130 | This tool system provides a flexible and powerful way to augment the Gemini
131 | model's capabilities, making the Gemini CLI a versatile assistant for a wide
132 | range of tasks.
```
