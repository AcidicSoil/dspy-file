Project Structure:
├── authentication.md
├── checkpointing.md
├── commands.md
├── custom-commands.md
├── enterprise.md
├── gemini-ignore.md
├── gemini-md.md
├── headless.md
├── index.md
├── keyboard-shortcuts.md
├── sandbox.md
├── telemetry.md
├── themes.md
├── token-caching.md
├── trusted-folders.md
├── tutorials.md
└── uninstall.md


authentication.md
```
1 | # Authentication Setup
2 | 
3 | See: [Getting Started - Authentication Setup](../get-started/authentication.md).
```

checkpointing.md
```
1 | # Checkpointing
2 | 
3 | The Gemini CLI includes a Checkpointing feature that automatically saves a
4 | snapshot of your project's state before any file modifications are made by
5 | AI-powered tools. This allows you to safely experiment with and apply code
6 | changes, knowing you can instantly revert back to the state before the tool was
7 | run.
8 | 
9 | ## How It Works
10 | 
11 | When you approve a tool that modifies the file system (like `write_file` or
12 | `replace`), the CLI automatically creates a "checkpoint." This checkpoint
13 | includes:
14 | 
15 | 1.  **A Git Snapshot:** A commit is made in a special, shadow Git repository
16 |     located in your home directory (`~/.gemini/history/<project_hash>`). This
17 |     snapshot captures the complete state of your project files at that moment.
18 |     It does **not** interfere with your own project's Git repository.
19 | 2.  **Conversation History:** The entire conversation you've had with the agent
20 |     up to that point is saved.
21 | 3.  **The Tool Call:** The specific tool call that was about to be executed is
22 |     also stored.
23 | 
24 | If you want to undo the change or simply go back, you can use the `/restore`
25 | command. Restoring a checkpoint will:
26 | 
27 | - Revert all files in your project to the state captured in the snapshot.
28 | - Restore the conversation history in the CLI.
29 | - Re-propose the original tool call, allowing you to run it again, modify it, or
30 |   simply ignore it.
31 | 
32 | All checkpoint data, including the Git snapshot and conversation history, is
33 | stored locally on your machine. The Git snapshot is stored in the shadow
34 | repository while the conversation history and tool calls are saved in a JSON
35 | file in your project's temporary directory, typically located at
36 | `~/.gemini/tmp/<project_hash>/checkpoints`.
37 | 
38 | ## Enabling the Feature
39 | 
40 | The Checkpointing feature is disabled by default. To enable it, you can either
41 | use a command-line flag or edit your `settings.json` file.
42 | 
43 | ### Using the Command-Line Flag
44 | 
45 | You can enable checkpointing for the current session by using the
46 | `--checkpointing` flag when starting the Gemini CLI:
47 | 
48 | ```bash
49 | gemini --checkpointing
50 | ```
51 | 
52 | ### Using the `settings.json` File
53 | 
54 | To enable checkpointing by default for all sessions, you need to edit your
55 | `settings.json` file.
56 | 
57 | Add the following key to your `settings.json`:
58 | 
59 | ```json
60 | {
61 |   "general": {
62 |     "checkpointing": {
63 |       "enabled": true
64 |     }
65 |   }
66 | }
67 | ```
68 | 
69 | ## Using the `/restore` Command
70 | 
71 | Once enabled, checkpoints are created automatically. To manage them, you use the
72 | `/restore` command.
73 | 
74 | ### List Available Checkpoints
75 | 
76 | To see a list of all saved checkpoints for the current project, simply run:
77 | 
78 | ```
79 | /restore
80 | ```
81 | 
82 | The CLI will display a list of available checkpoint files. These file names are
83 | typically composed of a timestamp, the name of the file being modified, and the
84 | name of the tool that was about to be run (e.g.,
85 | `2025-06-22T10-00-00_000Z-my-file.txt-write_file`).
86 | 
87 | ### Restore a Specific Checkpoint
88 | 
89 | To restore your project to a specific checkpoint, use the checkpoint file from
90 | the list:
91 | 
92 | ```
93 | /restore <checkpoint_file>
94 | ```
95 | 
96 | For example:
97 | 
98 | ```
99 | /restore 2025-06-22T10-00-00_000Z-my-file.txt-write_file
100 | ```
101 | 
102 | After running the command, your files and conversation will be immediately
103 | restored to the state they were in when the checkpoint was created, and the
104 | original tool prompt will reappear.
```

commands.md
```
1 | # CLI Commands
2 | 
3 | Gemini CLI supports several built-in commands to help you manage your session,
4 | customize the interface, and control its behavior. These commands are prefixed
5 | with a forward slash (`/`), an at symbol (`@`), or an exclamation mark (`!`).
6 | 
7 | ## Slash commands (`/`)
8 | 
9 | Slash commands provide meta-level control over the CLI itself.
10 | 
11 | ### Built-in Commands
12 | 
13 | - **`/bug`**
14 |   - **Description:** File an issue about Gemini CLI. By default, the issue is
15 |     filed within the GitHub repository for Gemini CLI. The string you enter
16 |     after `/bug` will become the headline for the bug being filed. The default
17 |     `/bug` behavior can be modified using the `advanced.bugCommand` setting in
18 |     your `.gemini/settings.json` files.
19 | 
20 | - **`/chat`**
21 |   - **Description:** Save and resume conversation history for branching
22 |     conversation state interactively, or resuming a previous state from a later
23 |     session.
24 |   - **Sub-commands:**
25 |     - **`save`**
26 |       - **Description:** Saves the current conversation history. You must add a
27 |         `<tag>` for identifying the conversation state.
28 |       - **Usage:** `/chat save <tag>`
29 |       - **Details on Checkpoint Location:** The default locations for saved chat
30 |         checkpoints are:
31 |         - Linux/macOS: `~/.gemini/tmp/<project_hash>/`
32 |         - Windows: `C:\Users\<YourUsername>\.gemini\tmp\<project_hash>\`
33 |         - When you run `/chat list`, the CLI only scans these specific
34 |           directories to find available checkpoints.
35 |         - **Note:** These checkpoints are for manually saving and resuming
36 |           conversation states. For automatic checkpoints created before file
37 |           modifications, see the
38 |           [Checkpointing documentation](../cli/checkpointing.md).
39 |     - **`resume`**
40 |       - **Description:** Resumes a conversation from a previous save.
41 |       - **Usage:** `/chat resume <tag>`
42 |     - **`list`**
43 |       - **Description:** Lists available tags for chat state resumption.
44 |     - **`delete`**
45 |       - **Description:** Deletes a saved conversation checkpoint.
46 |       - **Usage:** `/chat delete <tag>`
47 |     - **`share`**
48 |       - **Description** Writes the current conversation to a provided Markdown
49 |         or JSON file.
50 |       - **Usage** `/chat share file.md` or `/chat share file.json`. If no
51 |         filename is provided, then the CLI will generate one.
52 | 
53 | - **`/clear`**
54 |   - **Description:** Clear the terminal screen, including the visible session
55 |     history and scrollback within the CLI. The underlying session data (for
56 |     history recall) might be preserved depending on the exact implementation,
57 |     but the visual display is cleared.
58 |   - **Keyboard shortcut:** Press **Ctrl+L** at any time to perform a clear
59 |     action.
60 | 
61 | - **`/compress`**
62 |   - **Description:** Replace the entire chat context with a summary. This saves
63 |     on tokens used for future tasks while retaining a high level summary of what
64 |     has happened.
65 | 
66 | - **`/copy`**
67 |   - **Description:** Copies the last output produced by Gemini CLI to your
68 |     clipboard, for easy sharing or reuse.
69 |   - **Note:** This command requires platform-specific clipboard tools to be
70 |     installed.
71 |     - On Linux, it requires `xclip` or `xsel`. You can typically install them
72 |       using your system's package manager.
73 |     - On macOS, it requires `pbcopy`, and on Windows, it requires `clip`. These
74 |       tools are typically pre-installed on their respective systems.
75 | 
76 | - **`/directory`** (or **`/dir`**)
77 |   - **Description:** Manage workspace directories for multi-directory support.
78 |   - **Sub-commands:**
79 |     - **`add`**:
80 |       - **Description:** Add a directory to the workspace. The path can be
81 |         absolute or relative to the current working directory. Moreover, the
82 |         reference from home directory is supported as well.
83 |       - **Usage:** `/directory add <path1>,<path2>`
84 |       - **Note:** Disabled in restrictive sandbox profiles. If you're using
85 |         that, use `--include-directories` when starting the session instead.
86 |     - **`show`**:
87 |       - **Description:** Display all directories added by `/directory add` and
88 |         `--include-directories`.
89 |       - **Usage:** `/directory show`
90 | 
91 | - **`/editor`**
92 |   - **Description:** Open a dialog for selecting supported editors.
93 | 
94 | - **`/extensions`**
95 |   - **Description:** Lists all active extensions in the current Gemini CLI
96 |     session. See [Gemini CLI Extensions](../extensions/index.md).
97 | 
98 | - **`/help`** (or **`/?`**)
99 |   - **Description:** Display help information about Gemini CLI, including
100 |     available commands and their usage.
101 | 
102 | - **`/mcp`**
103 |   - **Description:** List configured Model Context Protocol (MCP) servers, their
104 |     connection status, server details, and available tools.
105 |   - **Sub-commands:**
106 |     - **`desc`** or **`descriptions`**:
107 |       - **Description:** Show detailed descriptions for MCP servers and tools.
108 |     - **`nodesc`** or **`nodescriptions`**:
109 |       - **Description:** Hide tool descriptions, showing only the tool names.
110 |     - **`schema`**:
111 |       - **Description:** Show the full JSON schema for the tool's configured
112 |         parameters.
113 |   - **Keyboard Shortcut:** Press **Ctrl+T** at any time to toggle between
114 |     showing and hiding tool descriptions.
115 | 
116 | - **`/memory`**
117 |   - **Description:** Manage the AI's instructional context (hierarchical memory
118 |     loaded from `GEMINI.md` files).
119 |   - **Sub-commands:**
120 |     - **`add`**:
121 |       - **Description:** Adds the following text to the AI's memory. Usage:
122 |         `/memory add <text to remember>`
123 |     - **`show`**:
124 |       - **Description:** Display the full, concatenated content of the current
125 |         hierarchical memory that has been loaded from all `GEMINI.md` files.
126 |         This lets you inspect the instructional context being provided to the
127 |         Gemini model.
128 |     - **`refresh`**:
129 |       - **Description:** Reload the hierarchical instructional memory from all
130 |         `GEMINI.md` files found in the configured locations (global,
131 |         project/ancestors, and sub-directories). This command updates the model
132 |         with the latest `GEMINI.md` content.
133 |     - **`list`**:
134 |       - **Description:** Lists the paths of the GEMINI.md files in use for
135 |         hierarchical memory.
136 |     - **Note:** For more details on how `GEMINI.md` files contribute to
137 |       hierarchical memory, see the
138 |       [CLI Configuration documentation](../get-started/configuration.md).
139 | 
140 | - **`/restore`**
141 |   - **Description:** Restores the project files to the state they were in just
142 |     before a tool was executed. This is particularly useful for undoing file
143 |     edits made by a tool. If run without a tool call ID, it will list available
144 |     checkpoints to restore from.
145 |   - **Usage:** `/restore [tool_call_id]`
146 |   - **Note:** Only available if the CLI is invoked with the `--checkpointing`
147 |     option or configured via [settings](../get-started/configuration.md). See
148 |     [Checkpointing documentation](../cli/checkpointing.md) for more details.
149 | 
150 | - **`/settings`**
151 |   - **Description:** Open the settings editor to view and modify Gemini CLI
152 |     settings.
153 |   - **Details:** This command provides a user-friendly interface for changing
154 |     settings that control the behavior and appearance of Gemini CLI. It is
155 |     equivalent to manually editing the `.gemini/settings.json` file, but with
156 |     validation and guidance to prevent errors.
157 |   - **Usage:** Simply run `/settings` and the editor will open. You can then
158 |     browse or search for specific settings, view their current values, and
159 |     modify them as desired. Changes to some settings are applied immediately,
160 |     while others require a restart.
161 | 
162 | - **`/stats`**
163 |   - **Description:** Display detailed statistics for the current Gemini CLI
164 |     session, including token usage, cached token savings (when available), and
165 |     session duration. Note: Cached token information is only displayed when
166 |     cached tokens are being used, which occurs with API key authentication but
167 |     not with OAuth authentication at this time.
168 | 
169 | - [**`/theme`**](./themes.md)
170 |   - **Description:** Open a dialog that lets you change the visual theme of
171 |     Gemini CLI.
172 | 
173 | - **`/auth`**
174 |   - **Description:** Open a dialog that lets you change the authentication
175 |     method.
176 | 
177 | - **`/about`**
178 |   - **Description:** Show version info. Please share this information when
179 |     filing issues.
180 | 
181 | - [**`/tools`**](../tools/index.md)
182 |   - **Description:** Display a list of tools that are currently available within
183 |     Gemini CLI.
184 |   - **Usage:** `/tools [desc]`
185 |   - **Sub-commands:**
186 |     - **`desc`** or **`descriptions`**:
187 |       - **Description:** Show detailed descriptions of each tool, including each
188 |         tool's name with its full description as provided to the model.
189 |     - **`nodesc`** or **`nodescriptions`**:
190 |       - **Description:** Hide tool descriptions, showing only the tool names.
191 | 
192 | - **`/privacy`**
193 |   - **Description:** Display the Privacy Notice and allow users to select
194 |     whether they consent to the collection of their data for service improvement
195 |     purposes.
196 | 
197 | - **`/quit`** (or **`/exit`**)
198 |   - **Description:** Exit Gemini CLI.
199 | 
200 | - **`/vim`**
201 |   - **Description:** Toggle vim mode on or off. When vim mode is enabled, the
202 |     input area supports vim-style navigation and editing commands in both NORMAL
203 |     and INSERT modes.
204 |   - **Features:**
205 |     - **NORMAL mode:** Navigate with `h`, `j`, `k`, `l`; jump by words with `w`,
206 |       `b`, `e`; go to line start/end with `0`, `$`, `^`; go to specific lines
207 |       with `G` (or `gg` for first line)
208 |     - **INSERT mode:** Standard text input with escape to return to NORMAL mode
209 |     - **Editing commands:** Delete with `x`, change with `c`, insert with `i`,
210 |       `a`, `o`, `O`; complex operations like `dd`, `cc`, `dw`, `cw`
211 |     - **Count support:** Prefix commands with numbers (e.g., `3h`, `5w`, `10G`)
212 |     - **Repeat last command:** Use `.` to repeat the last editing operation
213 |     - **Persistent setting:** Vim mode preference is saved to
214 |       `~/.gemini/settings.json` and restored between sessions
215 |   - **Status indicator:** When enabled, shows `[NORMAL]` or `[INSERT]` in the
216 |     footer
217 | 
218 | - **`/init`**
219 |   - **Description:** To help users easily create a `GEMINI.md` file, this
220 |     command analyzes the current directory and generates a tailored context
221 |     file, making it simpler for them to provide project-specific instructions to
222 |     the Gemini agent.
223 | 
224 | ### Custom Commands
225 | 
226 | Custom commands allow you to create personalized shortcuts for your most-used
227 | prompts. For detailed instructions on how to create, manage, and use them,
228 | please see the dedicated [Custom Commands documentation](./custom-commands.md).
229 | 
230 | ## Input Prompt Shortcuts
231 | 
232 | These shortcuts apply directly to the input prompt for text manipulation.
233 | 
234 | - **Undo:**
235 |   - **Keyboard shortcut:** Press **Ctrl+z** to undo the last action in the input
236 |     prompt.
237 | 
238 | - **Redo:**
239 |   - **Keyboard shortcut:** Press **Ctrl+Shift+Z** to redo the last undone action
240 |     in the input prompt.
241 | 
242 | ## At commands (`@`)
243 | 
244 | At commands are used to include the content of files or directories as part of
245 | your prompt to Gemini. These commands include git-aware filtering.
246 | 
247 | - **`@<path_to_file_or_directory>`**
248 |   - **Description:** Inject the content of the specified file or files into your
249 |     current prompt. This is useful for asking questions about specific code,
250 |     text, or collections of files.
251 |   - **Examples:**
252 |     - `@path/to/your/file.txt Explain this text.`
253 |     - `@src/my_project/ Summarize the code in this directory.`
254 |     - `What is this file about? @README.md`
255 |   - **Details:**
256 |     - If a path to a single file is provided, the content of that file is read.
257 |     - If a path to a directory is provided, the command attempts to read the
258 |       content of files within that directory and any subdirectories.
259 |     - Spaces in paths should be escaped with a backslash (e.g.,
260 |       `@My\ Documents/file.txt`).
261 |     - The command uses the `read_many_files` tool internally. The content is
262 |       fetched and then inserted into your query before being sent to the Gemini
263 |       model.
264 |     - **Git-aware filtering:** By default, git-ignored files (like
265 |       `node_modules/`, `dist/`, `.env`, `.git/`) are excluded. This behavior can
266 |       be changed via the `context.fileFiltering` settings.
267 |     - **File types:** The command is intended for text-based files. While it
268 |       might attempt to read any file, binary files or very large files might be
269 |       skipped or truncated by the underlying `read_many_files` tool to ensure
270 |       performance and relevance. The tool indicates if files were skipped.
271 |   - **Output:** The CLI will show a tool call message indicating that
272 |     `read_many_files` was used, along with a message detailing the status and
273 |     the path(s) that were processed.
274 | 
275 | - **`@` (Lone at symbol)**
276 |   - **Description:** If you type a lone `@` symbol without a path, the query is
277 |     passed as-is to the Gemini model. This might be useful if you are
278 |     specifically talking _about_ the `@` symbol in your prompt.
279 | 
280 | ### Error handling for `@` commands
281 | 
282 | - If the path specified after `@` is not found or is invalid, an error message
283 |   will be displayed, and the query might not be sent to the Gemini model, or it
284 |   will be sent without the file content.
285 | - If the `read_many_files` tool encounters an error (e.g., permission issues),
286 |   this will also be reported.
287 | 
288 | ## Shell mode & passthrough commands (`!`)
289 | 
290 | The `!` prefix lets you interact with your system's shell directly from within
291 | Gemini CLI.
292 | 
293 | - **`!<shell_command>`**
294 |   - **Description:** Execute the given `<shell_command>` using `bash` on
295 |     Linux/macOS or `cmd.exe` on Windows. Any output or errors from the command
296 |     are displayed in the terminal.
297 |   - **Examples:**
298 |     - `!ls -la` (executes `ls -la` and returns to Gemini CLI)
299 |     - `!git status` (executes `git status` and returns to Gemini CLI)
300 | 
301 | - **`!` (Toggle shell mode)**
302 |   - **Description:** Typing `!` on its own toggles shell mode.
303 |     - **Entering shell mode:**
304 |       - When active, shell mode uses a different coloring and a "Shell Mode
305 |         Indicator".
306 |       - While in shell mode, text you type is interpreted directly as a shell
307 |         command.
308 |     - **Exiting shell mode:**
309 |       - When exited, the UI reverts to its standard appearance and normal Gemini
310 |         CLI behavior resumes.
311 | 
312 | - **Caution for all `!` usage:** Commands you execute in shell mode have the
313 |   same permissions and impact as if you ran them directly in your terminal.
314 | 
315 | - **Environment Variable:** When a command is executed via `!` or in shell mode,
316 |   the `GEMINI_CLI=1` environment variable is set in the subprocess's
317 |   environment. This allows scripts or tools to detect if they are being run from
318 |   within the Gemini CLI.
```

custom-commands.md
```
1 | # Custom Commands
2 | 
3 | Custom commands let you save and reuse your favorite or most frequently used
4 | prompts as personal shortcuts within Gemini CLI. You can create commands that
5 | are specific to a single project or commands that are available globally across
6 | all your projects, streamlining your workflow and ensuring consistency.
7 | 
8 | ## File locations and precedence
9 | 
10 | Gemini CLI discovers commands from two locations, loaded in a specific order:
11 | 
12 | 1.  **User Commands (Global):** Located in `~/.gemini/commands/`. These commands
13 |     are available in any project you are working on.
14 | 2.  **Project Commands (Local):** Located in
15 |     `<your-project-root>/.gemini/commands/`. These commands are specific to the
16 |     current project and can be checked into version control to be shared with
17 |     your team.
18 | 
19 | If a command in the project directory has the same name as a command in the user
20 | directory, the **project command will always be used.** This allows projects to
21 | override global commands with project-specific versions.
22 | 
23 | ## Naming and namespacing
24 | 
25 | The name of a command is determined by its file path relative to its `commands`
26 | directory. Subdirectories are used to create namespaced commands, with the path
27 | separator (`/` or `\`) being converted to a colon (`:`).
28 | 
29 | - A file at `~/.gemini/commands/test.toml` becomes the command `/test`.
30 | - A file at `<project>/.gemini/commands/git/commit.toml` becomes the namespaced
31 |   command `/git:commit`.
32 | 
33 | ## TOML File Format (v1)
34 | 
35 | Your command definition files must be written in the TOML format and use the
36 | `.toml` file extension.
37 | 
38 | ### Required fields
39 | 
40 | - `prompt` (String): The prompt that will be sent to the Gemini model when the
41 |   command is executed. This can be a single-line or multi-line string.
42 | 
43 | ### Optional fields
44 | 
45 | - `description` (String): A brief, one-line description of what the command
46 |   does. This text will be displayed next to your command in the `/help` menu.
47 |   **If you omit this field, a generic description will be generated from the
48 |   filename.**
49 | 
50 | ## Handling arguments
51 | 
52 | Custom commands support two powerful methods for handling arguments. The CLI
53 | automatically chooses the correct method based on the content of your command\'s
54 | `prompt`.
55 | 
56 | ### 1. Context-aware injection with `{{args}}`
57 | 
58 | If your `prompt` contains the special placeholder `{{args}}`, the CLI will
59 | replace that placeholder with the text the user typed after the command name.
60 | 
61 | The behavior of this injection depends on where it is used:
62 | 
63 | **A. Raw injection (outside Shell commands)**
64 | 
65 | When used in the main body of the prompt, the arguments are injected exactly as
66 | the user typed them.
67 | 
68 | **Example (`git/fix.toml`):**
69 | 
70 | ```toml
71 | # Invoked via: /git:fix "Button is misaligned"
72 | 
73 | description = "Generates a fix for a given issue."
74 | prompt = "Please provide a code fix for the issue described here: {{args}}."
75 | ```
76 | 
77 | The model receives:
78 | `Please provide a code fix for the issue described here: "Button is misaligned".`
79 | 
80 | **B. Using arguments in Shell commands (inside `!{...}` blocks)**
81 | 
82 | When you use `{{args}}` inside a shell injection block (`!{...}`), the arguments
83 | are automatically **shell-escaped** before replacement. This allows you to
84 | safely pass arguments to shell commands, ensuring the resulting command is
85 | syntactically correct and secure while preventing command injection
86 | vulnerabilities.
87 | 
88 | **Example (`/grep-code.toml`):**
89 | 
90 | ```toml
91 | prompt = """
92 | Please summarize the findings for the pattern `{{args}}`.
93 | 
94 | Search Results:
95 | !{grep -r {{args}} .}
96 | """
97 | ```
98 | 
99 | When you run `/grep-code It\'s complicated`:
100 | 
101 | 1. The CLI sees `{{args}}` used both outside and inside `!{...}`.
102 | 2. Outside: The first `{{args}}` is replaced raw with `It\'s complicated`.
103 | 3. Inside: The second `{{args}}` is replaced with the escaped version (e.g., on
104 |    Linux: `"It\'s complicated"`).
105 | 4. The command executed is `grep -r "It\'s complicated" .`.
106 | 5. The CLI prompts you to confirm this exact, secure command before execution.
107 | 6. The final prompt is sent.
108 | 
109 | ### 2. Default argument handling
110 | 
111 | If your `prompt` does **not** contain the special placeholder `{{args}}`, the
112 | CLI uses a default behavior for handling arguments.
113 | 
114 | If you provide arguments to the command (e.g., `/mycommand arg1`), the CLI will
115 | append the full command you typed to the end of the prompt, separated by two
116 | newlines. This allows the model to see both the original instructions and the
117 | specific arguments you just provided.
118 | 
119 | If you do **not** provide any arguments (e.g., `/mycommand`), the prompt is sent
120 | to the model exactly as it is, with nothing appended.
121 | 
122 | **Example (`changelog.toml`):**
123 | 
124 | This example shows how to create a robust command by defining a role for the
125 | model, explaining where to find the user's input, and specifying the expected
126 | format and behavior.
127 | 
128 | ```toml
129 | # In: <project>/.gemini/commands/changelog.toml
130 | # Invoked via: /changelog 1.2.0 added "Support for default argument parsing."
131 | 
132 | description = "Adds a new entry to the project\'s CHANGELOG.md file."
133 | prompt = """
134 | # Task: Update Changelog
135 | 
136 | You are an expert maintainer of this software project. A user has invoked a command to add a new entry to the changelog.
137 | 
138 | **The user\'s raw command is appended below your instructions.**
139 | 
140 | Your task is to parse the `<version>`, `<change_type>`, and `<message>` from their input and use the `write_file` tool to correctly update the `CHANGELOG.md` file.
141 | 
142 | ## Expected Format
143 | The command follows this format: `/changelog <version> <type> <message>`
144 | - `<type>` must be one of: "added", "changed", "fixed", "removed".
145 | 
146 | ## Behavior
147 | 1. Read the `CHANGELOG.md` file.
148 | 2. Find the section for the specified `<version>`.
149 | 3. Add the `<message>` under the correct `<type>` heading.
150 | 4. If the version or type section doesn\'t exist, create it.
151 | 5. Adhere strictly to the "Keep a Changelog" format.
152 | """
153 | ```
154 | 
155 | When you run `/changelog 1.2.0 added "New feature"`, the final text sent to the
156 | model will be the original prompt followed by two newlines and the command you
157 | typed.
158 | 
159 | ### 3. Executing Shell commands with `!{...}`
160 | 
161 | You can make your commands dynamic by executing shell commands directly within
162 | your `prompt` and injecting their output. This is ideal for gathering context
163 | from your local environment, like reading file content or checking the status of
164 | Git.
165 | 
166 | When a custom command attempts to execute a shell command, Gemini CLI will now
167 | prompt you for confirmation before proceeding. This is a security measure to
168 | ensure that only intended commands can be run.
169 | 
170 | **How it works:**
171 | 
172 | 1.  **Inject commands:** Use the `!{...}` syntax.
173 | 2.  **Argument substitution:** If `{{args}}` is present inside the block, it is
174 |     automatically shell-escaped (see
175 |     [Context-Aware Injection](#1-context-aware-injection-with-args) above).
176 | 3.  **Robust parsing:** The parser correctly handles complex shell commands that
177 |     include nested braces, such as JSON payloads. **Note:** The content inside
178 |     `!{...}` must have balanced braces (`{` and `}`). If you need to execute a
179 |     command containing unbalanced braces, consider wrapping it in an external
180 |     script file and calling the script within the `!{...}` block.
181 | 4.  **Security check and confirmation:** The CLI performs a security check on
182 |     the final, resolved command (after arguments are escaped and substituted). A
183 |     dialog will appear showing the exact command(s) to be executed.
184 | 5.  **Execution and error reporting:** The command is executed. If the command
185 |     fails, the output injected into the prompt will include the error messages
186 |     (stderr) followed by a status line, e.g.,
187 |     `[Shell command exited with code 1]`. This helps the model understand the
188 |     context of the failure.
189 | 
190 | **Example (`git/commit.toml`):**
191 | 
192 | This command gets the staged git diff and uses it to ask the model to write a
193 | commit message.
194 | 
195 | ````toml
196 | # In: <project>/.gemini/commands/git/commit.toml
197 | # Invoked via: /git:commit
198 | 
199 | description = "Generates a Git commit message based on staged changes."
200 | 
201 | # The prompt uses !{...} to execute the command and inject its output.
202 | prompt = """
203 | Please generate a Conventional Commit message based on the following git diff:
204 | 
205 | ```diff
206 | !{git diff --staged}
207 | ```
208 | 
209 | """
210 | 
211 | ````
212 | 
213 | When you run `/git:commit`, the CLI first executes `git diff --staged`, then
214 | replaces `!{git diff --staged}` with the output of that command before sending
215 | the final, complete prompt to the model.
216 | 
217 | ### 4. Injecting file content with `@{...}`
218 | 
219 | You can directly embed the content of a file or a directory listing into your
220 | prompt using the `@{...}` syntax. This is useful for creating commands that
221 | operate on specific files.
222 | 
223 | **How it works:**
224 | 
225 | - **File injection**: `@{path/to/file.txt}` is replaced by the content of
226 |   `file.txt`.
227 | - **Multimodal support**: If the path points to a supported image (e.g., PNG,
228 |   JPEG), PDF, audio, or video file, it will be correctly encoded and injected as
229 |   multimodal input. Other binary files are handled gracefully and skipped.
230 | - **Directory listing**: `@{path/to/dir}` is traversed and each file present
231 |   within the directory and all subdirectories is inserted into the prompt. This
232 |   respects `.gitignore` and `.geminiignore` if enabled.
233 | - **Workspace-aware**: The command searches for the path in the current
234 |   directory and any other workspace directories. Absolute paths are allowed if
235 |   they are within the workspace.
236 | - **Processing order**: File content injection with `@{...}` is processed
237 |   _before_ shell commands (`!{...}`) and argument substitution (`{{args}}`).
238 | - **Parsing**: The parser requires the content inside `@{...}` (the path) to
239 |   have balanced braces (`{` and `}`).
240 | 
241 | **Example (`review.toml`):**
242 | 
243 | This command injects the content of a _fixed_ best practices file
244 | (`docs/best-practices.md`) and uses the user\'s arguments to provide context for
245 | the review.
246 | 
247 | ```toml
248 | # In: <project>/.gemini/commands/review.toml
249 | # Invoked via: /review FileCommandLoader.ts
250 | 
251 | description = "Reviews the provided context using a best practice guide."
252 | prompt = """
253 | You are an expert code reviewer.
254 | 
255 | Your task is to review {{args}}.
256 | 
257 | Use the following best practices when providing your review:
258 | 
259 | @{docs/best-practices.md}
260 | """
261 | ```
262 | 
263 | When you run `/review FileCommandLoader.ts`, the `@{docs/best-practices.md}`
264 | placeholder is replaced by the content of that file, and `{{args}}` is replaced
265 | by the text you provided, before the final prompt is sent to the model.
266 | 
267 | ---
268 | 
269 | ## Example: A "Pure Function" refactoring command
270 | 
271 | Let's create a global command that asks the model to refactor a piece of code.
272 | 
273 | **1. Create the file and directories:**
274 | 
275 | First, ensure the user commands directory exists, then create a `refactor`
276 | subdirectory for organization and the final TOML file.
277 | 
278 | ```bash
279 | mkdir -p ~/.gemini/commands/refactor
280 | touch ~/.gemini/commands/refactor/pure.toml
281 | ```
282 | 
283 | **2. Add the content to the file:**
284 | 
285 | Open `~/.gemini/commands/refactor/pure.toml` in your editor and add the
286 | following content. We are including the optional `description` for best
287 | practice.
288 | 
289 | ```toml
290 | # In: ~/.gemini/commands/refactor/pure.toml
291 | # This command will be invoked via: /refactor:pure
292 | 
293 | description = "Asks the model to refactor the current context into a pure function."
294 | 
295 | prompt = """
296 | Please analyze the code I\'ve provided in the current context.
297 | Refactor it into a pure function.
298 | 
299 | Your response should include:
300 | 1. The refactored, pure function code block.
301 | 2. A brief explanation of the key changes you made and why they contribute to purity.
302 | """
303 | ```
304 | 
305 | **3. Run the Command:**
306 | 
307 | That's it! You can now run your command in the CLI. First, you might add a file
308 | to the context, and then invoke your command:
309 | 
310 | ```
311 | > @my-messy-function.js
312 | > /refactor:pure
313 | ```
314 | 
315 | Gemini CLI will then execute the multi-line prompt defined in your TOML file.
```

enterprise.md
```
1 | # Gemini CLI for the Enterprise
2 | 
3 | This document outlines configuration patterns and best practices for deploying
4 | and managing Gemini CLI in an enterprise environment. By leveraging system-level
5 | settings, administrators can enforce security policies, manage tool access, and
6 | ensure a consistent experience for all users.
7 | 
8 | > **A Note on Security:** The patterns described in this document are intended
9 | > to help administrators create a more controlled and secure environment for
10 | > using Gemini CLI. However, they should not be considered a foolproof security
11 | > boundary. A determined user with sufficient privileges on their local machine
12 | > may still be able to circumvent these configurations. These measures are
13 | > designed to prevent accidental misuse and enforce corporate policy in a
14 | > managed environment, not to defend against a malicious actor with local
15 | > administrative rights.
16 | 
17 | ## Centralized Configuration: The System Settings File
18 | 
19 | The most powerful tools for enterprise administration are the system-wide
20 | settings files. These files allow you to define a baseline configuration
21 | (`system-defaults.json`) and a set of overrides (`settings.json`) that apply to
22 | all users on a machine. For a complete overview of configuration options, see
23 | the [Configuration documentation](../get-started/configuration.md).
24 | 
25 | Settings are merged from four files. The precedence order for single-value
26 | settings (like `theme`) is:
27 | 
28 | 1. System Defaults (`system-defaults.json`)
29 | 2. User Settings (`~/.gemini/settings.json`)
30 | 3. Workspace Settings (`<project>/.gemini/settings.json`)
31 | 4. System Overrides (`settings.json`)
32 | 
33 | This means the System Overrides file has the final say. For settings that are
34 | arrays (`includeDirectories`) or objects (`mcpServers`), the values are merged.
35 | 
36 | **Example of Merging and Precedence:**
37 | 
38 | Here is how settings from different levels are combined.
39 | 
40 | - **System Defaults `system-defaults.json`:**
41 | 
42 |   ```json
43 |   {
44 |     "ui": {
45 |       "theme": "default-corporate-theme"
46 |     },
47 |     "context": {
48 |       "includeDirectories": ["/etc/gemini-cli/common-context"]
49 |     }
50 |   }
51 |   ```
52 | 
53 | - **User `settings.json` (`~/.gemini/settings.json`):**
54 | 
55 |   ```json
56 |   {
57 |     "ui": {
58 |       "theme": "user-preferred-dark-theme"
59 |     },
60 |     "mcpServers": {
61 |       "corp-server": {
62 |         "command": "/usr/local/bin/corp-server-dev"
63 |       },
64 |       "user-tool": {
65 |         "command": "npm start --prefix ~/tools/my-tool"
66 |       }
67 |     },
68 |     "context": {
69 |       "includeDirectories": ["~/gemini-context"]
70 |     }
71 |   }
72 |   ```
73 | 
74 | - **Workspace `settings.json` (`<project>/.gemini/settings.json`):**
75 | 
76 |   ```json
77 |   {
78 |     "ui": {
79 |       "theme": "project-specific-light-theme"
80 |     },
81 |     "mcpServers": {
82 |       "project-tool": {
83 |         "command": "npm start"
84 |       }
85 |     },
86 |     "context": {
87 |       "includeDirectories": ["./project-context"]
88 |     }
89 |   }
90 |   ```
91 | 
92 | - **System Overrides `settings.json`:**
93 |   ```json
94 |   {
95 |     "ui": {
96 |       "theme": "system-enforced-theme"
97 |     },
98 |     "mcpServers": {
99 |       "corp-server": {
100 |         "command": "/usr/local/bin/corp-server-prod"
101 |       }
102 |     },
103 |     "context": {
104 |       "includeDirectories": ["/etc/gemini-cli/global-context"]
105 |     }
106 |   }
107 |   ```
108 | 
109 | This results in the following merged configuration:
110 | 
111 | - **Final Merged Configuration:**
112 |   ```json
113 |   {
114 |     "ui": {
115 |       "theme": "system-enforced-theme"
116 |     },
117 |     "mcpServers": {
118 |       "corp-server": {
119 |         "command": "/usr/local/bin/corp-server-prod"
120 |       },
121 |       "user-tool": {
122 |         "command": "npm start --prefix ~/tools/my-tool"
123 |       },
124 |       "project-tool": {
125 |         "command": "npm start"
126 |       }
127 |     },
128 |     "context": {
129 |       "includeDirectories": [
130 |         "/etc/gemini-cli/common-context",
131 |         "~/gemini-context",
132 |         "./project-context",
133 |         "/etc/gemini-cli/global-context"
134 |       ]
135 |     }
136 |   }
137 |   ```
138 | 
139 | **Why:**
140 | 
141 | - **`theme`**: The value from the system overrides (`system-enforced-theme`) is
142 |   used, as it has the highest precedence.
143 | - **`mcpServers`**: The objects are merged. The `corp-server` definition from
144 |   the system overrides takes precedence over the user's definition. The unique
145 |   `user-tool` and `project-tool` are included.
146 | - **`includeDirectories`**: The arrays are concatenated in the order of System
147 |   Defaults, User, Workspace, and then System Overrides.
148 | 
149 | - **Location**:
150 |   - **Linux**: `/etc/gemini-cli/settings.json`
151 |   - **Windows**: `C:\ProgramData\gemini-cli\settings.json`
152 |   - **macOS**: `/Library/Application Support/GeminiCli/settings.json`
153 |   - The path can be overridden using the `GEMINI_CLI_SYSTEM_SETTINGS_PATH`
154 |     environment variable.
155 | - **Control**: This file should be managed by system administrators and
156 |   protected with appropriate file permissions to prevent unauthorized
157 |   modification by users.
158 | 
159 | By using the system settings file, you can enforce the security and
160 | configuration patterns described below.
161 | 
162 | ## Restricting Tool Access
163 | 
164 | You can significantly enhance security by controlling which tools the Gemini
165 | model can use. This is achieved through the `tools.core` and `tools.exclude`
166 | settings. For a list of available tools, see the
167 | [Tools documentation](../tools/index.md).
168 | 
169 | ### Allowlisting with `coreTools`
170 | 
171 | The most secure approach is to explicitly add the tools and commands that users
172 | are permitted to execute to an allowlist. This prevents the use of any tool not
173 | on the approved list.
174 | 
175 | **Example:** Allow only safe, read-only file operations and listing files.
176 | 
177 | ```json
178 | {
179 |   "tools": {
180 |     "core": ["ReadFileTool", "GlobTool", "ShellTool(ls)"]
181 |   }
182 | }
183 | ```
184 | 
185 | ### Blocklisting with `excludeTools`
186 | 
187 | Alternatively, you can add specific tools that are considered dangerous in your
188 | environment to a blocklist.
189 | 
190 | **Example:** Prevent the use of the shell tool for removing files.
191 | 
192 | ```json
193 | {
194 |   "tools": {
195 |     "exclude": ["ShellTool(rm -rf)"]
196 |   }
197 | }
198 | ```
199 | 
200 | **Security Note:** Blocklisting with `excludeTools` is less secure than
201 | allowlisting with `coreTools`, as it relies on blocking known-bad commands, and
202 | clever users may find ways to bypass simple string-based blocks. **Allowlisting
203 | is the recommended approach.**
204 | 
205 | ## Managing Custom Tools (MCP Servers)
206 | 
207 | If your organization uses custom tools via
208 | [Model-Context Protocol (MCP) servers](../core/tools-api.md), it is crucial to
209 | understand how server configurations are managed to apply security policies
210 | effectively.
211 | 
212 | ### How MCP Server Configurations are Merged
213 | 
214 | Gemini CLI loads `settings.json` files from three levels: System, Workspace, and
215 | User. When it comes to the `mcpServers` object, these configurations are
216 | **merged**:
217 | 
218 | 1.  **Merging:** The lists of servers from all three levels are combined into a
219 |     single list.
220 | 2.  **Precedence:** If a server with the **same name** is defined at multiple
221 |     levels (e.g., a server named `corp-api` exists in both system and user
222 |     settings), the definition from the highest-precedence level is used. The
223 |     order of precedence is: **System > Workspace > User**.
224 | 
225 | This means a user **cannot** override the definition of a server that is already
226 | defined in the system-level settings. However, they **can** add new servers with
227 | unique names.
228 | 
229 | ### Enforcing a Catalog of Tools
230 | 
231 | The security of your MCP tool ecosystem depends on a combination of defining the
232 | canonical servers and adding their names to an allowlist.
233 | 
234 | ### Restricting Tools Within an MCP Server
235 | 
236 | For even greater security, especially when dealing with third-party MCP servers,
237 | you can restrict which specific tools from a server are exposed to the model.
238 | This is done using the `includeTools` and `excludeTools` properties within a
239 | server's definition. This allows you to use a subset of tools from a server
240 | without allowing potentially dangerous ones.
241 | 
242 | Following the principle of least privilege, it is highly recommended to use
243 | `includeTools` to create an allowlist of only the necessary tools.
244 | 
245 | **Example:** Only allow the `code-search` and `get-ticket-details` tools from a
246 | third-party MCP server, even if the server offers other tools like
247 | `delete-ticket`.
248 | 
249 | ```json
250 | {
251 |   "mcp": {
252 |     "allowed": ["third-party-analyzer"]
253 |   },
254 |   "mcpServers": {
255 |     "third-party-analyzer": {
256 |       "command": "/usr/local/bin/start-3p-analyzer.sh",
257 |       "includeTools": ["code-search", "get-ticket-details"]
258 |     }
259 |   }
260 | }
261 | ```
262 | 
263 | #### More Secure Pattern: Define and Add to Allowlist in System Settings
264 | 
265 | To create a secure, centrally-managed catalog of tools, the system administrator
266 | **must** do both of the following in the system-level `settings.json` file:
267 | 
268 | 1.  **Define the full configuration** for every approved server in the
269 |     `mcpServers` object. This ensures that even if a user defines a server with
270 |     the same name, the secure system-level definition will take precedence.
271 | 2.  **Add the names** of those servers to an allowlist using the `mcp.allowed`
272 |     setting. This is a critical security step that prevents users from running
273 |     any servers that are not on this list. If this setting is omitted, the CLI
274 |     will merge and allow any server defined by the user.
275 | 
276 | **Example System `settings.json`:**
277 | 
278 | 1. Add the _names_ of all approved servers to an allowlist. This will prevent
279 |    users from adding their own servers.
280 | 
281 | 2. Provide the canonical _definition_ for each server on the allowlist.
282 | 
283 | ```json
284 | {
285 |   "mcp": {
286 |     "allowed": ["corp-data-api", "source-code-analyzer"]
287 |   },
288 |   "mcpServers": {
289 |     "corp-data-api": {
290 |       "command": "/usr/local/bin/start-corp-api.sh",
291 |       "timeout": 5000
292 |     },
293 |     "source-code-analyzer": {
294 |       "command": "/usr/local/bin/start-analyzer.sh"
295 |     }
296 |   }
297 | }
298 | ```
299 | 
300 | This pattern is more secure because it uses both definition and an allowlist.
301 | Any server a user defines will either be overridden by the system definition (if
302 | it has the same name) or blocked because its name is not in the `mcp.allowed`
303 | list.
304 | 
305 | ### Less Secure Pattern: Omitting the Allowlist
306 | 
307 | If the administrator defines the `mcpServers` object but fails to also specify
308 | the `mcp.allowed` allowlist, users may add their own servers.
309 | 
310 | **Example System `settings.json`:**
311 | 
312 | This configuration defines servers but does not enforce the allowlist. The
313 | administrator has NOT included the "mcp.allowed" setting.
314 | 
315 | ```json
316 | {
317 |   "mcpServers": {
318 |     "corp-data-api": {
319 |       "command": "/usr/local/bin/start-corp-api.sh"
320 |     }
321 |   }
322 | }
323 | ```
324 | 
325 | In this scenario, a user can add their own server in their local
326 | `settings.json`. Because there is no `mcp.allowed` list to filter the merged
327 | results, the user's server will be added to the list of available tools and
328 | allowed to run.
329 | 
330 | ## Enforcing Sandboxing for Security
331 | 
332 | To mitigate the risk of potentially harmful operations, you can enforce the use
333 | of sandboxing for all tool execution. The sandbox isolates tool execution in a
334 | containerized environment.
335 | 
336 | **Example:** Force all tool execution to happen within a Docker sandbox.
337 | 
338 | ```json
339 | {
340 |   "tools": {
341 |     "sandbox": "docker"
342 |   }
343 | }
344 | ```
345 | 
346 | You can also specify a custom, hardened Docker image for the sandbox using the
347 | `--sandbox-image` command-line argument or by building a custom
348 | `sandbox.Dockerfile` as described in the
349 | [Sandboxing documentation](./sandbox.md).
350 | 
351 | ## Controlling Network Access via Proxy
352 | 
353 | In corporate environments with strict network policies, you can configure Gemini
354 | CLI to route all outbound traffic through a corporate proxy. This can be set via
355 | an environment variable, but it can also be enforced for custom tools via the
356 | `mcpServers` configuration.
357 | 
358 | **Example (for an MCP Server):**
359 | 
360 | ```json
361 | {
362 |   "mcpServers": {
363 |     "proxied-server": {
364 |       "command": "node",
365 |       "args": ["mcp_server.js"],
366 |       "env": {
367 |         "HTTP_PROXY": "http://proxy.example.com:8080",
368 |         "HTTPS_PROXY": "http://proxy.example.com:8080"
369 |       }
370 |     }
371 |   }
372 | }
373 | ```
374 | 
375 | ## Telemetry and Auditing
376 | 
377 | For auditing and monitoring purposes, you can configure Gemini CLI to send
378 | telemetry data to a central location. This allows you to track tool usage and
379 | other events. For more information, see the
380 | [telemetry documentation](./telemetry.md).
381 | 
382 | **Example:** Enable telemetry and send it to a local OTLP collector. If
383 | `otlpEndpoint` is not specified, it defaults to `http://localhost:4317`.
384 | 
385 | ```json
386 | {
387 |   "telemetry": {
388 |     "enabled": true,
389 |     "target": "gcp",
390 |     "logPrompts": false
391 |   }
392 | }
393 | ```
394 | 
395 | **Note:** Ensure that `logPrompts` is set to `false` in an enterprise setting to
396 | avoid collecting potentially sensitive information from user prompts.
397 | 
398 | ## Authentication
399 | 
400 | You can enforce a specific authentication method for all users by setting the
401 | `enforcedAuthType` in the system-level `settings.json` file. This prevents users
402 | from choosing a different authentication method. See the
403 | [Authentication docs](./authentication.md) for more details.
404 | 
405 | **Example:** Enforce the use of Google login for all users.
406 | 
407 | ```json
408 | {
409 |   "enforcedAuthType": "oauth-personal"
410 | }
411 | ```
412 | 
413 | If a user has a different authentication method configured, they will be
414 | prompted to switch to the enforced method. In non-interactive mode, the CLI will
415 | exit with an error if the configured authentication method does not match the
416 | enforced one.
417 | 
418 | ## Putting It All Together: Example System `settings.json`
419 | 
420 | Here is an example of a system `settings.json` file that combines several of the
421 | patterns discussed above to create a secure, controlled environment for Gemini
422 | CLI.
423 | 
424 | ```json
425 | {
426 |   "tools": {
427 |     "sandbox": "docker",
428 |     "core": [
429 |       "ReadFileTool",
430 |       "GlobTool",
431 |       "ShellTool(ls)",
432 |       "ShellTool(cat)",
433 |       "ShellTool(grep)"
434 |     ]
435 |   },
436 |   "mcp": {
437 |     "allowed": ["corp-tools"]
438 |   },
439 |   "mcpServers": {
440 |     "corp-tools": {
441 |       "command": "/opt/gemini-tools/start.sh",
442 |       "timeout": 5000
443 |     }
444 |   },
445 |   "telemetry": {
446 |     "enabled": true,
447 |     "target": "gcp",
448 |     "otlpEndpoint": "https://telemetry-prod.example.com:4317",
449 |     "logPrompts": false
450 |   },
451 |   "advanced": {
452 |     "bugCommand": {
453 |       "urlTemplate": "https://servicedesk.example.com/new-ticket?title={title}&details={info}"
454 |     }
455 |   },
456 |   "privacy": {
457 |     "usageStatisticsEnabled": false
458 |   }
459 | }
460 | ```
461 | 
462 | This configuration:
463 | 
464 | - Forces all tool execution into a Docker sandbox.
465 | - Strictly uses an allowlist for a small set of safe shell commands and file
466 |   tools.
467 | - Defines and allows a single corporate MCP server for custom tools.
468 | - Enables telemetry for auditing, without logging prompt content.
469 | - Redirects the `/bug` command to an internal ticketing system.
470 | - Disables general usage statistics collection.
```

gemini-ignore.md
```
1 | # Ignoring Files
2 | 
3 | This document provides an overview of the Gemini Ignore (`.geminiignore`)
4 | feature of the Gemini CLI.
5 | 
6 | The Gemini CLI includes the ability to automatically ignore files, similar to
7 | `.gitignore` (used by Git) and `.aiexclude` (used by Gemini Code Assist). Adding
8 | paths to your `.geminiignore` file will exclude them from tools that support
9 | this feature, although they will still be visible to other services (such as
10 | Git).
11 | 
12 | ## How it works
13 | 
14 | When you add a path to your `.geminiignore` file, tools that respect this file
15 | will exclude matching files and directories from their operations. For example,
16 | when you use the [`read_many_files`](../tools/multi-file.md) command, any paths
17 | in your `.geminiignore` file will be automatically excluded.
18 | 
19 | For the most part, `.geminiignore` follows the conventions of `.gitignore`
20 | files:
21 | 
22 | - Blank lines and lines starting with `#` are ignored.
23 | - Standard glob patterns are supported (such as `*`, `?`, and `[]`).
24 | - Putting a `/` at the end will only match directories.
25 | - Putting a `/` at the beginning anchors the path relative to the
26 |   `.geminiignore` file.
27 | - `!` negates a pattern.
28 | 
29 | You can update your `.geminiignore` file at any time. To apply the changes, you
30 | must restart your Gemini CLI session.
31 | 
32 | ## How to use `.geminiignore`
33 | 
34 | To enable `.geminiignore`:
35 | 
36 | 1. Create a file named `.geminiignore` in the root of your project directory.
37 | 
38 | To add a file or directory to `.geminiignore`:
39 | 
40 | 1. Open your `.geminiignore` file.
41 | 2. Add the path or file you want to ignore, for example: `/archive/` or
42 |    `apikeys.txt`.
43 | 
44 | ### `.geminiignore` examples
45 | 
46 | You can use `.geminiignore` to ignore directories and files:
47 | 
48 | ```
49 | # Exclude your /packages/ directory and all subdirectories
50 | /packages/
51 | 
52 | # Exclude your apikeys.txt file
53 | apikeys.txt
54 | ```
55 | 
56 | You can use wildcards in your `.geminiignore` file with `*`:
57 | 
58 | ```
59 | # Exclude all .md files
60 | *.md
61 | ```
62 | 
63 | Finally, you can exclude files and directories from exclusion with `!`:
64 | 
65 | ```
66 | # Exclude all .md files except README.md
67 | *.md
68 | !README.md
69 | ```
70 | 
71 | To remove paths from your `.geminiignore` file, delete the relevant lines.
```

gemini-md.md
```
1 | # Provide Context with GEMINI.md Files
2 | 
3 | Context files, which use the default name `GEMINI.md`, are a powerful feature
4 | for providing instructional context to the Gemini model. You can use these files
5 | to give project-specific instructions, define a persona, or provide coding style
6 | guides to make the AI's responses more accurate and tailored to your needs.
7 | 
8 | Instead of repeating instructions in every prompt, you can define them once in a
9 | context file.
10 | 
11 | ## Understand the context hierarchy
12 | 
13 | The CLI uses a hierarchical system to source context. It loads various context
14 | files from several locations, concatenates the contents of all found files, and
15 | sends them to the model with every prompt. The CLI loads files in the following
16 | order:
17 | 
18 | 1.  **Global context file:**
19 |     - **Location:** `~/.gemini/GEMINI.md` (in your user home directory).
20 |     - **Scope:** Provides default instructions for all your projects.
21 | 
22 | 2.  **Project root and ancestor context files:**
23 |     - **Location:** The CLI searches for a `GEMINI.md` file in your current
24 |       working directory and then in each parent directory up to the project root
25 |       (identified by a `.git` folder).
26 |     - **Scope:** Provides context relevant to the entire project.
27 | 
28 | 3.  **Sub-directory context files:**
29 |     - **Location:** The CLI also scans for `GEMINI.md` files in subdirectories
30 |       below your current working directory. It respects rules in `.gitignore`
31 |       and `.geminiignore`.
32 |     - **Scope:** Lets you write highly specific instructions for a particular
33 |       component or module.
34 | 
35 | The CLI footer displays the number of loaded context files, which gives you a
36 | quick visual cue of the active instructional context.
37 | 
38 | ### Example `GEMINI.md` file
39 | 
40 | Here is an example of what you can include in a `GEMINI.md` file at the root of
41 | a TypeScript project:
42 | 
43 | ```markdown
44 | # Project: My TypeScript Library
45 | 
46 | ## General Instructions
47 | 
48 | - When you generate new TypeScript code, follow the existing coding style.
49 | - Ensure all new functions and classes have JSDoc comments.
50 | - Prefer functional programming paradigms where appropriate.
51 | 
52 | ## Coding Style
53 | 
54 | - Use 2 spaces for indentation.
55 | - Prefix interface names with `I` (for example, `IUserService`).
56 | - Always use strict equality (`===` and `!==`).
57 | ```
58 | 
59 | ## Manage context with the `/memory` command
60 | 
61 | You can interact with the loaded context files by using the `/memory` command.
62 | 
63 | - **`/memory show`**: Displays the full, concatenated content of the current
64 |   hierarchical memory. This lets you inspect the exact instructional context
65 |   being provided to the model.
66 | - **`/memory refresh`**: Forces a re-scan and reload of all `GEMINI.md` files
67 |   from all configured locations.
68 | - **`/memory add <text>`**: Appends your text to your global
69 |   `~/.gemini/GEMINI.md` file. This lets you add persistent memories on the fly.
70 | 
71 | ## Modularize context with imports
72 | 
73 | You can break down large `GEMINI.md` files into smaller, more manageable
74 | components by importing content from other files using the `@file.md` syntax.
75 | This feature supports both relative and absolute paths.
76 | 
77 | **Example `GEMINI.md` with imports:**
78 | 
79 | ```markdown
80 | # Main GEMINI.md file
81 | 
82 | This is the main content.
83 | 
84 | @./components/instructions.md
85 | 
86 | More content here.
87 | 
88 | @../shared/style-guide.md
89 | ```
90 | 
91 | For more details, see the [Memory Import Processor](../core/memport.md)
92 | documentation.
93 | 
94 | ## Customize the context file name
95 | 
96 | While `GEMINI.md` is the default filename, you can configure this in your
97 | `settings.json` file. To specify a different name or a list of names, use the
98 | `context.fileName` property.
99 | 
100 | **Example `settings.json`:**
101 | 
102 | ```json
103 | {
104 |   "context": {
105 |     "fileName": ["AGENTS.md", "CONTEXT.md", "GEMINI.md"]
106 |   }
107 | }
108 | ```
```

headless.md
```
1 | # Headless Mode
2 | 
3 | Headless mode allows you to run Gemini CLI programmatically from command line
4 | scripts and automation tools without any interactive UI. This is ideal for
5 | scripting, automation, CI/CD pipelines, and building AI-powered tools.
6 | 
7 | - [Headless Mode](#headless-mode)
8 |   - [Overview](#overview)
9 |   - [Basic Usage](#basic-usage)
10 |     - [Direct Prompts](#direct-prompts)
11 |     - [Stdin Input](#stdin-input)
12 |     - [Combining with File Input](#combining-with-file-input)
13 |   - [Output Formats](#output-formats)
14 |     - [Text Output (Default)](#text-output-default)
15 |     - [JSON Output](#json-output)
16 |       - [Response Schema](#response-schema)
17 |       - [Example Usage](#example-usage)
18 |     - [File Redirection](#file-redirection)
19 |   - [Configuration Options](#configuration-options)
20 |   - [Examples](#examples)
21 |     - [Code review](#code-review)
22 |     - [Generate commit messages](#generate-commit-messages)
23 |     - [API documentation](#api-documentation)
24 |     - [Batch code analysis](#batch-code-analysis)
25 |     - [Code review](#code-review-1)
26 |     - [Log analysis](#log-analysis)
27 |     - [Release notes generation](#release-notes-generation)
28 |     - [Model and tool usage tracking](#model-and-tool-usage-tracking)
29 |   - [Resources](#resources)
30 | 
31 | ## Overview
32 | 
33 | The headless mode provides a headless interface to Gemini CLI that:
34 | 
35 | - Accepts prompts via command line arguments or stdin
36 | - Returns structured output (text or JSON)
37 | - Supports file redirection and piping
38 | - Enables automation and scripting workflows
39 | - Provides consistent exit codes for error handling
40 | 
41 | ## Basic Usage
42 | 
43 | ### Direct Prompts
44 | 
45 | Use the `--prompt` (or `-p`) flag to run in headless mode:
46 | 
47 | ```bash
48 | gemini --prompt "What is machine learning?"
49 | ```
50 | 
51 | ### Stdin Input
52 | 
53 | Pipe input to Gemini CLI from your terminal:
54 | 
55 | ```bash
56 | echo "Explain this code" | gemini
57 | ```
58 | 
59 | ### Combining with File Input
60 | 
61 | Read from files and process with Gemini:
62 | 
63 | ```bash
64 | cat README.md | gemini --prompt "Summarize this documentation"
65 | ```
66 | 
67 | ## Output Formats
68 | 
69 | ### Text Output (Default)
70 | 
71 | Standard human-readable output:
72 | 
73 | ```bash
74 | gemini -p "What is the capital of France?"
75 | ```
76 | 
77 | Response format:
78 | 
79 | ```
80 | The capital of France is Paris.
81 | ```
82 | 
83 | ### JSON Output
84 | 
85 | Returns structured data including response, statistics, and metadata. This
86 | format is ideal for programmatic processing and automation scripts.
87 | 
88 | #### Response Schema
89 | 
90 | The JSON output follows this high-level structure:
91 | 
92 | ```json
93 | {
94 |   "response": "string", // The main AI-generated content answering your prompt
95 |   "stats": {
96 |     // Usage metrics and performance data
97 |     "models": {
98 |       // Per-model API and token usage statistics
99 |       "[model-name]": {
100 |         "api": {
101 |           /* request counts, errors, latency */
102 |         },
103 |         "tokens": {
104 |           /* prompt, response, cached, total counts */
105 |         }
106 |       }
107 |     },
108 |     "tools": {
109 |       // Tool execution statistics
110 |       "totalCalls": "number",
111 |       "totalSuccess": "number",
112 |       "totalFail": "number",
113 |       "totalDurationMs": "number",
114 |       "totalDecisions": {
115 |         /* accept, reject, modify, auto_accept counts */
116 |       },
117 |       "byName": {
118 |         /* per-tool detailed stats */
119 |       }
120 |     },
121 |     "files": {
122 |       // File modification statistics
123 |       "totalLinesAdded": "number",
124 |       "totalLinesRemoved": "number"
125 |     }
126 |   },
127 |   "error": {
128 |     // Present only when an error occurred
129 |     "type": "string", // Error type (e.g., "ApiError", "AuthError")
130 |     "message": "string", // Human-readable error description
131 |     "code": "number" // Optional error code
132 |   }
133 | }
134 | ```
135 | 
136 | #### Example Usage
137 | 
138 | ```bash
139 | gemini -p "What is the capital of France?" --output-format json
140 | ```
141 | 
142 | Response:
143 | 
144 | ```json
145 | {
146 |   "response": "The capital of France is Paris.",
147 |   "stats": {
148 |     "models": {
149 |       "gemini-2.5-pro": {
150 |         "api": {
151 |           "totalRequests": 2,
152 |           "totalErrors": 0,
153 |           "totalLatencyMs": 5053
154 |         },
155 |         "tokens": {
156 |           "prompt": 24939,
157 |           "candidates": 20,
158 |           "total": 25113,
159 |           "cached": 21263,
160 |           "thoughts": 154,
161 |           "tool": 0
162 |         }
163 |       },
164 |       "gemini-2.5-flash": {
165 |         "api": {
166 |           "totalRequests": 1,
167 |           "totalErrors": 0,
168 |           "totalLatencyMs": 1879
169 |         },
170 |         "tokens": {
171 |           "prompt": 8965,
172 |           "candidates": 10,
173 |           "total": 9033,
174 |           "cached": 0,
175 |           "thoughts": 30,
176 |           "tool": 28
177 |         }
178 |       }
179 |     },
180 |     "tools": {
181 |       "totalCalls": 1,
182 |       "totalSuccess": 1,
183 |       "totalFail": 0,
184 |       "totalDurationMs": 1881,
185 |       "totalDecisions": {
186 |         "accept": 0,
187 |         "reject": 0,
188 |         "modify": 0,
189 |         "auto_accept": 1
190 |       },
191 |       "byName": {
192 |         "google_web_search": {
193 |           "count": 1,
194 |           "success": 1,
195 |           "fail": 0,
196 |           "durationMs": 1881,
197 |           "decisions": {
198 |             "accept": 0,
199 |             "reject": 0,
200 |             "modify": 0,
201 |             "auto_accept": 1
202 |           }
203 |         }
204 |       }
205 |     },
206 |     "files": {
207 |       "totalLinesAdded": 0,
208 |       "totalLinesRemoved": 0
209 |     }
210 |   }
211 | }
212 | ```
213 | 
214 | ### File Redirection
215 | 
216 | Save output to files or pipe to other commands:
217 | 
218 | ```bash
219 | # Save to file
220 | gemini -p "Explain Docker" > docker-explanation.txt
221 | gemini -p "Explain Docker" --output-format json > docker-explanation.json
222 | 
223 | # Append to file
224 | gemini -p "Add more details" >> docker-explanation.txt
225 | 
226 | # Pipe to other tools
227 | gemini -p "What is Kubernetes?" --output-format json | jq '.response'
228 | gemini -p "Explain microservices" | wc -w
229 | gemini -p "List programming languages" | grep -i "python"
230 | ```
231 | 
232 | ## Configuration Options
233 | 
234 | Key command-line options for headless usage:
235 | 
236 | | Option                  | Description                        | Example                                            |
237 | | ----------------------- | ---------------------------------- | -------------------------------------------------- |
238 | | `--prompt`, `-p`        | Run in headless mode               | `gemini -p "query"`                                |
239 | | `--output-format`       | Specify output format (text, json) | `gemini -p "query" --output-format json`           |
240 | | `--model`, `-m`         | Specify the Gemini model           | `gemini -p "query" -m gemini-2.5-flash`            |
241 | | `--debug`, `-d`         | Enable debug mode                  | `gemini -p "query" --debug`                        |
242 | | `--all-files`, `-a`     | Include all files in context       | `gemini -p "query" --all-files`                    |
243 | | `--include-directories` | Include additional directories     | `gemini -p "query" --include-directories src,docs` |
244 | | `--yolo`, `-y`          | Auto-approve all actions           | `gemini -p "query" --yolo`                         |
245 | | `--approval-mode`       | Set approval mode                  | `gemini -p "query" --approval-mode auto_edit`      |
246 | 
247 | For complete details on all available configuration options, settings files, and
248 | environment variables, see the
249 | [Configuration Guide](../get-started/configuration.md).
250 | 
251 | ## Examples
252 | 
253 | #### Code review
254 | 
255 | ```bash
256 | cat src/auth.py | gemini -p "Review this authentication code for security issues" > security-review.txt
257 | ```
258 | 
259 | #### Generate commit messages
260 | 
261 | ```bash
262 | result=$(git diff --cached | gemini -p "Write a concise commit message for these changes" --output-format json)
263 | echo "$result" | jq -r '.response'
264 | ```
265 | 
266 | #### API documentation
267 | 
268 | ```bash
269 | result=$(cat api/routes.js | gemini -p "Generate OpenAPI spec for these routes" --output-format json)
270 | echo "$result" | jq -r '.response' > openapi.json
271 | ```
272 | 
273 | #### Batch code analysis
274 | 
275 | ```bash
276 | for file in src/*.py; do
277 |     echo "Analyzing $file..."
278 |     result=$(cat "$file" | gemini -p "Find potential bugs and suggest improvements" --output-format json)
279 |     echo "$result" | jq -r '.response' > "reports/$(basename "$file").analysis"
280 |     echo "Completed analysis for $(basename "$file")" >> reports/progress.log
281 | done
282 | ```
283 | 
284 | #### Code review
285 | 
286 | ```bash
287 | result=$(git diff origin/main...HEAD | gemini -p "Review these changes for bugs, security issues, and code quality" --output-format json)
288 | echo "$result" | jq -r '.response' > pr-review.json
289 | ```
290 | 
291 | #### Log analysis
292 | 
293 | ```bash
294 | grep "ERROR" /var/log/app.log | tail -20 | gemini -p "Analyze these errors and suggest root cause and fixes" > error-analysis.txt
295 | ```
296 | 
297 | #### Release notes generation
298 | 
299 | ```bash
300 | result=$(git log --oneline v1.0.0..HEAD | gemini -p "Generate release notes from these commits" --output-format json)
301 | response=$(echo "$result" | jq -r '.response')
302 | echo "$response"
303 | echo "$response" >> CHANGELOG.md
304 | ```
305 | 
306 | #### Model and tool usage tracking
307 | 
308 | ```bash
309 | result=$(gemini -p "Explain this database schema" --include-directories db --output-format json)
310 | total_tokens=$(echo "$result" | jq -r '.stats.models // {} | to_entries | map(.value.tokens.total) | add // 0')
311 | models_used=$(echo "$result" | jq -r '.stats.models // {} | keys | join(", ") | if . == "" then "none" else . end')
312 | tool_calls=$(echo "$result" | jq -r '.stats.tools.totalCalls // 0')
313 | tools_used=$(echo "$result" | jq -r '.stats.tools.byName // {} | keys | join(", ") | if . == "" then "none" else . end')
314 | echo "$(date): $total_tokens tokens, $tool_calls tool calls ($tools_used) used with models: $models_used" >> usage.log
315 | echo "$result" | jq -r '.response' > schema-docs.md
316 | echo "Recent usage trends:"
317 | tail -5 usage.log
318 | ```
319 | 
320 | ## Resources
321 | 
322 | - [CLI Configuration](../get-started/configuration.md) - Complete configuration
323 |   guide
324 | - [Authentication](../get-started/authentication.md) - Setup authentication
325 | - [Commands](./commands.md) - Interactive commands reference
326 | - [Tutorials](./tutorials.md) - Step-by-step automation guides
```

index.md
```
1 | # Gemini CLI
2 | 
3 | Within Gemini CLI, `packages/cli` is the frontend for users to send and receive
4 | prompts with the Gemini AI model and its associated tools. For a general
5 | overview of Gemini CLI, see the [main documentation page](../index.md).
6 | 
7 | ## Basic features
8 | 
9 | - **[Commands](./commands.md):** A reference for all built-in slash commands
10 |   (e.g., `/help`, `/chat`, `/tools`).
11 | - **[Custom Commands](./custom-commands.md):** Create your own commands and
12 |   shortcuts for frequently used prompts.
13 | - **[Headless Mode](./headless.md):** Use Gemini CLI programmatically for
14 |   scripting and automation.
15 | - **[Themes](./themes.md):** Customizing the CLI's appearance with different
16 |   themes.
17 | - **[Keyboard Shortcuts](./keyboard-shortcuts.md):** A reference for all
18 |   keyboard shortcuts to improve your workflow.
19 | - **[Tutorials](./tutorials.md):** Step-by-step guides for common tasks.
20 | 
21 | ## Advanced features
22 | 
23 | - **[Checkpointing](./checkpointing.md):** Automatically save and restore
24 |   snapshots of your session and files.
25 | - **[Enterprise Configuration](./enterprise.md):** Deploying and manage Gemini
26 |   CLI in an enterprise environment.
27 | - **[Sandboxing](./sandbox.md):** Isolate tool execution in a secure,
28 |   containerized environment.
29 | - **[Telemetry](./telemetry.md):** Configure observability to monitor usage and
30 |   performance.
31 | - **[Token Caching](./token-caching.md):** Optimize API costs by caching tokens.
32 | - **[Trusted Folders](./trusted-folders.md):** A security feature to control
33 |   which projects can use the full capabilities of the CLI.
34 | - **[Ignoring Files (.geminiignore)](./gemini-ignore.md):** Exclude specific
35 |   files and directories from being accessed by tools.
36 | - **[Context Files (GEMINI.md)](./gemini-md.md):** Provide persistent,
37 |   hierarchical context to the model.
38 | 
39 | ## Non-interactive mode
40 | 
41 | Gemini CLI can be run in a non-interactive mode, which is useful for scripting
42 | and automation. In this mode, you pipe input to the CLI, it executes the
43 | command, and then it exits.
44 | 
45 | The following example pipes a command to Gemini CLI from your terminal:
46 | 
47 | ```bash
48 | echo "What is fine tuning?" | gemini
49 | ```
50 | 
51 | You can also use the `--prompt` or `-p` flag:
52 | 
53 | ```bash
54 | gemini -p "What is fine tuning?"
55 | ```
56 | 
57 | For comprehensive documentation on headless usage, scripting, automation, and
58 | advanced examples, see the **[Headless Mode](./headless.md)** guide.
```

keyboard-shortcuts.md
```
1 | # Gemini CLI Keyboard Shortcuts
2 | 
3 | This document lists the available keyboard shortcuts in the Gemini CLI.
4 | 
5 | ## General
6 | 
7 | | Shortcut | Description                                                                                                           |
8 | | -------- | --------------------------------------------------------------------------------------------------------------------- |
9 | | `Esc`    | Close dialogs and suggestions.                                                                                        |
10 | | `Ctrl+C` | Cancel the ongoing request and clear the input. Press twice to exit the application.                                  |
11 | | `Ctrl+D` | Exit the application if the input is empty. Press twice to confirm.                                                   |
12 | | `Ctrl+L` | Clear the screen.                                                                                                     |
13 | | `Ctrl+O` | Toggle the display of the debug console.                                                                              |
14 | | `Ctrl+S` | Allows long responses to print fully, disabling truncation. Use your terminal's scrollback to view the entire output. |
15 | | `Ctrl+T` | Toggle the display of tool descriptions.                                                                              |
16 | | `Ctrl+Y` | Toggle auto-approval (YOLO mode) for all tool calls.                                                                  |
17 | 
18 | ## Input Prompt
19 | 
20 | | Shortcut                                           | Description                                                                                                                         |
21 | | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
22 | | `!`                                                | Toggle shell mode when the input is empty.                                                                                          |
23 | | `\` (at end of line) + `Enter`                     | Insert a newline.                                                                                                                   |
24 | | `Down Arrow`                                       | Navigate down through the input history.                                                                                            |
25 | | `Enter`                                            | Submit the current prompt.                                                                                                          |
26 | | `Meta+Delete` / `Ctrl+Delete`                      | Delete the word to the right of the cursor.                                                                                         |
27 | | `Tab`                                              | Autocomplete the current suggestion if one exists.                                                                                  |
28 | | `Up Arrow`                                         | Navigate up through the input history.                                                                                              |
29 | | `Ctrl+A` / `Home`                                  | Move the cursor to the beginning of the line.                                                                                       |
30 | | `Ctrl+B` / `Left Arrow`                            | Move the cursor one character to the left.                                                                                          |
31 | | `Ctrl+C`                                           | Clear the input prompt                                                                                                              |
32 | | `Esc` (double press)                               | Clear the input prompt.                                                                                                             |
33 | | `Ctrl+D` / `Delete`                                | Delete the character to the right of the cursor.                                                                                    |
34 | | `Ctrl+E` / `End`                                   | Move the cursor to the end of the line.                                                                                             |
35 | | `Ctrl+F` / `Right Arrow`                           | Move the cursor one character to the right.                                                                                         |
36 | | `Ctrl+H` / `Backspace`                             | Delete the character to the left of the cursor.                                                                                     |
37 | | `Ctrl+K`                                           | Delete from the cursor to the end of the line.                                                                                      |
38 | | `Ctrl+Left Arrow` / `Meta+Left Arrow` / `Meta+B`   | Move the cursor one word to the left.                                                                                               |
39 | | `Ctrl+N`                                           | Navigate down through the input history.                                                                                            |
40 | | `Ctrl+P`                                           | Navigate up through the input history.                                                                                              |
41 | | `Ctrl+Right Arrow` / `Meta+Right Arrow` / `Meta+F` | Move the cursor one word to the right.                                                                                              |
42 | | `Ctrl+U`                                           | Delete from the cursor to the beginning of the line.                                                                                |
43 | | `Ctrl+V`                                           | Paste clipboard content. If the clipboard contains an image, it will be saved and a reference to it will be inserted in the prompt. |
44 | | `Ctrl+W` / `Meta+Backspace` / `Ctrl+Backspace`     | Delete the word to the left of the cursor.                                                                                          |
45 | | `Ctrl+X` / `Meta+Enter`                            | Open the current input in an external editor.                                                                                       |
46 | 
47 | ## Suggestions
48 | 
49 | | Shortcut        | Description                            |
50 | | --------------- | -------------------------------------- |
51 | | `Down Arrow`    | Navigate down through the suggestions. |
52 | | `Tab` / `Enter` | Accept the selected suggestion.        |
53 | | `Up Arrow`      | Navigate up through the suggestions.   |
54 | 
55 | ## Radio Button Select
56 | 
57 | | Shortcut           | Description                                                                                                   |
58 | | ------------------ | ------------------------------------------------------------------------------------------------------------- |
59 | | `Down Arrow` / `j` | Move selection down.                                                                                          |
60 | | `Enter`            | Confirm selection.                                                                                            |
61 | | `Up Arrow` / `k`   | Move selection up.                                                                                            |
62 | | `1-9`              | Select an item by its number.                                                                                 |
63 | | (multi-digit)      | For items with numbers greater than 9, press the digits in quick succession to select the corresponding item. |
64 | 
65 | ## IDE Integration
66 | 
67 | | Shortcut | Description                       |
68 | | -------- | --------------------------------- |
69 | | `Ctrl+G` | See context CLI received from IDE |
```

sandbox.md
```
1 | # Sandboxing in the Gemini CLI
2 | 
3 | This document provides a guide to sandboxing in the Gemini CLI, including
4 | prerequisites, quickstart, and configuration.
5 | 
6 | ## Prerequisites
7 | 
8 | Before using sandboxing, you need to install and set up the Gemini CLI:
9 | 
10 | ```bash
11 | npm install -g @google/gemini-cli
12 | ```
13 | 
14 | To verify the installation
15 | 
16 | ```bash
17 | gemini --version
18 | ```
19 | 
20 | ## Overview of sandboxing
21 | 
22 | Sandboxing isolates potentially dangerous operations (such as shell commands or
23 | file modifications) from your host system, providing a security barrier between
24 | AI operations and your environment.
25 | 
26 | The benefits of sandboxing include:
27 | 
28 | - **Security**: Prevent accidental system damage or data loss.
29 | - **Isolation**: Limit file system access to project directory.
30 | - **Consistency**: Ensure reproducible environments across different systems.
31 | - **Safety**: Reduce risk when working with untrusted code or experimental
32 |   commands.
33 | 
34 | ## Sandboxing methods
35 | 
36 | Your ideal method of sandboxing may differ depending on your platform and your
37 | preferred container solution.
38 | 
39 | ### 1. macOS Seatbelt (macOS only)
40 | 
41 | Lightweight, built-in sandboxing using `sandbox-exec`.
42 | 
43 | **Default profile**: `permissive-open` - restricts writes outside project
44 | directory but allows most other operations.
45 | 
46 | ### 2. Container-based (Docker/Podman)
47 | 
48 | Cross-platform sandboxing with complete process isolation.
49 | 
50 | **Note**: Requires building the sandbox image locally or using a published image
51 | from your organization's registry.
52 | 
53 | ## Quickstart
54 | 
55 | ```bash
56 | # Enable sandboxing with command flag
57 | gemini -s -p "analyze the code structure"
58 | 
59 | # Use environment variable
60 | export GEMINI_SANDBOX=true
61 | gemini -p "run the test suite"
62 | 
63 | # Configure in settings.json
64 | {
65 |   "tools": {
66 |     "sandbox": "docker"
67 |   }
68 | }
69 | ```
70 | 
71 | ## Configuration
72 | 
73 | ### Enable sandboxing (in order of precedence)
74 | 
75 | 1. **Command flag**: `-s` or `--sandbox`
76 | 2. **Environment variable**: `GEMINI_SANDBOX=true|docker|podman|sandbox-exec`
77 | 3. **Settings file**: `"sandbox": true` in the `tools` object of your
78 |    `settings.json` file (e.g., `{"tools": {"sandbox": true}}`).
79 | 
80 | ### macOS Seatbelt profiles
81 | 
82 | Built-in profiles (set via `SEATBELT_PROFILE` env var):
83 | 
84 | - `permissive-open` (default): Write restrictions, network allowed
85 | - `permissive-closed`: Write restrictions, no network
86 | - `permissive-proxied`: Write restrictions, network via proxy
87 | - `restrictive-open`: Strict restrictions, network allowed
88 | - `restrictive-closed`: Maximum restrictions
89 | 
90 | ### Custom Sandbox Flags
91 | 
92 | For container-based sandboxing, you can inject custom flags into the `docker` or
93 | `podman` command using the `SANDBOX_FLAGS` environment variable. This is useful
94 | for advanced configurations, such as disabling security features for specific
95 | use cases.
96 | 
97 | **Example (Podman)**:
98 | 
99 | To disable SELinux labeling for volume mounts, you can set the following:
100 | 
101 | ```bash
102 | export SANDBOX_FLAGS="--security-opt label=disable"
103 | ```
104 | 
105 | Multiple flags can be provided as a space-separated string:
106 | 
107 | ```bash
108 | export SANDBOX_FLAGS="--flag1 --flag2=value"
109 | ```
110 | 
111 | ## Linux UID/GID handling
112 | 
113 | The sandbox automatically handles user permissions on Linux. Override these
114 | permissions with:
115 | 
116 | ```bash
117 | export SANDBOX_SET_UID_GID=true   # Force host UID/GID
118 | export SANDBOX_SET_UID_GID=false  # Disable UID/GID mapping
119 | ```
120 | 
121 | ## Troubleshooting
122 | 
123 | ### Common issues
124 | 
125 | **"Operation not permitted"**
126 | 
127 | - Operation requires access outside sandbox.
128 | - Try more permissive profile or add mount points.
129 | 
130 | **Missing commands**
131 | 
132 | - Add to custom Dockerfile.
133 | - Install via `sandbox.bashrc`.
134 | 
135 | **Network issues**
136 | 
137 | - Check sandbox profile allows network.
138 | - Verify proxy configuration.
139 | 
140 | ### Debug mode
141 | 
142 | ```bash
143 | DEBUG=1 gemini -s -p "debug command"
144 | ```
145 | 
146 | **Note:** If you have `DEBUG=true` in a project's `.env` file, it won't affect
147 | gemini-cli due to automatic exclusion. Use `.gemini/.env` files for gemini-cli
148 | specific debug settings.
149 | 
150 | ### Inspect sandbox
151 | 
152 | ```bash
153 | # Check environment
154 | gemini -s -p "run shell command: env | grep SANDBOX"
155 | 
156 | # List mounts
157 | gemini -s -p "run shell command: mount | grep workspace"
158 | ```
159 | 
160 | ## Security notes
161 | 
162 | - Sandboxing reduces but doesn't eliminate all risks.
163 | - Use the most restrictive profile that allows your work.
164 | - Container overhead is minimal after first build.
165 | - GUI applications may not work in sandboxes.
166 | 
167 | ## Related documentation
168 | 
169 | - [Configuration](../get-started/configuration.md): Full configuration options.
170 | - [Commands](./commands.md): Available commands.
171 | - [Troubleshooting](../troubleshooting.md): General troubleshooting.
```

telemetry.md
```
1 | # Observability with OpenTelemetry
2 | 
3 | Learn how to enable and setup OpenTelemetry for Gemini CLI.
4 | 
5 | - [Observability with OpenTelemetry](#observability-with-opentelemetry)
6 |   - [Key Benefits](#key-benefits)
7 |   - [OpenTelemetry Integration](#opentelemetry-integration)
8 |   - [Configuration](#configuration)
9 |   - [Google Cloud Telemetry](#google-cloud-telemetry)
10 |     - [Prerequisites](#prerequisites)
11 |     - [Direct Export (Recommended)](#direct-export-recommended)
12 |     - [Collector-Based Export (Advanced)](#collector-based-export-advanced)
13 |   - [Local Telemetry](#local-telemetry)
14 |     - [File-based Output (Recommended)](#file-based-output-recommended)
15 |     - [Collector-Based Export (Advanced)](#collector-based-export-advanced-1)
16 |   - [Logs and Metrics](#logs-and-metrics)
17 |     - [Logs](#logs)
18 |     - [Metrics](#metrics)
19 |       - [Custom](#custom)
20 |       - [GenAI Semantic Convention](#genai-semantic-convention)
21 | 
22 | ## Key Benefits
23 | 
24 | - **🔍 Usage Analytics**: Understand interaction patterns and feature adoption
25 |   across your team
26 | - **⚡ Performance Monitoring**: Track response times, token consumption, and
27 |   resource utilization
28 | - **🐛 Real-time Debugging**: Identify bottlenecks, failures, and error patterns
29 |   as they occur
30 | - **📊 Workflow Optimization**: Make informed decisions to improve
31 |   configurations and processes
32 | - **🏢 Enterprise Governance**: Monitor usage across teams, track costs, ensure
33 |   compliance, and integrate with existing monitoring infrastructure
34 | 
35 | ## OpenTelemetry Integration
36 | 
37 | Built on **[OpenTelemetry]** — the vendor-neutral, industry-standard
38 | observability framework — Gemini CLI's observability system provides:
39 | 
40 | - **Universal Compatibility**: Export to any OpenTelemetry backend (Google
41 |   Cloud, Jaeger, Prometheus, Datadog, etc.)
42 | - **Standardized Data**: Use consistent formats and collection methods across
43 |   your toolchain
44 | - **Future-Proof Integration**: Connect with existing and future observability
45 |   infrastructure
46 | - **No Vendor Lock-in**: Switch between backends without changing your
47 |   instrumentation
48 | 
49 | [OpenTelemetry]: https://opentelemetry.io/
50 | 
51 | ## Configuration
52 | 
53 | All telemetry behavior is controlled through your `.gemini/settings.json` file.
54 | These settings can be overridden by environment variables or CLI flags.
55 | 
56 | | Setting        | Environment Variable             | CLI Flag                                                 | Description                                       | Values            | Default                 |
57 | | -------------- | -------------------------------- | -------------------------------------------------------- | ------------------------------------------------- | ----------------- | ----------------------- |
58 | | `enabled`      | `GEMINI_TELEMETRY_ENABLED`       | `--telemetry` / `--no-telemetry`                         | Enable or disable telemetry                       | `true`/`false`    | `false`                 |
59 | | `target`       | `GEMINI_TELEMETRY_TARGET`        | `--telemetry-target <local\|gcp>`                        | Where to send telemetry data                      | `"gcp"`/`"local"` | `"local"`               |
60 | | `otlpEndpoint` | `GEMINI_TELEMETRY_OTLP_ENDPOINT` | `--telemetry-otlp-endpoint <URL>`                        | OTLP collector endpoint                           | URL string        | `http://localhost:4317` |
61 | | `otlpProtocol` | `GEMINI_TELEMETRY_OTLP_PROTOCOL` | `--telemetry-otlp-protocol <grpc\|http>`                 | OTLP transport protocol                           | `"grpc"`/`"http"` | `"grpc"`                |
62 | | `outfile`      | `GEMINI_TELEMETRY_OUTFILE`       | `--telemetry-outfile <path>`                             | Save telemetry to file (overrides `otlpEndpoint`) | file path         | -                       |
63 | | `logPrompts`   | `GEMINI_TELEMETRY_LOG_PROMPTS`   | `--telemetry-log-prompts` / `--no-telemetry-log-prompts` | Include prompts in telemetry logs                 | `true`/`false`    | `true`                  |
64 | | `useCollector` | `GEMINI_TELEMETRY_USE_COLLECTOR` | -                                                        | Use external OTLP collector (advanced)            | `true`/`false`    | `false`                 |
65 | 
66 | **Note on boolean environment variables:** For the boolean settings (`enabled`,
67 | `logPrompts`, `useCollector`), setting the corresponding environment variable to
68 | `true` or `1` will enable the feature. Any other value will disable it.
69 | 
70 | For detailed information about all configuration options, see the
71 | [Configuration Guide](../get-started/configuration.md).
72 | 
73 | ## Google Cloud Telemetry
74 | 
75 | ### Prerequisites
76 | 
77 | Before using either method below, complete these steps:
78 | 
79 | 1. Set your Google Cloud project ID:
80 |    - For telemetry in a separate project from inference:
81 |      ```bash
82 |      export OTLP_GOOGLE_CLOUD_PROJECT="your-telemetry-project-id"
83 |      ```
84 |    - For telemetry in the same project as inference:
85 |      ```bash
86 |      export GOOGLE_CLOUD_PROJECT="your-project-id"
87 |      ```
88 | 
89 | 2. Authenticate with Google Cloud:
90 |    - If using a user account:
91 |      ```bash
92 |      gcloud auth application-default login
93 |      ```
94 |    - If using a service account:
95 |      ```bash
96 |      export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/service-account.json"
97 |      ```
98 | 3. Make sure your account or service account has these IAM roles:
99 |    - Cloud Trace Agent
100 |    - Monitoring Metric Writer
101 |    - Logs Writer
102 | 
103 | 4. Enable the required Google Cloud APIs (if not already enabled):
104 |    ```bash
105 |    gcloud services enable \
106 |      cloudtrace.googleapis.com \
107 |      monitoring.googleapis.com \
108 |      logging.googleapis.com \
109 |      --project="$OTLP_GOOGLE_CLOUD_PROJECT"
110 |    ```
111 | 
112 | ### Direct Export (Recommended)
113 | 
114 | Sends telemetry directly to Google Cloud services. No collector needed.
115 | 
116 | 1. Enable telemetry in your `.gemini/settings.json`:
117 |    ```json
118 |    {
119 |      "telemetry": {
120 |        "enabled": true,
121 |        "target": "gcp"
122 |      }
123 |    }
124 |    ```
125 | 2. Run Gemini CLI and send prompts.
126 | 3. View logs and metrics:
127 |    - Open the Google Cloud Console in your browser after sending prompts:
128 |      - Logs: https://console.cloud.google.com/logs/
129 |      - Metrics: https://console.cloud.google.com/monitoring/metrics-explorer
130 |      - Traces: https://console.cloud.google.com/traces/list
131 | 
132 | ### Collector-Based Export (Advanced)
133 | 
134 | For custom processing, filtering, or routing, use an OpenTelemetry collector to
135 | forward data to Google Cloud.
136 | 
137 | 1. Configure your `.gemini/settings.json`:
138 |    ```json
139 |    {
140 |      "telemetry": {
141 |        "enabled": true,
142 |        "target": "gcp",
143 |        "useCollector": true
144 |      }
145 |    }
146 |    ```
147 | 2. Run the automation script:
148 |    ```bash
149 |    npm run telemetry -- --target=gcp
150 |    ```
151 |    This will:
152 |    - Start a local OTEL collector that forwards to Google Cloud
153 |    - Configure your workspace
154 |    - Provide links to view traces, metrics, and logs in Google Cloud Console
155 |    - Save collector logs to `~/.gemini/tmp/<projectHash>/otel/collector-gcp.log`
156 |    - Stop collector on exit (e.g. `Ctrl+C`)
157 | 3. Run Gemini CLI and send prompts.
158 | 4. View logs and metrics:
159 |    - Open the Google Cloud Console in your browser after sending prompts:
160 |      - Logs: https://console.cloud.google.com/logs/
161 |      - Metrics: https://console.cloud.google.com/monitoring/metrics-explorer
162 |      - Traces: https://console.cloud.google.com/traces/list
163 |    - Open `~/.gemini/tmp/<projectHash>/otel/collector-gcp.log` to view local
164 |      collector logs.
165 | 
166 | ## Local Telemetry
167 | 
168 | For local development and debugging, you can capture telemetry data locally:
169 | 
170 | ### File-based Output (Recommended)
171 | 
172 | 1. Enable telemetry in your `.gemini/settings.json`:
173 |    ```json
174 |    {
175 |      "telemetry": {
176 |        "enabled": true,
177 |        "target": "local",
178 |        "otlpEndpoint": "",
179 |        "outfile": ".gemini/telemetry.log"
180 |      }
181 |    }
182 |    ```
183 | 2. Run Gemini CLI and send prompts.
184 | 3. View logs and metrics in the specified file (e.g., `.gemini/telemetry.log`).
185 | 
186 | ### Collector-Based Export (Advanced)
187 | 
188 | 1. Run the automation script:
189 |    ```bash
190 |    npm run telemetry -- --target=local
191 |    ```
192 |    This will:
193 |    - Download and start Jaeger and OTEL collector
194 |    - Configure your workspace for local telemetry
195 |    - Provide a Jaeger UI at http://localhost:16686
196 |    - Save logs/metrics to `~/.gemini/tmp/<projectHash>/otel/collector.log`
197 |    - Stop collector on exit (e.g. `Ctrl+C`)
198 | 2. Run Gemini CLI and send prompts.
199 | 3. View traces at http://localhost:16686 and logs/metrics in the collector log
200 |    file.
201 | 
202 | ## Logs and Metrics
203 | 
204 | The following section describes the structure of logs and metrics generated for
205 | Gemini CLI.
206 | 
207 | The `session.id`, `installation.id`, and `user.email` are included as common
208 | attributes on all logs and metrics.
209 | 
210 | ### Logs
211 | 
212 | Logs are timestamped records of specific events. The following events are logged
213 | for Gemini CLI:
214 | 
215 | - `gemini_cli.config`: This event occurs once at startup with the CLI's
216 |   configuration.
217 |   - **Attributes**:
218 |     - `model` (string)
219 |     - `embedding_model` (string)
220 |     - `sandbox_enabled` (boolean)
221 |     - `core_tools_enabled` (string)
222 |     - `approval_mode` (string)
223 |     - `api_key_enabled` (boolean)
224 |     - `vertex_ai_enabled` (boolean)
225 |     - `code_assist_enabled` (boolean)
226 |     - `log_prompts_enabled` (boolean)
227 |     - `file_filtering_respect_git_ignore` (boolean)
228 |     - `debug_mode` (boolean)
229 |     - `mcp_servers` (string)
230 |     - `output_format` (string: "text" or "json")
231 | 
232 | - `gemini_cli.user_prompt`: This event occurs when a user submits a prompt.
233 |   - **Attributes**:
234 |     - `prompt_length` (int)
235 |     - `prompt_id` (string)
236 |     - `prompt` (string, this attribute is excluded if `log_prompts_enabled` is
237 |       configured to be `false`)
238 |     - `auth_type` (string)
239 | 
240 | - `gemini_cli.tool_call`: This event occurs for each function call.
241 |   - **Attributes**:
242 |     - `function_name`
243 |     - `function_args`
244 |     - `duration_ms`
245 |     - `success` (boolean)
246 |     - `decision` (string: "accept", "reject", "auto_accept", or "modify", if
247 |       applicable)
248 |     - `error` (if applicable)
249 |     - `error_type` (if applicable)
250 |     - `content_length` (int, if applicable)
251 |     - `metadata` (if applicable, dictionary of string -> any)
252 | 
253 | - `gemini_cli.file_operation`: This event occurs for each file operation.
254 |   - **Attributes**:
255 |     - `tool_name` (string)
256 |     - `operation` (string: "create", "read", "update")
257 |     - `lines` (int, if applicable)
258 |     - `mimetype` (string, if applicable)
259 |     - `extension` (string, if applicable)
260 |     - `programming_language` (string, if applicable)
261 |     - `diff_stat` (json string, if applicable): A JSON string with the following
262 |       members:
263 |       - `ai_added_lines` (int)
264 |       - `ai_removed_lines` (int)
265 |       - `user_added_lines` (int)
266 |       - `user_removed_lines` (int)
267 | 
268 | - `gemini_cli.api_request`: This event occurs when making a request to Gemini
269 |   API.
270 |   - **Attributes**:
271 |     - `model`
272 |     - `request_text` (if applicable)
273 | 
274 | - `gemini_cli.api_error`: This event occurs if the API request fails.
275 |   - **Attributes**:
276 |     - `model`
277 |     - `error`
278 |     - `error_type`
279 |     - `status_code`
280 |     - `duration_ms`
281 |     - `auth_type`
282 | 
283 | - `gemini_cli.api_response`: This event occurs upon receiving a response from
284 |   Gemini API.
285 |   - **Attributes**:
286 |     - `model`
287 |     - `status_code`
288 |     - `duration_ms`
289 |     - `error` (optional)
290 |     - `input_token_count`
291 |     - `output_token_count`
292 |     - `cached_content_token_count`
293 |     - `thoughts_token_count`
294 |     - `tool_token_count`
295 |     - `response_text` (if applicable)
296 |     - `auth_type`
297 | 
298 | - `gemini_cli.tool_output_truncated`: This event occurs when the output of a
299 |   tool call is too large and gets truncated.
300 |   - **Attributes**:
301 |     - `tool_name` (string)
302 |     - `original_content_length` (int)
303 |     - `truncated_content_length` (int)
304 |     - `threshold` (int)
305 |     - `lines` (int)
306 |     - `prompt_id` (string)
307 | 
308 | - `gemini_cli.malformed_json_response`: This event occurs when a `generateJson`
309 |   response from Gemini API cannot be parsed as a json.
310 |   - **Attributes**:
311 |     - `model`
312 | 
313 | - `gemini_cli.flash_fallback`: This event occurs when Gemini CLI switches to
314 |   flash as fallback.
315 |   - **Attributes**:
316 |     - `auth_type`
317 | 
318 | - `gemini_cli.slash_command`: This event occurs when a user executes a slash
319 |   command.
320 |   - **Attributes**:
321 |     - `command` (string)
322 |     - `subcommand` (string, if applicable)
323 | 
324 | - `gemini_cli.extension_enable`: This event occurs when an extension is enabled
325 | - `gemini_cli.extension_install`: This event occurs when an extension is
326 |   installed
327 |   - **Attributes**:
328 |     - `extension_name` (string)
329 |     - `extension_version` (string)
330 |     - `extension_source` (string)
331 |     - `status` (string)
332 | - `gemini_cli.extension_uninstall`: This event occurs when an extension is
333 |   uninstalled
334 | 
335 | ### Metrics
336 | 
337 | Metrics are numerical measurements of behavior over time.
338 | 
339 | #### Custom
340 | 
341 | - `gemini_cli.session.count` (Counter, Int): Incremented once per CLI startup.
342 | 
343 | - `gemini_cli.tool.call.count` (Counter, Int): Counts tool calls.
344 |   - **Attributes**:
345 |     - `function_name`
346 |     - `success` (boolean)
347 |     - `decision` (string: "accept", "reject", or "modify", if applicable)
348 |     - `tool_type` (string: "mcp", or "native", if applicable)
349 |     - `model_added_lines` (Int, optional): Lines added by model in the proposed
350 |       changes, if applicable
351 |     - `model_removed_lines` (Int, optional): Lines removed by model in the
352 |       proposed changes, if applicable
353 |     - `user_added_lines` (Int, optional): Lines added by user edits after model
354 |       proposal, if applicable
355 |     - `user_removed_lines` (Int, optional): Lines removed by user edits after
356 |       model proposal, if applicable
357 | 
358 | - `gemini_cli.tool.call.latency` (Histogram, ms): Measures tool call latency.
359 |   - **Attributes**:
360 |     - `function_name`
361 |     - `decision` (string: "accept", "reject", or "modify", if applicable)
362 | 
363 | - `gemini_cli.api.request.count` (Counter, Int): Counts all API requests.
364 |   - **Attributes**:
365 |     - `model`
366 |     - `status_code`
367 |     - `error_type` (if applicable)
368 | 
369 | - `gemini_cli.api.request.latency` (Histogram, ms): Measures API request
370 |   latency.
371 |   - **Attributes**:
372 |     - `model`
373 |   - **Note**: This metric overlaps with `gen_ai.client.operation.duration` below
374 |     that's compliant with GenAI Semantic Conventions.
375 | 
376 | - `gemini_cli.token.usage` (Counter, Int): Counts the number of tokens used.
377 |   - **Attributes**:
378 |     - `model`
379 |     - `type` (string: "input", "output", "thought", "cache", or "tool")
380 |   - **Note**: This metric overlaps with `gen_ai.client.token.usage` below for
381 |     `input`/`output` token types that's compliant with GenAI Semantic
382 |     Conventions.
383 | 
384 | - `gemini_cli.file.operation.count` (Counter, Int): Counts file operations.
385 |   - **Attributes**:
386 |     - `operation` (string: "create", "read", "update"): The type of file
387 |       operation.
388 |     - `lines` (Int, if applicable): Number of lines in the file.
389 |     - `mimetype` (string, if applicable): Mimetype of the file.
390 |     - `extension` (string, if applicable): File extension of the file.
391 |     - `programming_language` (string, if applicable): The programming language
392 |       of the file.
393 | 
394 | - `gemini_cli.chat_compression` (Counter, Int): Counts chat compression
395 |   operations
396 |   - **Attributes**:
397 |     - `tokens_before`: (Int): Number of tokens in context prior to compression
398 |     - `tokens_after`: (Int): Number of tokens in context after compression
399 | 
400 | #### GenAI Semantic Convention
401 | 
402 | The following metrics comply with [OpenTelemetry GenAI semantic conventions] for
403 | standardized observability across GenAI applications:
404 | 
405 | - `gen_ai.client.token.usage` (Histogram, token): Number of input and output
406 |   tokens used per operation.
407 |   - **Attributes**:
408 |     - `gen_ai.operation.name` (string): The operation type (e.g.,
409 |       "generate_content", "chat")
410 |     - `gen_ai.provider.name` (string): The GenAI provider ("gcp.gen_ai" or
411 |       "gcp.vertex_ai")
412 |     - `gen_ai.token.type` (string): The token type ("input" or "output")
413 |     - `gen_ai.request.model` (string, optional): The model name used for the
414 |       request
415 |     - `gen_ai.response.model` (string, optional): The model name that generated
416 |       the response
417 |     - `server.address` (string, optional): GenAI server address
418 |     - `server.port` (int, optional): GenAI server port
419 | 
420 | - `gen_ai.client.operation.duration` (Histogram, s): GenAI operation duration in
421 |   seconds.
422 |   - **Attributes**:
423 |     - `gen_ai.operation.name` (string): The operation type (e.g.,
424 |       "generate_content", "chat")
425 |     - `gen_ai.provider.name` (string): The GenAI provider ("gcp.gen_ai" or
426 |       "gcp.vertex_ai")
427 |     - `gen_ai.request.model` (string, optional): The model name used for the
428 |       request
429 |     - `gen_ai.response.model` (string, optional): The model name that generated
430 |       the response
431 |     - `server.address` (string, optional): GenAI server address
432 |     - `server.port` (int, optional): GenAI server port
433 |     - `error.type` (string, optional): Error type if the operation failed
434 | 
435 | [OpenTelemetry GenAI semantic conventions]:
436 |   https://github.com/open-telemetry/semantic-conventions/blob/main/docs/gen-ai/gen-ai-metrics.md
```

themes.md
```
1 | # Themes
2 | 
3 | Gemini CLI supports a variety of themes to customize its color scheme and
4 | appearance. You can change the theme to suit your preferences via the `/theme`
5 | command or `"theme":` configuration setting.
6 | 
7 | ## Available Themes
8 | 
9 | Gemini CLI comes with a selection of pre-defined themes, which you can list
10 | using the `/theme` command within Gemini CLI:
11 | 
12 | - **Dark Themes:**
13 |   - `ANSI`
14 |   - `Atom One`
15 |   - `Ayu`
16 |   - `Default`
17 |   - `Dracula`
18 |   - `GitHub`
19 | - **Light Themes:**
20 |   - `ANSI Light`
21 |   - `Ayu Light`
22 |   - `Default Light`
23 |   - `GitHub Light`
24 |   - `Google Code`
25 |   - `Xcode`
26 | 
27 | ### Changing Themes
28 | 
29 | 1.  Enter `/theme` into Gemini CLI.
30 | 2.  A dialog or selection prompt appears, listing the available themes.
31 | 3.  Using the arrow keys, select a theme. Some interfaces might offer a live
32 |     preview or highlight as you select.
33 | 4.  Confirm your selection to apply the theme.
34 | 
35 | **Note:** If a theme is defined in your `settings.json` file (either by name or
36 | by a file path), you must remove the `"theme"` setting from the file before you
37 | can change the theme using the `/theme` command.
38 | 
39 | ### Theme Persistence
40 | 
41 | Selected themes are saved in Gemini CLI's
42 | [configuration](../get-started/configuration.md) so your preference is
43 | remembered across sessions.
44 | 
45 | ---
46 | 
47 | ## Custom Color Themes
48 | 
49 | Gemini CLI allows you to create your own custom color themes by specifying them
50 | in your `settings.json` file. This gives you full control over the color palette
51 | used in the CLI.
52 | 
53 | ### How to Define a Custom Theme
54 | 
55 | Add a `customThemes` block to your user, project, or system `settings.json`
56 | file. Each custom theme is defined as an object with a unique name and a set of
57 | color keys. For example:
58 | 
59 | ```json
60 | {
61 |   "ui": {
62 |     "customThemes": {
63 |       "MyCustomTheme": {
64 |         "name": "MyCustomTheme",
65 |         "type": "custom",
66 |         "Background": "#181818",
67 |         ...
68 |       }
69 |     }
70 |   }
71 | }
72 | ```
73 | 
74 | **Color keys:**
75 | 
76 | - `Background`
77 | - `Foreground`
78 | - `LightBlue`
79 | - `AccentBlue`
80 | - `AccentPurple`
81 | - `AccentCyan`
82 | - `AccentGreen`
83 | - `AccentYellow`
84 | - `AccentRed`
85 | - `Comment`
86 | - `Gray`
87 | - `DiffAdded` (optional, for added lines in diffs)
88 | - `DiffRemoved` (optional, for removed lines in diffs)
89 | - `DiffModified` (optional, for modified lines in diffs)
90 | 
91 | **Required Properties:**
92 | 
93 | - `name` (must match the key in the `customThemes` object and be a string)
94 | - `type` (must be the string `"custom"`)
95 | - `Background`
96 | - `Foreground`
97 | - `LightBlue`
98 | - `AccentBlue`
99 | - `AccentPurple`
100 | - `AccentCyan`
101 | - `AccentGreen`
102 | - `AccentYellow`
103 | - `AccentRed`
104 | - `Comment`
105 | - `Gray`
106 | 
107 | You can use either hex codes (e.g., `#FF0000`) **or** standard CSS color names
108 | (e.g., `coral`, `teal`, `blue`) for any color value. See
109 | [CSS color names](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value#color_keywords)
110 | for a full list of supported names.
111 | 
112 | You can define multiple custom themes by adding more entries to the
113 | `customThemes` object.
114 | 
115 | ### Loading Themes from a File
116 | 
117 | In addition to defining custom themes in `settings.json`, you can also load a
118 | theme directly from a JSON file by specifying the file path in your
119 | `settings.json`. This is useful for sharing themes or keeping them separate from
120 | your main configuration.
121 | 
122 | To load a theme from a file, set the `theme` property in your `settings.json` to
123 | the path of your theme file:
124 | 
125 | ```json
126 | {
127 |   "ui": {
128 |     "theme": "/path/to/your/theme.json"
129 |   }
130 | }
131 | ```
132 | 
133 | The theme file must be a valid JSON file that follows the same structure as a
134 | custom theme defined in `settings.json`.
135 | 
136 | **Example `my-theme.json`:**
137 | 
138 | ```json
139 | {
140 |   "name": "My File Theme",
141 |   "type": "custom",
142 |   "Background": "#282A36",
143 |   "Foreground": "#F8F8F2",
144 |   "LightBlue": "#82AAFF",
145 |   "AccentBlue": "#61AFEF",
146 |   "AccentPurple": "#BD93F9",
147 |   "AccentCyan": "#8BE9FD",
148 |   "AccentGreen": "#50FA7B",
149 |   "AccentYellow": "#F1FA8C",
150 |   "AccentRed": "#FF5555",
151 |   "Comment": "#6272A4",
152 |   "Gray": "#ABB2BF",
153 |   "DiffAdded": "#A6E3A1",
154 |   "DiffRemoved": "#F38BA8",
155 |   "DiffModified": "#89B4FA",
156 |   "GradientColors": ["#4796E4", "#847ACE", "#C3677F"]
157 | }
158 | ```
159 | 
160 | **Security Note:** For your safety, Gemini CLI will only load theme files that
161 | are located within your home directory. If you attempt to load a theme from
162 | outside your home directory, a warning will be displayed and the theme will not
163 | be loaded. This is to prevent loading potentially malicious theme files from
164 | untrusted sources.
165 | 
166 | ### Example Custom Theme
167 | 
168 | <img src="../assets/theme-custom.png" alt="Custom theme example" width="600" />
169 | 
170 | ### Using Your Custom Theme
171 | 
172 | - Select your custom theme using the `/theme` command in Gemini CLI. Your custom
173 |   theme will appear in the theme selection dialog.
174 | - Or, set it as the default by adding `"theme": "MyCustomTheme"` to the `ui`
175 |   object in your `settings.json`.
176 | - Custom themes can be set at the user, project, or system level, and follow the
177 |   same [configuration precedence](../get-started/configuration.md) as other
178 |   settings.
179 | 
180 | ---
181 | 
182 | ## Dark Themes
183 | 
184 | ### ANSI
185 | 
186 | <img src="../assets/theme-ansi.png" alt="ANSI theme" width="600" />
187 | 
188 | ### Atom OneDark
189 | 
190 | <img src="../assets/theme-atom-one.png" alt="Atom One theme" width="600">
191 | 
192 | ### Ayu
193 | 
194 | <img src="../assets/theme-ayu.png" alt="Ayu theme" width="600">
195 | 
196 | ### Default
197 | 
198 | <img src="../assets/theme-default.png" alt="Default theme" width="600">
199 | 
200 | ### Dracula
201 | 
202 | <img src="../assets/theme-dracula.png" alt="Dracula theme" width="600">
203 | 
204 | ### GitHub
205 | 
206 | <img src="../assets/theme-github.png" alt="GitHub theme" width="600">
207 | 
208 | ## Light Themes
209 | 
210 | ### ANSI Light
211 | 
212 | <img src="../assets/theme-ansi-light.png" alt="ANSI Light theme" width="600">
213 | 
214 | ### Ayu Light
215 | 
216 | <img src="../assets/theme-ayu-light.png" alt="Ayu Light theme" width="600">
217 | 
218 | ### Default Light
219 | 
220 | <img src="../assets/theme-default-light.png" alt="Default Light theme" width="600">
221 | 
222 | ### GitHub Light
223 | 
224 | <img src="../assets/theme-github-light.png" alt="GitHub Light theme" width="600">
225 | 
226 | ### Google Code
227 | 
228 | <img src="../assets/theme-google-light.png" alt="Google Code theme" width="600">
229 | 
230 | ### Xcode
231 | 
232 | <img src="../assets/theme-xcode-light.png" alt="Xcode Light theme" width="600">
```

trusted-folders.md
```
1 | # Trusted Folders
2 | 
3 | The Trusted Folders feature is a security setting that gives you control over
4 | which projects can use the full capabilities of the Gemini CLI. It prevents
5 | potentially malicious code from running by asking you to approve a folder before
6 | the CLI loads any project-specific configurations from it.
7 | 
8 | ## Enabling the Feature
9 | 
10 | The Trusted Folders feature is **disabled by default**. To use it, you must
11 | first enable it in your settings.
12 | 
13 | Add the following to your user `settings.json` file:
14 | 
15 | ```json
16 | {
17 |   "security": {
18 |     "folderTrust": {
19 |       "enabled": true
20 |     }
21 |   }
22 | }
23 | ```
24 | 
25 | ## How It Works: The Trust Dialog
26 | 
27 | Once the feature is enabled, the first time you run the Gemini CLI from a
28 | folder, a dialog will automatically appear, prompting you to make a choice:
29 | 
30 | - **Trust folder**: Grants full trust to the current folder (e.g.,
31 |   `my-project`).
32 | - **Trust parent folder**: Grants trust to the parent directory (e.g.,
33 |   `safe-projects`), which automatically trusts all of its subdirectories as
34 |   well. This is useful if you keep all your safe projects in one place.
35 | - **Don't trust**: Marks the folder as untrusted. The CLI will operate in a
36 |   restricted "safe mode."
37 | 
38 | Your choice is saved in a central file (`~/.gemini/trustedFolders.json`), so you
39 | will only be asked once per folder.
40 | 
41 | ## Why Trust Matters: The Impact of an Untrusted Workspace
42 | 
43 | When a folder is **untrusted**, the Gemini CLI runs in a restricted "safe mode"
44 | to protect you. In this mode, the following features are disabled:
45 | 
46 | 1.  **Workspace Settings are Ignored**: The CLI will **not** load the
47 |     `.gemini/settings.json` file from the project. This prevents the loading of
48 |     custom tools and other potentially dangerous configurations.
49 | 
50 | 2.  **Environment Variables are Ignored**: The CLI will **not** load any `.env`
51 |     files from the project.
52 | 
53 | 3.  **Extension Management is Restricted**: You **cannot install, update, or
54 |     uninstall** extensions.
55 | 
56 | 4.  **Tool Auto-Acceptance is Disabled**: You will always be prompted before any
57 |     tool is run, even if you have auto-acceptance enabled globally.
58 | 
59 | 5.  **Automatic Memory Loading is Disabled**: The CLI will not automatically
60 |     load files into context from directories specified in local settings.
61 | 
62 | Granting trust to a folder unlocks the full functionality of the Gemini CLI for
63 | that workspace.
64 | 
65 | ## Managing Your Trust Settings
66 | 
67 | If you need to change a decision or see all your settings, you have a couple of
68 | options:
69 | 
70 | - **Change the Current Folder's Trust**: Run the `/permissions` command from
71 |   within the CLI. This will bring up the same interactive dialog, allowing you
72 |   to change the trust level for the current folder.
73 | 
74 | - **View All Trust Rules**: To see a complete list of all your trusted and
75 |   untrusted folder rules, you can inspect the contents of the
76 |   `~/.gemini/trustedFolders.json` file in your home directory.
77 | 
78 | ## The Trust Check Process (Advanced)
79 | 
80 | For advanced users, it's helpful to know the exact order of operations for how
81 | trust is determined:
82 | 
83 | 1.  **IDE Trust Signal**: If you are using the
84 |     [IDE Integration](../ide-integration/index.md), the CLI first asks the IDE
85 |     if the workspace is trusted. The IDE's response takes highest priority.
86 | 
87 | 2.  **Local Trust File**: If the IDE is not connected, the CLI checks the
88 |     central `~/.gemini/trustedFolders.json` file.
```

tutorials.md
```
1 | # Tutorials
2 | 
3 | This page contains tutorials for interacting with Gemini CLI.
4 | 
5 | ## Setting up a Model Context Protocol (MCP) server
6 | 
7 | > [!CAUTION] Before using a third-party MCP server, ensure you trust its source
8 | > and understand the tools it provides. Your use of third-party servers is at
9 | > your own risk.
10 | 
11 | This tutorial demonstrates how to set up a MCP server, using the
12 | [GitHub MCP server](https://github.com/github/github-mcp-server) as an example.
13 | The GitHub MCP server provides tools for interacting with GitHub repositories,
14 | such as creating issues and commenting on pull requests.
15 | 
16 | ### Prerequisites
17 | 
18 | Before you begin, ensure you have the following installed and configured:
19 | 
20 | - **Docker:** Install and run [Docker].
21 | - **GitHub Personal Access Token (PAT):** Create a new [classic] or
22 |   [fine-grained] PAT with the necessary scopes.
23 | 
24 | [Docker]: https://www.docker.com/
25 | [classic]: https://github.com/settings/tokens/new
26 | [fine-grained]: https://github.com/settings/personal-access-tokens/new
27 | 
28 | ### Guide
29 | 
30 | #### Configure the MCP server in `settings.json`
31 | 
32 | In your project's root directory, create or open the
33 | [`.gemini/settings.json` file](../get-started/configuration.md). Within the
34 | file, add the `mcpServers` configuration block, which provides instructions for
35 | how to launch the GitHub MCP server.
36 | 
37 | ```json
38 | {
39 |   "mcpServers": {
40 |     "github": {
41 |       "command": "docker",
42 |       "args": [
43 |         "run",
44 |         "-i",
45 |         "--rm",
46 |         "-e",
47 |         "GITHUB_PERSONAL_ACCESS_TOKEN",
48 |         "ghcr.io/github/github-mcp-server"
49 |       ],
50 |       "env": {
51 |         "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
52 |       }
53 |     }
54 |   }
55 | }
56 | ```
57 | 
58 | #### Set your GitHub token
59 | 
60 | > [!CAUTION] Using a broadly scoped personal access token that has access to
61 | > personal and private repositories can lead to information from the private
62 | > repository being leaked into the public repository. We recommend using a
63 | > fine-grained access token that doesn't share access to both public and private
64 | > repositories.
65 | 
66 | Use an environment variable to store your GitHub PAT:
67 | 
68 | ```bash
69 | GITHUB_PERSONAL_ACCESS_TOKEN="pat_YourActualGitHubTokenHere"
70 | ```
71 | 
72 | Gemini CLI uses this value in the `mcpServers` configuration that you defined in
73 | the `settings.json` file.
74 | 
75 | #### Launch Gemini CLI and verify the connection
76 | 
77 | When you launch Gemini CLI, it automatically reads your configuration and
78 | launches the GitHub MCP server in the background. You can then use natural
79 | language prompts to ask Gemini CLI to perform GitHub actions. For example:
80 | 
81 | ```bash
82 | "get all open issues assigned to me in the 'foo/bar' repo and prioritize them"
83 | ```
```

uninstall.md
```
1 | # Uninstalling the CLI
2 | 
3 | Your uninstall method depends on how you ran the CLI. Follow the instructions
4 | for either npx or a global npm installation.
5 | 
6 | ## Method 1: Using npx
7 | 
8 | npx runs packages from a temporary cache without a permanent installation. To
9 | "uninstall" the CLI, you must clear this cache, which will remove gemini-cli and
10 | any other packages previously executed with npx.
11 | 
12 | The npx cache is a directory named `_npx` inside your main npm cache folder. You
13 | can find your npm cache path by running `npm config get cache`.
14 | 
15 | **For macOS / Linux**
16 | 
17 | ```bash
18 | # The path is typically ~/.npm/_npx
19 | rm -rf "$(npm config get cache)/_npx"
20 | ```
21 | 
22 | **For Windows**
23 | 
24 | _Command Prompt_
25 | 
26 | ```cmd
27 | :: The path is typically %LocalAppData%\npm-cache\_npx
28 | rmdir /s /q "%LocalAppData%\npm-cache\_npx"
29 | ```
30 | 
31 | _PowerShell_
32 | 
33 | ```powershell
34 | # The path is typically $env:LocalAppData\npm-cache\_npx
35 | Remove-Item -Path (Join-Path $env:LocalAppData "npm-cache\_npx") -Recurse -Force
36 | ```
37 | 
38 | ## Method 2: Using npm (Global Install)
39 | 
40 | If you installed the CLI globally (e.g., `npm install -g @google/gemini-cli`),
41 | use the `npm uninstall` command with the `-g` flag to remove it.
42 | 
43 | ```bash
44 | npm uninstall -g @google/gemini-cli
45 | ```
46 | 
47 | This command completely removes the package from your system.
```
