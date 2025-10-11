Project Structure:
├── architecture.md
├── assets
│   ├── connected_devtools.png
│   ├── gemini-screenshot.png
│   ├── release_patch.png
│   ├── theme-ansi-light.png
│   ├── theme-ansi.png
│   ├── theme-atom-one.png
│   ├── theme-ayu-light.png
│   ├── theme-ayu.png
│   ├── theme-custom.png
│   ├── theme-default-light.png
│   ├── theme-default.png
│   ├── theme-dracula.png
│   ├── theme-github-light.png
│   ├── theme-github.png
│   ├── theme-google-light.png
│   └── theme-xcode-light.png
├── changelogs
│   └── index.md
├── cli
│   ├── authentication.md
│   ├── checkpointing.md
│   ├── commands.md
│   ├── custom-commands.md
│   ├── enterprise.md
│   ├── gemini-ignore.md
│   ├── gemini-md.md
│   ├── headless.md
│   ├── index.md
│   ├── keyboard-shortcuts.md
│   ├── sandbox.md
│   ├── telemetry.md
│   ├── themes.md
│   ├── token-caching.md
│   ├── trusted-folders.md
│   ├── tutorials.md
│   └── uninstall.md
├── core
│   ├── index.md
│   ├── memport.md
│   └── tools-api.md
├── examples
│   └── proxy-script.md
├── extensions
│   ├── extension-releasing.md
│   ├── getting-started-extensions.md
│   └── index.md
├── faq.md
├── get-started
│   ├── authentication.md
│   ├── configuration-v1.md
│   ├── configuration.md
│   ├── deployment.md
│   ├── examples.md
│   ├── index.md
│   └── installation.md
├── ide-integration
│   ├── ide-companion-spec.md
│   └── index.md
├── index.md
├── integration-tests.md
├── issue-and-pr-automation.md
├── mermaid
│   ├── context.mmd
│   └── render-path.mmd
├── npm.md
├── quota-and-pricing.md
├── releases.md
├── sidebar.json
├── tools
│   ├── file-system.md
│   ├── index.md
│   ├── mcp-server.md
│   ├── memory.md
│   ├── multi-file.md
│   ├── shell.md
│   ├── web-fetch.md
│   └── web-search.md
├── tos-privacy.md
└── troubleshooting.md


architecture.md
```
1 | # Gemini CLI Architecture Overview
2 | 
3 | This document provides a high-level overview of the Gemini CLI's architecture.
4 | 
5 | ## Core components
6 | 
7 | The Gemini CLI is primarily composed of two main packages, along with a suite of
8 | tools that can be used by the system in the course of handling command-line
9 | input:
10 | 
11 | 1.  **CLI package (`packages/cli`):**
12 |     - **Purpose:** This contains the user-facing portion of the Gemini CLI, such
13 |       as handling the initial user input, presenting the final output, and
14 |       managing the overall user experience.
15 |     - **Key functions contained in the package:**
16 |       - [Input processing](/docs/cli/commands.md)
17 |       - History management
18 |       - Display rendering
19 |       - [Theme and UI customization](/docs/cli/themes.md)
20 |       - [CLI configuration settings](/docs/get-started/configuration.md)
21 | 
22 | 2.  **Core package (`packages/core`):**
23 |     - **Purpose:** This acts as the backend for the Gemini CLI. It receives
24 |       requests sent from `packages/cli`, orchestrates interactions with the
25 |       Gemini API, and manages the execution of available tools.
26 |     - **Key functions contained in the package:**
27 |       - API client for communicating with the Google Gemini API
28 |       - Prompt construction and management
29 |       - Tool registration and execution logic
30 |       - State management for conversations or sessions
31 |       - Server-side configuration
32 | 
33 | 3.  **Tools (`packages/core/src/tools/`):**
34 |     - **Purpose:** These are individual modules that extend the capabilities of
35 |       the Gemini model, allowing it to interact with the local environment
36 |       (e.g., file system, shell commands, web fetching).
37 |     - **Interaction:** `packages/core` invokes these tools based on requests
38 |       from the Gemini model.
39 | 
40 | ## Interaction Flow
41 | 
42 | A typical interaction with the Gemini CLI follows this flow:
43 | 
44 | 1.  **User input:** The user types a prompt or command into the terminal, which
45 |     is managed by `packages/cli`.
46 | 2.  **Request to core:** `packages/cli` sends the user's input to
47 |     `packages/core`.
48 | 3.  **Request processed:** The core package:
49 |     - Constructs an appropriate prompt for the Gemini API, possibly including
50 |       conversation history and available tool definitions.
51 |     - Sends the prompt to the Gemini API.
52 | 4.  **Gemini API response:** The Gemini API processes the prompt and returns a
53 |     response. This response might be a direct answer or a request to use one of
54 |     the available tools.
55 | 5.  **Tool execution (if applicable):**
56 |     - When the Gemini API requests a tool, the core package prepares to execute
57 |       it.
58 |     - If the requested tool can modify the file system or execute shell
59 |       commands, the user is first given details of the tool and its arguments,
60 |       and the user must approve the execution.
61 |     - Read-only operations, such as reading files, might not require explicit
62 |       user confirmation to proceed.
63 |     - Once confirmed, or if confirmation is not required, the core package
64 |       executes the relevant action within the relevant tool, and the result is
65 |       sent back to the Gemini API by the core package.
66 |     - The Gemini API processes the tool result and generates a final response.
67 | 6.  **Response to CLI:** The core package sends the final response back to the
68 |     CLI package.
69 | 7.  **Display to user:** The CLI package formats and displays the response to
70 |     the user in the terminal.
71 | 
72 | ## Key Design Principles
73 | 
74 | - **Modularity:** Separating the CLI (frontend) from the Core (backend) allows
75 |   for independent development and potential future extensions (e.g., different
76 |   frontends for the same backend).
77 | - **Extensibility:** The tool system is designed to be extensible, allowing new
78 |   capabilities to be added.
79 | - **User experience:** The CLI focuses on providing a rich and interactive
80 |   terminal experience.
```

faq.md
```
1 | # Frequently Asked Questions (FAQ)
2 | 
3 | This page provides answers to common questions and solutions to frequent
4 | problems encountered while using Gemini CLI.
5 | 
6 | ## General issues
7 | 
8 | ### Why am I getting an `API error: 429 - Resource exhausted`?
9 | 
10 | This error indicates that you have exceeded your API request limit. The Gemini
11 | API has rate limits to prevent abuse and ensure fair usage.
12 | 
13 | To resolve this, you can:
14 | 
15 | - **Check your usage:** Review your API usage in the Google AI Studio or your
16 |   Google Cloud project dashboard.
17 | - **Optimize your prompts:** If you are making many requests in a short period,
18 |   try to batch your prompts or introduce delays between requests.
19 | - **Request a quota increase:** If you consistently need a higher limit, you can
20 |   request a quota increase from Google.
21 | 
22 | ### Why am I getting an `ERR_REQUIRE_ESM` error when running `npm run start`?
23 | 
24 | This error typically occurs in Node.js projects when there is a mismatch between
25 | CommonJS and ES Modules.
26 | 
27 | This is often due to a misconfiguration in your `package.json` or
28 | `tsconfig.json`. Ensure that:
29 | 
30 | 1.  Your `package.json` has `"type": "module"`.
31 | 2.  Your `tsconfig.json` has `"module": "NodeNext"` or a compatible setting in
32 |     the `compilerOptions`.
33 | 
34 | If the problem persists, try deleting your `node_modules` directory and
35 | `package-lock.json` file, and then run `npm install` again.
36 | 
37 | ### Why don't I see cached token counts in my stats output?
38 | 
39 | Cached token information is only displayed when cached tokens are being used.
40 | This feature is available for API key users (Gemini API key or Google Cloud
41 | Vertex AI) but not for OAuth users (such as Google Personal/Enterprise accounts
42 | like Google Gmail or Google Workspace, respectively). This is because the Gemini
43 | Code Assist API does not support cached content creation. You can still view
44 | your total token usage using the `/stats` command in Gemini CLI.
45 | 
46 | ## Installation and updates
47 | 
48 | ### How do I update Gemini CLI to the latest version?
49 | 
50 | If you installed it globally via `npm`, update it using the command
51 | `npm install -g @google/gemini-cli@latest`. If you compiled it from source, pull
52 | the latest changes from the repository, and then rebuild using the command
53 | `npm run build`.
54 | 
55 | ## Platform-specific issues
56 | 
57 | ### Why does the CLI crash on Windows when I run a command like `chmod +x`?
58 | 
59 | Commands like `chmod` are specific to Unix-like operating systems (Linux,
60 | macOS). They are not available on Windows by default.
61 | 
62 | To resolve this, you can:
63 | 
64 | - **Use Windows-equivalent commands:** Instead of `chmod`, you can use `icacls`
65 |   to modify file permissions on Windows.
66 | - **Use a compatibility layer:** Tools like Git Bash or Windows Subsystem for
67 |   Linux (WSL) provide a Unix-like environment on Windows where these commands
68 |   will work.
69 | 
70 | ## Configuration
71 | 
72 | ### How do I configure my `GOOGLE_CLOUD_PROJECT`?
73 | 
74 | You can configure your Google Cloud Project ID using an environment variable.
75 | 
76 | Set the `GOOGLE_CLOUD_PROJECT` environment variable in your shell:
77 | 
78 | ```bash
79 | export GOOGLE_CLOUD_PROJECT="your-project-id"
80 | ```
81 | 
82 | To make this setting permanent, add this line to your shell's startup file
83 | (e.g., `~/.bashrc`, `~/.zshrc`).
84 | 
85 | ### What is the best way to store my API keys securely?
86 | 
87 | Exposing API keys in scripts or checking them into source control is a security
88 | risk.
89 | 
90 | To store your API keys securely, you can:
91 | 
92 | - **Use a `.env` file:** Create a `.env` file in your project's `.gemini`
93 |   directory (`.gemini/.env`) and store your keys there. Gemini CLI will
94 |   automatically load these variables.
95 | - **Use your system's keyring:** For the most secure storage, use your operating
96 |   system's secret management tool (like macOS Keychain, Windows Credential
97 |   Manager, or a secret manager on Linux). You can then have your scripts or
98 |   environment load the key from the secure storage at runtime.
99 | 
100 | ### Where are the Gemini CLI configuration and settings files stored?
101 | 
102 | The Gemini CLI configuration is stored in two `settings.json` files:
103 | 
104 | 1.  In your home directory: `~/.gemini/settings.json`.
105 | 2.  In your project's root directory: `./.gemini/settings.json`.
106 | 
107 | Refer to [Gemini CLI Configuration](./get-started/configuration.md) for more
108 | details.
109 | 
110 | ## Google AI Pro/Ultra and subscription FAQs
111 | 
112 | ### Where can I learn more about my Google AI Pro or Google AI Ultra subscription?
113 | 
114 | To learn more about your Google AI Pro or Google AI Ultra subscription, visit
115 | **Manage subscription** in your [subscription settings](https://one.google.com).
116 | 
117 | ### How do I know if I have higher limits for Google AI Pro or Ultra?
118 | 
119 | If you're subscribed to Google AI Pro or Ultra, you automatically have higher
120 | limits to Gemini Code Assist and Gemini CLI. These are shared across Gemini CLI
121 | and agent mode in the IDE. You can confirm you have higher limits by checking if
122 | you are still subscribed to Google AI Pro or Ultra in your
123 | [subscription settings](https://one.google.com).
124 | 
125 | ### What is the privacy policy for using Gemini Code Assist or Gemini CLI if I've subscribed to Google AI Pro or Ultra?
126 | 
127 | To learn more about your privacy policy and terms of service governed by your
128 | subscription, visit
129 | [Gemini Code Assist: Terms of Service and Privacy Policies](https://developers.google.com/gemini-code-assist/resources/privacy-notices).
130 | 
131 | ### I've upgraded to Google AI Pro or Ultra but it still says I am hitting quota limits. Is this a bug?
132 | 
133 | The higher limits in your Google AI Pro or Ultra subscription are for Gemini 2.5
134 | across both Gemini 2.5 Pro and Flash. They are shared quota across Gemini CLI
135 | and agent mode in Gemini Code Assist IDE extensions. You can learn more about
136 | quota limits for Gemini CLI, Gemini Code Assist and agent mode in Gemini Code
137 | Assist at
138 | [Quotas and limits](https://developers.google.com/gemini-code-assist/resources/quotas).
139 | 
140 | ### If I upgrade to higher limits for Gemini CLI and Gemini Code Assist by purchasing a Google AI Pro or Ultra subscription, will Gemini start using my data to improve its machine learning models?
141 | 
142 | Google does not use your data to improve Google's machine learning models if you
143 | purchase a paid plan. Note: If you decide to remain on the free version of
144 | Gemini Code Assist, Gemini Code Assist for individuals, you can also opt out of
145 | using your data to improve Google's machine learning models. See the
146 | [Gemini Code Assist for individuals privacy notice](https://developers.google.com/gemini-code-assist/resources/privacy-notice-gemini-code-assist-individuals)
147 | for more information.
148 | 
149 | ## Not seeing your question?
150 | 
151 | Search the
152 | [Gemini CLI Q&A discussions on GitHub](https://github.com/google-gemini/gemini-cli/discussions/categories/q-a)
153 | or
154 | [start a new discussion on GitHub](https://github.com/google-gemini/gemini-cli/discussions/new?category=q-a)
```

index.md
```
1 | # Welcome to Gemini CLI documentation
2 | 
3 | This documentation provides a comprehensive guide to installing, using, and
4 | developing Gemini CLI. This tool lets you interact with Gemini models through a
5 | command-line interface.
6 | 
7 | ## Overview
8 | 
9 | Gemini CLI brings the capabilities of Gemini models to your terminal in an
10 | interactive Read-Eval-Print Loop (REPL) environment. Gemini CLI consists of a
11 | client-side application (`packages/cli`) that communicates with a local server
12 | (`packages/core`), which in turn manages requests to the Gemini API and its AI
13 | models. Gemini CLI also contains a variety of tools for tasks such as performing
14 | file system operations, running shells, and web fetching, which are managed by
15 | `packages/core`.
16 | 
17 | ## Navigating the documentation
18 | 
19 | This documentation is organized into the following sections:
20 | 
21 | ### Get started
22 | 
23 | - **[Gemini CLI Quickstart](./get-started/index.md):** Let's get started with
24 |   Gemini CLI.
25 | - **[Installation](./get-started/installation.md):** Install and run Gemini CLI.
26 | - **[Authentication](./get-started/authentication.md):** Authenticate Gemini
27 |   CLI.
28 | - **[Configuration](./get-started/configuration.md):** Information on
29 |   configuring the CLI.
30 | - **[Examples](./get-started/examples.md):** Example usage of Gemini CLI.
31 | 
32 | ### CLI
33 | 
34 | - **[CLI overview](./cli/index.md):** Overview of the command-line interface.
35 | - **[Commands](./cli/commands.md):** Description of available CLI commands.
36 | - **[Enterprise](./cli/enterprise.md):** Gemini CLI for enterprise.
37 | - **[Themes](./cli/themes.md):** Themes for Gemini CLI.
38 | - **[Token Caching](./cli/token-caching.md):** Token caching and optimization.
39 | - **[Tutorials](./cli/tutorials.md):** Tutorials for Gemini CLI.
40 | - **[Checkpointing](./cli/checkpointing.md):** Documentation for the
41 |   checkpointing feature.
42 | - **[Telemetry](./cli/telemetry.md):** Overview of telemetry in the CLI.
43 | - **[Trusted Folders](./cli/trusted-folders.md):** An overview of the Trusted
44 |   Folders security feature.
45 | 
46 | ### Core
47 | 
48 | - **[Gemini CLI core overview](./core/index.md):** Information about Gemini CLI
49 |   core.
50 | - **[Memport](./core/memport.md):** Using the Memory Import Processor.
51 | - **[Tools API](./core/tools-api.md):** Information on how the core manages and
52 |   exposes tools.
53 | 
54 | ### Tools
55 | 
56 | - **[Gemini CLI tools overview](./tools/index.md):** Information about Gemini
57 |   CLI's tools.
58 | - **[File System Tools](./tools/file-system.md):** Documentation for the
59 |   `read_file` and `write_file` tools.
60 | - **[MCP servers](./tools/mcp-server.md):** Using MCP servers with Gemini CLI.
61 | - **[Multi-File Read Tool](./tools/multi-file.md):** Documentation for the
62 |   `read_many_files` tool.
63 | - **[Shell Tool](./tools/shell.md):** Documentation for the `run_shell_command`
64 |   tool.
65 | - **[Web Fetch Tool](./tools/web-fetch.md):** Documentation for the `web_fetch`
66 |   tool.
67 | - **[Web Search Tool](./tools/web-search.md):** Documentation for the
68 |   `google_web_search` tool.
69 | - **[Memory Tool](./tools/memory.md):** Documentation for the `save_memory`
70 |   tool.
71 | 
72 | ### Extensions
73 | 
74 | - **[Extensions](./extensions/index.md):** How to extend the CLI with new
75 |   functionality.
76 | - **[Get Started with Extensions](./extensions/getting-started-extensions.md):**
77 |   Learn how to build your own extension.
78 | - **[Extension Releasing](./extensions/extension-releasing.md):** How to release
79 |   Gemini CLI extensions.
80 | 
81 | ### IDE integration
82 | 
83 | - **[IDE Integration](./ide-integration/index.md):** Connect the CLI to your
84 |   editor.
85 | - **[IDE Companion Extension Spec](./ide-integration/ide-companion-spec.md):**
86 |   Spec for building IDE companion extensions.
87 | 
88 | ### About the Gemini CLI project
89 | 
90 | - **[Architecture Overview](./architecture.md):** Understand the high-level
91 |   design of Gemini CLI, including its components and how they interact.
92 | - **[Contributing & Development Guide](../CONTRIBUTING.md):** Information for
93 |   contributors and developers, including setup, building, testing, and coding
94 |   conventions.
95 | - **[NPM](./npm.md):** Details on how the project's packages are structured.
96 | - **[Troubleshooting Guide](./troubleshooting.md):** Find solutions to common
97 |   problems.
98 | - **[FAQ](./faq.md):** Frequently asked questions.
99 | - **[Terms of Service and Privacy Notice](./tos-privacy.md):** Information on
100 |   the terms of service and privacy notices applicable to your use of Gemini CLI.
101 | - **[Releases](./releases.md):** Information on the project's releases and
102 |   deployment cadence.
103 | 
104 | We hope this documentation helps you make the most of Gemini CLI!
```

integration-tests.md
```
1 | # Integration Tests
2 | 
3 | This document provides information about the integration testing framework used
4 | in this project.
5 | 
6 | ## Overview
7 | 
8 | The integration tests are designed to validate the end-to-end functionality of
9 | the Gemini CLI. They execute the built binary in a controlled environment and
10 | verify that it behaves as expected when interacting with the file system.
11 | 
12 | These tests are located in the `integration-tests` directory and are run using a
13 | custom test runner.
14 | 
15 | ## Running the tests
16 | 
17 | The integration tests are not run as part of the default `npm run test` command.
18 | They must be run explicitly using the `npm run test:integration:all` script.
19 | 
20 | The integration tests can also be run using the following shortcut:
21 | 
22 | ```bash
23 | npm run test:e2e
24 | ```
25 | 
26 | ## Running a specific set of tests
27 | 
28 | To run a subset of test files, you can use
29 | `npm run <integration test command> <file_name1> ....` where &lt;integration
30 | test command&gt; is either `test:e2e` or `test:integration*` and `<file_name>`
31 | is any of the `.test.js` files in the `integration-tests/` directory. For
32 | example, the following command runs `list_directory.test.js` and
33 | `write_file.test.js`:
34 | 
35 | ```bash
36 | npm run test:e2e list_directory write_file
37 | ```
38 | 
39 | ### Running a single test by name
40 | 
41 | To run a single test by its name, use the `--test-name-pattern` flag:
42 | 
43 | ```bash
44 | npm run test:e2e -- --test-name-pattern "reads a file"
45 | ```
46 | 
47 | ### Deflaking a test
48 | 
49 | Before adding a **new** integration test, you should test it at least 5 times
50 | with the deflake script to make sure that it is not flaky.
51 | 
52 | ```bash
53 | npm run deflake -- --runs=5 --command="npm run test:e2e -- -- --test-name-pattern '<your-new-test-name>'"
54 | ```
55 | 
56 | ### Running all tests
57 | 
58 | To run the entire suite of integration tests, use the following command:
59 | 
60 | ```bash
61 | npm run test:integration:all
62 | ```
63 | 
64 | ### Sandbox matrix
65 | 
66 | The `all` command will run tests for `no sandboxing`, `docker` and `podman`.
67 | Each individual type can be run using the following commands:
68 | 
69 | ```bash
70 | npm run test:integration:sandbox:none
71 | ```
72 | 
73 | ```bash
74 | npm run test:integration:sandbox:docker
75 | ```
76 | 
77 | ```bash
78 | npm run test:integration:sandbox:podman
79 | ```
80 | 
81 | ## Diagnostics
82 | 
83 | The integration test runner provides several options for diagnostics to help
84 | track down test failures.
85 | 
86 | ### Keeping test output
87 | 
88 | You can preserve the temporary files created during a test run for inspection.
89 | This is useful for debugging issues with file system operations.
90 | 
91 | To keep the test output set the `KEEP_OUTPUT` environment variable to `true`.
92 | 
93 | ```bash
94 | KEEP_OUTPUT=true npm run test:integration:sandbox:none
95 | ```
96 | 
97 | When output is kept, the test runner will print the path to the unique directory
98 | for the test run.
99 | 
100 | ### Verbose output
101 | 
102 | For more detailed debugging, set the `VERBOSE` environment variable to `true`.
103 | 
104 | ```bash
105 | VERBOSE=true npm run test:integration:sandbox:none
106 | ```
107 | 
108 | When using `VERBOSE=true` and `KEEP_OUTPUT=true` in the same command, the output
109 | is streamed to the console and also saved to a log file within the test's
110 | temporary directory.
111 | 
112 | The verbose output is formatted to clearly identify the source of the logs:
113 | 
114 | ```
115 | --- TEST: <log dir>:<test-name> ---
116 | ... output from the gemini command ...
117 | --- END TEST: <log dir>:<test-name> ---
118 | ```
119 | 
120 | ## Linting and formatting
121 | 
122 | To ensure code quality and consistency, the integration test files are linted as
123 | part of the main build process. You can also manually run the linter and
124 | auto-fixer.
125 | 
126 | ### Running the linter
127 | 
128 | To check for linting errors, run the following command:
129 | 
130 | ```bash
131 | npm run lint
132 | ```
133 | 
134 | You can include the `:fix` flag in the command to automatically fix any fixable
135 | linting errors:
136 | 
137 | ```bash
138 | npm run lint:fix
139 | ```
140 | 
141 | ## Directory structure
142 | 
143 | The integration tests create a unique directory for each test run inside the
144 | `.integration-tests` directory. Within this directory, a subdirectory is created
145 | for each test file, and within that, a subdirectory is created for each
146 | individual test case.
147 | 
148 | This structure makes it easy to locate the artifacts for a specific test run,
149 | file, or case.
150 | 
151 | ```
152 | .integration-tests/
153 | └── <run-id>/
154 |     └── <test-file-name>.test.js/
155 |         └── <test-case-name>/
156 |             ├── output.log
157 |             └── ...other test artifacts...
158 | ```
159 | 
160 | ## Continuous integration
161 | 
162 | To ensure the integration tests are always run, a GitHub Actions workflow is
163 | defined in `.github/workflows/e2e.yml`. This workflow automatically runs the
164 | integrations tests for pull requests against the `main` branch, or when a pull
165 | request is added to a merge queue.
166 | 
167 | The workflow runs the tests in different sandboxing environments to ensure
168 | Gemini CLI is tested across each:
169 | 
170 | - `sandbox:none`: Runs the tests without any sandboxing.
171 | - `sandbox:docker`: Runs the tests in a Docker container.
172 | - `sandbox:podman`: Runs the tests in a Podman container.
```

issue-and-pr-automation.md
```
1 | # Automation and Triage Processes
2 | 
3 | This document provides a detailed overview of the automated processes we use to
4 | manage and triage issues and pull requests. Our goal is to provide prompt
5 | feedback and ensure that contributions are reviewed and integrated efficiently.
6 | Understanding this automation will help you as a contributor know what to expect
7 | and how to best interact with our repository bots.
8 | 
9 | ## Guiding Principle: Issues and Pull Requests
10 | 
11 | First and foremost, almost every Pull Request (PR) should be linked to a
12 | corresponding Issue. The issue describes the "what" and the "why" (the bug or
13 | feature), while the PR is the "how" (the implementation). This separation helps
14 | us track work, prioritize features, and maintain clear historical context. Our
15 | automation is built around this principle.
16 | 
17 | ---
18 | 
19 | ## Detailed Automation Workflows
20 | 
21 | Here is a breakdown of the specific automation workflows that run in our
22 | repository.
23 | 
24 | ### 1. When you open an Issue: `Automated Issue Triage`
25 | 
26 | This is the first bot you will interact with when you create an issue. Its job
27 | is to perform an initial analysis and apply the correct labels.
28 | 
29 | - **Workflow File**: `.github/workflows/gemini-automated-issue-triage.yml`
30 | - **When it runs**: Immediately after an issue is created or reopened.
31 | - **What it does**:
32 |   - It uses a Gemini model to analyze the issue's title and body against a
33 |     detailed set of guidelines.
34 |   - **Applies one `area/*` label**: Categorizes the issue into a functional area
35 |     of the project (e.g., `area/ux`, `area/models`, `area/platform`).
36 |   - **Applies one `kind/*` label**: Identifies the type of issue (e.g.,
37 |     `kind/bug`, `kind/enhancement`, `kind/question`).
38 |   - **Applies one `priority/*` label**: Assigns a priority from P0 (critical) to
39 |     P3 (low) based on the described impact.
40 |   - **May apply `status/need-information`**: If the issue lacks critical details
41 |     (like logs or reproduction steps), it will be flagged for more information.
42 |   - **May apply `status/need-retesting`**: If the issue references a CLI version
43 |     that is more than six versions old, it will be flagged for retesting on a
44 |     current version.
45 | - **What you should do**:
46 |   - Fill out the issue template as completely as possible. The more detail you
47 |     provide, the more accurate the triage will be.
48 |   - If the `status/need-information` label is added, please provide the
49 |     requested details in a comment.
50 | 
51 | ### 2. When you open a Pull Request: `Continuous Integration (CI)`
52 | 
53 | This workflow ensures that all changes meet our quality standards before they
54 | can be merged.
55 | 
56 | - **Workflow File**: `.github/workflows/ci.yml`
57 | - **When it runs**: On every push to a pull request.
58 | - **What it does**:
59 |   - **Lint**: Checks that your code adheres to our project's formatting and
60 |     style rules.
61 |   - **Test**: Runs our full suite of automated tests across macOS, Windows, and
62 |     Linux, and on multiple Node.js versions. This is the most time-consuming
63 |     part of the CI process.
64 |   - **Post Coverage Comment**: After all tests have successfully passed, a bot
65 |     will post a comment on your PR. This comment provides a summary of how well
66 |     your changes are covered by tests.
67 | - **What you should do**:
68 |   - Ensure all CI checks pass. A green checkmark ✅ will appear next to your
69 |     commit when everything is successful.
70 |   - If a check fails (a red "X" ❌), click the "Details" link next to the failed
71 |     check to view the logs, identify the problem, and push a fix.
72 | 
73 | ### 3. Ongoing Triage for Pull Requests: `PR Auditing and Label Sync`
74 | 
75 | This workflow runs periodically to ensure all open PRs are correctly linked to
76 | issues and have consistent labels.
77 | 
78 | - **Workflow File**: `.github/workflows/gemini-scheduled-pr-triage.yml`
79 | - **When it runs**: Every 15 minutes on all open pull requests.
80 | - **What it does**:
81 |   - **Checks for a linked issue**: The bot scans your PR description for a
82 |     keyword that links it to an issue (e.g., `Fixes #123`, `Closes #456`).
83 |   - **Adds `status/need-issue`**: If no linked issue is found, the bot will add
84 |     the `status/need-issue` label to your PR. This is a clear signal that an
85 |     issue needs to be created and linked.
86 |   - **Synchronizes labels**: If an issue _is_ linked, the bot ensures the PR's
87 |     labels perfectly match the issue's labels. It will add any missing labels
88 |     and remove any that don't belong, and it will remove the `status/need-issue`
89 |     label if it was present.
90 | - **What you should do**:
91 |   - **Always link your PR to an issue.** This is the most important step. Add a
92 |     line like `Resolves #<issue-number>` to your PR description.
93 |   - This will ensure your PR is correctly categorized and moves through the
94 |     review process smoothly.
95 | 
96 | ### 4. Ongoing Triage for Issues: `Scheduled Issue Triage`
97 | 
98 | This is a fallback workflow to ensure that no issue gets missed by the triage
99 | process.
100 | 
101 | - **Workflow File**: `.github/workflows/gemini-scheduled-issue-triage.yml`
102 | - **When it runs**: Every hour on all open issues.
103 | - **What it does**:
104 |   - It actively seeks out issues that either have no labels at all or still have
105 |     the `status/need-triage` label.
106 |   - It then triggers the same powerful Gemini-based analysis as the initial
107 |     triage bot to apply the correct labels.
108 | - **What you should do**:
109 |   - You typically don't need to do anything. This workflow is a safety net to
110 |     ensure every issue is eventually categorized, even if the initial triage
111 |     fails.
112 | 
113 | ### 5. Release Automation
114 | 
115 | This workflow handles the process of packaging and publishing new versions of
116 | the Gemini CLI.
117 | 
118 | - **Workflow File**: `.github/workflows/release-manual.yml`
119 | - **When it runs**: On a daily schedule for "nightly" releases, and manually for
120 |   official patch/minor releases.
121 | - **What it does**:
122 |   - Automatically builds the project, bumps the version numbers, and publishes
123 |     the packages to npm.
124 |   - Creates a corresponding release on GitHub with generated release notes.
125 | - **What you should do**:
126 |   - As a contributor, you don't need to do anything for this process. You can be
127 |     confident that once your PR is merged into the `main` branch, your changes
128 |     will be included in the very next nightly release.
129 | 
130 | We hope this detailed overview is helpful. If you have any questions about our
131 | automation or processes, please don't hesitate to ask!
```

npm.md
```
1 | # Package Overview
2 | 
3 | This monorepo contains two main packages: `@google/gemini-cli` and
4 | `@google/gemini-cli-core`.
5 | 
6 | ## `@google/gemini-cli`
7 | 
8 | This is the main package for the Gemini CLI. It is responsible for the user
9 | interface, command parsing, and all other user-facing functionality.
10 | 
11 | When this package is published, it is bundled into a single executable file.
12 | This bundle includes all of the package's dependencies, including
13 | `@google/gemini-cli-core`. This means that whether a user installs the package
14 | with `npm install -g @google/gemini-cli` or runs it directly with
15 | `npx @google/gemini-cli`, they are using this single, self-contained executable.
16 | 
17 | ## `@google/gemini-cli-core`
18 | 
19 | This package contains the core logic for interacting with the Gemini API. It is
20 | responsible for making API requests, handling authentication, and managing the
21 | local cache.
22 | 
23 | This package is not bundled. When it is published, it is published as a standard
24 | Node.js package with its own dependencies. This allows it to be used as a
25 | standalone package in other projects, if needed. All transpiled js code in the
26 | `dist` folder is included in the package.
27 | 
28 | ## NPM Workspaces
29 | 
30 | This project uses
31 | [NPM Workspaces](https://docs.npmjs.com/cli/v10/using-npm/workspaces) to manage
32 | the packages within this monorepo. This simplifies development by allowing us to
33 | manage dependencies and run scripts across multiple packages from the root of
34 | the project.
35 | 
36 | ### How it Works
37 | 
38 | The root `package.json` file defines the workspaces for this project:
39 | 
40 | ```json
41 | {
42 |   "workspaces": ["packages/*"]
43 | }
44 | ```
45 | 
46 | This tells NPM that any folder inside the `packages` directory is a separate
47 | package that should be managed as part of the workspace.
48 | 
49 | ### Benefits of Workspaces
50 | 
51 | - **Simplified Dependency Management**: Running `npm install` from the root of
52 |   the project will install all dependencies for all packages in the workspace
53 |   and link them together. This means you don't need to run `npm install` in each
54 |   package's directory.
55 | - **Automatic Linking**: Packages within the workspace can depend on each other.
56 |   When you run `npm install`, NPM will automatically create symlinks between the
57 |   packages. This means that when you make changes to one package, the changes
58 |   are immediately available to other packages that depend on it.
59 | - **Simplified Script Execution**: You can run scripts in any package from the
60 |   root of the project using the `--workspace` flag. For example, to run the
61 |   `build` script in the `cli` package, you can run
62 |   `npm run build --workspace @google/gemini-cli`.
```

quota-and-pricing.md
```
1 | # Gemini CLI: Quotas and Pricing
2 | 
3 | Gemini CLI offers a generous free tier that covers the use cases for many
4 | individual developers. For enterprise / professional usage, or if you need
5 | higher limits, there are multiple possible avenues depending on what type of
6 | account you use to authenticate.
7 | 
8 | See [privacy and terms](./tos-privacy.md) for details on Privacy policy and
9 | Terms of Service.
10 | 
11 | > [!NOTE] Published prices are list price; additional negotiated commercial
12 | > discounting may apply.
13 | 
14 | This article outlines the specific quotas and pricing applicable to the Gemini
15 | CLI when using different authentication methods.
16 | 
17 | Generally, there are three categories to choose from:
18 | 
19 | - Free Usage: Ideal for experimentation and light use.
20 | - Paid Tier (fixed price): For individual developers or enterprises who need
21 |   more generous daily quotas and predictable costs.
22 | - Pay-As-You-Go: The most flexible option for professional use, long-running
23 |   tasks, or when you need full control over your usage.
24 | 
25 | ## Free Usage
26 | 
27 | Your journey begins with a generous free tier, perfect for experimentation and
28 | light use.
29 | 
30 | Your free usage limits depend on your authorization type.
31 | 
32 | ### Log in with Google (Gemini Code Assist for individuals)
33 | 
34 | For users who authenticate by using their Google account to access Gemini Code
35 | Assist for individuals. This includes:
36 | 
37 | - 1000 model requests / user / day
38 | - 60 model requests / user / minute
39 | - Model requests will be made across the Gemini model family as determined by
40 |   Gemini CLI.
41 | 
42 | Learn more at
43 | [Gemini Code Assist for Individuals Limits](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli).
44 | 
45 | ### Log in with Gemini API Key (Unpaid)
46 | 
47 | If you are using a Gemini API key, you can also benefit from a free tier. This
48 | includes:
49 | 
50 | - 250 model requests / user / day
51 | - 10 model requests / user / minute
52 | - Model requests to Flash model only.
53 | 
54 | Learn more at
55 | [Gemini API Rate Limits](https://ai.google.dev/gemini-api/docs/rate-limits).
56 | 
57 | ### Log in with Vertex AI (Express Mode)
58 | 
59 | Vertex AI offers an Express Mode without the need to enable billing. This
60 | includes:
61 | 
62 | - 90 days before you need to enable billing.
63 | - Quotas and models are variable and specific to your account.
64 | 
65 | Learn more at
66 | [Vertex AI Express Mode Limits](https://cloud.google.com/vertex-ai/generative-ai/docs/start/express-mode/overview#quotas).
67 | 
68 | ## Paid tier: Higher limits for a fixed cost
69 | 
70 | If you use up your initial number of requests, you can continue to benefit from
71 | Gemini CLI by upgrading to one of the following subscriptions:
72 | 
73 | - [Google AI Pro and AI Ultra](https://cloud.google.com/products/gemini/pricing)
74 |   by signing up at
75 |   [Set up Gemini Code Assist](https://goo.gle/set-up-gemini-code-assist). This
76 |   is recommended for individual developers. Quotas and pricing are based on a
77 |   fixed price subscription.
78 | 
79 |   For predictable costs, you can log in with Google.
80 | 
81 |   Learn more at
82 |   [Gemini Code Assist Quotas and Limits](https://developers.google.com/gemini-code-assist/resources/quotas)
83 | 
84 | - [Purchase a Gemini Code Assist Subscription through Google Cloud ](https://cloud.google.com/gemini/docs/codeassist/overview)
85 |   by signing up in the Google Cloud console. Learn more at [Set up Gemini Code
86 |   Assist] (https://cloud.google.com/gemini/docs/discover/set-up-gemini) Quotas
87 |   and pricing are based on a fixed price subscription with assigned license
88 |   seats. For predictable costs, you can sign in with Google.
89 | 
90 |   This includes:
91 |   - Gemini Code Assist Standard edition:
92 |     - 1500 model requests / user / day
93 |     - 120 model requests / user / minute
94 |   - Gemini Code Assist Enterprise edition:
95 |     - 2000 model requests / user / day
96 |     - 120 model requests / user / minute
97 |   - Model requests will be made across the Gemini model family as determined by
98 |     Gemini CLI.
99 | 
100 |   [Learn more about Gemini Code Assist Standard and Enterprise license limits](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli).
101 | 
102 | ## Pay As You Go
103 | 
104 | If you hit your daily request limits or exhaust your Gemini Pro quota even after
105 | upgrading, the most flexible solution is to switch to a pay-as-you-go model,
106 | where you pay for the specific amount of processing you use. This is the
107 | recommended path for uninterrupted access.
108 | 
109 | To do this, log in using a Gemini API key or Vertex AI.
110 | 
111 | - Vertex AI (Regular Mode):
112 |   - Quota: Governed by a dynamic shared quota system or pre-purchased
113 |     provisioned throughput.
114 |   - Cost: Based on model and token usage.
115 | 
116 | Learn more at
117 | [Vertex AI Dynamic Shared Quota](https://cloud.google.com/vertex-ai/generative-ai/docs/resources/dynamic-shared-quota)
118 | and [Vertex AI Pricing](https://cloud.google.com/vertex-ai/pricing).
119 | 
120 | - Gemini API key:
121 |   - Quota: Varies by pricing tier.
122 |   - Cost: Varies by pricing tier and model/token usage.
123 | 
124 | Learn more at
125 | [Gemini API Rate Limits](https://ai.google.dev/gemini-api/docs/rate-limits),
126 | [Gemini API Pricing](https://ai.google.dev/gemini-api/docs/pricing)
127 | 
128 | It’s important to highlight that when using an API key, you pay per token/call.
129 | This can be more expensive for many small calls with few tokens, but it's the
130 | only way to ensure your workflow isn't interrupted by quota limits.
131 | 
132 | ## Gemini for Workspace plans
133 | 
134 | These plans currently apply only to the use of Gemini web-based products
135 | provided by Google-based experiences (for example, the Gemini web app or the
136 | Flow video editor). These plans do not apply to the API usage which powers the
137 | Gemini CLI. Supporting these plans is under active consideration for future
138 | support.
139 | 
140 | ## Tips to Avoid High Costs
141 | 
142 | When using a Pay as you Go API key, be mindful of your usage to avoid unexpected
143 | costs.
144 | 
145 | - Don't blindly accept every suggestion, especially for computationally
146 |   intensive tasks like refactoring large codebases.
147 | - Be intentional with your prompts and commands. You are paying per call, so
148 |   think about the most efficient way to get the job done.
149 | 
150 | ## Gemini API vs. Vertex
151 | 
152 | - Gemini API (gemini developer api): This is the fastest way to use the Gemini
153 |   models directly.
154 | - Vertex AI: This is the enterprise-grade platform for building, deploying, and
155 |   managing Gemini models with specific security and control requirements.
156 | 
157 | ## Understanding your usage
158 | 
159 | A summary of model usage is available through the `/stats` command and presented
160 | on exit at the end of a session.
```

releases.md
```
1 | # Gemini CLI Releases
2 | 
3 | ## Release Cadence and Tags
4 | 
5 | We will follow https://semver.org/ as closely as possible but will call out when
6 | or if we have to deviate from it. Our weekly releases will be minor version
7 | increments and any bug or hotfixes between releases will go out as patch
8 | versions on the most recent release.
9 | 
10 | Each Tuesday ~2000 UTC new Stable and Preview releases will be cut. The
11 | promotion flow is:
12 | 
13 | - Code is committed to main and pushed each night to nightly
14 | - After no more than 1 week on main, code is promoted to the `preview` channel
15 | - After 1 week the most recent `preview` channel is promoted to `stable` channel
16 | - Patch fixes will be produced against both `preview` and `stable` as needed,
17 |   with the final 'patch' version number incrementing each time.
18 | 
19 | ### Preview
20 | 
21 | These releases will not have been fully vetted and may contain regressions or
22 | other outstanding issues. Please help us test and install with `preview` tag.
23 | 
24 | ```bash
25 | npm install -g @google/gemini-cli@preview
26 | ```
27 | 
28 | ### Stable
29 | 
30 | This will be the full promotion of last week's release + any bug fixes and
31 | validations. Use `latest` tag.
32 | 
33 | ```bash
34 | npm install -g @google/gemini-cli@latest
35 | ```
36 | 
37 | ### Nightly
38 | 
39 | - New releases will be published each day at UTC 0000. This will be all changes
40 |   from the main branch as represented at time of release. It should be assumed
41 |   there are pending validations and issues. Use `nightly` tag.
42 | 
43 | ```bash
44 | npm install -g @google/gemini-cli@nightly
45 | ```
46 | 
47 | ## Weekly Release Promotion
48 | 
49 | Each Tuesday, the on-call engineer will trigger the "Promote Release" workflow.
50 | This single action automates the entire weekly release process:
51 | 
52 | 1.  **Promotes Preview to Stable:** The workflow identifies the latest `preview`
53 |     release and promotes it to `stable`. This becomes the new `latest` version
54 |     on npm.
55 | 2.  **Promotes Nightly to Preview:** The latest `nightly` release is then
56 |     promoted to become the new `preview` version.
57 | 3.  **Prepares for next Nightly:** A pull request is automatically created and
58 |     merged to bump the version in `main` in preparation for the next nightly
59 |     release.
60 | 
61 | This process ensures a consistent and reliable release cadence with minimal
62 | manual intervention.
63 | 
64 | ### Source of Truth for Versioning
65 | 
66 | To ensure the highest reliability, the release promotion process uses the **NPM
67 | registry as the single source of truth** for determining the current version of
68 | each release channel (`stable`, `preview`, and `nightly`).
69 | 
70 | 1.  **Fetch from NPM:** The workflow begins by querying NPM's `dist-tags`
71 |     (`latest`, `preview`, `nightly`) to get the exact version strings for the
72 |     packages currently available to users.
73 | 2.  **Cross-Check for Integrity:** For each version retrieved from NPM, the
74 |     workflow performs a critical integrity check:
75 |     - It verifies that a corresponding **git tag** exists in the repository.
76 |     - It verifies that a corresponding **GitHub Release** has been created.
77 | 3.  **Halt on Discrepancy:** If either the git tag or the GitHub Release is
78 |     missing for a version listed on NPM, the workflow will immediately fail.
79 |     This strict check prevents promotions from a broken or incomplete previous
80 |     release and alerts the on-call engineer to a release state inconsistency
81 |     that must be manually resolved.
82 | 4.  **Calculate Next Version:** Only after these checks pass does the workflow
83 |     proceed to calculate the next semantic version based on the trusted version
84 |     numbers retrieved from NPM.
85 | 
86 | This NPM-first approach, backed by integrity checks, makes the release process
87 | highly robust and prevents the kinds of versioning discrepancies that can arise
88 | from relying solely on git history or API outputs.
89 | 
90 | ## Manual Releases
91 | 
92 | For situations requiring a release outside of the regular nightly and weekly
93 | promotion schedule, and NOT already covered by patching process, you can use the
94 | `Release: Manual` workflow. This workflow provides a direct way to publish a
95 | specific version from any branch, tag, or commit SHA.
96 | 
97 | ### How to Create a Manual Release
98 | 
99 | 1.  Navigate to the **Actions** tab of the repository.
100 | 2.  Select the **Release: Manual** workflow from the list.
101 | 3.  Click the **Run workflow** dropdown button.
102 | 4.  Fill in the required inputs:
103 |     - **Version**: The exact version to release (e.g., `v0.6.1`). This must be a
104 |       valid semantic version with a `v` prefix.
105 |     - **Ref**: The branch, tag, or full commit SHA to release from.
106 |     - **NPM Channel**: The npm channel to publish to. The options are `preview`,
107 |       `nightly`, `latest` (for stable releases), and `dev`. The default is
108 |       `dev`.
109 |     - **Dry Run**: Leave as `true` to run all steps without publishing, or set
110 |       to `false` to perform a live release.
111 |     - **Force Skip Tests**: Set to `true` to skip the test suite. This is not
112 |       recommended for production releases.
113 |     - **Skip GitHub Release**: Set to `true` to skip creating a GitHub release
114 |       and create an npm release only.
115 | 5.  Click **Run workflow**.
116 | 
117 | The workflow will then proceed to test (if not skipped), build, and publish the
118 | release. If the workflow fails during a non-dry run, it will automatically
119 | create a GitHub issue with the failure details.
120 | 
121 | ## Rollback/Rollforward
122 | 
123 | In the event that a release has a critical regression, you can quickly roll back
124 | to a previous stable version or roll forward to a new patch by changing the npm
125 | `dist-tag`. The `Release: Change Tags` workflow provides a safe and controlled
126 | way to do this.
127 | 
128 | This is the preferred method for both rollbacks and rollforwards, as it does not
129 | require a full release cycle.
130 | 
131 | ### How to Change a Release Tag
132 | 
133 | 1.  Navigate to the **Actions** tab of the repository.
134 | 2.  Select the **Release: Change Tags** workflow from the list.
135 | 3.  Click the **Run workflow** dropdown button.
136 | 4.  Fill in the required inputs:
137 |     - **Version**: The existing package version that you want to point the tag
138 |       to (e.g., `0.5.0-preview-2`). This version **must** already be published
139 |       to the npm registry.
140 |     - **Channel**: The npm `dist-tag` to apply (e.g., `preview`, `stable`).
141 |     - **Dry Run**: Leave as `true` to log the action without making changes, or
142 |       set to `false` to perform the live tag change.
143 | 5.  Click **Run workflow**.
144 | 
145 | The workflow will then run `npm dist-tag add` for both the `@google/gemini-cli`
146 | and `@google/gemini-cli-core` packages, pointing the specified channel to the
147 | specified version.
148 | 
149 | ## Patching
150 | 
151 | If a critical bug that is already fixed on `main` needs to be patched on a
152 | `stable` or `preview` release, the process is now highly automated.
153 | 
154 | ### How to Patch
155 | 
156 | #### 1. Create the Patch Pull Request
157 | 
158 | There are two ways to create a patch pull request:
159 | 
160 | **Option A: From a GitHub Comment (Recommended)**
161 | 
162 | After a pull request containing the fix has been merged, a maintainer can add a
163 | comment on that same PR with the following format:
164 | 
165 | `/patch [channel]`
166 | 
167 | - **channel** (optional):
168 |   - _no channel_ - patches both stable and preview channels (default,
169 |     recommended for most fixes)
170 |   - `both` - patches both stable and preview channels (same as default)
171 |   - `stable` - patches only the stable channel
172 |   - `preview` - patches only the preview channel
173 | 
174 | Examples:
175 | 
176 | - `/patch` (patches both stable and preview - default)
177 | - `/patch both` (patches both stable and preview - explicit)
178 | - `/patch stable` (patches only stable)
179 | - `/patch preview` (patches only preview)
180 | 
181 | The `Release: Patch from Comment` workflow will automatically find the merge
182 | commit SHA and trigger the `Release: Patch (1) Create PR` workflow. If the PR is
183 | not yet merged, it will post a comment indicating the failure.
184 | 
185 | **Option B: Manually Triggering the Workflow**
186 | 
187 | Navigate to the **Actions** tab and run the **Release: Patch (1) Create PR**
188 | workflow.
189 | 
190 | - **Commit**: The full SHA of the commit on `main` that you want to cherry-pick.
191 | - **Channel**: The channel you want to patch (`stable` or `preview`).
192 | 
193 | This workflow will automatically:
194 | 
195 | 1.  Find the latest release tag for the channel.
196 | 2.  Create a release branch from that tag if one doesn't exist (e.g.,
197 |     `release/v0.5.1-pr-12345`).
198 | 3.  Create a new hotfix branch from the release branch.
199 | 4.  Cherry-pick your specified commit into the hotfix branch.
200 | 5.  Create a pull request from the hotfix branch back to the release branch.
201 | 
202 | #### 2. Review and Merge
203 | 
204 | Review the automatically created pull request(s) to ensure the cherry-pick was
205 | successful and the changes are correct. Once approved, merge the pull request.
206 | 
207 | **Security Note:** The `release/*` branches are protected by branch protection
208 | rules. A pull request to one of these branches requires at least one review from
209 | a code owner before it can be merged. This ensures that no unauthorized code is
210 | released.
211 | 
212 | #### 2.5. Adding Multiple Commits to a Hotfix (Advanced)
213 | 
214 | If you need to include multiple fixes in a single patch release, you can add
215 | additional commits to the hotfix branch after the initial patch PR has been
216 | created:
217 | 
218 | 1. **Start with the primary fix**: Use `/patch` (or `/patch both`) on the most
219 |    important PR to create the initial hotfix branch and PR.
220 | 
221 | 2. **Checkout the hotfix branch locally**:
222 | 
223 |    ```bash
224 |    git fetch origin
225 |    git checkout hotfix/v0.5.1/stable/cherry-pick-abc1234  # Use the actual branch name from the PR
226 |    ```
227 | 
228 | 3. **Cherry-pick additional commits**:
229 | 
230 |    ```bash
231 |    git cherry-pick <commit-sha-1>
232 |    git cherry-pick <commit-sha-2>
233 |    # Add as many commits as needed
234 |    ```
235 | 
236 | 4. **Push the updated branch**:
237 | 
238 |    ```bash
239 |    git push origin hotfix/v0.5.1/stable/cherry-pick-abc1234
240 |    ```
241 | 
242 | 5. **Test and review**: The existing patch PR will automatically update with
243 |    your additional commits. Test thoroughly since you're now releasing multiple
244 |    changes together.
245 | 
246 | 6. **Update the PR description**: Consider updating the PR title and description
247 |    to reflect that it includes multiple fixes.
248 | 
249 | This approach allows you to group related fixes into a single patch release
250 | while maintaining full control over what gets included and how conflicts are
251 | resolved.
252 | 
253 | #### 3. Automatic Release
254 | 
255 | Upon merging the pull request, the `Release: Patch (2) Trigger` workflow is
256 | automatically triggered. It will then start the `Release: Patch (3) Release`
257 | workflow, which will:
258 | 
259 | 1.  Build and test the patched code.
260 | 2.  Publish the new patch version to npm.
261 | 3.  Create a new GitHub release with the patch notes.
262 | 
263 | This fully automated process ensures that patches are created and released
264 | consistently and reliably.
265 | 
266 | #### Troubleshooting: Older Branch Workflows
267 | 
268 | **Issue**: If the patch trigger workflow fails with errors like "Resource not
269 | accessible by integration" or references to non-existent workflow files (e.g.,
270 | `patch-release.yml`), this indicates the hotfix branch contains an outdated
271 | version of the workflow files.
272 | 
273 | **Root Cause**: When a PR is merged, GitHub Actions runs the workflow definition
274 | from the **source branch** (the hotfix branch), not from the target branch (the
275 | release branch). If the hotfix branch was created from an older release branch
276 | that predates workflow improvements, it will use the old workflow logic.
277 | 
278 | **Solutions**:
279 | 
280 | **Option 1: Manual Trigger (Quick Fix)** Manually trigger the updated workflow
281 | from the branch with the latest workflow code:
282 | 
283 | ```bash
284 | # For a preview channel patch with tests skipped
285 | gh workflow run release-patch-2-trigger.yml --ref <branch-with-updated-workflow> \
286 |   --field ref="hotfix/v0.6.0-preview.2/preview/cherry-pick-abc1234" \
287 |   --field workflow_ref=<branch-with-updated-workflow> \
288 |   --field dry_run=false \
289 |   --field force_skip_tests=true
290 | 
291 | # For a stable channel patch
292 | gh workflow run release-patch-2-trigger.yml --ref <branch-with-updated-workflow> \
293 |   --field ref="hotfix/v0.5.1/stable/cherry-pick-abc1234" \
294 |   --field workflow_ref=<branch-with-updated-workflow> \
295 |   --field dry_run=false \
296 |   --field force_skip_tests=false
297 | 
298 | # Example using main branch (most common case)
299 | gh workflow run release-patch-2-trigger.yml --ref main \
300 |   --field ref="hotfix/v0.6.0-preview.2/preview/cherry-pick-abc1234" \
301 |   --field workflow_ref=main \
302 |   --field dry_run=false \
303 |   --field force_skip_tests=true
304 | ```
305 | 
306 | **Note**: Replace `<branch-with-updated-workflow>` with the branch containing
307 | the latest workflow improvements (usually `main`, but could be a feature branch
308 | if testing updates).
309 | 
310 | **Option 2: Update the Hotfix Branch** Merge the latest main branch into your
311 | hotfix branch to get the updated workflows:
312 | 
313 | ```bash
314 | git checkout hotfix/v0.6.0-preview.2/preview/cherry-pick-abc1234
315 | git merge main
316 | git push
317 | ```
318 | 
319 | Then close and reopen the PR to retrigger the workflow with the updated version.
320 | 
321 | **Option 3: Direct Release Trigger** Skip the trigger workflow entirely and
322 | directly run the release workflow:
323 | 
324 | ```bash
325 | # Replace channel and release_ref with appropriate values
326 | gh workflow run release-patch-3-release.yml --ref main \
327 |   --field type="preview" \
328 |   --field dry_run=false \
329 |   --field force_skip_tests=true \
330 |   --field release_ref="release/v0.6.0-preview.2"
331 | ```
332 | 
333 | ### Docker
334 | 
335 | We also run a Google cloud build called
336 | [release-docker.yml](../.gcp/release-docker.yml). Which publishes the sandbox
337 | docker to match your release. This will also be moved to GH and combined with
338 | the main release file once service account permissions are sorted out.
339 | 
340 | ## Release Validation
341 | 
342 | After pushing a new release smoke testing should be performed to ensure that the
343 | packages are working as expected. This can be done by installing the packages
344 | locally and running a set of tests to ensure that they are functioning
345 | correctly.
346 | 
347 | - `npx -y @google/gemini-cli@latest --version` to validate the push worked as
348 |   expected if you were not doing a rc or dev tag
349 | - `npx -y @google/gemini-cli@<release tag> --version` to validate the tag pushed
350 |   appropriately
351 | - _This is destructive locally_
352 |   `npm uninstall @google/gemini-cli && npm uninstall -g @google/gemini-cli && npm cache clean --force &&  npm install @google/gemini-cli@<version>`
353 | - Smoke testing a basic run through of exercising a few llm commands and tools
354 |   is recommended to ensure that the packages are working as expected. We'll
355 |   codify this more in the future.
356 | 
357 | ## Local Testing and Validation: Changes to the Packaging and Publishing Process
358 | 
359 | If you need to test the release process without actually publishing to NPM or
360 | creating a public GitHub release, you can trigger the workflow manually from the
361 | GitHub UI.
362 | 
363 | 1.  Go to the
364 |     [Actions tab](https://github.com/google-gemini/gemini-cli/actions/workflows/release-manual.yml)
365 |     of the repository.
366 | 2.  Click on the "Run workflow" dropdown.
367 | 3.  Leave the `dry_run` option checked (`true`).
368 | 4.  Click the "Run workflow" button.
369 | 
370 | This will run the entire release process but will skip the `npm publish` and
371 | `gh release create` steps. You can inspect the workflow logs to ensure
372 | everything is working as expected.
373 | 
374 | It is crucial to test any changes to the packaging and publishing process
375 | locally before committing them. This ensures that the packages will be published
376 | correctly and that they will work as expected when installed by a user.
377 | 
378 | To validate your changes, you can perform a dry run of the publishing process.
379 | This will simulate the publishing process without actually publishing the
380 | packages to the npm registry.
381 | 
382 | ```bash
383 | npm_package_version=9.9.9 SANDBOX_IMAGE_REGISTRY="registry" SANDBOX_IMAGE_NAME="thename" npm run publish:npm --dry-run
384 | ```
385 | 
386 | This command will do the following:
387 | 
388 | 1.  Build all the packages.
389 | 2.  Run all the prepublish scripts.
390 | 3.  Create the package tarballs that would be published to npm.
391 | 4.  Print a summary of the packages that would be published.
392 | 
393 | You can then inspect the generated tarballs to ensure that they contain the
394 | correct files and that the `package.json` files have been updated correctly. The
395 | tarballs will be created in the root of each package's directory (e.g.,
396 | `packages/cli/google-gemini-cli-0.1.6.tgz`).
397 | 
398 | By performing a dry run, you can be confident that your changes to the packaging
399 | process are correct and that the packages will be published successfully.
400 | 
401 | ## Release Deep Dive
402 | 
403 | The release process creates two distinct types of artifacts for different
404 | distribution channels: standard packages for the NPM registry and a single,
405 | self-contained executable for GitHub Releases.
406 | 
407 | Here are the key stages:
408 | 
409 | **Stage 1: Pre-Release Sanity Checks and Versioning**
410 | 
411 | - **What happens:** Before any files are moved, the process ensures the project
412 |   is in a good state. This involves running tests, linting, and type-checking
413 |   (`npm run preflight`). The version number in the root `package.json` and
414 |   `packages/cli/package.json` is updated to the new release version.
415 | 
416 | **Stage 2: Building the Source Code for NPM**
417 | 
418 | - **What happens:** The TypeScript source code in `packages/core/src` and
419 |   `packages/cli/src` is compiled into standard JavaScript.
420 | - **File movement:**
421 |   - `packages/core/src/**/*.ts` -> compiled to -> `packages/core/dist/`
422 |   - `packages/cli/src/**/*.ts` -> compiled to -> `packages/cli/dist/`
423 | - **Why:** The TypeScript code written during development needs to be converted
424 |   into plain JavaScript that can be run by Node.js. The `core` package is built
425 |   first as the `cli` package depends on it.
426 | 
427 | **Stage 3: Publishing Standard Packages to NPM**
428 | 
429 | - **What happens:** The `npm publish` command is run for the
430 |   `@google/gemini-cli-core` and `@google/gemini-cli` packages.
431 | - **Why:** This publishes them as standard Node.js packages. Users installing
432 |   via `npm install -g @google/gemini-cli` will download these packages, and
433 |   `npm` will handle installing the `@google/gemini-cli-core` dependency
434 |   automatically. The code in these packages is not bundled into a single file.
435 | 
436 | **Stage 4: Assembling and Creating the GitHub Release Asset**
437 | 
438 | This stage happens _after_ the NPM publish and creates the single-file
439 | executable that enables `npx` usage directly from the GitHub repository.
440 | 
441 | 1.  **The JavaScript Bundle is Created:**
442 |     - **What happens:** The built JavaScript from both `packages/core/dist` and
443 |       `packages/cli/dist`, along with all third-party JavaScript dependencies,
444 |       are bundled by `esbuild` into a single, executable JavaScript file (e.g.,
445 |       `gemini.js`). The `node-pty` library is excluded from this bundle as it
446 |       contains native binaries.
447 |     - **Why:** This creates a single, optimized file that contains all the
448 |       necessary application code. It simplifies execution for users who want to
449 |       run the CLI without a full `npm install`, as all dependencies (including
450 |       the `core` package) are included directly.
451 | 
452 | 2.  **The `bundle` Directory is Assembled:**
453 |     - **What happens:** A temporary `bundle` folder is created at the project
454 |       root. The single `gemini.js` executable is placed inside it, along with
455 |       other essential files.
456 |     - **File movement:**
457 |       - `gemini.js` (from esbuild) -> `bundle/gemini.js`
458 |       - `README.md` -> `bundle/README.md`
459 |       - `LICENSE` -> `bundle/LICENSE`
460 |       - `packages/cli/src/utils/*.sb` (sandbox profiles) -> `bundle/`
461 |     - **Why:** This creates a clean, self-contained directory with everything
462 |       needed to run the CLI and understand its license and usage.
463 | 
464 | 3.  **The GitHub Release is Created:**
465 |     - **What happens:** The contents of the `bundle` directory, including the
466 |       `gemini.js` executable, are attached as assets to a new GitHub Release.
467 |     - **Why:** This makes the single-file version of the CLI available for
468 |       direct download and enables the
469 |       `npx https://github.com/google-gemini/gemini-cli` command, which downloads
470 |       and runs this specific bundled asset.
471 | 
472 | **Summary of Artifacts**
473 | 
474 | - **NPM:** Publishes standard, un-bundled Node.js packages. The primary artifact
475 |   is the code in `packages/cli/dist`, which depends on
476 |   `@google/gemini-cli-core`.
477 | - **GitHub Release:** Publishes a single, bundled `gemini.js` file that contains
478 |   all dependencies, for easy execution via `npx`.
479 | 
480 | This dual-artifact process ensures that both traditional `npm` users and those
481 | who prefer the convenience of `npx` have an optimized experience.
482 | 
483 | ## Notifications
484 | 
485 | Failing release workflows will automatically create an issue with the label
486 | `release-failure`.
487 | 
488 | A notification will be posted to the maintainer's chat channel when issues with
489 | this type are created.
490 | 
491 | ### Modifying chat notifications
492 | 
493 | Notifications use
494 | [GitHub for Google Chat](https://workspace.google.com/marketplace/app/github_for_google_chat/536184076190).
495 | To modify the notifications, use `/github-settings` within the chat space.
496 | 
497 | > [!WARNING] The following instructions describe a fragile workaround that
498 | > depends on the internal structure of the chat application's UI. It is likely
499 | > to break with future updates.
500 | 
501 | The list of available labels is not currently populated correctly. If you want
502 | to add a label that does not appear alphabetically in the first 30 labels in the
503 | repo, you must use your browser's developer tools to manually modify the UI:
504 | 
505 | 1. Open your browser's developer tools (e.g., Chrome DevTools).
506 | 2. In the `/github-settings` dialog, inspect the list of labels.
507 | 3. Locate one of the `<li>` elements representing a label.
508 | 4. In the HTML, modify the `data-option-value` attribute of that `<li>` element
509 |    to the desired label name (e.g., `release-failure`).
510 | 5. Click on your modified label in the UI to select it, then save your settings.
```

sidebar.json
```
1 | [
2 |   {
3 |     "label": "Overview",
4 |     "items": [
5 |       {
6 |         "label": "Introduction",
7 |         "slug": "docs"
8 |       },
9 |       {
10 |         "label": "Architecture Overview",
11 |         "slug": "docs/architecture"
12 |       }
13 |     ]
14 |   },
15 |   {
16 |     "label": "Get Started",
17 |     "items": [
18 |       {
19 |         "label": "Gemini CLI Quickstart",
20 |         "slug": "docs/get-started"
21 |       },
22 |       {
23 |         "label": "Authentication",
24 |         "slug": "docs/get-started/authentication"
25 |       },
26 |       {
27 |         "label": "Configuration",
28 |         "slug": "docs/get-started/configuration"
29 |       },
30 |       {
31 |         "label": "Installation",
32 |         "slug": "docs/get-started/installation"
33 |       },
34 |       {
35 |         "label": "Examples",
36 |         "slug": "docs/get-started/examples"
37 |       }
38 |     ]
39 |   },
40 |   {
41 |     "label": "CLI",
42 |     "items": [
43 |       {
44 |         "label": "Introduction",
45 |         "slug": "docs/cli"
46 |       },
47 |       {
48 |         "label": "Commands",
49 |         "slug": "docs/cli/commands"
50 |       },
51 |       {
52 |         "label": "Checkpointing",
53 |         "slug": "docs/cli/checkpointing"
54 |       },
55 |       {
56 |         "label": "Custom Commands",
57 |         "slug": "docs/cli/custom-commands"
58 |       },
59 |       {
60 |         "label": "Enterprise",
61 |         "slug": "docs/cli/enterprise"
62 |       },
63 |       {
64 |         "label": "Headless Mode",
65 |         "slug": "docs/cli/headless"
66 |       },
67 |       {
68 |         "label": "Keyboard Shortcuts",
69 |         "slug": "docs/cli/keyboard-shortcuts"
70 |       },
71 |       {
72 |         "label": "Sandbox",
73 |         "slug": "docs/cli/sandbox"
74 |       },
75 |       {
76 |         "label": "Telemetry",
77 |         "slug": "docs/cli/telemetry"
78 |       },
79 |       {
80 |         "label": "Themes",
81 |         "slug": "docs/cli/themes"
82 |       },
83 |       {
84 |         "label": "Token Caching",
85 |         "slug": "docs/cli/token-caching"
86 |       },
87 |       {
88 |         "label": "Trusted Folders",
89 |         "slug": "docs/cli/trusted-folders"
90 |       },
91 |       {
92 |         "label": "Tutorials",
93 |         "slug": "docs/cli/tutorials"
94 |       },
95 |       {
96 |         "label": "Uninstall",
97 |         "slug": "docs/cli/uninstall"
98 |       }
99 |     ]
100 |   },
101 |   {
102 |     "label": "Core",
103 |     "items": [
104 |       {
105 |         "label": "Introduction",
106 |         "slug": "docs/core"
107 |       },
108 |       {
109 |         "label": "Tools API",
110 |         "slug": "docs/core/tools-api"
111 |       },
112 |       {
113 |         "label": "Memory Import Processor",
114 |         "slug": "docs/core/memport"
115 |       }
116 |     ]
117 |   },
118 |   {
119 |     "label": "Tools",
120 |     "items": [
121 |       {
122 |         "label": "Introduction",
123 |         "slug": "docs/tools"
124 |       },
125 |       {
126 |         "label": "File System",
127 |         "slug": "docs/tools/file-system"
128 |       },
129 |       {
130 |         "label": "Multi-File Read",
131 |         "slug": "docs/tools/multi-file"
132 |       },
133 |       {
134 |         "label": "Shell",
135 |         "slug": "docs/tools/shell"
136 |       },
137 |       {
138 |         "label": "Web Fetch",
139 |         "slug": "docs/tools/web-fetch"
140 |       },
141 |       {
142 |         "label": "Web Search",
143 |         "slug": "docs/tools/web-search"
144 |       },
145 |       {
146 |         "label": "Memory",
147 |         "slug": "docs/tools/memory"
148 |       },
149 |       {
150 |         "label": "MCP Servers",
151 |         "slug": "docs/tools/mcp-server"
152 |       }
153 |     ]
154 |   },
155 |   {
156 |     "label": "Extensions",
157 |     "items": [
158 |       {
159 |         "label": "Introduction",
160 |         "slug": "docs/extensions"
161 |       },
162 |       {
163 |         "label": "Get Started with Extensions",
164 |         "slug": "docs/extensions/getting-started-extensions.md"
165 |       },
166 |       {
167 |         "label": "Extension Releasing",
168 |         "slug": "docs/extensions/extension-releasing"
169 |       }
170 |     ]
171 |   },
172 |   {
173 |     "label": "IDE Integration",
174 |     "items": [
175 |       {
176 |         "label": "Introduction",
177 |         "slug": "docs/ide-integration"
178 |       },
179 |       {
180 |         "label": "IDE Companion Spec",
181 |         "slug": "docs/ide-integration/ide-companion-spec"
182 |       }
183 |     ]
184 |   },
185 |   {
186 |     "label": "Development",
187 |     "items": [
188 |       {
189 |         "label": "NPM",
190 |         "slug": "docs/npm"
191 |       },
192 |       {
193 |         "label": "Releases",
194 |         "slug": "docs/releases"
195 |       },
196 |       {
197 |         "label": "Changelog",
198 |         "slug": "docs/changelogs"
199 |       },
200 |       {
201 |         "label": "Integration Tests",
202 |         "slug": "docs/integration-tests"
203 |       },
204 |       {
205 |         "label": "Issue and PR Automation",
206 |         "slug": "docs/issue-and-pr-automation"
207 |       }
208 |     ]
209 |   },
210 |   {
211 |     "label": "Support",
212 |     "items": [
213 |       {
214 |         "label": "FAQ",
215 |         "slug": "docs/faq"
216 |       },
217 |       {
218 |         "label": "Troubleshooting",
219 |         "slug": "docs/troubleshooting"
220 |       },
221 |       {
222 |         "label": "Quota and Pricing",
223 |         "slug": "docs/quota-and-pricing"
224 |       },
225 |       {
226 |         "label": "Terms of Service",
227 |         "slug": "docs/tos-privacy"
228 |       }
229 |     ]
230 |   }
231 | ]
```

tos-privacy.md
```
1 | # Gemini CLI: License, Terms of Service, and Privacy Notices
2 | 
3 | Gemini CLI is an open-source tool that lets you interact with Google's powerful
4 | AI services directly from your command-line interface. The Gemini CLI software
5 | is licensed under the [Apache 2.0 license](/LICENSE). When you use Gemini CLI to
6 | access or use Google’s services, the Terms of Service and Privacy Notices
7 | applicable to those services apply to such access and use.
8 | 
9 | Your Gemini CLI Usage Statistics are handled in accordance with Google's Privacy
10 | Policy.
11 | 
12 | **Note:** See [quotas and pricing](/docs/quota-and-pricing.md) for the quota and
13 | pricing details that apply to your usage of the Gemini CLI.
14 | 
15 | ## Supported authentication methods
16 | 
17 | Your authentication method refers to the method you use to log into and access
18 | Google’s services with Gemini CLI. Supported authentication methods include:
19 | 
20 | - Logging in with your Google account to Gemini Code Assist.
21 | - Using an API key with Gemini Developer API.
22 | - Using an API key with Vertex AI GenAI API.
23 | 
24 | The Terms of Service and Privacy Notices applicable to the aforementioned Google
25 | services are set forth in the table below.
26 | 
27 | If you log in with your Google account and you do not already have a Gemini Code
28 | Assist account associated with your Google account, you will be directed to the
29 | sign up flow for Gemini Code Assist for individuals. If your Google account is
30 | managed by your organization, your administrator may not permit access to Gemini
31 | Code Assist for individuals. Please see the
32 | [Gemini Code Assist for individuals FAQs](https://developers.google.com/gemini-code-assist/resources/faqs)
33 | for further information.
34 | 
35 | | Authentication Method    | Service(s)                   | Terms of Service                                                                                        | Privacy Notice                                                                                |
36 | | :----------------------- | :--------------------------- | :------------------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------------------------- |
37 | | Google Account           | Gemini Code Assist services  | [Terms of Service](https://developers.google.com/gemini-code-assist/resources/privacy-notices)          | [Privacy Notices](https://developers.google.com/gemini-code-assist/resources/privacy-notices) |
38 | | Gemini Developer API Key | Gemini API - Unpaid Services | [Gemini API Terms of Service - Unpaid Services](https://ai.google.dev/gemini-api/terms#unpaid-services) | [Google Privacy Policy](https://policies.google.com/privacy)                                  |
39 | | Gemini Developer API Key | Gemini API - Paid Services   | [Gemini API Terms of Service - Paid Services](https://ai.google.dev/gemini-api/terms#paid-services)     | [Google Privacy Policy](https://policies.google.com/privacy)                                  |
40 | | Vertex AI GenAI API Key  | Vertex AI GenAI API          | [Google Cloud Platform Terms of Service](https://cloud.google.com/terms/service-terms/)                 | [Google Cloud Privacy Notice](https://cloud.google.com/terms/cloud-privacy-notice)            |
41 | 
42 | ## 1. If you have logged in with your Google account to Gemini Code Assist
43 | 
44 | For users who use their Google account to access
45 | [Gemini Code Assist](https://codeassist.google), these Terms of Service and
46 | Privacy Notice documents apply:
47 | 
48 | - Gemini Code Assist for individuals:
49 |   [Google Terms of Service](https://policies.google.com/terms) and
50 |   [Gemini Code Assist for individuals Privacy Notice](https://developers.google.com/gemini-code-assist/resources/privacy-notice-gemini-code-assist-individuals).
51 | - Gemini Code Assist with Google AI Pro or Ultra subscription:
52 |   [Google Terms of Service](https://policies.google.com/terms),
53 |   [Google One Additional Terms of Service](https://one.google.com/terms-of-service)
54 |   and [Google Privacy Policy\*](https://policies.google.com/privacy).
55 | - Gemini Code Assist Standard and Enterprise editions:
56 |   [Google Cloud Platform Terms of Service](https://cloud.google.com/terms) and
57 |   [Google Cloud Privacy Notice](https://cloud.google.com/terms/cloud-privacy-notice).
58 | 
59 | _\* If your account is also associated with an active subscription to Gemini
60 | Code Assist Standard or Enterprise edition, the terms and privacy policy of
61 | Gemini Code Assist Standard or Enterprise edition will apply to all your use of
62 | Gemini Code Assist._
63 | 
64 | ## 2. If you have logged in with a Gemini API key to the Gemini Developer API
65 | 
66 | If you are using a Gemini API key for authentication with the
67 | [Gemini Developer API](https://ai.google.dev/gemini-api/docs), these Terms of
68 | Service and Privacy Notice documents apply:
69 | 
70 | - Terms of Service: Your use of the Gemini CLI is governed by the
71 |   [Gemini API Terms of Service](https://ai.google.dev/gemini-api/terms). These
72 |   terms may differ depending on whether you are using an unpaid or paid service:
73 |   - For unpaid services, refer to the
74 |     [Gemini API Terms of Service - Unpaid Services](https://ai.google.dev/gemini-api/terms#unpaid-services).
75 |   - For paid services, refer to the
76 |     [Gemini API Terms of Service - Paid Services](https://ai.google.dev/gemini-api/terms#paid-services).
77 | - Privacy Notice: The collection and use of your data is described in the
78 |   [Google Privacy Policy](https://policies.google.com/privacy).
79 | 
80 | ## 3. If you have logged in with a Gemini API key to the Vertex AI GenAI API
81 | 
82 | If you are using a Gemini API key for authentication with a
83 | [Vertex AI GenAI API](https://cloud.google.com/vertex-ai/generative-ai/docs/reference/rest)
84 | backend, these Terms of Service and Privacy Notice documents apply:
85 | 
86 | - Terms of Service: Your use of the Gemini CLI is governed by the
87 |   [Google Cloud Platform Service Terms](https://cloud.google.com/terms/service-terms/).
88 | - Privacy Notice: The collection and use of your data is described in the
89 |   [Google Cloud Privacy Notice](https://cloud.google.com/terms/cloud-privacy-notice).
90 | 
91 | ## Usage statistics opt-out
92 | 
93 | You may opt-out from sending Gemini CLI Usage Statistics to Google by following
94 | the instructions available here:
95 | [Usage Statistics Configuration](https://github.com/google-gemini/gemini-cli/blob/main/docs/get-started/configuration.md#usage-statistics).
```

troubleshooting.md
```
1 | # Troubleshooting guide
2 | 
3 | This guide provides solutions to common issues and debugging tips, including
4 | topics on:
5 | 
6 | - Authentication or login errors
7 | - Frequently asked questions (FAQs)
8 | - Debugging tips
9 | - Existing GitHub Issues similar to yours or creating new Issues
10 | 
11 | ## Authentication or login errors
12 | 
13 | - **Error: `Failed to login. Message: Request contains an invalid argument`**
14 |   - Users with Google Workspace accounts or Google Cloud accounts associated
15 |     with their Gmail accounts may not be able to activate the free tier of the
16 |     Google Code Assist plan.
17 |   - For Google Cloud accounts, you can work around this by setting
18 |     `GOOGLE_CLOUD_PROJECT` to your project ID.
19 |   - Alternatively, you can obtain the Gemini API key from
20 |     [Google AI Studio](http://aistudio.google.com/app/apikey), which also
21 |     includes a separate free tier.
22 | 
23 | - **Error: `UNABLE_TO_GET_ISSUER_CERT_LOCALLY` or
24 |   `unable to get local issuer certificate`**
25 |   - **Cause:** You may be on a corporate network with a firewall that intercepts
26 |     and inspects SSL/TLS traffic. This often requires a custom root CA
27 |     certificate to be trusted by Node.js.
28 |   - **Solution:** Set the `NODE_EXTRA_CA_CERTS` environment variable to the
29 |     absolute path of your corporate root CA certificate file.
30 |     - Example: `export NODE_EXTRA_CA_CERTS=/path/to/your/corporate-ca.crt`
31 | 
32 | ## Common error messages and solutions
33 | 
34 | - **Error: `EADDRINUSE` (Address already in use) when starting an MCP server.**
35 |   - **Cause:** Another process is already using the port that the MCP server is
36 |     trying to bind to.
37 |   - **Solution:** Either stop the other process that is using the port or
38 |     configure the MCP server to use a different port.
39 | 
40 | - **Error: Command not found (when attempting to run Gemini CLI with
41 |   `gemini`).**
42 |   - **Cause:** Gemini CLI is not correctly installed or it is not in your
43 |     system's `PATH`.
44 |   - **Solution:** The update depends on how you installed Gemini CLI:
45 |     - If you installed `gemini` globally, check that your `npm` global binary
46 |       directory is in your `PATH`. You can update Gemini CLI using the command
47 |       `npm install -g @google/gemini-cli@latest`.
48 |     - If you are running `gemini` from source, ensure you are using the correct
49 |       command to invoke it (e.g., `node packages/cli/dist/index.js ...`). To
50 |       update Gemini CLI, pull the latest changes from the repository, and then
51 |       rebuild using the command `npm run build`.
52 | 
53 | - **Error: `MODULE_NOT_FOUND` or import errors.**
54 |   - **Cause:** Dependencies are not installed correctly, or the project hasn't
55 |     been built.
56 |   - **Solution:**
57 |     1.  Run `npm install` to ensure all dependencies are present.
58 |     2.  Run `npm run build` to compile the project.
59 |     3.  Verify that the build completed successfully with `npm run start`.
60 | 
61 | - **Error: "Operation not permitted", "Permission denied", or similar.**
62 |   - **Cause:** When sandboxing is enabled, Gemini CLI may attempt operations
63 |     that are restricted by your sandbox configuration, such as writing outside
64 |     the project directory or system temp directory.
65 |   - **Solution:** Refer to the [Configuration: Sandboxing](./cli/sandbox.md)
66 |     documentation for more information, including how to customize your sandbox
67 |     configuration.
68 | 
69 | - **Gemini CLI is not running in interactive mode in "CI" environments**
70 |   - **Issue:** The Gemini CLI does not enter interactive mode (no prompt
71 |     appears) if an environment variable starting with `CI_` (e.g., `CI_TOKEN`)
72 |     is set. This is because the `is-in-ci` package, used by the underlying UI
73 |     framework, detects these variables and assumes a non-interactive CI
74 |     environment.
75 |   - **Cause:** The `is-in-ci` package checks for the presence of `CI`,
76 |     `CONTINUOUS_INTEGRATION`, or any environment variable with a `CI_` prefix.
77 |     When any of these are found, it signals that the environment is
78 |     non-interactive, which prevents the Gemini CLI from starting in its
79 |     interactive mode.
80 |   - **Solution:** If the `CI_` prefixed variable is not needed for the CLI to
81 |     function, you can temporarily unset it for the command. e.g.,
82 |     `env -u CI_TOKEN gemini`
83 | 
84 | - **DEBUG mode not working from project .env file**
85 |   - **Issue:** Setting `DEBUG=true` in a project's `.env` file doesn't enable
86 |     debug mode for gemini-cli.
87 |   - **Cause:** The `DEBUG` and `DEBUG_MODE` variables are automatically excluded
88 |     from project `.env` files to prevent interference with gemini-cli behavior.
89 |   - **Solution:** Use a `.gemini/.env` file instead, or configure the
90 |     `advanced.excludedEnvVars` setting in your `settings.json` to exclude fewer
91 |     variables.
92 | 
93 | ## Exit Codes
94 | 
95 | The Gemini CLI uses specific exit codes to indicate the reason for termination.
96 | This is especially useful for scripting and automation.
97 | 
98 | | Exit Code | Error Type                 | Description                                                                                         |
99 | | --------- | -------------------------- | --------------------------------------------------------------------------------------------------- |
100 | | 41        | `FatalAuthenticationError` | An error occurred during the authentication process.                                                |
101 | | 42        | `FatalInputError`          | Invalid or missing input was provided to the CLI. (non-interactive mode only)                       |
102 | | 44        | `FatalSandboxError`        | An error occurred with the sandboxing environment (e.g., Docker, Podman, or Seatbelt).              |
103 | | 52        | `FatalConfigError`         | A configuration file (`settings.json`) is invalid or contains errors.                               |
104 | | 53        | `FatalTurnLimitedError`    | The maximum number of conversational turns for the session was reached. (non-interactive mode only) |
105 | 
106 | ## Debugging Tips
107 | 
108 | - **CLI debugging:**
109 |   - Use the `--verbose` flag (if available) with CLI commands for more detailed
110 |     output.
111 |   - Check the CLI logs, often found in a user-specific configuration or cache
112 |     directory.
113 | 
114 | - **Core debugging:**
115 |   - Check the server console output for error messages or stack traces.
116 |   - Increase log verbosity if configurable.
117 |   - Use Node.js debugging tools (e.g., `node --inspect`) if you need to step
118 |     through server-side code.
119 | 
120 | - **Tool issues:**
121 |   - If a specific tool is failing, try to isolate the issue by running the
122 |     simplest possible version of the command or operation the tool performs.
123 |   - For `run_shell_command`, check that the command works directly in your shell
124 |     first.
125 |   - For _file system tools_, verify that paths are correct and check the
126 |     permissions.
127 | 
128 | - **Pre-flight checks:**
129 |   - Always run `npm run preflight` before committing code. This can catch many
130 |     common issues related to formatting, linting, and type errors.
131 | 
132 | ## Existing GitHub Issues similar to yours or creating new Issues
133 | 
134 | If you encounter an issue that was not covered here in this _Troubleshooting
135 | guide_, consider searching the Gemini CLI
136 | [Issue tracker on GitHub](https://github.com/google-gemini/gemini-cli/issues).
137 | If you can't find an issue similar to yours, consider creating a new GitHub
138 | Issue with a detailed description. Pull requests are also welcome!
```

core/index.md
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

core/memport.md
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

core/tools-api.md
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

cli/authentication.md
```
1 | # Authentication Setup
2 | 
3 | See: [Getting Started - Authentication Setup](../get-started/authentication.md).
```

cli/checkpointing.md
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

cli/commands.md
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

cli/custom-commands.md
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

cli/enterprise.md
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

cli/gemini-ignore.md
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

cli/gemini-md.md
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

cli/headless.md
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

cli/index.md
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

cli/keyboard-shortcuts.md
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

cli/sandbox.md
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

cli/telemetry.md
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

cli/themes.md
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

cli/trusted-folders.md
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

cli/tutorials.md
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

cli/uninstall.md
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

examples/proxy-script.md
```
1 | # Example Proxy Script
2 | 
3 | The following is an example of a proxy script that can be used with the
4 | `GEMINI_SANDBOX_PROXY_COMMAND` environment variable. This script only allows
5 | `HTTPS` connections to `example.com:443` and declines all other requests.
6 | 
7 | ```javascript
8 | #!/usr/bin/env node
9 | 
10 | /**
11 |  * @license
12 |  * Copyright 2025 Google LLC
13 |  * SPDX-License-Identifier: Apache-2.0
14 |  */
15 | 
16 | // Example proxy server that listens on :::8877 and only allows HTTPS connections to example.com.
17 | // Set `GEMINI_SANDBOX_PROXY_COMMAND=scripts/example-proxy.js` to run proxy alongside sandbox
18 | // Test via `curl https://example.com` inside sandbox (in shell mode or via shell tool)
19 | 
20 | import http from 'node:http';
21 | import net from 'node:net';
22 | import { URL } from 'node:url';
23 | import console from 'node:console';
24 | 
25 | const PROXY_PORT = 8877;
26 | const ALLOWED_DOMAINS = ['example.com', 'googleapis.com'];
27 | const ALLOWED_PORT = '443';
28 | 
29 | const server = http.createServer((req, res) => {
30 |   // Deny all requests other than CONNECT for HTTPS
31 |   console.log(
32 |     `[PROXY] Denying non-CONNECT request for: ${req.method} ${req.url}`,
33 |   );
34 |   res.writeHead(405, { 'Content-Type': 'text/plain' });
35 |   res.end('Method Not Allowed');
36 | });
37 | 
38 | server.on('connect', (req, clientSocket, head) => {
39 |   // req.url will be in the format "hostname:port" for a CONNECT request.
40 |   const { port, hostname } = new URL(`http://${req.url}`);
41 | 
42 |   console.log(`[PROXY] Intercepted CONNECT request for: ${hostname}:${port}`);
43 | 
44 |   if (
45 |     ALLOWED_DOMAINS.some(
46 |       (domain) => hostname == domain || hostname.endsWith(`.${domain}`),
47 |     ) &&
48 |     port === ALLOWED_PORT
49 |   ) {
50 |     console.log(`[PROXY] Allowing connection to ${hostname}:${port}`);
51 | 
52 |     // Establish a TCP connection to the original destination.
53 |     const serverSocket = net.connect(port, hostname, () => {
54 |       clientSocket.write('HTTP/1.1 200 Connection Established\r\n\r\n');
55 |       // Create a tunnel by piping data between the client and the destination server.
56 |       serverSocket.write(head);
57 |       serverSocket.pipe(clientSocket);
58 |       clientSocket.pipe(serverSocket);
59 |     });
60 | 
61 |     serverSocket.on('error', (err) => {
62 |       console.error(`[PROXY] Error connecting to destination: ${err.message}`);
63 |       clientSocket.end(`HTTP/1.1 502 Bad Gateway\r\n\r\n`);
64 |     });
65 |   } else {
66 |     console.log(`[PROXY] Denying connection to ${hostname}:${port}`);
67 |     clientSocket.end('HTTP/1.1 403 Forbidden\r\n\r\n');
68 |   }
69 | 
70 |   clientSocket.on('error', (err) => {
71 |     // This can happen if the client hangs up.
72 |     console.error(`[PROXY] Client socket error: ${err.message}`);
73 |   });
74 | });
75 | 
76 | server.listen(PROXY_PORT, () => {
77 |   const address = server.address();
78 |   console.log(`[PROXY] Proxy listening on ${address.address}:${address.port}`);
79 |   console.log(
80 |     `[PROXY] Allowing HTTPS connections to domains: ${ALLOWED_DOMAINS.join(', ')}`,
81 |   );
82 | });
83 | ```
```

get-started/authentication.md
```
1 | # Gemini CLI Authentication Setup
2 | 
3 | Gemini CLI requires authentication using Google's services. Before using Gemini
4 | CLI, configure **one** of the following authentication methods:
5 | 
6 | - Interactive mode:
7 |   - Recommended: Login with Google
8 |   - Use Gemini API key
9 |   - Use Vertex AI
10 | - Headless (non-interactive) mode
11 | - Google Cloud Shell
12 | 
13 | ## Quick Check: Running in Google Cloud Shell?
14 | 
15 | If you are running the Gemini CLI within a Google Cloud Shell environment,
16 | authentication is typically automatic using your Cloud Shell credentials.
17 | 
18 | ## Authenticate in Interactive mode
19 | 
20 | When you run Gemini CLI through the command-line, Gemini CLI will provide the
21 | following options:
22 | 
23 | ```bash
24 | > 1. Login with Google
25 | > 2. Use Gemini API key
26 | > 3. Vertex AI
27 | ```
28 | 
29 | The following sections provide instructions for each of these authentication
30 | options.
31 | 
32 | ### Recommended: Login with Google
33 | 
34 | If you are running Gemini CLI on your local machine, the simplest method is
35 | logging in with your Google account.
36 | 
37 | > **Important:** Use this method if you are a **Google AI Pro** or **Google AI
38 | > Ultra** subscriber.
39 | 
40 | 1. Select **Login with Google**. Gemini CLI will open a login prompt using your
41 |    web browser.
42 | 
43 |    If you are a **Google AI Pro** or **Google AI Ultra** subscriber, login with
44 |    the Google account associated with your subscription.
45 | 
46 | 2. Follow the on-screen instructions. Your credentials will be cached locally
47 |    for future sessions.
48 | 
49 |    > **Note:** This method requires a web browser on a machine that can
50 |    > communicate with the terminal running the CLI (e.g., your local machine).
51 |    > The browser will be redirected to a `localhost` URL that the CLI listens on
52 |    > during setup.
53 | 
54 | #### (Optional) Set your Google Cloud Project
55 | 
56 | When you log in using a Google account, you may be prompted to select a
57 | `GOOGLE_CLOUD_PROJECT`.
58 | 
59 | This can be necessary if you are:
60 | 
61 | - Using a Google Workspace account.
62 | - Using a Gemini Code Assist license from the Google Developer Program.
63 | - Using a license from a Gemini Code Assist subscription.
64 | - Using the product outside the
65 |   [supported regions](https://developers.google.com/gemini-code-assist/resources/available-locations)
66 |   for free individual usage.
67 | - A Google account holder under the age of 18.
68 | 
69 | If you fall into one of these categories, you must:
70 | 
71 | 1.  Have a Google Cloud Project ID.
72 | 2.  [Enable the Gemini for Cloud API](https://cloud.google.com/gemini/docs/discover/set-up-gemini#enable-api).
73 | 3.  [Configure necessary IAM access permissions](https://cloud.google.com/gemini/docs/discover/set-up-gemini#grant-iam).
74 | 
75 | To set the project ID, you can export either the `GOOGLE_CLOUD_PROJECT` or
76 | `GOOGLE_CLOUD_PROJECT_ID` environment variable. The CLI checks for
77 | `GOOGLE_CLOUD_PROJECT` first, then falls back to `GOOGLE_CLOUD_PROJECT_ID` :
78 | 
79 | ```bash
80 | # Replace YOUR_PROJECT_ID with your actual Google Cloud Project ID
81 | # Using the standard variable:
82 | export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
83 | 
84 | # Or, using the fallback variable:
85 | export GOOGLE_CLOUD_PROJECT_ID="YOUR_PROJECT_ID"
86 | ```
87 | 
88 | To make this setting persistent, see
89 | [Persisting Environment Variables](#persisting-environment-variables).
90 | 
91 | ### Use Gemini API Key
92 | 
93 | If you don't want to authenticate using your Google account, you can use an API
94 | key from Google AI Studio.
95 | 
96 | 1.  Obtain your API key from
97 |     [Google AI Studio](https://aistudio.google.com/app/apikey).
98 | 2.  Set the `GEMINI_API_KEY` environment variable:
99 | 
100 |     ```bash
101 |     # Replace YOUR_GEMINI_API_KEY with the key from AI Studio
102 |     export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"
103 |     ```
104 | 
105 | To make this setting persistent, see
106 | [Persisting Environment Variables](#persisting-environment-variables).
107 | 
108 | > **Warning:** Treat API keys, especially for services like Gemini, as sensitive
109 | > credentials. Protect them to prevent unauthorized access and potential misuse
110 | > of the service under your account.
111 | 
112 | ### Use Vertex AI
113 | 
114 | If you intend to use Google Cloud's Vertex AI platform, you have several
115 | authentication options:
116 | 
117 | - Application Default Credentials (ADC) and `gcloud`.
118 | - A Service Account JSON key.
119 | - A Google Cloud API key.
120 | 
121 | #### First: Set required environment variables
122 | 
123 | Regardless of your method of authentication, you'll typically need to set the
124 | following variables: `GOOGLE_CLOUD_PROJECT` (or `GOOGLE_CLOUD_PROJECT_ID`) and
125 | `GOOGLE_CLOUD_LOCATION`.
126 | 
127 | To set these variables:
128 | 
129 | ```bash
130 | # Replace with your project ID and desired location (e.g., us-central1)
131 | # You can use GOOGLE_CLOUD_PROJECT_ID as a fallback for GOOGLE_CLOUD_PROJECT
132 | export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
133 | export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"
134 | ```
135 | 
136 | #### A. Vertex AI - Application Default Credentials (ADC) using `gcloud`
137 | 
138 | Consider this method of authentication if you have Google Cloud CLI installed.
139 | 
140 | > **Note:** If you have previously set `GOOGLE_API_KEY` or `GEMINI_API_KEY`, you
141 | > must unset them to use ADC:
142 | 
143 | ```bash
144 | unset GOOGLE_API_KEY GEMINI_API_KEY
145 | ```
146 | 
147 | 1.  Ensure you have a Google Cloud project and Vertex AI API is enabled.
148 | 2.  Log in to Google Cloud:
149 | 
150 |     ```bash
151 |     gcloud auth application-default login
152 |     ```
153 | 
154 |     See
155 |     [Set up Application Default Credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc)
156 |     for details.
157 | 
158 | 3.  Ensure `GOOGLE_CLOUD_PROJECT` (or `GOOGLE_CLOUD_PROJECT_ID`) and
159 |     `GOOGLE_CLOUD_LOCATION` are set.
160 | 
161 | #### B. Vertex AI - Service Account JSON key
162 | 
163 | Consider this method of authentication in non-interactive environments, CI/CD,
164 | or if your organization restricts user-based ADC or API key creation.
165 | 
166 | > **Note:** If you have previously set `GOOGLE_API_KEY` or `GEMINI_API_KEY`, you
167 | > must unset them:
168 | 
169 | ```bash
170 | unset GOOGLE_API_KEY GEMINI_API_KEY
171 | ```
172 | 
173 | 1.  [Create a service account and key](https://cloud.google.com/iam/docs/keys-create-delete)
174 |     and download the provided JSON file. Assign the "Vertex AI User" role to the
175 |     service account.
176 | 2.  Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the JSON
177 |     file's absolute path:
178 | 
179 |     ```bash
180 |     # Replace /path/to/your/keyfile.json with the actual path
181 |     export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/keyfile.json"
182 |     ```
183 | 
184 | 3.  Ensure `GOOGLE_CLOUD_PROJECT` (or `GOOGLE_CLOUD_PROJECT_ID`) and
185 |     `GOOGLE_CLOUD_LOCATION` are set.
186 | 
187 | > **Warning:** Protect your service account key file as it provides access to
188 | > your resources.
189 | 
190 | #### C. Vertex AI - Google Cloud API key
191 | 
192 | 1.  Obtain a Google Cloud API key:
193 |     [Get an API Key](https://cloud.google.com/vertex-ai/generative-ai/docs/start/api-keys?usertype=newuser).
194 | 2.  Set the `GOOGLE_API_KEY` environment variable:
195 | 
196 |     ```bash
197 |     # Replace YOUR_GOOGLE_API_KEY with your Vertex AI API key
198 |     export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"
199 |     ```
200 | 
201 |     > **Note:** If you see errors like
202 |     > `"API keys are not supported by this API..."`, your organization might
203 |     > restrict API key usage for this service. Try the
204 |     > [Service Account JSON Key](#b-vertex-ai-service-account-json-key) or
205 |     > [ADC](#a-vertex-ai-application-default-credentials-adc-using-gcloud)
206 |     > methods instead.
207 | 
208 | To make any of these Vertex AI environment variable settings persistent, see
209 | [Persisting Environment Variables](#persisting-environment-variables).
210 | 
211 | ## Persisting Environment Variables
212 | 
213 | To avoid setting environment variables in every terminal session, you can:
214 | 
215 | 1.  **Add your environment variables to your shell configuration file:** Append
216 |     the `export ...` commands to your shell's startup file (e.g., `~/.bashrc`,
217 |     `~/.zshrc`, or `~/.profile`) and reload your shell (e.g.,
218 |     `source ~/.bashrc`).
219 | 
220 |     ```bash
221 |     # Example for .bashrc
222 |     echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.bashrc
223 |     source ~/.bashrc
224 |     ```
225 | 
226 |     > **Warning:** Be advised that when you export API keys or service account
227 |     > paths in your shell configuration file, any process executed from the
228 |     > shell can potentially read them.
229 | 
230 | 2.  **Use a `.env` file:** Create a `.gemini/.env` file in your project
231 |     directory or home directory. Gemini CLI automatically loads variables from
232 |     the first `.env` file it finds, searching up from the current directory,
233 |     then in `~/.gemini/.env` or `~/.env`. `.gemini/.env` is recommended.
234 | 
235 |     Example for user-wide settings:
236 | 
237 |     ```bash
238 |     mkdir -p ~/.gemini
239 |     cat >> ~/.gemini/.env <<'EOF'
240 |     GOOGLE_CLOUD_PROJECT="your-project-id"
241 |     # Add other variables like GEMINI_API_KEY as needed
242 |     EOF
243 |     ```
244 | 
245 |     Variables are loaded from the first file found, not merged.
246 | 
247 | ## Non-interactive mode / headless environments
248 | 
249 | Non-interative mode / headless environments will use your existing
250 | authentication method, if an existing authentication credential is cached.
251 | 
252 | If you have not already logged in with an authentication credential (such as a
253 | Google account), you **must** configure authentication using environment
254 | variables:
255 | 
256 | 1.  **Gemini API Key:** Set `GEMINI_API_KEY`.
257 | 2.  **Vertex AI:**
258 |     - Set `GOOGLE_GENAI_USE_VERTEXAI=true`.
259 |     - **With Google Cloud API Key:** Set `GOOGLE_API_KEY`.
260 |     - **With ADC:** Ensure ADC is configured (e.g., via a service account with
261 |       `GOOGLE_APPLICATION_CREDENTIALS`) and set `GOOGLE_CLOUD_PROJECT` (or
262 |       `GOOGLE_CLOUD_PROJECT_ID`) and `GOOGLE_CLOUD_LOCATION`.
263 | 
264 | The CLI will exit with an error in non-interactive mode if no suitable
265 | environment variables are found.
266 | 
267 | ## What's next?
268 | 
269 | Your authentication method affects your quotas, pricing, Terms of Service, and
270 | privacy notices. Review the following pages to learn more:
271 | 
272 | - [Gemini CLI: Quotas and Pricing](../quota-and-pricing.md).
273 | - [Gemini CLI: Terms of Service and Privacy Notice](../tos-privacy.md).
```

get-started/configuration-v1.md
```
1 | # Gemini CLI Configuration
2 | 
3 | **Note on Deprecated Configuration Format**
4 | 
5 | This document describes the legacy v1 format for the `settings.json` file. This
6 | format is now deprecated.
7 | 
8 | - The new format will be supported in the stable release starting
9 |   **[09/10/25]**.
10 | - Automatic migration from the old format to the new format will begin on
11 |   **[09/17/25]**.
12 | 
13 | For details on the new, recommended format, please see the
14 | [current Configuration documentation](./configuration.md).
15 | 
16 | Gemini CLI offers several ways to configure its behavior, including environment
17 | variables, command-line arguments, and settings files. This document outlines
18 | the different configuration methods and available settings.
19 | 
20 | ## Configuration layers
21 | 
22 | Configuration is applied in the following order of precedence (lower numbers are
23 | overridden by higher numbers):
24 | 
25 | 1.  **Default values:** Hardcoded defaults within the application.
26 | 2.  **System defaults file:** System-wide default settings that can be
27 |     overridden by other settings files.
28 | 3.  **User settings file:** Global settings for the current user.
29 | 4.  **Project settings file:** Project-specific settings.
30 | 5.  **System settings file:** System-wide settings that override all other
31 |     settings files.
32 | 6.  **Environment variables:** System-wide or session-specific variables,
33 |     potentially loaded from `.env` files.
34 | 7.  **Command-line arguments:** Values passed when launching the CLI.
35 | 
36 | ## Settings files
37 | 
38 | Gemini CLI uses JSON settings files for persistent configuration. There are four
39 | locations for these files:
40 | 
41 | - **System defaults file:**
42 |   - **Location:** `/etc/gemini-cli/system-defaults.json` (Linux),
43 |     `C:\ProgramData\gemini-cli\system-defaults.json` (Windows) or
44 |     `/Library/Application Support/GeminiCli/system-defaults.json` (macOS). The
45 |     path can be overridden using the `GEMINI_CLI_SYSTEM_DEFAULTS_PATH`
46 |     environment variable.
47 |   - **Scope:** Provides a base layer of system-wide default settings. These
48 |     settings have the lowest precedence and are intended to be overridden by
49 |     user, project, or system override settings.
50 | - **User settings file:**
51 |   - **Location:** `~/.gemini/settings.json` (where `~` is your home directory).
52 |   - **Scope:** Applies to all Gemini CLI sessions for the current user. User
53 |     settings override system defaults.
54 | - **Project settings file:**
55 |   - **Location:** `.gemini/settings.json` within your project's root directory.
56 |   - **Scope:** Applies only when running Gemini CLI from that specific project.
57 |     Project settings override user settings and system defaults.
58 | - **System settings file:**
59 |   - **Location:** `/etc/gemini-cli/settings.json` (Linux),
60 |     `C:\ProgramData\gemini-cli\settings.json` (Windows) or
61 |     `/Library/Application Support/GeminiCli/settings.json` (macOS). The path can
62 |     be overridden using the `GEMINI_CLI_SYSTEM_SETTINGS_PATH` environment
63 |     variable.
64 |   - **Scope:** Applies to all Gemini CLI sessions on the system, for all users.
65 |     System settings act as overrides, taking precedence over all other settings
66 |     files. May be useful for system administrators at enterprises to have
67 |     controls over users' Gemini CLI setups.
68 | 
69 | **Note on environment variables in settings:** String values within your
70 | `settings.json` files can reference environment variables using either
71 | `$VAR_NAME` or `${VAR_NAME}` syntax. These variables will be automatically
72 | resolved when the settings are loaded. For example, if you have an environment
73 | variable `MY_API_TOKEN`, you could use it in `settings.json` like this:
74 | `"apiKey": "$MY_API_TOKEN"`.
75 | 
76 | > **Note for Enterprise Users:** For guidance on deploying and managing Gemini
77 | > CLI in a corporate environment, please see the
78 | > [Enterprise Configuration](../cli/enterprise.md) documentation.
79 | 
80 | ### The `.gemini` directory in your project
81 | 
82 | In addition to a project settings file, a project's `.gemini` directory can
83 | contain other project-specific files related to Gemini CLI's operation, such as:
84 | 
85 | - [Custom sandbox profiles](#sandboxing) (e.g.,
86 |   `.gemini/sandbox-macos-custom.sb`, `.gemini/sandbox.Dockerfile`).
87 | 
88 | ### Available settings in `settings.json`:
89 | 
90 | - **`contextFileName`** (string or array of strings):
91 |   - **Description:** Specifies the filename for context files (e.g.,
92 |     `GEMINI.md`, `AGENTS.md`). Can be a single filename or a list of accepted
93 |     filenames.
94 |   - **Default:** `GEMINI.md`
95 |   - **Example:** `"contextFileName": "AGENTS.md"`
96 | 
97 | - **`bugCommand`** (object):
98 |   - **Description:** Overrides the default URL for the `/bug` command.
99 |   - **Default:**
100 |     `"urlTemplate": "https://github.com/google-gemini/gemini-cli/issues/new?template=bug_report.yml&title={title}&info={info}"`
101 |   - **Properties:**
102 |     - **`urlTemplate`** (string): A URL that can contain `{title}` and `{info}`
103 |       placeholders.
104 |   - **Example:**
105 |     ```json
106 |     "bugCommand": {
107 |       "urlTemplate": "https://bug.example.com/new?title={title}&info={info}"
108 |     }
109 |     ```
110 | 
111 | - **`fileFiltering`** (object):
112 |   - **Description:** Controls git-aware file filtering behavior for @ commands
113 |     and file discovery tools.
114 |   - **Default:** `"respectGitIgnore": true, "enableRecursiveFileSearch": true`
115 |   - **Properties:**
116 |     - **`respectGitIgnore`** (boolean): Whether to respect .gitignore patterns
117 |       when discovering files. When set to `true`, git-ignored files (like
118 |       `node_modules/`, `dist/`, `.env`) are automatically excluded from @
119 |       commands and file listing operations.
120 |     - **`enableRecursiveFileSearch`** (boolean): Whether to enable searching
121 |       recursively for filenames under the current tree when completing @
122 |       prefixes in the prompt.
123 |     - **`disableFuzzySearch`** (boolean): When `true`, disables the fuzzy search
124 |       capabilities when searching for files, which can improve performance on
125 |       projects with a large number of files.
126 |   - **Example:**
127 |     ```json
128 |     "fileFiltering": {
129 |       "respectGitIgnore": true,
130 |       "enableRecursiveFileSearch": false,
131 |       "disableFuzzySearch": true
132 |     }
133 |     ```
134 | 
135 | ### Troubleshooting File Search Performance
136 | 
137 | If you are experiencing performance issues with file searching (e.g., with `@`
138 | completions), especially in projects with a very large number of files, here are
139 | a few things you can try in order of recommendation:
140 | 
141 | 1.  **Use `.geminiignore`:** Create a `.geminiignore` file in your project root
142 |     to exclude directories that contain a large number of files that you don't
143 |     need to reference (e.g., build artifacts, logs, `node_modules`). Reducing
144 |     the total number of files crawled is the most effective way to improve
145 |     performance.
146 | 
147 | 2.  **Disable Fuzzy Search:** If ignoring files is not enough, you can disable
148 |     fuzzy search by setting `disableFuzzySearch` to `true` in your
149 |     `settings.json` file. This will use a simpler, non-fuzzy matching algorithm,
150 |     which can be faster.
151 | 
152 | 3.  **Disable Recursive File Search:** As a last resort, you can disable
153 |     recursive file search entirely by setting `enableRecursiveFileSearch` to
154 |     `false`. This will be the fastest option as it avoids a recursive crawl of
155 |     your project. However, it means you will need to type the full path to files
156 |     when using `@` completions.
157 | 
158 | - **`coreTools`** (array of strings):
159 |   - **Description:** Allows you to specify a list of core tool names that should
160 |     be made available to the model. This can be used to restrict the set of
161 |     built-in tools. See [Built-in Tools](../core/tools-api.md#built-in-tools)
162 |     for a list of core tools. You can also specify command-specific restrictions
163 |     for tools that support it, like the `ShellTool`. For example,
164 |     `"coreTools": ["ShellTool(ls -l)"]` will only allow the `ls -l` command to
165 |     be executed.
166 |   - **Default:** All tools available for use by the Gemini model.
167 |   - **Example:** `"coreTools": ["ReadFileTool", "GlobTool", "ShellTool(ls)"]`.
168 | 
169 | - **`allowedTools`** (array of strings):
170 |   - **Default:** `undefined`
171 |   - **Description:** A list of tool names that will bypass the confirmation
172 |     dialog. This is useful for tools that you trust and use frequently. The
173 |     match semantics are the same as `coreTools`.
174 |   - **Example:** `"allowedTools": ["ShellTool(git status)"]`.
175 | 
176 | - **`excludeTools`** (array of strings):
177 |   - **Description:** Allows you to specify a list of core tool names that should
178 |     be excluded from the model. A tool listed in both `excludeTools` and
179 |     `coreTools` is excluded. You can also specify command-specific restrictions
180 |     for tools that support it, like the `ShellTool`. For example,
181 |     `"excludeTools": ["ShellTool(rm -rf)"]` will block the `rm -rf` command.
182 |   - **Default**: No tools excluded.
183 |   - **Example:** `"excludeTools": ["run_shell_command", "findFiles"]`.
184 |   - **Security Note:** Command-specific restrictions in `excludeTools` for
185 |     `run_shell_command` are based on simple string matching and can be easily
186 |     bypassed. This feature is **not a security mechanism** and should not be
187 |     relied upon to safely execute untrusted code. It is recommended to use
188 |     `coreTools` to explicitly select commands that can be executed.
189 | 
190 | - **`allowMCPServers`** (array of strings):
191 |   - **Description:** Allows you to specify a list of MCP server names that
192 |     should be made available to the model. This can be used to restrict the set
193 |     of MCP servers to connect to. Note that this will be ignored if
194 |     `--allowed-mcp-server-names` is set.
195 |   - **Default:** All MCP servers are available for use by the Gemini model.
196 |   - **Example:** `"allowMCPServers": ["myPythonServer"]`.
197 |   - **Security Note:** This uses simple string matching on MCP server names,
198 |     which can be modified. If you're a system administrator looking to prevent
199 |     users from bypassing this, consider configuring the `mcpServers` at the
200 |     system settings level such that the user will not be able to configure any
201 |     MCP servers of their own. This should not be used as an airtight security
202 |     mechanism.
203 | 
204 | - **`excludeMCPServers`** (array of strings):
205 |   - **Description:** Allows you to specify a list of MCP server names that
206 |     should be excluded from the model. A server listed in both
207 |     `excludeMCPServers` and `allowMCPServers` is excluded. Note that this will
208 |     be ignored if `--allowed-mcp-server-names` is set.
209 |   - **Default**: No MCP servers excluded.
210 |   - **Example:** `"excludeMCPServers": ["myNodeServer"]`.
211 |   - **Security Note:** This uses simple string matching on MCP server names,
212 |     which can be modified. If you're a system administrator looking to prevent
213 |     users from bypassing this, consider configuring the `mcpServers` at the
214 |     system settings level such that the user will not be able to configure any
215 |     MCP servers of their own. This should not be used as an airtight security
216 |     mechanism.
217 | 
218 | - **`autoAccept`** (boolean):
219 |   - **Description:** Controls whether the CLI automatically accepts and executes
220 |     tool calls that are considered safe (e.g., read-only operations) without
221 |     explicit user confirmation. If set to `true`, the CLI will bypass the
222 |     confirmation prompt for tools deemed safe.
223 |   - **Default:** `false`
224 |   - **Example:** `"autoAccept": true`
225 | 
226 | - **`theme`** (string):
227 |   - **Description:** Sets the visual [theme](../cli/themes.md) for Gemini CLI.
228 |   - **Default:** `"Default"`
229 |   - **Example:** `"theme": "GitHub"`
230 | 
231 | - **`vimMode`** (boolean):
232 |   - **Description:** Enables or disables vim mode for input editing. When
233 |     enabled, the input area supports vim-style navigation and editing commands
234 |     with NORMAL and INSERT modes. The vim mode status is displayed in the footer
235 |     and persists between sessions.
236 |   - **Default:** `false`
237 |   - **Example:** `"vimMode": true`
238 | 
239 | - **`sandbox`** (boolean or string):
240 |   - **Description:** Controls whether and how to use sandboxing for tool
241 |     execution. If set to `true`, Gemini CLI uses a pre-built
242 |     `gemini-cli-sandbox` Docker image. For more information, see
243 |     [Sandboxing](#sandboxing).
244 |   - **Default:** `false`
245 |   - **Example:** `"sandbox": "docker"`
246 | 
247 | - **`toolDiscoveryCommand`** (string):
248 |   - **Description:** Defines a custom shell command for discovering tools from
249 |     your project. The shell command must return on `stdout` a JSON array of
250 |     [function declarations](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations).
251 |     Tool wrappers are optional.
252 |   - **Default:** Empty
253 |   - **Example:** `"toolDiscoveryCommand": "bin/get_tools"`
254 | 
255 | - **`toolCallCommand`** (string):
256 |   - **Description:** Defines a custom shell command for calling a specific tool
257 |     that was discovered using `toolDiscoveryCommand`. The shell command must
258 |     meet the following criteria:
259 |     - It must take function `name` (exactly as in
260 |       [function declaration](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations))
261 |       as first command line argument.
262 |     - It must read function arguments as JSON on `stdin`, analogous to
263 |       [`functionCall.args`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functioncall).
264 |     - It must return function output as JSON on `stdout`, analogous to
265 |       [`functionResponse.response.content`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functionresponse).
266 |   - **Default:** Empty
267 |   - **Example:** `"toolCallCommand": "bin/call_tool"`
268 | 
269 | - **`mcpServers`** (object):
270 |   - **Description:** Configures connections to one or more Model-Context
271 |     Protocol (MCP) servers for discovering and using custom tools. Gemini CLI
272 |     attempts to connect to each configured MCP server to discover available
273 |     tools. If multiple MCP servers expose a tool with the same name, the tool
274 |     names will be prefixed with the server alias you defined in the
275 |     configuration (e.g., `serverAlias__actualToolName`) to avoid conflicts. Note
276 |     that the system might strip certain schema properties from MCP tool
277 |     definitions for compatibility. At least one of `command`, `url`, or
278 |     `httpUrl` must be provided. If multiple are specified, the order of
279 |     precedence is `httpUrl`, then `url`, then `command`.
280 |   - **Default:** Empty
281 |   - **Properties:**
282 |     - **`<SERVER_NAME>`** (object): The server parameters for the named server.
283 |       - `command` (string, optional): The command to execute to start the MCP
284 |         server via standard I/O.
285 |       - `args` (array of strings, optional): Arguments to pass to the command.
286 |       - `env` (object, optional): Environment variables to set for the server
287 |         process.
288 |       - `cwd` (string, optional): The working directory in which to start the
289 |         server.
290 |       - `url` (string, optional): The URL of an MCP server that uses Server-Sent
291 |         Events (SSE) for communication.
292 |       - `httpUrl` (string, optional): The URL of an MCP server that uses
293 |         streamable HTTP for communication.
294 |       - `headers` (object, optional): A map of HTTP headers to send with
295 |         requests to `url` or `httpUrl`.
296 |       - `timeout` (number, optional): Timeout in milliseconds for requests to
297 |         this MCP server.
298 |       - `trust` (boolean, optional): Trust this server and bypass all tool call
299 |         confirmations.
300 |       - `description` (string, optional): A brief description of the server,
301 |         which may be used for display purposes.
302 |       - `includeTools` (array of strings, optional): List of tool names to
303 |         include from this MCP server. When specified, only the tools listed here
304 |         will be available from this server (allowlist behavior). If not
305 |         specified, all tools from the server are enabled by default.
306 |       - `excludeTools` (array of strings, optional): List of tool names to
307 |         exclude from this MCP server. Tools listed here will not be available to
308 |         the model, even if they are exposed by the server. **Note:**
309 |         `excludeTools` takes precedence over `includeTools` - if a tool is in
310 |         both lists, it will be excluded.
311 |   - **Example:**
312 |     ```json
313 |     "mcpServers": {
314 |       "myPythonServer": {
315 |         "command": "python",
316 |         "args": ["mcp_server.py", "--port", "8080"],
317 |         "cwd": "./mcp_tools/python",
318 |         "timeout": 5000,
319 |         "includeTools": ["safe_tool", "file_reader"],
320 |       },
321 |       "myNodeServer": {
322 |         "command": "node",
323 |         "args": ["mcp_server.js"],
324 |         "cwd": "./mcp_tools/node",
325 |         "excludeTools": ["dangerous_tool", "file_deleter"]
326 |       },
327 |       "myDockerServer": {
328 |         "command": "docker",
329 |         "args": ["run", "-i", "--rm", "-e", "API_KEY", "ghcr.io/foo/bar"],
330 |         "env": {
331 |           "API_KEY": "$MY_API_TOKEN"
332 |         }
333 |       },
334 |       "mySseServer": {
335 |         "url": "http://localhost:8081/events",
336 |         "headers": {
337 |           "Authorization": "Bearer $MY_SSE_TOKEN"
338 |         },
339 |         "description": "An example SSE-based MCP server."
340 |       },
341 |       "myStreamableHttpServer": {
342 |         "httpUrl": "http://localhost:8082/stream",
343 |         "headers": {
344 |           "X-API-Key": "$MY_HTTP_API_KEY"
345 |         },
346 |         "description": "An example Streamable HTTP-based MCP server."
347 |       }
348 |     }
349 |     ```
350 | 
351 | - **`checkpointing`** (object):
352 |   - **Description:** Configures the checkpointing feature, which allows you to
353 |     save and restore conversation and file states. See the
354 |     [Checkpointing documentation](../cli/checkpointing.md) for more details.
355 |   - **Default:** `{"enabled": false}`
356 |   - **Properties:**
357 |     - **`enabled`** (boolean): When `true`, the `/restore` command is available.
358 | 
359 | - **`preferredEditor`** (string):
360 |   - **Description:** Specifies the preferred editor to use for viewing diffs.
361 |   - **Default:** `vscode`
362 |   - **Example:** `"preferredEditor": "vscode"`
363 | 
364 | - **`telemetry`** (object)
365 |   - **Description:** Configures logging and metrics collection for Gemini CLI.
366 |     For more information, see [Telemetry](../cli/telemetry.md).
367 |   - **Default:**
368 |     `{"enabled": false, "target": "local", "otlpEndpoint": "http://localhost:4317", "logPrompts": true}`
369 |   - **Properties:**
370 |     - **`enabled`** (boolean): Whether or not telemetry is enabled.
371 |     - **`target`** (string): The destination for collected telemetry. Supported
372 |       values are `local` and `gcp`.
373 |     - **`otlpEndpoint`** (string): The endpoint for the OTLP Exporter.
374 |     - **`logPrompts`** (boolean): Whether or not to include the content of user
375 |       prompts in the logs.
376 |   - **Example:**
377 |     ```json
378 |     "telemetry": {
379 |       "enabled": true,
380 |       "target": "local",
381 |       "otlpEndpoint": "http://localhost:16686",
382 |       "logPrompts": false
383 |     }
384 |     ```
385 | - **`usageStatisticsEnabled`** (boolean):
386 |   - **Description:** Enables or disables the collection of usage statistics. See
387 |     [Usage Statistics](#usage-statistics) for more information.
388 |   - **Default:** `true`
389 |   - **Example:**
390 |     ```json
391 |     "usageStatisticsEnabled": false
392 |     ```
393 | 
394 | - **`hideTips`** (boolean):
395 |   - **Description:** Enables or disables helpful tips in the CLI interface.
396 |   - **Default:** `false`
397 |   - **Example:**
398 | 
399 |     ```json
400 |     "hideTips": true
401 |     ```
402 | 
403 | - **`hideBanner`** (boolean):
404 |   - **Description:** Enables or disables the startup banner (ASCII art logo) in
405 |     the CLI interface.
406 |   - **Default:** `false`
407 |   - **Example:**
408 | 
409 |     ```json
410 |     "hideBanner": true
411 |     ```
412 | 
413 | - **`maxSessionTurns`** (number):
414 |   - **Description:** Sets the maximum number of turns for a session. If the
415 |     session exceeds this limit, the CLI will stop processing and start a new
416 |     chat.
417 |   - **Default:** `-1` (unlimited)
418 |   - **Example:**
419 |     ```json
420 |     "maxSessionTurns": 10
421 |     ```
422 | 
423 | - **`summarizeToolOutput`** (object):
424 |   - **Description:** Enables or disables the summarization of tool output. You
425 |     can specify the token budget for the summarization using the `tokenBudget`
426 |     setting.
427 |   - Note: Currently only the `run_shell_command` tool is supported.
428 |   - **Default:** `{}` (Disabled by default)
429 |   - **Example:**
430 |     ```json
431 |     "summarizeToolOutput": {
432 |       "run_shell_command": {
433 |         "tokenBudget": 2000
434 |       }
435 |     }
436 |     ```
437 | 
438 | - **`excludedProjectEnvVars`** (array of strings):
439 |   - **Description:** Specifies environment variables that should be excluded
440 |     from being loaded from project `.env` files. This prevents project-specific
441 |     environment variables (like `DEBUG=true`) from interfering with gemini-cli
442 |     behavior. Variables from `.gemini/.env` files are never excluded.
443 |   - **Default:** `["DEBUG", "DEBUG_MODE"]`
444 |   - **Example:**
445 |     ```json
446 |     "excludedProjectEnvVars": ["DEBUG", "DEBUG_MODE", "NODE_ENV"]
447 |     ```
448 | 
449 | - **`includeDirectories`** (array of strings):
450 |   - **Description:** Specifies an array of additional absolute or relative paths
451 |     to include in the workspace context. Missing directories will be skipped
452 |     with a warning by default. Paths can use `~` to refer to the user's home
453 |     directory. This setting can be combined with the `--include-directories`
454 |     command-line flag.
455 |   - **Default:** `[]`
456 |   - **Example:**
457 |     ```json
458 |     "includeDirectories": [
459 |       "/path/to/another/project",
460 |       "../shared-library",
461 |       "~/common-utils"
462 |     ]
463 |     ```
464 | 
465 | - **`loadMemoryFromIncludeDirectories`** (boolean):
466 |   - **Description:** Controls the behavior of the `/memory refresh` command. If
467 |     set to `true`, `GEMINI.md` files should be loaded from all directories that
468 |     are added. If set to `false`, `GEMINI.md` should only be loaded from the
469 |     current directory.
470 |   - **Default:** `false`
471 |   - **Example:**
472 |     ```json
473 |     "loadMemoryFromIncludeDirectories": true
474 |     ```
475 | 
476 | - **`chatCompression`** (object):
477 |   - **Description:** Controls the settings for chat history compression, both
478 |     automatic and when manually invoked through the /compress command.
479 |   - **Properties:**
480 |     - **`contextPercentageThreshold`** (number): A value between 0 and 1 that
481 |       specifies the token threshold for compression as a percentage of the
482 |       model's total token limit. For example, a value of `0.6` will trigger
483 |       compression when the chat history exceeds 60% of the token limit.
484 |   - **Example:**
485 |     ```json
486 |     "chatCompression": {
487 |       "contextPercentageThreshold": 0.6
488 |     }
489 |     ```
490 | 
491 | - **`showLineNumbers`** (boolean):
492 |   - **Description:** Controls whether line numbers are displayed in code blocks
493 |     in the CLI output.
494 |   - **Default:** `true`
495 |   - **Example:**
496 |     ```json
497 |     "showLineNumbers": false
498 |     ```
499 | 
500 | - **`accessibility`** (object):
501 |   - **Description:** Configures accessibility features for the CLI.
502 |   - **Properties:**
503 |     - **`screenReader`** (boolean): Enables screen reader mode, which adjusts
504 |       the TUI for better compatibility with screen readers. This can also be
505 |       enabled with the `--screen-reader` command-line flag, which will take
506 |       precedence over the setting.
507 |     - **`disableLoadingPhrases`** (boolean): Disables the display of loading
508 |       phrases during operations.
509 |   - **Default:** `{"screenReader": false, "disableLoadingPhrases": false}`
510 |   - **Example:**
511 |     ```json
512 |     "accessibility": {
513 |       "screenReader": true,
514 |       "disableLoadingPhrases": true
515 |     }
516 |     ```
517 | 
518 | ### Example `settings.json`:
519 | 
520 | ```json
521 | {
522 |   "theme": "GitHub",
523 |   "sandbox": "docker",
524 |   "toolDiscoveryCommand": "bin/get_tools",
525 |   "toolCallCommand": "bin/call_tool",
526 |   "mcpServers": {
527 |     "mainServer": {
528 |       "command": "bin/mcp_server.py"
529 |     },
530 |     "anotherServer": {
531 |       "command": "node",
532 |       "args": ["mcp_server.js", "--verbose"]
533 |     }
534 |   },
535 |   "telemetry": {
536 |     "enabled": true,
537 |     "target": "local",
538 |     "otlpEndpoint": "http://localhost:4317",
539 |     "logPrompts": true
540 |   },
541 |   "usageStatisticsEnabled": true,
542 |   "hideTips": false,
543 |   "hideBanner": false,
544 |   "maxSessionTurns": 10,
545 |   "summarizeToolOutput": {
546 |     "run_shell_command": {
547 |       "tokenBudget": 100
548 |     }
549 |   },
550 |   "excludedProjectEnvVars": ["DEBUG", "DEBUG_MODE", "NODE_ENV"],
551 |   "includeDirectories": ["path/to/dir1", "~/path/to/dir2", "../path/to/dir3"],
552 |   "loadMemoryFromIncludeDirectories": true
553 | }
554 | ```
555 | 
556 | ## Shell History
557 | 
558 | The CLI keeps a history of shell commands you run. To avoid conflicts between
559 | different projects, this history is stored in a project-specific directory
560 | within your user's home folder.
561 | 
562 | - **Location:** `~/.gemini/tmp/<project_hash>/shell_history`
563 |   - `<project_hash>` is a unique identifier generated from your project's root
564 |     path.
565 |   - The history is stored in a file named `shell_history`.
566 | 
567 | ## Environment Variables & `.env` Files
568 | 
569 | Environment variables are a common way to configure applications, especially for
570 | sensitive information like API keys or for settings that might change between
571 | environments. For authentication setup, see the
572 | [Authentication documentation](./authentication.md) which covers all available
573 | authentication methods.
574 | 
575 | The CLI automatically loads environment variables from an `.env` file. The
576 | loading order is:
577 | 
578 | 1.  `.env` file in the current working directory.
579 | 2.  If not found, it searches upwards in parent directories until it finds an
580 |     `.env` file or reaches the project root (identified by a `.git` folder) or
581 |     the home directory.
582 | 3.  If still not found, it looks for `~/.env` (in the user's home directory).
583 | 
584 | **Environment Variable Exclusion:** Some environment variables (like `DEBUG` and
585 | `DEBUG_MODE`) are automatically excluded from being loaded from project `.env`
586 | files to prevent interference with gemini-cli behavior. Variables from
587 | `.gemini/.env` files are never excluded. You can customize this behavior using
588 | the `excludedProjectEnvVars` setting in your `settings.json` file.
589 | 
590 | - **`GEMINI_API_KEY`**:
591 |   - Your API key for the Gemini API.
592 |   - One of several available [authentication methods](./authentication.md).
593 |   - Set this in your shell profile (e.g., `~/.bashrc`, `~/.zshrc`) or an `.env`
594 |     file.
595 | - **`GEMINI_MODEL`**:
596 |   - Specifies the default Gemini model to use.
597 |   - Overrides the hardcoded default
598 |   - Example: `export GEMINI_MODEL="gemini-2.5-flash"`
599 | - **`GOOGLE_API_KEY`**:
600 |   - Your Google Cloud API key.
601 |   - Required for using Vertex AI in express mode.
602 |   - Ensure you have the necessary permissions.
603 |   - Example: `export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"`.
604 | - **`GOOGLE_CLOUD_PROJECT`**:
605 |   - Your Google Cloud Project ID.
606 |   - Required for using Code Assist or Vertex AI.
607 |   - If using Vertex AI, ensure you have the necessary permissions in this
608 |     project.
609 |   - **Cloud Shell Note:** When running in a Cloud Shell environment, this
610 |     variable defaults to a special project allocated for Cloud Shell users. If
611 |     you have `GOOGLE_CLOUD_PROJECT` set in your global environment in Cloud
612 |     Shell, it will be overridden by this default. To use a different project in
613 |     Cloud Shell, you must define `GOOGLE_CLOUD_PROJECT` in a `.env` file.
614 |   - Example: `export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
615 | - **`GOOGLE_APPLICATION_CREDENTIALS`** (string):
616 |   - **Description:** The path to your Google Application Credentials JSON file.
617 |   - **Example:**
618 |     `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
619 | - **`OTLP_GOOGLE_CLOUD_PROJECT`**:
620 |   - Your Google Cloud Project ID for Telemetry in Google Cloud
621 |   - Example: `export OTLP_GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
622 | - **`GOOGLE_CLOUD_LOCATION`**:
623 |   - Your Google Cloud Project Location (e.g., us-central1).
624 |   - Required for using Vertex AI in non express mode.
625 |   - Example: `export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"`.
626 | - **`GEMINI_SANDBOX`**:
627 |   - Alternative to the `sandbox` setting in `settings.json`.
628 |   - Accepts `true`, `false`, `docker`, `podman`, or a custom command string.
629 | - **`SEATBELT_PROFILE`** (macOS specific):
630 |   - Switches the Seatbelt (`sandbox-exec`) profile on macOS.
631 |   - `permissive-open`: (Default) Restricts writes to the project folder (and a
632 |     few other folders, see
633 |     `packages/cli/src/utils/sandbox-macos-permissive-open.sb`) but allows other
634 |     operations.
635 |   - `strict`: Uses a strict profile that declines operations by default.
636 |   - `<profile_name>`: Uses a custom profile. To define a custom profile, create
637 |     a file named `sandbox-macos-<profile_name>.sb` in your project's `.gemini/`
638 |     directory (e.g., `my-project/.gemini/sandbox-macos-custom.sb`).
639 | - **`DEBUG` or `DEBUG_MODE`** (often used by underlying libraries or the CLI
640 |   itself):
641 |   - Set to `true` or `1` to enable verbose debug logging, which can be helpful
642 |     for troubleshooting.
643 |   - **Note:** These variables are automatically excluded from project `.env`
644 |     files by default to prevent interference with gemini-cli behavior. Use
645 |     `.gemini/.env` files if you need to set these for gemini-cli specifically.
646 | - **`NO_COLOR`**:
647 |   - Set to any value to disable all color output in the CLI.
648 | - **`CLI_TITLE`**:
649 |   - Set to a string to customize the title of the CLI.
650 | - **`CODE_ASSIST_ENDPOINT`**:
651 |   - Specifies the endpoint for the code assist server.
652 |   - This is useful for development and testing.
653 | 
654 | ## Command-Line Arguments
655 | 
656 | Arguments passed directly when running the CLI can override other configurations
657 | for that specific session.
658 | 
659 | - **`--model <model_name>`** (**`-m <model_name>`**):
660 |   - Specifies the Gemini model to use for this session.
661 |   - Example: `npm start -- --model gemini-1.5-pro-latest`
662 | - **`--prompt <your_prompt>`** (**`-p <your_prompt>`**):
663 |   - Used to pass a prompt directly to the command. This invokes Gemini CLI in a
664 |     non-interactive mode.
665 | - **`--prompt-interactive <your_prompt>`** (**`-i <your_prompt>`**):
666 |   - Starts an interactive session with the provided prompt as the initial input.
667 |   - The prompt is processed within the interactive session, not before it.
668 |   - Cannot be used when piping input from stdin.
669 |   - Example: `gemini -i "explain this code"`
670 | - **`--sandbox`** (**`-s`**):
671 |   - Enables sandbox mode for this session.
672 | - **`--sandbox-image`**:
673 |   - Sets the sandbox image URI.
674 | - **`--debug`** (**`-d`**):
675 |   - Enables debug mode for this session, providing more verbose output.
676 | - **`--all-files`** (**`-a`**):
677 |   - If set, recursively includes all files within the current directory as
678 |     context for the prompt.
679 | - **`--help`** (or **`-h`**):
680 |   - Displays help information about command-line arguments.
681 | - **`--show-memory-usage`**:
682 |   - Displays the current memory usage.
683 | - **`--yolo`**:
684 |   - Enables YOLO mode, which automatically approves all tool calls.
685 | - **`--approval-mode <mode>`**:
686 |   - Sets the approval mode for tool calls. Available modes:
687 |     - `default`: Prompt for approval on each tool call (default behavior)
688 |     - `auto_edit`: Automatically approve edit tools (replace, write_file) while
689 |       prompting for others
690 |     - `yolo`: Automatically approve all tool calls (equivalent to `--yolo`)
691 |   - Cannot be used together with `--yolo`. Use `--approval-mode=yolo` instead of
692 |     `--yolo` for the new unified approach.
693 |   - Example: `gemini --approval-mode auto_edit`
694 | - **`--allowed-tools <tool1,tool2,...>`**:
695 |   - A comma-separated list of tool names that will bypass the confirmation
696 |     dialog.
697 |   - Example: `gemini --allowed-tools "ShellTool(git status)"`
698 | - **`--telemetry`**:
699 |   - Enables [telemetry](../cli/telemetry.md).
700 | - **`--telemetry-target`**:
701 |   - Sets the telemetry target. See [telemetry](../cli/telemetry.md) for more
702 |     information.
703 | - **`--telemetry-otlp-endpoint`**:
704 |   - Sets the OTLP endpoint for telemetry. See [telemetry](../cli/telemetry.md)
705 |     for more information.
706 | - **`--telemetry-otlp-protocol`**:
707 |   - Sets the OTLP protocol for telemetry (`grpc` or `http`). Defaults to `grpc`.
708 |     See [telemetry](../cli/telemetry.md) for more information.
709 | - **`--telemetry-log-prompts`**:
710 |   - Enables logging of prompts for telemetry. See
711 |     [telemetry](../cli/telemetry.md) for more information.
712 | - **`--checkpointing`**:
713 |   - Enables [checkpointing](../cli/checkpointing.md).
714 | - **`--extensions <extension_name ...>`** (**`-e <extension_name ...>`**):
715 |   - Specifies a list of extensions to use for the session. If not provided, all
716 |     available extensions are used.
717 |   - Use the special term `gemini -e none` to disable all extensions.
718 |   - Example: `gemini -e my-extension -e my-other-extension`
719 | - **`--list-extensions`** (**`-l`**):
720 |   - Lists all available extensions and exits.
721 | - **`--proxy`**:
722 |   - Sets the proxy for the CLI.
723 |   - Example: `--proxy http://localhost:7890`.
724 | - **`--include-directories <dir1,dir2,...>`**:
725 |   - Includes additional directories in the workspace for multi-directory
726 |     support.
727 |   - Can be specified multiple times or as comma-separated values.
728 |   - 5 directories can be added at maximum.
729 |   - Example: `--include-directories /path/to/project1,/path/to/project2` or
730 |     `--include-directories /path/to/project1 --include-directories /path/to/project2`
731 | - **`--screen-reader`**:
732 |   - Enables screen reader mode for accessibility.
733 | - **`--version`**:
734 |   - Displays the version of the CLI.
735 | 
736 | ## Context Files (Hierarchical Instructional Context)
737 | 
738 | While not strictly configuration for the CLI's _behavior_, context files
739 | (defaulting to `GEMINI.md` but configurable via the `contextFileName` setting)
740 | are crucial for configuring the _instructional context_ (also referred to as
741 | "memory") provided to the Gemini model. This powerful feature allows you to give
742 | project-specific instructions, coding style guides, or any relevant background
743 | information to the AI, making its responses more tailored and accurate to your
744 | needs. The CLI includes UI elements, such as an indicator in the footer showing
745 | the number of loaded context files, to keep you informed about the active
746 | context.
747 | 
748 | - **Purpose:** These Markdown files contain instructions, guidelines, or context
749 |   that you want the Gemini model to be aware of during your interactions. The
750 |   system is designed to manage this instructional context hierarchically.
751 | 
752 | ### Example Context File Content (e.g., `GEMINI.md`)
753 | 
754 | Here's a conceptual example of what a context file at the root of a TypeScript
755 | project might contain:
756 | 
757 | ```markdown
758 | # Project: My Awesome TypeScript Library
759 | 
760 | ## General Instructions:
761 | 
762 | - When generating new TypeScript code, please follow the existing coding style.
763 | - Ensure all new functions and classes have JSDoc comments.
764 | - Prefer functional programming paradigms where appropriate.
765 | - All code should be compatible with TypeScript 5.0 and Node.js 20+.
766 | 
767 | ## Coding Style:
768 | 
769 | - Use 2 spaces for indentation.
770 | - Interface names should be prefixed with `I` (e.g., `IUserService`).
771 | - Private class members should be prefixed with an underscore (`_`).
772 | - Always use strict equality (`===` and `!==`).
773 | 
774 | ## Specific Component: `src/api/client.ts`
775 | 
776 | - This file handles all outbound API requests.
777 | - When adding new API call functions, ensure they include robust error handling
778 |   and logging.
779 | - Use the existing `fetchWithRetry` utility for all GET requests.
780 | 
781 | ## Regarding Dependencies:
782 | 
783 | - Avoid introducing new external dependencies unless absolutely necessary.
784 | - If a new dependency is required, please state the reason.
785 | ```
786 | 
787 | This example demonstrates how you can provide general project context, specific
788 | coding conventions, and even notes about particular files or components. The
789 | more relevant and precise your context files are, the better the AI can assist
790 | you. Project-specific context files are highly encouraged to establish
791 | conventions and context.
792 | 
793 | - **Hierarchical Loading and Precedence:** The CLI implements a sophisticated
794 |   hierarchical memory system by loading context files (e.g., `GEMINI.md`) from
795 |   several locations. Content from files lower in this list (more specific)
796 |   typically overrides or supplements content from files higher up (more
797 |   general). The exact concatenation order and final context can be inspected
798 |   using the `/memory show` command. The typical loading order is:
799 |   1.  **Global Context File:**
800 |       - Location: `~/.gemini/<contextFileName>` (e.g., `~/.gemini/GEMINI.md` in
801 |         your user home directory).
802 |       - Scope: Provides default instructions for all your projects.
803 |   2.  **Project Root & Ancestors Context Files:**
804 |       - Location: The CLI searches for the configured context file in the
805 |         current working directory and then in each parent directory up to either
806 |         the project root (identified by a `.git` folder) or your home directory.
807 |       - Scope: Provides context relevant to the entire project or a significant
808 |         portion of it.
809 |   3.  **Sub-directory Context Files (Contextual/Local):**
810 |       - Location: The CLI also scans for the configured context file in
811 |         subdirectories _below_ the current working directory (respecting common
812 |         ignore patterns like `node_modules`, `.git`, etc.). The breadth of this
813 |         search is limited to 200 directories by default, but can be configured
814 |         with a `memoryDiscoveryMaxDirs` field in your `settings.json` file.
815 |       - Scope: Allows for highly specific instructions relevant to a particular
816 |         component, module, or subsection of your project.
817 | - **Concatenation & UI Indication:** The contents of all found context files are
818 |   concatenated (with separators indicating their origin and path) and provided
819 |   as part of the system prompt to the Gemini model. The CLI footer displays the
820 |   count of loaded context files, giving you a quick visual cue about the active
821 |   instructional context.
822 | - **Importing Content:** You can modularize your context files by importing
823 |   other Markdown files using the `@path/to/file.md` syntax. For more details,
824 |   see the [Memory Import Processor documentation](../core/memport.md).
825 | - **Commands for Memory Management:**
826 |   - Use `/memory refresh` to force a re-scan and reload of all context files
827 |     from all configured locations. This updates the AI's instructional context.
828 |   - Use `/memory show` to display the combined instructional context currently
829 |     loaded, allowing you to verify the hierarchy and content being used by the
830 |     AI.
831 |   - See the [Commands documentation](../cli/commands.md#memory) for full details
832 |     on the `/memory` command and its sub-commands (`show` and `refresh`).
833 | 
834 | By understanding and utilizing these configuration layers and the hierarchical
835 | nature of context files, you can effectively manage the AI's memory and tailor
836 | the Gemini CLI's responses to your specific needs and projects.
837 | 
838 | ## Sandboxing
839 | 
840 | The Gemini CLI can execute potentially unsafe operations (like shell commands
841 | and file modifications) within a sandboxed environment to protect your system.
842 | 
843 | Sandboxing is disabled by default, but you can enable it in a few ways:
844 | 
845 | - Using `--sandbox` or `-s` flag.
846 | - Setting `GEMINI_SANDBOX` environment variable.
847 | - Sandbox is enabled when using `--yolo` or `--approval-mode=yolo` by default.
848 | 
849 | By default, it uses a pre-built `gemini-cli-sandbox` Docker image.
850 | 
851 | For project-specific sandboxing needs, you can create a custom Dockerfile at
852 | `.gemini/sandbox.Dockerfile` in your project's root directory. This Dockerfile
853 | can be based on the base sandbox image:
854 | 
855 | ```dockerfile
856 | FROM gemini-cli-sandbox
857 | 
858 | # Add your custom dependencies or configurations here
859 | # For example:
860 | # RUN apt-get update && apt-get install -y some-package
861 | # COPY ./my-config /app/my-config
862 | ```
863 | 
864 | When `.gemini/sandbox.Dockerfile` exists, you can use `BUILD_SANDBOX`
865 | environment variable when running Gemini CLI to automatically build the custom
866 | sandbox image:
867 | 
868 | ```bash
869 | BUILD_SANDBOX=1 gemini -s
870 | ```
871 | 
872 | ## Usage Statistics
873 | 
874 | To help us improve the Gemini CLI, we collect anonymized usage statistics. This
875 | data helps us understand how the CLI is used, identify common issues, and
876 | prioritize new features.
877 | 
878 | **What we collect:**
879 | 
880 | - **Tool Calls:** We log the names of the tools that are called, whether they
881 |   succeed or fail, and how long they take to execute. We do not collect the
882 |   arguments passed to the tools or any data returned by them.
883 | - **API Requests:** We log the Gemini model used for each request, the duration
884 |   of the request, and whether it was successful. We do not collect the content
885 |   of the prompts or responses.
886 | - **Session Information:** We collect information about the configuration of the
887 |   CLI, such as the enabled tools and the approval mode.
888 | 
889 | **What we DON'T collect:**
890 | 
891 | - **Personally Identifiable Information (PII):** We do not collect any personal
892 |   information, such as your name, email address, or API keys.
893 | - **Prompt and Response Content:** We do not log the content of your prompts or
894 |   the responses from the Gemini model.
895 | - **File Content:** We do not log the content of any files that are read or
896 |   written by the CLI.
897 | 
898 | **How to opt out:**
899 | 
900 | You can opt out of usage statistics collection at any time by setting the
901 | `usageStatisticsEnabled` property to `false` in your `settings.json` file:
902 | 
903 | ```json
904 | {
905 |   "usageStatisticsEnabled": false
906 | }
907 | ```
```

get-started/configuration.md
```
1 | # Gemini CLI Configuration
2 | 
3 | > **Note on Configuration Format, 9/17/25:** The format of the `settings.json`
4 | > file has been updated to a new, more organized structure.
5 | >
6 | > - The new format will be supported in the stable release starting
7 | >   **[09/10/25]**.
8 | > - Automatic migration from the old format to the new format will begin on
9 | >   **[09/17/25]**.
10 | >
11 | > For details on the previous format, please see the
12 | > [v1 Configuration documentation](./configuration-v1.md).
13 | 
14 | Gemini CLI offers several ways to configure its behavior, including environment
15 | variables, command-line arguments, and settings files. This document outlines
16 | the different configuration methods and available settings.
17 | 
18 | ## Configuration layers
19 | 
20 | Configuration is applied in the following order of precedence (lower numbers are
21 | overridden by higher numbers):
22 | 
23 | 1.  **Default values:** Hardcoded defaults within the application.
24 | 2.  **System defaults file:** System-wide default settings that can be
25 |     overridden by other settings files.
26 | 3.  **User settings file:** Global settings for the current user.
27 | 4.  **Project settings file:** Project-specific settings.
28 | 5.  **System settings file:** System-wide settings that override all other
29 |     settings files.
30 | 6.  **Environment variables:** System-wide or session-specific variables,
31 |     potentially loaded from `.env` files.
32 | 7.  **Command-line arguments:** Values passed when launching the CLI.
33 | 
34 | ## Settings files
35 | 
36 | Gemini CLI uses JSON settings files for persistent configuration. There are four
37 | locations for these files:
38 | 
39 | - **System defaults file:**
40 |   - **Location:** `/etc/gemini-cli/system-defaults.json` (Linux),
41 |     `C:\ProgramData\gemini-cli\system-defaults.json` (Windows) or
42 |     `/Library/Application Support/GeminiCli/system-defaults.json` (macOS). The
43 |     path can be overridden using the `GEMINI_CLI_SYSTEM_DEFAULTS_PATH`
44 |     environment variable.
45 |   - **Scope:** Provides a base layer of system-wide default settings. These
46 |     settings have the lowest precedence and are intended to be overridden by
47 |     user, project, or system override settings.
48 | - **User settings file:**
49 |   - **Location:** `~/.gemini/settings.json` (where `~` is your home directory).
50 |   - **Scope:** Applies to all Gemini CLI sessions for the current user. User
51 |     settings override system defaults.
52 | - **Project settings file:**
53 |   - **Location:** `.gemini/settings.json` within your project's root directory.
54 |   - **Scope:** Applies only when running Gemini CLI from that specific project.
55 |     Project settings override user settings and system defaults.
56 | - **System settings file:**
57 |   - **Location:** `/etc/gemini-cli/settings.json` (Linux),
58 |     `C:\ProgramData\gemini-cli\settings.json` (Windows) or
59 |     `/Library/Application Support/GeminiCli/settings.json` (macOS). The path can
60 |     be overridden using the `GEMINI_CLI_SYSTEM_SETTINGS_PATH` environment
61 |     variable.
62 |   - **Scope:** Applies to all Gemini CLI sessions on the system, for all users.
63 |     System settings act as overrides, taking precedence over all other settings
64 |     files. May be useful for system administrators at enterprises to have
65 |     controls over users' Gemini CLI setups.
66 | 
67 | **Note on environment variables in settings:** String values within your
68 | `settings.json` files can reference environment variables using either
69 | `$VAR_NAME` or `${VAR_NAME}` syntax. These variables will be automatically
70 | resolved when the settings are loaded. For example, if you have an environment
71 | variable `MY_API_TOKEN`, you could use it in `settings.json` like this:
72 | `"apiKey": "$MY_API_TOKEN"`.
73 | 
74 | > **Note for Enterprise Users:** For guidance on deploying and managing Gemini
75 | > CLI in a corporate environment, please see the
76 | > [Enterprise Configuration](../cli/enterprise.md) documentation.
77 | 
78 | ### The `.gemini` directory in your project
79 | 
80 | In addition to a project settings file, a project's `.gemini` directory can
81 | contain other project-specific files related to Gemini CLI's operation, such as:
82 | 
83 | - [Custom sandbox profiles](#sandboxing) (e.g.,
84 |   `.gemini/sandbox-macos-custom.sb`, `.gemini/sandbox.Dockerfile`).
85 | 
86 | ### Available settings in `settings.json`
87 | 
88 | Settings are organized into categories. All settings should be placed within
89 | their corresponding top-level category object in your `settings.json` file.
90 | 
91 | #### `general`
92 | 
93 | - **`general.preferredEditor`** (string):
94 |   - **Description:** The preferred editor to open files in.
95 |   - **Default:** `undefined`
96 | 
97 | - **`general.vimMode`** (boolean):
98 |   - **Description:** Enable Vim keybindings.
99 |   - **Default:** `false`
100 | 
101 | - **`general.disableAutoUpdate`** (boolean):
102 |   - **Description:** Disable automatic updates.
103 |   - **Default:** `false`
104 | 
105 | - **`general.disableUpdateNag`** (boolean):
106 |   - **Description:** Disable update notification prompts.
107 |   - **Default:** `false`
108 | 
109 | - **`general.checkpointing.enabled`** (boolean):
110 |   - **Description:** Enable session checkpointing for recovery.
111 |   - **Default:** `false`
112 | 
113 | #### `output`
114 | 
115 | - **`output.format`** (string):
116 |   - **Description:** The format of the CLI output.
117 |   - **Default:** `"text"`
118 |   - **Values:** `"text"`, `"json"`
119 | 
120 | #### `ui`
121 | 
122 | - **`ui.theme`** (string):
123 |   - **Description:** The color theme for the UI. See [Themes](../cli/themes.md)
124 |     for available options.
125 |   - **Default:** `undefined`
126 | 
127 | - **`ui.customThemes`** (object):
128 |   - **Description:** Custom theme definitions.
129 |   - **Default:** `{}`
130 | 
131 | - **`ui.hideWindowTitle`** (boolean):
132 |   - **Description:** Hide the window title bar.
133 |   - **Default:** `false`
134 | 
135 | - **`ui.hideTips`** (boolean):
136 |   - **Description:** Hide helpful tips in the UI.
137 |   - **Default:** `false`
138 | 
139 | - **`ui.hideBanner`** (boolean):
140 |   - **Description:** Hide the application banner.
141 |   - **Default:** `false`
142 | 
143 | - **`ui.hideFooter`** (boolean):
144 |   - **Description:** Hide the footer from the UI.
145 |   - **Default:** `false`
146 | 
147 | - **`ui.showMemoryUsage`** (boolean):
148 |   - **Description:** Display memory usage information in the UI.
149 |   - **Default:** `false`
150 | 
151 | - **`ui.showLineNumbers`** (boolean):
152 |   - **Description:** Show line numbers in the chat.
153 |   - **Default:** `false`
154 | 
155 | - **`ui.showCitations`** (boolean):
156 |   - **Description:** Show citations for generated text in the chat.
157 |   - **Default:** `true`
158 | 
159 | - **`ui.accessibility.disableLoadingPhrases`** (boolean):
160 |   - **Description:** Disable loading phrases for accessibility.
161 |   - **Default:** `false`
162 | 
163 | - **`ui.accessibility.screenReader`** (boolean):
164 |   - **Description:** Show plaintext interactive view that is more screen reader
165 |     friendly.
166 |   - **Default:** `false`
167 | 
168 | - **`ui.customWittyPhrases`** (array of strings):
169 |   - **Description:** A list of custom phrases to display during loading states.
170 |     When provided, the CLI will cycle through these phrases instead of the
171 |     default ones.
172 |   - **Default:** `[]`
173 | 
174 | #### `ide`
175 | 
176 | - **`ide.enabled`** (boolean):
177 |   - **Description:** Enable IDE integration mode.
178 |   - **Default:** `false`
179 | 
180 | - **`ide.hasSeenNudge`** (boolean):
181 |   - **Description:** Whether the user has seen the IDE integration nudge.
182 |   - **Default:** `false`
183 | 
184 | #### `privacy`
185 | 
186 | - **`privacy.usageStatisticsEnabled`** (boolean):
187 |   - **Description:** Enable collection of usage statistics.
188 |   - **Default:** `true`
189 | 
190 | #### `model`
191 | 
192 | - **`model.name`** (string):
193 |   - **Description:** The Gemini model to use for conversations.
194 |   - **Default:** `undefined`
195 | 
196 | - **`model.maxSessionTurns`** (number):
197 |   - **Description:** Maximum number of user/model/tool turns to keep in a
198 |     session. -1 means unlimited.
199 |   - **Default:** `-1`
200 | 
201 | - **`model.summarizeToolOutput`** (object):
202 |   - **Description:** Enables or disables the summarization of tool output. You
203 |     can specify the token budget for the summarization using the `tokenBudget`
204 |     setting. Note: Currently only the `run_shell_command` tool is supported. For
205 |     example `{"run_shell_command": {"tokenBudget": 2000}}`
206 |   - **Default:** `undefined`
207 | 
208 | - **`model.chatCompression.contextPercentageThreshold`** (number):
209 |   - **Description:** Sets the threshold for chat history compression as a
210 |     percentage of the model's total token limit. This is a value between 0 and 1
211 |     that applies to both automatic compression and the manual `/compress`
212 |     command. For example, a value of `0.6` will trigger compression when the
213 |     chat history exceeds 60% of the token limit.
214 |   - **Default:** `0.7`
215 | 
216 | - **`model.skipNextSpeakerCheck`** (boolean):
217 |   - **Description:** Skip the next speaker check.
218 |   - **Default:** `false`
219 | 
220 | #### `context`
221 | 
222 | - **`context.fileName`** (string or array of strings):
223 |   - **Description:** The name of the context file(s).
224 |   - **Default:** `undefined`
225 | 
226 | - **`context.importFormat`** (string):
227 |   - **Description:** The format to use when importing memory.
228 |   - **Default:** `undefined`
229 | 
230 | - **`context.discoveryMaxDirs`** (number):
231 |   - **Description:** Maximum number of directories to search for memory.
232 |   - **Default:** `200`
233 | 
234 | - **`context.includeDirectories`** (array):
235 |   - **Description:** Additional directories to include in the workspace context.
236 |     Missing directories will be skipped with a warning.
237 |   - **Default:** `[]`
238 | 
239 | - **`context.loadFromIncludeDirectories`** (boolean):
240 |   - **Description:** Controls the behavior of the `/memory refresh` command. If
241 |     set to `true`, `GEMINI.md` files should be loaded from all directories that
242 |     are added. If set to `false`, `GEMINI.md` should only be loaded from the
243 |     current directory.
244 |   - **Default:** `false`
245 | 
246 | - **`context.fileFiltering.respectGitIgnore`** (boolean):
247 |   - **Description:** Respect .gitignore files when searching.
248 |   - **Default:** `true`
249 | 
250 | - **`context.fileFiltering.respectGeminiIgnore`** (boolean):
251 |   - **Description:** Respect .geminiignore files when searching.
252 |   - **Default:** `true`
253 | 
254 | - **`context.fileFiltering.enableRecursiveFileSearch`** (boolean):
255 |   - **Description:** Whether to enable searching recursively for filenames under
256 |     the current tree when completing `@` prefixes in the prompt.
257 |   - **Default:** `true`
258 | 
259 | #### `tools`
260 | 
261 | - **`tools.sandbox`** (boolean or string):
262 |   - **Description:** Sandbox execution environment (can be a boolean or a path
263 |     string).
264 |   - **Default:** `undefined`
265 | 
266 | - **`tools.shell.enableInteractiveShell`** (boolean):
267 |   - **Description:** Enables interactive terminal for running shell commands. If
268 |     an interactive session cannot be started, it will fall back to a standard
269 |     shell.
270 |   - **Default:** `true`
271 | 
272 | - **`tools.core`** (array of strings):
273 |   - **Description:** This can be used to restrict the set of built-in tools
274 |     [with an allowlist](../cli/enterprise.md#restricting-tool-access). See
275 |     [Built-in Tools](../core/tools-api.md#built-in-tools) for a list of core
276 |     tools. The match semantics are the same as `tools.allowed`.
277 |   - **Default:** `undefined`
278 | 
279 | - **`tools.exclude`** (array of strings):
280 |   - **Description:** Tool names to exclude from discovery.
281 |   - **Default:** `undefined`
282 | 
283 | - **`tools.allowed`** (array of strings):
284 |   - **Description:** A list of tool names that will bypass the confirmation
285 |     dialog. This is useful for tools that you trust and use frequently. For
286 |     example, `["run_shell_command(git)", "run_shell_command(npm test)"]` will
287 |     skip the confirmation dialog to run any `git` and `npm test` commands. See
288 |     [Shell Tool command restrictions](../tools/shell.md#command-restrictions)
289 |     for details on prefix matching, command chaining, etc.
290 |   - **Default:** `undefined`
291 | 
292 | - **`tools.discoveryCommand`** (string):
293 |   - **Description:** Command to run for tool discovery.
294 |   - **Default:** `undefined`
295 | 
296 | - **`tools.callCommand`** (string):
297 |   - **Description:** Defines a custom shell command for calling a specific tool
298 |     that was discovered using `tools.discoveryCommand`. The shell command must
299 |     meet the following criteria:
300 |     - It must take function `name` (exactly as in
301 |       [function declaration](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations))
302 |       as the first command line argument.
303 |     - It must read function arguments as JSON on `stdin`, analogous to
304 |       [`functionCall.args`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functioncall).
305 |     - It must return function output as JSON on `stdout`, analogous to
306 |       [`functionResponse.response.content`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functionresponse).
307 |   - **Default:** `undefined`
308 | 
309 | #### `mcp`
310 | 
311 | - **`mcp.serverCommand`** (string):
312 |   - **Description:** Command to start an MCP server.
313 |   - **Default:** `undefined`
314 | 
315 | - **`mcp.allowed`** (array of strings):
316 |   - **Description:** An allowlist of MCP servers to allow.
317 |   - **Default:** `undefined`
318 | 
319 | - **`mcp.excluded`** (array of strings):
320 |   - **Description:** A denylist of MCP servers to exclude.
321 |   - **Default:** `undefined`
322 | 
323 | #### `security`
324 | 
325 | - **`security.folderTrust.enabled`** (boolean):
326 |   - **Description:** Setting to track whether Folder trust is enabled.
327 |   - **Default:** `false`
328 | 
329 | - **`security.auth.selectedType`** (string):
330 |   - **Description:** The currently selected authentication type.
331 |   - **Default:** `undefined`
332 | 
333 | - **`security.auth.enforcedType`** (string):
334 |   - **Description:** The required auth type (useful for enterprises).
335 |   - **Default:** `undefined`
336 | 
337 | - **`security.auth.useExternal`** (boolean):
338 |   - **Description:** Whether to use an external authentication flow.
339 |   - **Default:** `undefined`
340 | 
341 | #### `advanced`
342 | 
343 | - **`advanced.autoConfigureMemory`** (boolean):
344 |   - **Description:** Automatically configure Node.js memory limits.
345 |   - **Default:** `false`
346 | 
347 | - **`advanced.dnsResolutionOrder`** (string):
348 |   - **Description:** The DNS resolution order.
349 |   - **Default:** `undefined`
350 | 
351 | - **`advanced.excludedEnvVars`** (array of strings):
352 |   - **Description:** Environment variables to exclude from project context.
353 |   - **Default:** `["DEBUG","DEBUG_MODE"]`
354 | 
355 | - **`advanced.bugCommand`** (object):
356 |   - **Description:** Configuration for the bug report command.
357 |   - **Default:** `undefined`
358 | 
359 | #### `mcpServers`
360 | 
361 | Configures connections to one or more Model-Context Protocol (MCP) servers for
362 | discovering and using custom tools. Gemini CLI attempts to connect to each
363 | configured MCP server to discover available tools. If multiple MCP servers
364 | expose a tool with the same name, the tool names will be prefixed with the
365 | server alias you defined in the configuration (e.g.,
366 | `serverAlias__actualToolName`) to avoid conflicts. Note that the system might
367 | strip certain schema properties from MCP tool definitions for compatibility. At
368 | least one of `command`, `url`, or `httpUrl` must be provided. If multiple are
369 | specified, the order of precedence is `httpUrl`, then `url`, then `command`.
370 | 
371 | - **`mcpServers.<SERVER_NAME>`** (object): The server parameters for the named
372 |   server.
373 |   - `command` (string, optional): The command to execute to start the MCP server
374 |     via standard I/O.
375 |   - `args` (array of strings, optional): Arguments to pass to the command.
376 |   - `env` (object, optional): Environment variables to set for the server
377 |     process.
378 |   - `cwd` (string, optional): The working directory in which to start the
379 |     server.
380 |   - `url` (string, optional): The URL of an MCP server that uses Server-Sent
381 |     Events (SSE) for communication.
382 |   - `httpUrl` (string, optional): The URL of an MCP server that uses streamable
383 |     HTTP for communication.
384 |   - `headers` (object, optional): A map of HTTP headers to send with requests to
385 |     `url` or `httpUrl`.
386 |   - `timeout` (number, optional): Timeout in milliseconds for requests to this
387 |     MCP server.
388 |   - `trust` (boolean, optional): Trust this server and bypass all tool call
389 |     confirmations.
390 |   - `description` (string, optional): A brief description of the server, which
391 |     may be used for display purposes.
392 |   - `includeTools` (array of strings, optional): List of tool names to include
393 |     from this MCP server. When specified, only the tools listed here will be
394 |     available from this server (allowlist behavior). If not specified, all tools
395 |     from the server are enabled by default.
396 |   - `excludeTools` (array of strings, optional): List of tool names to exclude
397 |     from this MCP server. Tools listed here will not be available to the model,
398 |     even if they are exposed by the server. **Note:** `excludeTools` takes
399 |     precedence over `includeTools` - if a tool is in both lists, it will be
400 |     excluded.
401 | 
402 | #### `telemetry`
403 | 
404 | Configures logging and metrics collection for Gemini CLI. For more information,
405 | see [Telemetry](../cli/telemetry.md).
406 | 
407 | - **Properties:**
408 |   - **`enabled`** (boolean): Whether or not telemetry is enabled.
409 |   - **`target`** (string): The destination for collected telemetry. Supported
410 |     values are `local` and `gcp`.
411 |   - **`otlpEndpoint`** (string): The endpoint for the OTLP Exporter.
412 |   - **`otlpProtocol`** (string): The protocol for the OTLP Exporter (`grpc` or
413 |     `http`).
414 |   - **`logPrompts`** (boolean): Whether or not to include the content of user
415 |     prompts in the logs.
416 |   - **`outfile`** (string): The file to write telemetry to when `target` is
417 |     `local`.
418 |   - **`useCollector`** (boolean): Whether to use an external OTLP collector.
419 | 
420 | ### Example `settings.json`
421 | 
422 | Here is an example of a `settings.json` file with the nested structure, new as
423 | of v0.3.0:
424 | 
425 | ```json
426 | {
427 |   "general": {
428 |     "vimMode": true,
429 |     "preferredEditor": "code"
430 |   },
431 |   "ui": {
432 |     "theme": "GitHub",
433 |     "hideBanner": true,
434 |     "hideTips": false,
435 |     "customWittyPhrases": [
436 |       "You forget a thousand things every day. Make sure this is one of ’em",
437 |       "Connecting to AGI"
438 |     ]
439 |   },
440 |   "tools": {
441 |     "sandbox": "docker",
442 |     "discoveryCommand": "bin/get_tools",
443 |     "callCommand": "bin/call_tool",
444 |     "exclude": ["write_file"]
445 |   },
446 |   "mcpServers": {
447 |     "mainServer": {
448 |       "command": "bin/mcp_server.py"
449 |     },
450 |     "anotherServer": {
451 |       "command": "node",
452 |       "args": ["mcp_server.js", "--verbose"]
453 |     }
454 |   },
455 |   "telemetry": {
456 |     "enabled": true,
457 |     "target": "local",
458 |     "otlpEndpoint": "http://localhost:4317",
459 |     "logPrompts": true
460 |   },
461 |   "privacy": {
462 |     "usageStatisticsEnabled": true
463 |   },
464 |   "model": {
465 |     "name": "gemini-1.5-pro-latest",
466 |     "maxSessionTurns": 10,
467 |     "summarizeToolOutput": {
468 |       "run_shell_command": {
469 |         "tokenBudget": 100
470 |       }
471 |     }
472 |   },
473 |   "context": {
474 |     "fileName": ["CONTEXT.md", "GEMINI.md"],
475 |     "includeDirectories": ["path/to/dir1", "~/path/to/dir2", "../path/to/dir3"],
476 |     "loadFromIncludeDirectories": true,
477 |     "fileFiltering": {
478 |       "respectGitIgnore": false
479 |     }
480 |   },
481 |   "advanced": {
482 |     "excludedEnvVars": ["DEBUG", "DEBUG_MODE", "NODE_ENV"]
483 |   }
484 | }
485 | ```
486 | 
487 | ## Shell History
488 | 
489 | The CLI keeps a history of shell commands you run. To avoid conflicts between
490 | different projects, this history is stored in a project-specific directory
491 | within your user's home folder.
492 | 
493 | - **Location:** `~/.gemini/tmp/<project_hash>/shell_history`
494 |   - `<project_hash>` is a unique identifier generated from your project's root
495 |     path.
496 |   - The history is stored in a file named `shell_history`.
497 | 
498 | ## Environment Variables & `.env` Files
499 | 
500 | Environment variables are a common way to configure applications, especially for
501 | sensitive information like API keys or for settings that might change between
502 | environments. For authentication setup, see the
503 | [Authentication documentation](./authentication.md) which covers all available
504 | authentication methods.
505 | 
506 | The CLI automatically loads environment variables from an `.env` file. The
507 | loading order is:
508 | 
509 | 1.  `.env` file in the current working directory.
510 | 2.  If not found, it searches upwards in parent directories until it finds an
511 |     `.env` file or reaches the project root (identified by a `.git` folder) or
512 |     the home directory.
513 | 3.  If still not found, it looks for `~/.env` (in the user's home directory).
514 | 
515 | **Environment Variable Exclusion:** Some environment variables (like `DEBUG` and
516 | `DEBUG_MODE`) are automatically excluded from being loaded from project `.env`
517 | files to prevent interference with gemini-cli behavior. Variables from
518 | `.gemini/.env` files are never excluded. You can customize this behavior using
519 | the `advanced.excludedEnvVars` setting in your `settings.json` file.
520 | 
521 | - **`GEMINI_API_KEY`**:
522 |   - Your API key for the Gemini API.
523 |   - One of several available [authentication methods](./authentication.md).
524 |   - Set this in your shell profile (e.g., `~/.bashrc`, `~/.zshrc`) or an `.env`
525 |     file.
526 | - **`GEMINI_MODEL`**:
527 |   - Specifies the default Gemini model to use.
528 |   - Overrides the hardcoded default
529 |   - Example: `export GEMINI_MODEL="gemini-2.5-flash"`
530 | - **`GOOGLE_API_KEY`**:
531 |   - Your Google Cloud API key.
532 |   - Required for using Vertex AI in express mode.
533 |   - Ensure you have the necessary permissions.
534 |   - Example: `export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"`.
535 | - **`GOOGLE_CLOUD_PROJECT`**:
536 |   - Your Google Cloud Project ID.
537 |   - Required for using Code Assist or Vertex AI.
538 |   - If using Vertex AI, ensure you have the necessary permissions in this
539 |     project.
540 |   - **Cloud Shell Note:** When running in a Cloud Shell environment, this
541 |     variable defaults to a special project allocated for Cloud Shell users. If
542 |     you have `GOOGLE_CLOUD_PROJECT` set in your global environment in Cloud
543 |     Shell, it will be overridden by this default. To use a different project in
544 |     Cloud Shell, you must define `GOOGLE_CLOUD_PROJECT` in a `.env` file.
545 |   - Example: `export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
546 | - **`GOOGLE_APPLICATION_CREDENTIALS`** (string):
547 |   - **Description:** The path to your Google Application Credentials JSON file.
548 |   - **Example:**
549 |     `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
550 | - **`OTLP_GOOGLE_CLOUD_PROJECT`**:
551 |   - Your Google Cloud Project ID for Telemetry in Google Cloud
552 |   - Example: `export OTLP_GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
553 | - **`GEMINI_TELEMETRY_ENABLED`**:
554 |   - Set to `true` or `1` to enable telemetry. Any other value is treated as
555 |     disabling it.
556 |   - Overrides the `telemetry.enabled` setting.
557 | - **`GEMINI_TELEMETRY_TARGET`**:
558 |   - Sets the telemetry target (`local` or `gcp`).
559 |   - Overrides the `telemetry.target` setting.
560 | - **`GEMINI_TELEMETRY_OTLP_ENDPOINT`**:
561 |   - Sets the OTLP endpoint for telemetry.
562 |   - Overrides the `telemetry.otlpEndpoint` setting.
563 | - **`GEMINI_TELEMETRY_OTLP_PROTOCOL`**:
564 |   - Sets the OTLP protocol (`grpc` or `http`).
565 |   - Overrides the `telemetry.otlpProtocol` setting.
566 | - **`GEMINI_TELEMETRY_LOG_PROMPTS`**:
567 |   - Set to `true` or `1` to enable or disable logging of user prompts. Any other
568 |     value is treated as disabling it.
569 |   - Overrides the `telemetry.logPrompts` setting.
570 | - **`GEMINI_TELEMETRY_OUTFILE`**:
571 |   - Sets the file path to write telemetry to when the target is `local`.
572 |   - Overrides the `telemetry.outfile` setting.
573 | - **`GEMINI_TELEMETRY_USE_COLLECTOR`**:
574 |   - Set to `true` or `1` to enable or disable using an external OTLP collector.
575 |     Any other value is treated as disabling it.
576 |   - Overrides the `telemetry.useCollector` setting.
577 | - **`GOOGLE_CLOUD_LOCATION`**:
578 |   - Your Google Cloud Project Location (e.g., us-central1).
579 |   - Required for using Vertex AI in non-express mode.
580 |   - Example: `export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"`.
581 | - **`GEMINI_SANDBOX`**:
582 |   - Alternative to the `sandbox` setting in `settings.json`.
583 |   - Accepts `true`, `false`, `docker`, `podman`, or a custom command string.
584 | - **`SEATBELT_PROFILE`** (macOS specific):
585 |   - Switches the Seatbelt (`sandbox-exec`) profile on macOS.
586 |   - `permissive-open`: (Default) Restricts writes to the project folder (and a
587 |     few other folders, see
588 |     `packages/cli/src/utils/sandbox-macos-permissive-open.sb`) but allows other
589 |     operations.
590 |   - `strict`: Uses a strict profile that declines operations by default.
591 |   - `<profile_name>`: Uses a custom profile. To define a custom profile, create
592 |     a file named `sandbox-macos-<profile_name>.sb` in your project's `.gemini/`
593 |     directory (e.g., `my-project/.gemini/sandbox-macos-custom.sb`).
594 | - **`DEBUG` or `DEBUG_MODE`** (often used by underlying libraries or the CLI
595 |   itself):
596 |   - Set to `true` or `1` to enable verbose debug logging, which can be helpful
597 |     for troubleshooting.
598 |   - **Note:** These variables are automatically excluded from project `.env`
599 |     files by default to prevent interference with gemini-cli behavior. Use
600 |     `.gemini/.env` files if you need to set these for gemini-cli specifically.
601 | - **`NO_COLOR`**:
602 |   - Set to any value to disable all color output in the CLI.
603 | - **`CLI_TITLE`**:
604 |   - Set to a string to customize the title of the CLI.
605 | - **`CODE_ASSIST_ENDPOINT`**:
606 |   - Specifies the endpoint for the code assist server.
607 |   - This is useful for development and testing.
608 | 
609 | ## Command-Line Arguments
610 | 
611 | Arguments passed directly when running the CLI can override other configurations
612 | for that specific session.
613 | 
614 | - **`--model <model_name>`** (**`-m <model_name>`**):
615 |   - Specifies the Gemini model to use for this session.
616 |   - Example: `npm start -- --model gemini-1.5-pro-latest`
617 | - **`--prompt <your_prompt>`** (**`-p <your_prompt>`**):
618 |   - Used to pass a prompt directly to the command. This invokes Gemini CLI in a
619 |     non-interactive mode.
620 |   - For scripting examples, use the `--output-format json` flag to get
621 |     structured output.
622 | - **`--prompt-interactive <your_prompt>`** (**`-i <your_prompt>`**):
623 |   - Starts an interactive session with the provided prompt as the initial input.
624 |   - The prompt is processed within the interactive session, not before it.
625 |   - Cannot be used when piping input from stdin.
626 |   - Example: `gemini -i "explain this code"`
627 | - **`--output-format <format>`**:
628 |   - **Description:** Specifies the format of the CLI output for non-interactive
629 |     mode.
630 |   - **Values:**
631 |     - `text`: (Default) The standard human-readable output.
632 |     - `json`: A machine-readable JSON output.
633 |   - **Note:** For structured output and scripting, use the
634 |     `--output-format json` flag.
635 | - **`--sandbox`** (**`-s`**):
636 |   - Enables sandbox mode for this session.
637 | - **`--sandbox-image`**:
638 |   - Sets the sandbox image URI.
639 | - **`--debug`** (**`-d`**):
640 |   - Enables debug mode for this session, providing more verbose output.
641 | - **`--all-files`** (**`-a`**):
642 |   - If set, recursively includes all files within the current directory as
643 |     context for the prompt.
644 | - **`--help`** (or **`-h`**):
645 |   - Displays help information about command-line arguments.
646 | - **`--show-memory-usage`**:
647 |   - Displays the current memory usage.
648 | - **`--yolo`**:
649 |   - Enables YOLO mode, which automatically approves all tool calls.
650 | - **`--approval-mode <mode>`**:
651 |   - Sets the approval mode for tool calls. Available modes:
652 |     - `default`: Prompt for approval on each tool call (default behavior)
653 |     - `auto_edit`: Automatically approve edit tools (replace, write_file) while
654 |       prompting for others
655 |     - `yolo`: Automatically approve all tool calls (equivalent to `--yolo`)
656 |   - Cannot be used together with `--yolo`. Use `--approval-mode=yolo` instead of
657 |     `--yolo` for the new unified approach.
658 |   - Example: `gemini --approval-mode auto_edit`
659 | - **`--allowed-tools <tool1,tool2,...>`**:
660 |   - A comma-separated list of tool names that will bypass the confirmation
661 |     dialog.
662 |   - Example: `gemini --allowed-tools "ShellTool(git status)"`
663 | - **`--telemetry`**:
664 |   - Enables [telemetry](../cli/telemetry.md).
665 | - **`--telemetry-target`**:
666 |   - Sets the telemetry target. See [telemetry](../cli/telemetry.md) for more
667 |     information.
668 | - **`--telemetry-otlp-endpoint`**:
669 |   - Sets the OTLP endpoint for telemetry. See [telemetry](../cli/telemetry.md)
670 |     for more information.
671 | - **`--telemetry-otlp-protocol`**:
672 |   - Sets the OTLP protocol for telemetry (`grpc` or `http`). Defaults to `grpc`.
673 |     See [telemetry](../cli/telemetry.md) for more information.
674 | - **`--telemetry-log-prompts`**:
675 |   - Enables logging of prompts for telemetry. See
676 |     [telemetry](../cli/telemetry.md) for more information.
677 | - **`--checkpointing`**:
678 |   - Enables [checkpointing](../cli/checkpointing.md).
679 | - **`--extensions <extension_name ...>`** (**`-e <extension_name ...>`**):
680 |   - Specifies a list of extensions to use for the session. If not provided, all
681 |     available extensions are used.
682 |   - Use the special term `gemini -e none` to disable all extensions.
683 |   - Example: `gemini -e my-extension -e my-other-extension`
684 | - **`--list-extensions`** (**`-l`**):
685 |   - Lists all available extensions and exits.
686 | - **`--proxy`**:
687 |   - Sets the proxy for the CLI.
688 |   - Example: `--proxy http://localhost:7890`.
689 | - **`--include-directories <dir1,dir2,...>`**:
690 |   - Includes additional directories in the workspace for multi-directory
691 |     support.
692 |   - Can be specified multiple times or as comma-separated values.
693 |   - 5 directories can be added at maximum.
694 |   - Example: `--include-directories /path/to/project1,/path/to/project2` or
695 |     `--include-directories /path/to/project1 --include-directories /path/to/project2`
696 | - **`--screen-reader`**:
697 |   - Enables screen reader mode, which adjusts the TUI for better compatibility
698 |     with screen readers.
699 | - **`--version`**:
700 |   - Displays the version of the CLI.
701 | 
702 | ## Context Files (Hierarchical Instructional Context)
703 | 
704 | While not strictly configuration for the CLI's _behavior_, context files
705 | (defaulting to `GEMINI.md` but configurable via the `context.fileName` setting)
706 | are crucial for configuring the _instructional context_ (also referred to as
707 | "memory") provided to the Gemini model. This powerful feature allows you to give
708 | project-specific instructions, coding style guides, or any relevant background
709 | information to the AI, making its responses more tailored and accurate to your
710 | needs. The CLI includes UI elements, such as an indicator in the footer showing
711 | the number of loaded context files, to keep you informed about the active
712 | context.
713 | 
714 | - **Purpose:** These Markdown files contain instructions, guidelines, or context
715 |   that you want the Gemini model to be aware of during your interactions. The
716 |   system is designed to manage this instructional context hierarchically.
717 | 
718 | ### Example Context File Content (e.g., `GEMINI.md`)
719 | 
720 | Here's a conceptual example of what a context file at the root of a TypeScript
721 | project might contain:
722 | 
723 | ```markdown
724 | # Project: My Awesome TypeScript Library
725 | 
726 | ## General Instructions:
727 | 
728 | - When generating new TypeScript code, please follow the existing coding style.
729 | - Ensure all new functions and classes have JSDoc comments.
730 | - Prefer functional programming paradigms where appropriate.
731 | - All code should be compatible with TypeScript 5.0 and Node.js 20+.
732 | 
733 | ## Coding Style:
734 | 
735 | - Use 2 spaces for indentation.
736 | - Interface names should be prefixed with `I` (e.g., `IUserService`).
737 | - Private class members should be prefixed with an underscore (`_`).
738 | - Always use strict equality (`===` and `!==`).
739 | 
740 | ## Specific Component: `src/api/client.ts`
741 | 
742 | - This file handles all outbound API requests.
743 | - When adding new API call functions, ensure they include robust error handling
744 |   and logging.
745 | - Use the existing `fetchWithRetry` utility for all GET requests.
746 | 
747 | ## Regarding Dependencies:
748 | 
749 | - Avoid introducing new external dependencies unless absolutely necessary.
750 | - If a new dependency is required, please state the reason.
751 | ```
752 | 
753 | This example demonstrates how you can provide general project context, specific
754 | coding conventions, and even notes about particular files or components. The
755 | more relevant and precise your context files are, the better the AI can assist
756 | you. Project-specific context files are highly encouraged to establish
757 | conventions and context.
758 | 
759 | - **Hierarchical Loading and Precedence:** The CLI implements a sophisticated
760 |   hierarchical memory system by loading context files (e.g., `GEMINI.md`) from
761 |   several locations. Content from files lower in this list (more specific)
762 |   typically overrides or supplements content from files higher up (more
763 |   general). The exact concatenation order and final context can be inspected
764 |   using the `/memory show` command. The typical loading order is:
765 |   1.  **Global Context File:**
766 |       - Location: `~/.gemini/<configured-context-filename>` (e.g.,
767 |         `~/.gemini/GEMINI.md` in your user home directory).
768 |       - Scope: Provides default instructions for all your projects.
769 |   2.  **Project Root & Ancestors Context Files:**
770 |       - Location: The CLI searches for the configured context file in the
771 |         current working directory and then in each parent directory up to either
772 |         the project root (identified by a `.git` folder) or your home directory.
773 |       - Scope: Provides context relevant to the entire project or a significant
774 |         portion of it.
775 |   3.  **Sub-directory Context Files (Contextual/Local):**
776 |       - Location: The CLI also scans for the configured context file in
777 |         subdirectories _below_ the current working directory (respecting common
778 |         ignore patterns like `node_modules`, `.git`, etc.). The breadth of this
779 |         search is limited to 200 directories by default, but can be configured
780 |         with the `context.discoveryMaxDirs` setting in your `settings.json`
781 |         file.
782 |       - Scope: Allows for highly specific instructions relevant to a particular
783 |         component, module, or subsection of your project.
784 | - **Concatenation & UI Indication:** The contents of all found context files are
785 |   concatenated (with separators indicating their origin and path) and provided
786 |   as part of the system prompt to the Gemini model. The CLI footer displays the
787 |   count of loaded context files, giving you a quick visual cue about the active
788 |   instructional context.
789 | - **Importing Content:** You can modularize your context files by importing
790 |   other Markdown files using the `@path/to/file.md` syntax. For more details,
791 |   see the [Memory Import Processor documentation](../core/memport.md).
792 | - **Commands for Memory Management:**
793 |   - Use `/memory refresh` to force a re-scan and reload of all context files
794 |     from all configured locations. This updates the AI's instructional context.
795 |   - Use `/memory show` to display the combined instructional context currently
796 |     loaded, allowing you to verify the hierarchy and content being used by the
797 |     AI.
798 |   - See the [Commands documentation](../cli/commands.md#memory) for full details
799 |     on the `/memory` command and its sub-commands (`show` and `refresh`).
800 | 
801 | By understanding and utilizing these configuration layers and the hierarchical
802 | nature of context files, you can effectively manage the AI's memory and tailor
803 | the Gemini CLI's responses to your specific needs and projects.
804 | 
805 | ## Sandboxing
806 | 
807 | The Gemini CLI can execute potentially unsafe operations (like shell commands
808 | and file modifications) within a sandboxed environment to protect your system.
809 | 
810 | Sandboxing is disabled by default, but you can enable it in a few ways:
811 | 
812 | - Using `--sandbox` or `-s` flag.
813 | - Setting `GEMINI_SANDBOX` environment variable.
814 | - Sandbox is enabled when using `--yolo` or `--approval-mode=yolo` by default.
815 | 
816 | By default, it uses a pre-built `gemini-cli-sandbox` Docker image.
817 | 
818 | For project-specific sandboxing needs, you can create a custom Dockerfile at
819 | `.gemini/sandbox.Dockerfile` in your project's root directory. This Dockerfile
820 | can be based on the base sandbox image:
821 | 
822 | ```dockerfile
823 | FROM gemini-cli-sandbox
824 | 
825 | # Add your custom dependencies or configurations here
826 | # For example:
827 | # RUN apt-get update && apt-get install -y some-package
828 | # COPY ./my-config /app/my-config
829 | ```
830 | 
831 | When `.gemini/sandbox.Dockerfile` exists, you can use `BUILD_SANDBOX`
832 | environment variable when running Gemini CLI to automatically build the custom
833 | sandbox image:
834 | 
835 | ```bash
836 | BUILD_SANDBOX=1 gemini -s
837 | ```
838 | 
839 | ## Usage Statistics
840 | 
841 | To help us improve the Gemini CLI, we collect anonymized usage statistics. This
842 | data helps us understand how the CLI is used, identify common issues, and
843 | prioritize new features.
844 | 
845 | **What we collect:**
846 | 
847 | - **Tool Calls:** We log the names of the tools that are called, whether they
848 |   succeed or fail, and how long they take to execute. We do not collect the
849 |   arguments passed to the tools or any data returned by them.
850 | - **API Requests:** We log the Gemini model used for each request, the duration
851 |   of the request, and whether it was successful. We do not collect the content
852 |   of the prompts or responses.
853 | - **Session Information:** We collect information about the configuration of the
854 |   CLI, such as the enabled tools and the approval mode.
855 | 
856 | **What we DON'T collect:**
857 | 
858 | - **Personally Identifiable Information (PII):** We do not collect any personal
859 |   information, such as your name, email address, or API keys.
860 | - **Prompt and Response Content:** We do not log the content of your prompts or
861 |   the responses from the Gemini model.
862 | - **File Content:** We do not log the content of any files that are read or
863 |   written by the CLI.
864 | 
865 | **How to opt out:**
866 | 
867 | You can opt out of usage statistics collection at any time by setting the
868 | `usageStatisticsEnabled` property to `false` under the `privacy` category in
869 | your `settings.json` file:
870 | 
871 | ```json
872 | {
873 |   "privacy": {
874 |     "usageStatisticsEnabled": false
875 |   }
876 | }
877 | ```
```

get-started/deployment.md
```
1 | Note: This page will be replaced by [installation.md](installation.md).
2 | 
3 | # Gemini CLI Installation, Execution, and Deployment
4 | 
5 | Install and run Gemini CLI. This document provides an overview of Gemini CLI's
6 | installation methods and deployment architecture.
7 | 
8 | ## How to install and/or run Gemini CLI
9 | 
10 | There are several ways to run Gemini CLI. The recommended option depends on how
11 | you intend to use Gemini CLI.
12 | 
13 | - As a standard installation. This is the most straightforward method of using
14 |   Gemini CLI.
15 | - In a sandbox. This method offers increased security and isolation.
16 | - From the source. This is recommended for contributors to the project.
17 | 
18 | ### 1. Standard installation (recommended for standard users)
19 | 
20 | This is the recommended way for end-users to install Gemini CLI. It involves
21 | downloading the Gemini CLI package from the NPM registry.
22 | 
23 | - **Global install:**
24 | 
25 |   ```bash
26 |   npm install -g @google/gemini-cli
27 |   ```
28 | 
29 |   Then, run the CLI from anywhere:
30 | 
31 |   ```bash
32 |   gemini
33 |   ```
34 | 
35 | - **NPX execution:**
36 | 
37 |   ```bash
38 |   # Execute the latest version from NPM without a global install
39 |   npx @google/gemini-cli
40 |   ```
41 | 
42 | ### 2. Run in a sandbox (Docker/Podman)
43 | 
44 | For security and isolation, Gemini CLI can be run inside a container. This is
45 | the default way that the CLI executes tools that might have side effects.
46 | 
47 | - **Directly from the Registry:** You can run the published sandbox image
48 |   directly. This is useful for environments where you only have Docker and want
49 |   to run the CLI.
50 |   ```bash
51 |   # Run the published sandbox image
52 |   docker run --rm -it us-docker.pkg.dev/gemini-code-dev/gemini-cli/sandbox:0.1.1
53 |   ```
54 | - **Using the `--sandbox` flag:** If you have Gemini CLI installed locally
55 |   (using the standard installation described above), you can instruct it to run
56 |   inside the sandbox container.
57 |   ```bash
58 |   gemini --sandbox -y -p "your prompt here"
59 |   ```
60 | 
61 | ### 3. Run from source (recommended for Gemini CLI contributors)
62 | 
63 | Contributors to the project will want to run the CLI directly from the source
64 | code.
65 | 
66 | - **Development Mode:** This method provides hot-reloading and is useful for
67 |   active development.
68 |   ```bash
69 |   # From the root of the repository
70 |   npm run start
71 |   ```
72 | - **Production-like mode (Linked package):** This method simulates a global
73 |   installation by linking your local package. It's useful for testing a local
74 |   build in a production workflow.
75 | 
76 |   ```bash
77 |   # Link the local cli package to your global node_modules
78 |   npm link packages/cli
79 | 
80 |   # Now you can run your local version using the `gemini` command
81 |   gemini
82 |   ```
83 | 
84 | ---
85 | 
86 | ### 4. Running the latest Gemini CLI commit from GitHub
87 | 
88 | You can run the most recently committed version of Gemini CLI directly from the
89 | GitHub repository. This is useful for testing features still in development.
90 | 
91 | ```bash
92 | # Execute the CLI directly from the main branch on GitHub
93 | npx https://github.com/google-gemini/gemini-cli
94 | ```
95 | 
96 | ## Deployment architecture
97 | 
98 | The execution methods described above are made possible by the following
99 | architectural components and processes:
100 | 
101 | **NPM packages**
102 | 
103 | Gemini CLI project is a monorepo that publishes two core packages to the NPM
104 | registry:
105 | 
106 | - `@google/gemini-cli-core`: The backend, handling logic and tool execution.
107 | - `@google/gemini-cli`: The user-facing frontend.
108 | 
109 | These packages are used when performing the standard installation and when
110 | running Gemini CLI from the source.
111 | 
112 | **Build and packaging processes**
113 | 
114 | There are two distinct build processes used, depending on the distribution
115 | channel:
116 | 
117 | - **NPM publication:** For publishing to the NPM registry, the TypeScript source
118 |   code in `@google/gemini-cli-core` and `@google/gemini-cli` is transpiled into
119 |   standard JavaScript using the TypeScript Compiler (`tsc`). The resulting
120 |   `dist/` directory is what gets published in the NPM package. This is a
121 |   standard approach for TypeScript libraries.
122 | 
123 | - **GitHub `npx` execution:** When running the latest version of Gemini CLI
124 |   directly from GitHub, a different process is triggered by the `prepare` script
125 |   in `package.json`. This script uses `esbuild` to bundle the entire application
126 |   and its dependencies into a single, self-contained JavaScript file. This
127 |   bundle is created on-the-fly on the user's machine and is not checked into the
128 |   repository.
129 | 
130 | **Docker sandbox image**
131 | 
132 | The Docker-based execution method is supported by the `gemini-cli-sandbox`
133 | container image. This image is published to a container registry and contains a
134 | pre-installed, global version of Gemini CLI.
135 | 
136 | ## Release process
137 | 
138 | The release process is automated through GitHub Actions. The release workflow
139 | performs the following actions:
140 | 
141 | 1.  Build the NPM packages using `tsc`.
142 | 2.  Publish the NPM packages to the artifact registry.
143 | 3.  Create GitHub releases with bundled assets.
```

get-started/examples.md
```
1 | # Gemini CLI Examples
2 | 
3 | Not sure where to get started with Gemini CLI? This document covers examples on
4 | how to use Gemini CLI for a variety of tasks.
5 | 
6 | **Note:** Results are examples intended to showcase potential use cases. Your
7 | results may vary.
8 | 
9 | ## Rename your photographs based on content
10 | 
11 | Scenario: You have a folder containing the following files:
12 | 
13 | ```bash
14 | photos/photo1.png
15 | photos/photo2.png
16 | photos/photo3.png
17 | ```
18 | 
19 | Give Gemini the following prompt:
20 | 
21 | ```cli
22 | Rename the photos in my "photos" directory based on their contents.
23 | ```
24 | 
25 | Result: Gemini will ask for permission to rename your files.
26 | 
27 | Select **Yes, allow once.** and your files will be renamed:
28 | 
29 | ```bash
30 | photos/yellow_flowers.png
31 | photos/antique_dresser.png
32 | photos/green_android_robot.png
33 | ```
34 | 
35 | ## Explain a repository by reading its code
36 | 
37 | Scenario: You want to understand how a popular open-source utility works by
38 | inspecting its code, not just its README.
39 | 
40 | Give Gemini CLI the following prompt:
41 | 
42 | ```cli
43 | Clone the 'chalk' repository from https://github.com/chalk/chalk, read its key source files, and explain how it works.
44 | ```
45 | 
46 | Result: Gemini will perform a sequence of actions to answer your request.
47 | 
48 | 1.  First, it will ask for permission to run `git clone` to download the
49 |     repository.
50 | 2.  Next, it will find the important source files and ask for permission to read
51 |     them.
52 | 3.  Finally, after analyzing the code, it will provide a summary.
53 | 
54 | Gemini CLI will return an explanation based on the actual source code:
55 | 
56 | ```markdown
57 | The `chalk` library is a popular npm package for styling terminal output with
58 | colors. After analyzing the source code, here's how it works:
59 | 
60 | - **Core Functionality:** The main file sets up a chainable API. Each color or
61 |   modifier (like `bold` or `italic`) is a getter that appends the corresponding
62 |   ANSI escape code to an internal stack.
63 | 
64 | - **Chainable API:** When you call `chalk.red.bold('Hello')`, you are accessing
65 |   getters. The `red` getter adds the red color code, and the `bold` getter adds
66 |   the bold code.
67 | 
68 | - **Output Generation:** When the chain is treated as a string (e.g., in
69 |   `console.log`), a final `toString()` method is called. This method joins all
70 |   the stored ANSI codes, wraps them around the input string ('Hello'), and adds
71 |   a reset code at the end. This produces the final, styled string that the
72 |   terminal can render.
73 | ```
74 | 
75 | ## Combine two spreadsheets into one spreadsheet
76 | 
77 | Scenario: You have two .csv files: `Revenue - 2023.csv` and
78 | `Revenue - 2024.csv`. Each file contains monthly revenue figures, like so:
79 | 
80 | ```csv
81 | January,0
82 | February,0
83 | March,0
84 | April,900
85 | May,1000
86 | June,1000
87 | July,1200
88 | August,1800
89 | September,2000
90 | October,2400
91 | November,3400
92 | December,2100
93 | ```
94 | 
95 | You want to combine these two .csv files into a single .csv file.
96 | 
97 | Give Gemini CLI the following prompt:
98 | 
99 | ```cli
100 | Combine the two .csv files into a single .csv file, with each year a different column.
101 | ```
102 | 
103 | Result: Gemini CLI will read each file and then ask for permission to write a
104 | new file. Provide your permission and Gemini CLI will provide the following
105 | .csv:
106 | 
107 | ```csv
108 | Month,2023,2024
109 | January,0,1000
110 | February,0,1200
111 | March,0,2400
112 | April,900,500
113 | May,1000,800
114 | June,1000,900
115 | July,1200,1000
116 | August,1800,400
117 | September,2000,2000
118 | October,2400,3400
119 | November,3400,1800
120 | December,2100,9000
121 | ```
122 | 
123 | ## Run unit tests
124 | 
125 | Scenario: You've written a simple login page. You wish to write unit tests to
126 | ensure that your login page has code coverage.
127 | 
128 | Give Gemini CLI the following prompt:
129 | 
130 | ```cli
131 | Write unit tests for Login.js.
132 | ```
133 | 
134 | Result: Gemini CLI will ask for permission to write a new file and create a test
135 | for your login page
136 | 
137 | ```javascript
138 | import React from 'react';
139 | import { render, fireEvent, waitFor } from '@testing-library/react';
140 | import Login from './Login';
141 | 
142 | // Mock the API call for login
143 | jest.mock('./api', () => ({
144 |   login: jest.fn(),
145 | }));
146 | 
147 | describe('Login component', () => {
148 |   it('renders the login form correctly', () => {
149 |     const { getByLabelText, getByText } = render(<Login />);
150 | 
151 |     expect(getByLabelText('Username')).toBeInTheDocument();
152 |     expect(getByLabelText('Password')).toBeInTheDocument();
153 |     expect(getByText('Login')).toBeInTheDocument();
154 |   });
155 | 
156 |   it('shows an error message with invalid credentials', async () => {
157 |     const { getByLabelText, getByText, findByText } = render(<Login />);
158 |     const usernameInput = getByLabelText('Username');
159 |     const passwordInput = getByLabelText('Password');
160 |     const loginButton = getByText('Login');
161 | 
162 |     // Mock the API to return an error
163 |     require('./api').login.mockRejectedValue(new Error('Invalid credentials'));
164 | 
165 |     fireEvent.change(usernameInput, { target: { value: 'testuser' } });
166 |     fireEvent.change(passwordInput, { target: { value: 'wrongpassword' } });
167 |     fireEvent.click(loginButton);
168 | 
169 |     const errorMessage = await findByText('Invalid credentials');
170 |     expect(errorMessage).toBeInTheDocument();
171 |   });
172 | 
173 |   it('logs in successfully with valid credentials', async () => {
174 |     const onLoginSuccess = jest.fn();
175 |     const { getByLabelText, getByText } = render(
176 |       <Login onLoginSuccess={onLoginSuccess} />,
177 |     );
178 |     const usernameInput = getByLabelText('Username');
179 |     const passwordInput = getByLabelText('Password');
180 |     const loginButton = getByText('Login');
181 | 
182 |     // Mock the API to return a success message
183 |     require('./api').login.mockResolvedValue({ success: true });
184 | 
185 |     fireEvent.change(usernameInput, { target: { value: 'testuser' } });
186 |     fireEvent.change(passwordInput, { target: { value: 'correctpassword' } });
187 |     fireEvent.click(loginButton);
188 | 
189 |     await waitFor(() => {
190 |       expect(onLoginSuccess).toHaveBeenCalled();
191 |     });
192 |   });
193 | 
194 |   it('disables the submit button while submitting', async () => {
195 |     const { getByLabelText, getByText } = render(<Login />);
196 |     const usernameInput = getByLabelText('Username');
197 |     const passwordInput = getByLabelText('Password');
198 |     const loginButton = getByText('Login');
199 | 
200 |     // Mock the API to have a delay
201 |     require('./api').login.mockImplementation(
202 |       () =>
203 |         new Promise((resolve) =>
204 |           setTimeout(() => resolve({ success: true }), 1000),
205 |         ),
206 |     );
207 | 
208 |     fireEvent.change(usernameInput, { target: { value: 'testuser' } });
209 |     fireEvent.change(passwordInput, { target: { value: 'correctpassword' } });
210 |     fireEvent.click(loginButton);
211 | 
212 |     expect(loginButton).toBeDisabled();
213 | 
214 |     await waitFor(() => {
215 |       expect(loginButton).not.toBeDisabled();
216 |     });
217 |   });
218 | });
219 | ```
```

get-started/index.md
```
1 | # Get Started with Gemini CLI
2 | 
3 | Welcome to Gemini CLI! This guide will help you install, configure, and start
4 | using the Gemini CLI to enhance your workflow right from your terminal.
5 | 
6 | ## Quickstart: Install, authenticate, configure, and use Gemini CLI
7 | 
8 | Gemini CLI brings the power of advanced language models directly to your command
9 | line interface. As an AI-powered assistant, Gemini CLI can help you with a
10 | variety of tasks, from understanding and generating code to reviewing and
11 | editing documents.
12 | 
13 | ## Install
14 | 
15 | The standard method to install and run Gemini CLI uses `npm`:
16 | 
17 | ```bash
18 | npm install -g @google/gemini-cli
19 | ```
20 | 
21 | Once Gemini CLI is installed, run Gemini CLI from your command line:
22 | 
23 | ```bash
24 | gemini
25 | ```
26 | 
27 | For more installation options, see [Gemini CLI Installation](./installation.md).
28 | 
29 | ## Authenticate
30 | 
31 | To begin using Gemini CLI, you must authenticate with a Google service. The most
32 | straightforward authentication method uses your existing Google account:
33 | 
34 | 1. Run Gemini CLI after installation:
35 |    ```bash
36 |    gemini
37 |    ```
38 | 2. When asked "How would you like to authenticate for this project?" select **1.
39 |    Login with Google**.
40 | 3. Select your Google account.
41 | 4. Click on **Sign in**.
42 | 
43 | For other authentication options and information, see
44 | [GeminI CLI Authentication Setup](./authentication.md).
45 | 
46 | ## Configure
47 | 
48 | Gemini CLI offers several ways to configure its behavior, including environment
49 | variables, command-line arguments, and settings files.
50 | 
51 | To explore your configuration options, see
52 | [Gemini CLI Configuration](./configuration.md).
53 | 
54 | ## Use
55 | 
56 | Once installed and authenticated, you can start using Gemini CLI by issuing
57 | commands and prompts in your terminal. Ask it to generate code, explain files,
58 | and more.
59 | 
60 | To explore the power of Gemini CLI, see [Gemini CLI examples](./examples.md).
61 | 
62 | ## What's next?
63 | 
64 | - Find out more about [Gemini CLI's tools](../tools/index.md).
65 | - Review [Gemini CLI's commands](../cli/commands.md).
```

get-started/installation.md
```
1 | # Gemini CLI Installation, Execution, and Deployment
2 | 
3 | Install and run Gemini CLI. This document provides an overview of Gemini CLI's
4 | installation methods and deployment architecture.
5 | 
6 | ## How to install and/or run Gemini CLI
7 | 
8 | There are several ways to run Gemini CLI. The recommended option depends on how
9 | you intend to use Gemini CLI.
10 | 
11 | - As a standard installation. This is the most straightforward method of using
12 |   Gemini CLI.
13 | - In a sandbox. This method offers increased security and isolation.
14 | - From the source. This is recommended for contributors to the project.
15 | 
16 | ### 1. Standard installation (recommended for standard users)
17 | 
18 | This is the recommended way for end-users to install Gemini CLI. It involves
19 | downloading the Gemini CLI package from the NPM registry.
20 | 
21 | - **Global install:**
22 | 
23 |   ```bash
24 |   npm install -g @google/gemini-cli
25 |   ```
26 | 
27 |   Then, run the CLI from anywhere:
28 | 
29 |   ```bash
30 |   gemini
31 |   ```
32 | 
33 | - **NPX execution:**
34 | 
35 |   ```bash
36 |   # Execute the latest version from NPM without a global install
37 |   npx @google/gemini-cli
38 |   ```
39 | 
40 | ### 2. Run in a sandbox (Docker/Podman)
41 | 
42 | For security and isolation, Gemini CLI can be run inside a container. This is
43 | the default way that the CLI executes tools that might have side effects.
44 | 
45 | - **Directly from the Registry:** You can run the published sandbox image
46 |   directly. This is useful for environments where you only have Docker and want
47 |   to run the CLI.
48 |   ```bash
49 |   # Run the published sandbox image
50 |   docker run --rm -it us-docker.pkg.dev/gemini-code-dev/gemini-cli/sandbox:0.1.1
51 |   ```
52 | - **Using the `--sandbox` flag:** If you have Gemini CLI installed locally
53 |   (using the standard installation described above), you can instruct it to run
54 |   inside the sandbox container.
55 |   ```bash
56 |   gemini --sandbox -y -p "your prompt here"
57 |   ```
58 | 
59 | ### 3. Run from source (recommended for Gemini CLI contributors)
60 | 
61 | Contributors to the project will want to run the CLI directly from the source
62 | code.
63 | 
64 | - **Development Mode:** This method provides hot-reloading and is useful for
65 |   active development.
66 |   ```bash
67 |   # From the root of the repository
68 |   npm run start
69 |   ```
70 | - **Production-like mode (Linked package):** This method simulates a global
71 |   installation by linking your local package. It's useful for testing a local
72 |   build in a production workflow.
73 | 
74 |   ```bash
75 |   # Link the local cli package to your global node_modules
76 |   npm link packages/cli
77 | 
78 |   # Now you can run your local version using the `gemini` command
79 |   gemini
80 |   ```
81 | 
82 | ---
83 | 
84 | ### 4. Running the latest Gemini CLI commit from GitHub
85 | 
86 | You can run the most recently committed version of Gemini CLI directly from the
87 | GitHub repository. This is useful for testing features still in development.
88 | 
89 | ```bash
90 | # Execute the CLI directly from the main branch on GitHub
91 | npx https://github.com/google-gemini/gemini-cli
92 | ```
93 | 
94 | ## Deployment architecture
95 | 
96 | The execution methods described above are made possible by the following
97 | architectural components and processes:
98 | 
99 | **NPM packages**
100 | 
101 | Gemini CLI project is a monorepo that publishes two core packages to the NPM
102 | registry:
103 | 
104 | - `@google/gemini-cli-core`: The backend, handling logic and tool execution.
105 | - `@google/gemini-cli`: The user-facing frontend.
106 | 
107 | These packages are used when performing the standard installation and when
108 | running Gemini CLI from the source.
109 | 
110 | **Build and packaging processes**
111 | 
112 | There are two distinct build processes used, depending on the distribution
113 | channel:
114 | 
115 | - **NPM publication:** For publishing to the NPM registry, the TypeScript source
116 |   code in `@google/gemini-cli-core` and `@google/gemini-cli` is transpiled into
117 |   standard JavaScript using the TypeScript Compiler (`tsc`). The resulting
118 |   `dist/` directory is what gets published in the NPM package. This is a
119 |   standard approach for TypeScript libraries.
120 | 
121 | - **GitHub `npx` execution:** When running the latest version of Gemini CLI
122 |   directly from GitHub, a different process is triggered by the `prepare` script
123 |   in `package.json`. This script uses `esbuild` to bundle the entire application
124 |   and its dependencies into a single, self-contained JavaScript file. This
125 |   bundle is created on-the-fly on the user's machine and is not checked into the
126 |   repository.
127 | 
128 | **Docker sandbox image**
129 | 
130 | The Docker-based execution method is supported by the `gemini-cli-sandbox`
131 | container image. This image is published to a container registry and contains a
132 | pre-installed, global version of Gemini CLI.
133 | 
134 | ## Release process
135 | 
136 | The release process is automated through GitHub Actions. The release workflow
137 | performs the following actions:
138 | 
139 | 1.  Build the NPM packages using `tsc`.
140 | 2.  Publish the NPM packages to the artifact registry.
141 | 3.  Create GitHub releases with bundled assets.
```

extensions/extension-releasing.md
```
1 | # Extension Releasing
2 | 
3 | There are two primary ways of releasing extensions to users:
4 | 
5 | - [Git repository](#releasing-through-a-git-repository)
6 | - [Github Releases](#releasing-through-github-releases)
7 | 
8 | Git repository releases tend to be the simplest and most flexible approach,
9 | while GitHub releases can be more efficient on initial install as they are
10 | shipped as single archives instead of requiring a git clone which downloads each
11 | file individually. Github releases may also contain platform specific archives
12 | if you need to ship platform specific binary files.
13 | 
14 | ## Releasing through a git repository
15 | 
16 | This is the most flexible and simple option. All you need to do is create a
17 | publicly accessible git repo (such as a public github repository) and then users
18 | can install your extension using `gemini extensions install <your-repo-uri>`, or
19 | for a GitHub repository they can use the simplified
20 | `gemini extensions install <org>/<repo>` format. They can optionally depend on a
21 | specific ref (branch/tag/commit) using the `--ref=<some-ref>` argument, this
22 | defaults to the default branch.
23 | 
24 | Whenever commits are pushed to the ref that a user depends on, they will be
25 | prompted to update the extension. Note that this also allows for easy rollbacks,
26 | the HEAD commit is always treated as the latest version regardless of the actual
27 | version in the `gemini-extension.json` file.
28 | 
29 | ### Managing release channels using a git repository
30 | 
31 | Users can depend on any ref from your git repo, such as a branch or tag, which
32 | allows you to manage multiple release channels.
33 | 
34 | For instance, you can maintain a `stable` branch, which users can install this
35 | way `gemini extensions install <your-repo-uri> --ref=stable`. Or, you could make
36 | this the default by treating your default branch as your stable release branch,
37 | and doing development in a different branch (for instance called `dev`). You can
38 | maintain as many branches or tags as you like, providing maximum flexibility for
39 | you and your users.
40 | 
41 | Note that these `ref` arguments can be tags, branches, or even specific commits,
42 | which allows users to depend on a specific version of your extension. It is up
43 | to you how you want to manage your tags and branches.
44 | 
45 | ### Example releasing flow using a git repo
46 | 
47 | While there are many options for how you want to manage releases using a git
48 | flow, we recommend treating your default branch as your "stable" release branch.
49 | This means that the default behavior for
50 | `gemini extensions install <your-repo-uri>` is to be on the stable release
51 | branch.
52 | 
53 | Lets say you want to maintain three standard release channels, `stable`,
54 | `preview`, and `dev`. You would do all your standard development in the `dev`
55 | branch. When you are ready to do a preview release, you merge that branch into
56 | your `preview` branch. When you are ready to promote your preview branch to
57 | stable, you merge `preview` into your stable branch (which might be your default
58 | branch or a different branch).
59 | 
60 | You can also cherry pick changes from one branch into another using
61 | `git cherry-pick`, but do note that this will result in your branches having a
62 | slightly divergent history from each other, unless you force push changes to
63 | your branches on each release to restore the history to a clean slate (which may
64 | not be possible for the default branch depending on your repository settings).
65 | If you plan on doing cherry picks, you may want to avoid having your default
66 | branch be the stable branch to avoid force-pushing to the default branch which
67 | should generally be avoided.
68 | 
69 | ## Releasing through Github releases
70 | 
71 | Gemini CLI extensions can be distributed through
72 | [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases).
73 | This provides a faster and more reliable initial installation experience for
74 | users, as it avoids the need to clone the repository.
75 | 
76 | Each release includes at least one archive file, which contains the full
77 | contents of the repo at the tag that it was linked to. Releases may also include
78 | [pre-built archives](#custom-pre-built-archives) if your extension requires some
79 | build step or has platform specific binaries attached to it.
80 | 
81 | When checking for updates, gemini will just look for the "latest" release on
82 | github (you must mark it as such when creating the release), unless the user
83 | installed a specific release by passing `--ref=<some-release-tag>`.
84 | 
85 | You may also install extensions with the `--pre-release` flag in order to get
86 | the latest release regardless of whether it has been marked as "latest". This
87 | allows you to test that your release works before actually pushing it to all
88 | users.
89 | 
90 | ### Custom pre-built archives
91 | 
92 | Custom archives must be attached directly to the github release as assets and
93 | must be fully self-contained. This means they should include the entire
94 | extension, see [archive structure](#archive-structure).
95 | 
96 | If your extension is platform-independent, you can provide a single generic
97 | asset. In this case, there should be only one asset attached to the release.
98 | 
99 | Custom archives may also be used if you want to develop your extension within a
100 | larger repository, you can build an archive which has a different layout from
101 | the repo itself (for instance it might just be an archive of a subdirectory
102 | containing the extension).
103 | 
104 | #### Platform specific archives
105 | 
106 | To ensure Gemini CLI can automatically find the correct release asset for each
107 | platform, you must follow this naming convention. The CLI will search for assets
108 | in the following order:
109 | 
110 | 1.  **Platform and Architecture-Specific:**
111 |     `{platform}.{arch}.{name}.{extension}`
112 | 2.  **Platform-Specific:** `{platform}.{name}.{extension}`
113 | 3.  **Generic:** If only one asset is provided, it will be used as a generic
114 |     fallback.
115 | 
116 | - `{name}`: The name of your extension.
117 | - `{platform}`: The operating system. Supported values are:
118 |   - `darwin` (macOS)
119 |   - `linux`
120 |   - `win32` (Windows)
121 | - `{arch}`: The architecture. Supported values are:
122 |   - `x64`
123 |   - `arm64`
124 | - `{extension}`: The file extension of the archive (e.g., `.tar.gz` or `.zip`).
125 | 
126 | **Examples:**
127 | 
128 | - `darwin.arm64.my-tool.tar.gz` (specific to Apple Silicon Macs)
129 | - `darwin.my-tool.tar.gz` (for all Macs)
130 | - `linux.x64.my-tool.tar.gz`
131 | - `win32.my-tool.zip`
132 | 
133 | #### Archive structure
134 | 
135 | Archives must be fully contained extensions and have all the standard
136 | requirements - specifically the `gemini-extension.json` file must be at the root
137 | of the archive.
138 | 
139 | The rest of the layout should look exactly the same as a typical extension, see
140 | [extensions.md](./index.md).
141 | 
142 | #### Example GitHub Actions workflow
143 | 
144 | Here is an example of a GitHub Actions workflow that builds and releases a
145 | Gemini CLI extension for multiple platforms:
146 | 
147 | ```yaml
148 | name: Release Extension
149 | 
150 | on:
151 |   push:
152 |     tags:
153 |       - 'v*'
154 | 
155 | jobs:
156 |   release:
157 |     runs-on: ubuntu-latest
158 |     steps:
159 |       - uses: actions/checkout@v3
160 | 
161 |       - name: Set up Node.js
162 |         uses: actions/setup-node@v3
163 |         with:
164 |           node-version: '20'
165 | 
166 |       - name: Install dependencies
167 |         run: npm ci
168 | 
169 |       - name: Build extension
170 |         run: npm run build
171 | 
172 |       - name: Create release assets
173 |         run: |
174 |           npm run package -- --platform=darwin --arch=arm64
175 |           npm run package -- --platform=linux --arch=x64
176 |           npm run package -- --platform=win32 --arch=x64
177 | 
178 |       - name: Create GitHub Release
179 |         uses: softprops/action-gh-release@v1
180 |         with:
181 |           files: |
182 |             release/darwin.arm64.my-tool.tar.gz
183 |             release/linux.arm64.my-tool.tar.gz
184 |             release/win32.arm64.my-tool.zip
185 | ```
```

extensions/getting-started-extensions.md
```
1 | # Getting Started with Gemini CLI Extensions
2 | 
3 | This guide will walk you through creating your first Gemini CLI extension.
4 | You'll learn how to set up a new extension, add a custom tool via an MCP server,
5 | create a custom command, and provide context to the model with a `GEMINI.md`
6 | file.
7 | 
8 | ## Prerequisites
9 | 
10 | Before you start, make sure you have the Gemini CLI installed and a basic
11 | understanding of Node.js and TypeScript.
12 | 
13 | ## Step 1: Create a New Extension
14 | 
15 | The easiest way to start is by using one of the built-in templates. We'll use
16 | the `mcp-server` example as our foundation.
17 | 
18 | Run the following command to create a new directory called `my-first-extension`
19 | with the template files:
20 | 
21 | ```bash
22 | gemini extensions new my-first-extension mcp-server
23 | ```
24 | 
25 | This will create a new directory with the following structure:
26 | 
27 | ```
28 | my-first-extension/
29 | ├── example.ts
30 | ├── gemini-extension.json
31 | ├── package.json
32 | └── tsconfig.json
33 | ```
34 | 
35 | ## Step 2: Understand the Extension Files
36 | 
37 | Let's look at the key files in your new extension.
38 | 
39 | ### `gemini-extension.json`
40 | 
41 | This is the manifest file for your extension. It tells Gemini CLI how to load
42 | and use your extension.
43 | 
44 | ```json
45 | {
46 |   "name": "my-first-extension",
47 |   "version": "1.0.0",
48 |   "mcpServers": {
49 |     "nodeServer": {
50 |       "command": "node",
51 |       "args": ["${extensionPath}${/}dist${/}example.js"],
52 |       "cwd": "${extensionPath}"
53 |     }
54 |   }
55 | }
56 | ```
57 | 
58 | - `name`: The unique name for your extension.
59 | - `version`: The version of your extension.
60 | - `mcpServers`: This section defines one or more Model Context Protocol (MCP)
61 |   servers. MCP servers are how you can add new tools for the model to use.
62 |   - `command`, `args`, `cwd`: These fields specify how to start your server.
63 |     Notice the use of the `${extensionPath}` variable, which Gemini CLI replaces
64 |     with the absolute path to your extension's installation directory. This
65 |     allows your extension to work regardless of where it's installed.
66 | 
67 | ### `example.ts`
68 | 
69 | This file contains the source code for your MCP server. It's a simple Node.js
70 | server that uses the `@modelcontextprotocol/sdk`.
71 | 
72 | ```typescript
73 | /**
74 |  * @license
75 |  * Copyright 2025 Google LLC
76 |  * SPDX-License-Identifier: Apache-2.0
77 |  */
78 | 
79 | import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
80 | import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
81 | import { z } from 'zod';
82 | 
83 | const server = new McpServer({
84 |   name: 'prompt-server',
85 |   version: '1.0.0',
86 | });
87 | 
88 | // Registers a new tool named 'fetch_posts'
89 | server.registerTool(
90 |   'fetch_posts',
91 |   {
92 |     description: 'Fetches a list of posts from a public API.',
93 |     inputSchema: z.object({}).shape,
94 |   },
95 |   async () => {
96 |     const apiResponse = await fetch(
97 |       'https://jsonplaceholder.typicode.com/posts',
98 |     );
99 |     const posts = await apiResponse.json();
100 |     const response = { posts: posts.slice(0, 5) };
101 |     return {
102 |       content: [
103 |         {
104 |           type: 'text',
105 |           text: JSON.stringify(response),
106 |         },
107 |       ],
108 |     };
109 |   },
110 | );
111 | 
112 | // ... (prompt registration omitted for brevity)
113 | 
114 | const transport = new StdioServerTransport();
115 | await server.connect(transport);
116 | ```
117 | 
118 | This server defines a single tool called `fetch_posts` that fetches data from a
119 | public API.
120 | 
121 | ### `package.json` and `tsconfig.json`
122 | 
123 | These are standard configuration files for a TypeScript project. The
124 | `package.json` file defines dependencies and a `build` script, and
125 | `tsconfig.json` configures the TypeScript compiler.
126 | 
127 | ## Step 3: Build and Link Your Extension
128 | 
129 | Before you can use the extension, you need to compile the TypeScript code and
130 | link the extension to your Gemini CLI installation for local development.
131 | 
132 | 1.  **Install dependencies:**
133 | 
134 |     ```bash
135 |     cd my-first-extension
136 |     npm install
137 |     ```
138 | 
139 | 2.  **Build the server:**
140 | 
141 |     ```bash
142 |     npm run build
143 |     ```
144 | 
145 |     This will compile `example.ts` into `dist/example.js`, which is the file
146 |     referenced in your `gemini-extension.json`.
147 | 
148 | 3.  **Link the extension:**
149 | 
150 |     The `link` command creates a symbolic link from the Gemini CLI extensions
151 |     directory to your development directory. This means any changes you make
152 |     will be reflected immediately without needing to reinstall.
153 | 
154 |     ```bash
155 |     gemini extensions link .
156 |     ```
157 | 
158 | Now, restart your Gemini CLI session. The new `fetch_posts` tool will be
159 | available. You can test it by asking: "fetch posts".
160 | 
161 | ## Step 4: Add a Custom Command
162 | 
163 | Custom commands provide a way to create shortcuts for complex prompts. Let's add
164 | a command that searches for a pattern in your code.
165 | 
166 | 1.  Create a `commands` directory and a subdirectory for your command group:
167 | 
168 |     ```bash
169 |     mkdir -p commands/fs
170 |     ```
171 | 
172 | 2.  Create a file named `commands/fs/grep-code.toml`:
173 | 
174 |     ```toml
175 |     prompt = """
176 |     Please summarize the findings for the pattern `{{args}}`.
177 | 
178 |     Search Results:
179 |     !{grep -r {{args}} .}
180 |     """
181 |     ```
182 | 
183 |     This command, `/fs:grep-code`, will take an argument, run the `grep` shell
184 |     command with it, and pipe the results into a prompt for summarization.
185 | 
186 | After saving the file, restart the Gemini CLI. You can now run
187 | `/fs:grep-code "some pattern"` to use your new command.
188 | 
189 | ## Step 5: Add a Custom `GEMINI.md`
190 | 
191 | You can provide persistent context to the model by adding a `GEMINI.md` file to
192 | your extension. This is useful for giving the model instructions on how to
193 | behave or information about your extension's tools. Note that you may not always
194 | need this for extensions built to expose commands and prompts.
195 | 
196 | 1.  Create a file named `GEMINI.md` in the root of your extension directory:
197 | 
198 |     ```markdown
199 |     # My First Extension Instructions
200 | 
201 |     You are an expert developer assistant. When the user asks you to fetch
202 |     posts, use the `fetch_posts` tool. Be concise in your responses.
203 |     ```
204 | 
205 | 2.  Update your `gemini-extension.json` to tell the CLI to load this file:
206 | 
207 |     ```json
208 |     {
209 |       "name": "my-first-extension",
210 |       "version": "1.0.0",
211 |       "contextFileName": "GEMINI.md",
212 |       "mcpServers": {
213 |         "nodeServer": {
214 |           "command": "node",
215 |           "args": ["${extensionPath}${/}dist${/}example.js"],
216 |           "cwd": "${extensionPath}"
217 |         }
218 |       }
219 |     }
220 |     ```
221 | 
222 | Restart the CLI again. The model will now have the context from your `GEMINI.md`
223 | file in every session where the extension is active.
224 | 
225 | ## Step 6: Releasing Your Extension
226 | 
227 | Once you are happy with your extension, you can share it with others. The two
228 | primary ways of releasing extensions are via a Git repository or through GitHub
229 | Releases. Using a public Git repository is the simplest method.
230 | 
231 | For detailed instructions on both methods, please refer to the
232 | [Extension Releasing Guide](./extension-releasing.md).
233 | 
234 | ## Conclusion
235 | 
236 | You've successfully created a Gemini CLI extension! You learned how to:
237 | 
238 | - Bootstrap a new extension from a template.
239 | - Add custom tools with an MCP server.
240 | - Create convenient custom commands.
241 | - Provide persistent context to the model.
242 | - Link your extension for local development.
243 | 
244 | From here, you can explore more advanced features and build powerful new
245 | capabilities into the Gemini CLI.
```

extensions/index.md
```
1 | # Gemini CLI Extensions
2 | 
3 | _This documentation is up-to-date with the v0.4.0 release._
4 | 
5 | Gemini CLI extensions package prompts, MCP servers, and custom commands into a
6 | familiar and user-friendly format. With extensions, you can expand the
7 | capabilities of Gemini CLI and share those capabilities with others. They are
8 | designed to be easily installable and shareable.
9 | 
10 | See [getting started docs](getting-started-extensions.md) for a guide on
11 | creating your first extension.
12 | 
13 | See [releasing docs](extension-releasing.md) for an advanced guide on setting up
14 | GitHub releases.
15 | 
16 | ## Extension management
17 | 
18 | We offer a suite of extension management tools using `gemini extensions`
19 | commands.
20 | 
21 | Note that these commands are not supported from within the CLI, although you can
22 | list installed extensions using the `/extensions list` subcommand.
23 | 
24 | Note that all of these commands will only be reflected in active CLI sessions on
25 | restart.
26 | 
27 | ### Installing an extension
28 | 
29 | You can install an extension using `gemini extensions install` with either a
30 | GitHub URL or a local path.
31 | 
32 | Note that we create a copy of the installed extension, so you will need to run
33 | `gemini extensions update` to pull in changes from both locally-defined
34 | extensions and those on GitHub.
35 | 
36 | NOTE: If you are installing an extension from GitHub, you'll need to have `git`
37 | installed on your machine. See
38 | [git installation instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
39 | for help.
40 | 
41 | ```
42 | gemini extensions install https://github.com/gemini-cli-extensions/security
43 | ```
44 | 
45 | This will install the Gemini CLI Security extension, which offers support for a
46 | `/security:analyze` command.
47 | 
48 | ### Uninstalling an extension
49 | 
50 | To uninstall, run `gemini extensions uninstall extension-name`, so, in the case
51 | of the install example:
52 | 
53 | ```
54 | gemini extensions uninstall gemini-cli-security
55 | ```
56 | 
57 | ### Disabling an extension
58 | 
59 | Extensions are, by default, enabled across all workspaces. You can disable an
60 | extension entirely or for specific workspace.
61 | 
62 | For example, `gemini extensions disable extension-name` will disable the
63 | extension at the user level, so it will be disabled everywhere.
64 | `gemini extensions disable extension-name --scope=workspace` will only disable
65 | the extension in the current workspace.
66 | 
67 | ### Enabling an extension
68 | 
69 | You can enable extensions using `gemini extensions enable extension-name`. You
70 | can also enable an extension for a specific workspace using
71 | `gemini extensions enable extension-name --scope=workspace` from within that
72 | workspace.
73 | 
74 | This is useful if you have an extension disabled at the top-level and only
75 | enabled in specific places.
76 | 
77 | ### Updating an extension
78 | 
79 | For extensions installed from a local path or a git repository, you can
80 | explicitly update to the latest version (as reflected in the
81 | `gemini-extension.json` `version` field) with
82 | `gemini extensions update extension-name`.
83 | 
84 | You can update all extensions with:
85 | 
86 | ```
87 | gemini extensions update --all
88 | ```
89 | 
90 | ## Extension creation
91 | 
92 | We offer commands to make extension development easier.
93 | 
94 | ### Create a boilerplate extension
95 | 
96 | We offer several example extensions `context`, `custom-commands`,
97 | `exclude-tools` and `mcp-server`. You can view these examples
98 | [here](https://github.com/google-gemini/gemini-cli/tree/main/packages/cli/src/commands/extensions/examples).
99 | 
100 | To copy one of these examples into a development directory using the type of
101 | your choosing, run:
102 | 
103 | ```
104 | gemini extensions new path/to/directory custom-commands
105 | ```
106 | 
107 | ### Link a local extension
108 | 
109 | The `gemini extensions link` command will create a symbolic link from the
110 | extension installation directory to the development path.
111 | 
112 | This is useful so you don't have to run `gemini extensions update` every time
113 | you make changes you'd like to test.
114 | 
115 | ```
116 | gemini extensions link path/to/directory
117 | ```
118 | 
119 | ## How it works
120 | 
121 | On startup, Gemini CLI looks for extensions in `<home>/.gemini/extensions`
122 | 
123 | Extensions exist as a directory that contains a `gemini-extension.json` file.
124 | For example:
125 | 
126 | `<home>/.gemini/extensions/my-extension/gemini-extension.json`
127 | 
128 | ### `gemini-extension.json`
129 | 
130 | The `gemini-extension.json` file contains the configuration for the extension.
131 | The file has the following structure:
132 | 
133 | ```json
134 | {
135 |   "name": "my-extension",
136 |   "version": "1.0.0",
137 |   "mcpServers": {
138 |     "my-server": {
139 |       "command": "node my-server.js"
140 |     }
141 |   },
142 |   "contextFileName": "GEMINI.md",
143 |   "excludeTools": ["run_shell_command"]
144 | }
145 | ```
146 | 
147 | - `name`: The name of the extension. This is used to uniquely identify the
148 |   extension and for conflict resolution when extension commands have the same
149 |   name as user or project commands. The name should be lowercase or numbers and
150 |   use dashes instead of underscores or spaces. This is how users will refer to
151 |   your extension in the CLI. Note that we expect this name to match the
152 |   extension directory name.
153 | - `version`: The version of the extension.
154 | - `mcpServers`: A map of MCP servers to configure. The key is the name of the
155 |   server, and the value is the server configuration. These servers will be
156 |   loaded on startup just like MCP servers configured in a
157 |   [`settings.json` file](../get-started/configuration.md). If both an extension
158 |   and a `settings.json` file configure an MCP server with the same name, the
159 |   server defined in the `settings.json` file takes precedence.
160 |   - Note that all MCP server configuration options are supported except for
161 |     `trust`.
162 | - `contextFileName`: The name of the file that contains the context for the
163 |   extension. This will be used to load the context from the extension directory.
164 |   If this property is not used but a `GEMINI.md` file is present in your
165 |   extension directory, then that file will be loaded.
166 | - `excludeTools`: An array of tool names to exclude from the model. You can also
167 |   specify command-specific restrictions for tools that support it, like the
168 |   `run_shell_command` tool. For example,
169 |   `"excludeTools": ["run_shell_command(rm -rf)"]` will block the `rm -rf`
170 |   command. Note that this differs from the MCP server `excludeTools`
171 |   functionality, which can be listed in the MCP server config.
172 | 
173 | When Gemini CLI starts, it loads all the extensions and merges their
174 | configurations. If there are any conflicts, the workspace configuration takes
175 | precedence.
176 | 
177 | ### Custom commands
178 | 
179 | Extensions can provide [custom commands](../cli/custom-commands.md) by placing
180 | TOML files in a `commands/` subdirectory within the extension directory. These
181 | commands follow the same format as user and project custom commands and use
182 | standard naming conventions.
183 | 
184 | **Example**
185 | 
186 | An extension named `gcp` with the following structure:
187 | 
188 | ```
189 | .gemini/extensions/gcp/
190 | ├── gemini-extension.json
191 | └── commands/
192 |     ├── deploy.toml
193 |     └── gcs/
194 |         └── sync.toml
195 | ```
196 | 
197 | Would provide these commands:
198 | 
199 | - `/deploy` - Shows as `[gcp] Custom command from deploy.toml` in help
200 | - `/gcs:sync` - Shows as `[gcp] Custom command from sync.toml` in help
201 | 
202 | ### Conflict resolution
203 | 
204 | Extension commands have the lowest precedence. When a conflict occurs with user
205 | or project commands:
206 | 
207 | 1. **No conflict**: Extension command uses its natural name (e.g., `/deploy`)
208 | 2. **With conflict**: Extension command is renamed with the extension prefix
209 |    (e.g., `/gcp.deploy`)
210 | 
211 | For example, if both a user and the `gcp` extension define a `deploy` command:
212 | 
213 | - `/deploy` - Executes the user's deploy command
214 | - `/gcp.deploy` - Executes the extension's deploy command (marked with `[gcp]`
215 |   tag)
216 | 
217 | ## Variables
218 | 
219 | Gemini CLI extensions allow variable substitution in `gemini-extension.json`.
220 | This can be useful if e.g., you need the current directory to run an MCP server
221 | using `"cwd": "${extensionPath}${/}run.ts"`.
222 | 
223 | **Supported variables:**
224 | 
225 | | variable                   | description                                                                                                                                                     |
226 | | -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
227 | | `${extensionPath}`         | The fully-qualified path of the extension in the user's filesystem e.g., '/Users/username/.gemini/extensions/example-extension'. This will not unwrap symlinks. |
228 | | `${workspacePath}`         | The fully-qualified path of the current workspace.                                                                                                              |
229 | | `${/} or ${pathSeparator}` | The path separator (differs per OS).                                                                                                                            |
```

ide-integration/ide-companion-spec.md
```
1 | # Gemini CLI Companion Plugin: Interface Specification
2 | 
3 | > Last Updated: September 15, 2025
4 | 
5 | This document defines the contract for building a companion plugin to enable
6 | Gemini CLI's IDE mode. For VS Code, these features (native diffing, context
7 | awareness) are provided by the official extension
8 | ([marketplace](https://marketplace.visualstudio.com/items?itemName=Google.gemini-cli-vscode-ide-companion)).
9 | This specification is for contributors who wish to bring similar functionality
10 | to other editors like JetBrains IDEs, Sublime Text, etc.
11 | 
12 | ## I. The Communication Interface
13 | 
14 | Gemini CLI and the IDE plugin communicate through a local communication channel.
15 | 
16 | ### 1. Transport Layer: MCP over HTTP
17 | 
18 | The plugin **MUST** run a local HTTP server that implements the **Model Context
19 | Protocol (MCP)**.
20 | 
21 | - **Protocol:** The server must be a valid MCP server. We recommend using an
22 |   existing MCP SDK for your language of choice if available.
23 | - **Endpoint:** The server should expose a single endpoint (e.g., `/mcp`) for
24 |   all MCP communication.
25 | - **Port:** The server **MUST** listen on a dynamically assigned port (i.e.,
26 |   listen on port `0`).
27 | 
28 | ### 2. Discovery Mechanism: The Port File
29 | 
30 | For Gemini CLI to connect, it needs to discover which IDE instance it's running
31 | in and what port your server is using. The plugin **MUST** facilitate this by
32 | creating a "discovery file."
33 | 
34 | - **How the CLI Finds the File:** The CLI determines the Process ID (PID) of the
35 |   IDE it's running in by traversing the process tree. It then looks for a
36 |   discovery file that contains this PID in its name.
37 | - **File Location:** The file must be created in a specific directory:
38 |   `os.tmpdir()/gemini/ide/`. Your plugin must create this directory if it
39 |   doesn't exist.
40 | - **File Naming Convention:** The filename is critical and **MUST** follow the
41 |   pattern: `gemini-ide-server-${PID}-${PORT}.json`
42 |   - `${PID}`: The process ID of the parent IDE process. Your plugin must
43 |     determine this PID and include it in the filename.
44 |   - `${PORT}`: The port your MCP server is listening on.
45 | - **File Content & Workspace Validation:** The file **MUST** contain a JSON
46 |   object with the following structure:
47 | 
48 |   ```json
49 |   {
50 |     "port": 12345,
51 |     "workspacePath": "/path/to/project1:/path/to/project2",
52 |     "authToken": "a-very-secret-token",
53 |     "ideInfo": {
54 |       "name": "vscode",
55 |       "displayName": "VS Code"
56 |     }
57 |   }
58 |   ```
59 |   - `port` (number, required): The port of the MCP server.
60 |   - `workspacePath` (string, required): A list of all open workspace root paths,
61 |     delimited by the OS-specific path separator (`:` for Linux/macOS, `;` for
62 |     Windows). The CLI uses this path to ensure it's running in the same project
63 |     folder that's open in the IDE. If the CLI's current working directory is not
64 |     a sub-directory of `workspacePath`, the connection will be rejected. Your
65 |     plugin **MUST** provide the correct, absolute path(s) to the root of the
66 |     open workspace(s).
67 |   - `authToken` (string, required): A secret token for securing the connection.
68 |     The CLI will include this token in an `Authorization: Bearer <token>` header
69 |     on all requests.
70 |   - `ideInfo` (object, required): Information about the IDE.
71 |     - `name` (string, required): A short, lowercase identifier for the IDE
72 |       (e.g., `vscode`, `jetbrains`).
73 |     - `displayName` (string, required): A user-friendly name for the IDE (e.g.,
74 |       `VS Code`, `JetBrains IDE`).
75 | 
76 | - **Authentication:** To secure the connection, the plugin **MUST** generate a
77 |   unique, secret token and include it in the discovery file. The CLI will then
78 |   include this token in the `Authorization` header for all requests to the MCP
79 |   server (e.g., `Authorization: Bearer a-very-secret-token`). Your server
80 |   **MUST** validate this token on every request and reject any that are
81 |   unauthorized.
82 | - **Tie-Breaking with Environment Variables (Recommended):** For the most
83 |   reliable experience, your plugin **SHOULD** both create the discovery file and
84 |   set the `GEMINI_CLI_IDE_SERVER_PORT` environment variable in the integrated
85 |   terminal. The file serves as the primary discovery mechanism, but the
86 |   environment variable is crucial for tie-breaking. If a user has multiple IDE
87 |   windows open for the same workspace, the CLI uses the
88 |   `GEMINI_CLI_IDE_SERVER_PORT` variable to identify and connect to the correct
89 |   window's server.
90 | 
91 | ## II. The Context Interface
92 | 
93 | To enable context awareness, the plugin **MAY** provide the CLI with real-time
94 | information about the user's activity in the IDE.
95 | 
96 | ### `ide/contextUpdate` Notification
97 | 
98 | The plugin **MAY** send an `ide/contextUpdate`
99 | [notification](https://modelcontextprotocol.io/specification/2025-06-18/basic/index#notifications)
100 | to the CLI whenever the user's context changes.
101 | 
102 | - **Triggering Events:** This notification should be sent (with a recommended
103 |   debounce of 50ms) when:
104 |   - A file is opened, closed, or focused.
105 |   - The user's cursor position or text selection changes in the active file.
106 | - **Payload (`IdeContext`):** The notification parameters **MUST** be an
107 |   `IdeContext` object:
108 | 
109 |   ```typescript
110 |   interface IdeContext {
111 |     workspaceState?: {
112 |       openFiles?: File[];
113 |       isTrusted?: boolean;
114 |     };
115 |   }
116 | 
117 |   interface File {
118 |     // Absolute path to the file
119 |     path: string;
120 |     // Last focused Unix timestamp (for ordering)
121 |     timestamp: number;
122 |     // True if this is the currently focused file
123 |     isActive?: boolean;
124 |     cursor?: {
125 |       // 1-based line number
126 |       line: number;
127 |       // 1-based character number
128 |       character: number;
129 |     };
130 |     // The text currently selected by the user
131 |     selectedText?: string;
132 |   }
133 |   ```
134 | 
135 |   **Note:** The `openFiles` list should only include files that exist on disk.
136 |   Virtual files (e.g., unsaved files without a path, editor settings pages)
137 |   **MUST** be excluded.
138 | 
139 | ### How the CLI Uses This Context
140 | 
141 | After receiving the `IdeContext` object, the CLI performs several normalization
142 | and truncation steps before sending the information to the model.
143 | 
144 | - **File Ordering:** The CLI uses the `timestamp` field to determine the most
145 |   recently used files. It sorts the `openFiles` list based on this value.
146 |   Therefore, your plugin **MUST** provide an accurate Unix timestamp for when a
147 |   file was last focused.
148 | - **Active File:** The CLI considers only the most recent file (after sorting)
149 |   to be the "active" file. It will ignore the `isActive` flag on all other files
150 |   and clear their `cursor` and `selectedText` fields. Your plugin should focus
151 |   on setting `isActive: true` and providing cursor/selection details only for
152 |   the currently focused file.
153 | - **Truncation:** To manage token limits, the CLI truncates both the file list
154 |   (to 10 files) and the `selectedText` (to 16KB).
155 | 
156 | While the CLI handles the final truncation, it is highly recommended that your
157 | plugin also limits the amount of context it sends.
158 | 
159 | ## III. The Diffing Interface
160 | 
161 | To enable interactive code modifications, the plugin **MAY** expose a diffing
162 | interface. This allows the CLI to request that the IDE open a diff view, showing
163 | proposed changes to a file. The user can then review, edit, and ultimately
164 | accept or reject these changes directly within the IDE.
165 | 
166 | ### `openDiff` Tool
167 | 
168 | The plugin **MUST** register an `openDiff` tool on its MCP server.
169 | 
170 | - **Description:** This tool instructs the IDE to open a modifiable diff view
171 |   for a specific file.
172 | - **Request (`OpenDiffRequest`):** The tool is invoked via a `tools/call`
173 |   request. The `arguments` field within the request's `params` **MUST** be an
174 |   `OpenDiffRequest` object.
175 | 
176 |   ```typescript
177 |   interface OpenDiffRequest {
178 |     // The absolute path to the file to be diffed.
179 |     filePath: string;
180 |     // The proposed new content for the file.
181 |     newContent: string;
182 |   }
183 |   ```
184 | 
185 | - **Response (`CallToolResult`):** The tool **MUST** immediately return a
186 |   `CallToolResult` to acknowledge the request and report whether the diff view
187 |   was successfully opened.
188 |   - On Success: If the diff view was opened successfully, the response **MUST**
189 |     contain empty content (i.e., `content: []`).
190 |   - On Failure: If an error prevented the diff view from opening, the response
191 |     **MUST** have `isError: true` and include a `TextContent` block in the
192 |     `content` array describing the error.
193 | 
194 |   The actual outcome of the diff (acceptance or rejection) is communicated
195 |   asynchronously via notifications.
196 | 
197 | ### `closeDiff` Tool
198 | 
199 | The plugin **MUST** register a `closeDiff` tool on its MCP server.
200 | 
201 | - **Description:** This tool instructs the IDE to close an open diff view for a
202 |   specific file.
203 | - **Request (`CloseDiffRequest`):** The tool is invoked via a `tools/call`
204 |   request. The `arguments` field within the request's `params` **MUST** be an
205 |   `CloseDiffRequest` object.
206 | 
207 |   ```typescript
208 |   interface CloseDiffRequest {
209 |     // The absolute path to the file whose diff view should be closed.
210 |     filePath: string;
211 |   }
212 |   ```
213 | 
214 | - **Response (`CallToolResult`):** The tool **MUST** return a `CallToolResult`.
215 |   - On Success: If the diff view was closed successfully, the response **MUST**
216 |     include a single **TextContent** block in the content array containing the
217 |     file's final content before closing.
218 |   - On Failure: If an error prevented the diff view from closing, the response
219 |     **MUST** have `isError: true` and include a `TextContent` block in the
220 |     `content` array describing the error.
221 | 
222 | ### `ide/diffAccepted` Notification
223 | 
224 | When the user accepts the changes in a diff view (e.g., by clicking an "Apply"
225 | or "Save" button), the plugin **MUST** send an `ide/diffAccepted` notification
226 | to the CLI.
227 | 
228 | - **Payload:** The notification parameters **MUST** include the file path and
229 |   the final content of the file. The content may differ from the original
230 |   `newContent` if the user made manual edits in the diff view.
231 | 
232 |   ```typescript
233 |   {
234 |     // The absolute path to the file that was diffed.
235 |     filePath: string;
236 |     // The full content of the file after acceptance.
237 |     content: string;
238 |   }
239 |   ```
240 | 
241 | ### `ide/diffRejected` Notification
242 | 
243 | When the user rejects the changes (e.g., by closing the diff view without
244 | accepting), the plugin **MUST** send an `ide/diffRejected` notification to the
245 | CLI.
246 | 
247 | - **Payload:** The notification parameters **MUST** include the file path of the
248 |   rejected diff.
249 | 
250 |   ```typescript
251 |   {
252 |     // The absolute path to the file that was diffed.
253 |     filePath: string;
254 |   }
255 |   ```
256 | 
257 | ## IV. The Lifecycle Interface
258 | 
259 | The plugin **MUST** manage its resources and the discovery file correctly based
260 | on the IDE's lifecycle.
261 | 
262 | - **On Activation (IDE startup/plugin enabled):**
263 |   1.  Start the MCP server.
264 |   2.  Create the discovery file.
265 | - **On Deactivation (IDE shutdown/plugin disabled):**
266 |   1.  Stop the MCP server.
267 |   2.  Delete the discovery file.
```

ide-integration/index.md
```
1 | # IDE Integration
2 | 
3 | Gemini CLI can integrate with your IDE to provide a more seamless and
4 | context-aware experience. This integration allows the CLI to understand your
5 | workspace better and enables powerful features like native in-editor diffing.
6 | 
7 | Currently, the only supported IDE is
8 | [Visual Studio Code](https://code.visualstudio.com/) and other editors that
9 | support VS Code extensions. To build support for other editors, see the
10 | [IDE Companion Extension Spec](./ide-companion-spec.md).
11 | 
12 | ## Features
13 | 
14 | - **Workspace Context:** The CLI automatically gains awareness of your workspace
15 |   to provide more relevant and accurate responses. This context includes:
16 |   - The **10 most recently accessed files** in your workspace.
17 |   - Your active cursor position.
18 |   - Any text you have selected (up to a 16KB limit; longer selections will be
19 |     truncated).
20 | 
21 | - **Native Diffing:** When Gemini suggests code modifications, you can view the
22 |   changes directly within your IDE's native diff viewer. This allows you to
23 |   review, edit, and accept or reject the suggested changes seamlessly.
24 | 
25 | - **VS Code Commands:** You can access Gemini CLI features directly from the VS
26 |   Code Command Palette (`Cmd+Shift+P` or `Ctrl+Shift+P`):
27 |   - `Gemini CLI: Run`: Starts a new Gemini CLI session in the integrated
28 |     terminal.
29 |   - `Gemini CLI: Accept Diff`: Accepts the changes in the active diff editor.
30 |   - `Gemini CLI: Close Diff Editor`: Rejects the changes and closes the active
31 |     diff editor.
32 |   - `Gemini CLI: View Third-Party Notices`: Displays the third-party notices for
33 |     the extension.
34 | 
35 | ## Installation and Setup
36 | 
37 | There are three ways to set up the IDE integration:
38 | 
39 | ### 1. Automatic Nudge (Recommended)
40 | 
41 | When you run Gemini CLI inside a supported editor, it will automatically detect
42 | your environment and prompt you to connect. Answering "Yes" will automatically
43 | run the necessary setup, which includes installing the companion extension and
44 | enabling the connection.
45 | 
46 | ### 2. Manual Installation from CLI
47 | 
48 | If you previously dismissed the prompt or want to install the extension
49 | manually, you can run the following command inside Gemini CLI:
50 | 
51 | ```
52 | /ide install
53 | ```
54 | 
55 | This will find the correct extension for your IDE and install it.
56 | 
57 | ### 3. Manual Installation from a Marketplace
58 | 
59 | You can also install the extension directly from a marketplace.
60 | 
61 | - **For Visual Studio Code:** Install from the
62 |   [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=google.gemini-cli-vscode-ide-companion).
63 | - **For VS Code Forks:** To support forks of VS Code, the extension is also
64 |   published on the
65 |   [Open VSX Registry](https://open-vsx.org/extension/google/gemini-cli-vscode-ide-companion).
66 |   Follow your editor's instructions for installing extensions from this
67 |   registry.
68 | 
69 | > NOTE: The "Gemini CLI Companion" extension may appear towards the bottom of
70 | > search results. If you don't see it immediately, try scrolling down or sorting
71 | > by "Newly Published".
72 | >
73 | > After manually installing the extension, you must run `/ide enable` in the CLI
74 | > to activate the integration.
75 | 
76 | ## Usage
77 | 
78 | ### Enabling and Disabling
79 | 
80 | You can control the IDE integration from within the CLI:
81 | 
82 | - To enable the connection to the IDE, run:
83 |   ```
84 |   /ide enable
85 |   ```
86 | - To disable the connection, run:
87 |   ```
88 |   /ide disable
89 |   ```
90 | 
91 | When enabled, Gemini CLI will automatically attempt to connect to the IDE
92 | companion extension.
93 | 
94 | ### Checking the Status
95 | 
96 | To check the connection status and see the context the CLI has received from the
97 | IDE, run:
98 | 
99 | ```
100 | /ide status
101 | ```
102 | 
103 | If connected, this command will show the IDE it's connected to and a list of
104 | recently opened files it is aware of.
105 | 
106 | > [!NOTE] The file list is limited to 10 recently accessed files within your
107 | > workspace and only includes local files on disk.)
108 | 
109 | ### Working with Diffs
110 | 
111 | When you ask Gemini to modify a file, it can open a diff view directly in your
112 | editor.
113 | 
114 | **To accept a diff**, you can perform any of the following actions:
115 | 
116 | - Click the **checkmark icon** in the diff editor's title bar.
117 | - Save the file (e.g., with `Cmd+S` or `Ctrl+S`).
118 | - Open the Command Palette and run **Gemini CLI: Accept Diff**.
119 | - Respond with `yes` in the CLI when prompted.
120 | 
121 | **To reject a diff**, you can:
122 | 
123 | - Click the **'x' icon** in the diff editor's title bar.
124 | - Close the diff editor tab.
125 | - Open the Command Palette and run **Gemini CLI: Close Diff Editor**.
126 | - Respond with `no` in the CLI when prompted.
127 | 
128 | You can also **modify the suggested changes** directly in the diff view before
129 | accepting them.
130 | 
131 | If you select ‘Yes, allow always’ in the CLI, changes will no longer show up in
132 | the IDE as they will be auto-accepted.
133 | 
134 | ## Using with Sandboxing
135 | 
136 | If you are using Gemini CLI within a sandbox, please be aware of the following:
137 | 
138 | - **On macOS:** The IDE integration requires network access to communicate with
139 |   the IDE companion extension. You must use a Seatbelt profile that allows
140 |   network access.
141 | - **In a Docker Container:** If you run Gemini CLI inside a Docker (or Podman)
142 |   container, the IDE integration can still connect to the VS Code extension
143 |   running on your host machine. The CLI is configured to automatically find the
144 |   IDE server on `host.docker.internal`. No special configuration is usually
145 |   required, but you may need to ensure your Docker networking setup allows
146 |   connections from the container to the host.
147 | 
148 | ## Troubleshooting
149 | 
150 | If you encounter issues with IDE integration, here are some common error
151 | messages and how to resolve them.
152 | 
153 | ### Connection Errors
154 | 
155 | - **Message:**
156 |   `🔴 Disconnected: Failed to connect to IDE companion extension in [IDE Name]. Please ensure the extension is running. To install the extension, run /ide install.`
157 |   - **Cause:** Gemini CLI could not find the necessary environment variables
158 |     (`GEMINI_CLI_IDE_WORKSPACE_PATH` or `GEMINI_CLI_IDE_SERVER_PORT`) to connect
159 |     to the IDE. This usually means the IDE companion extension is not running or
160 |     did not initialize correctly.
161 |   - **Solution:**
162 |     1.  Make sure you have installed the **Gemini CLI Companion** extension in
163 |         your IDE and that it is enabled.
164 |     2.  Open a new terminal window in your IDE to ensure it picks up the correct
165 |         environment.
166 | 
167 | - **Message:**
168 |   `🔴 Disconnected: IDE connection error. The connection was lost unexpectedly. Please try reconnecting by running /ide enable`
169 |   - **Cause:** The connection to the IDE companion was lost.
170 |   - **Solution:** Run `/ide enable` to try and reconnect. If the issue
171 |     continues, open a new terminal window or restart your IDE.
172 | 
173 | ### Configuration Errors
174 | 
175 | - **Message:**
176 |   `🔴 Disconnected: Directory mismatch. Gemini CLI is running in a different location than the open workspace in [IDE Name]. Please run the CLI from one of the following directories: [List of directories]`
177 |   - **Cause:** The CLI's current working directory is outside the workspace you
178 |     have open in your IDE.
179 |   - **Solution:** `cd` into the same directory that is open in your IDE and
180 |     restart the CLI.
181 | 
182 | - **Message:**
183 |   `🔴 Disconnected: To use this feature, please open a workspace folder in [IDE Name] and try again.`
184 |   - **Cause:** You have no workspace open in your IDE.
185 |   - **Solution:** Open a workspace in your IDE and restart the CLI.
186 | 
187 | ### General Errors
188 | 
189 | - **Message:**
190 |   `IDE integration is not supported in your current environment. To use this feature, run Gemini CLI in one of these supported IDEs: [List of IDEs]`
191 |   - **Cause:** You are running Gemini CLI in a terminal or environment that is
192 |     not a supported IDE.
193 |   - **Solution:** Run Gemini CLI from the integrated terminal of a supported
194 |     IDE, like VS Code.
195 | 
196 | - **Message:**
197 |   `No installer is available for IDE. Please install the Gemini CLI Companion extension manually from the marketplace.`
198 |   - **Cause:** You ran `/ide install`, but the CLI does not have an automated
199 |     installer for your specific IDE.
200 |   - **Solution:** Open your IDE's extension marketplace, search for "Gemini CLI
201 |     Companion", and
202 |     [install it manually](#3-manual-installation-from-a-marketplace).
```

mermaid/context.mmd
```
1 | graph LR
2 |     %% --- Style Definitions ---
3 |     classDef new fill:#98fb98,color:#000
4 |     classDef changed fill:#add8e6,color:#000
5 |     classDef unchanged fill:#f0f0f0,color:#000
6 | 
7 |     %% --- Subgraphs ---
8 |     subgraph "Context Providers"
9 |         direction TB
10 |         A["gemini.tsx"]
11 |         B["AppContainer.tsx"]
12 |     end
13 | 
14 |     subgraph "Contexts"
15 |         direction TB
16 |         CtxSession["SessionContext"]
17 |         CtxVim["VimModeContext"]
18 |         CtxSettings["SettingsContext"]
19 |         CtxApp["AppContext"]
20 |         CtxConfig["ConfigContext"]
21 |         CtxUIState["UIStateContext"]
22 |         CtxUIActions["UIActionsContext"]
23 |     end
24 | 
25 |     subgraph "Component Consumers"
26 |         direction TB
27 |         ConsumerApp["App"]
28 |         ConsumerAppContainer["AppContainer"]
29 |         ConsumerAppHeader["AppHeader"]
30 |         ConsumerDialogManager["DialogManager"]
31 |         ConsumerHistoryItem["HistoryItemDisplay"]
32 |         ConsumerComposer["Composer"]
33 |         ConsumerMainContent["MainContent"]
34 |         ConsumerNotifications["Notifications"]
35 |     end
36 | 
37 |     %% --- Provider -> Context Connections ---
38 |     A -.-> CtxSession
39 |     A -.-> CtxVim
40 |     A -.-> CtxSettings
41 | 
42 |     B -.-> CtxApp
43 |     B -.-> CtxConfig
44 |     B -.-> CtxUIState
45 |     B -.-> CtxUIActions
46 |     B -.-> CtxSettings
47 | 
48 |     %% --- Context -> Consumer Connections ---
49 |     CtxSession -.-> ConsumerAppContainer
50 |     CtxSession -.-> ConsumerApp
51 | 
52 |     CtxVim -.-> ConsumerAppContainer
53 |     CtxVim -.-> ConsumerComposer
54 |     CtxVim -.-> ConsumerApp
55 | 
56 |     CtxSettings -.-> ConsumerAppContainer
57 |     CtxSettings -.-> ConsumerAppHeader
58 |     CtxSettings -.-> ConsumerDialogManager
59 |     CtxSettings -.-> ConsumerApp
60 | 
61 |     CtxApp -.-> ConsumerAppHeader
62 |     CtxApp -.-> ConsumerNotifications
63 | 
64 |     CtxConfig -.-> ConsumerAppHeader
65 |     CtxConfig -.-> ConsumerHistoryItem
66 |     CtxConfig -.-> ConsumerComposer
67 |     CtxConfig -.-> ConsumerDialogManager
68 | 
69 | 
70 | 
71 |     CtxUIState -.-> ConsumerApp
72 |     CtxUIState -.-> ConsumerMainContent
73 |     CtxUIState -.-> ConsumerComposer
74 |     CtxUIState -.-> ConsumerDialogManager
75 | 
76 |     CtxUIActions -.-> ConsumerComposer
77 |     CtxUIActions -.-> ConsumerDialogManager
78 | 
79 |     %% --- Apply Styles ---
80 |     %% New Elements (Green)
81 |     class B,CtxApp,CtxConfig,CtxUIState,CtxUIActions,ConsumerAppHeader,ConsumerDialogManager,ConsumerComposer,ConsumerMainContent,ConsumerNotifications new
82 | 
83 |     %% Heavily Changed Elements (Blue)
84 |     class A,ConsumerApp,ConsumerAppContainer,ConsumerHistoryItem changed
85 | 
86 |     %% Mostly Unchanged Elements (Gray)
87 |     class CtxSession,CtxVim,CtxSettings unchanged
88 | 
89 |     %% --- Link Styles ---
90 |     %% CtxSession (Red)
91 |     linkStyle 0,8,9 stroke:#e57373,stroke-width:2px
92 |     %% CtxVim (Orange)
93 |     linkStyle 1,10,11,12 stroke:#ffb74d,stroke-width:2px
94 |     %% CtxSettings (Yellow)
95 |     linkStyle 2,7,13,14,15,16 stroke:#fff176,stroke-width:2px
96 |     %% CtxApp (Green)
97 |     linkStyle 3,17,18 stroke:#81c784,stroke-width:2px
98 |     %% CtxConfig (Blue)
99 |     linkStyle 4,19,20,21,22 stroke:#64b5f6,stroke-width:2px
100 |     %% CtxUIState (Indigo)
101 |     linkStyle 5,23,24,25,26 stroke:#7986cb,stroke-width:2px
102 |     %% CtxUIActions (Violet)
103 |     linkStyle 6,27,28 stroke:#ba68c8,stroke-width:2px
```

mermaid/render-path.mmd
```
1 | graph TD
2 |     %% --- Style Definitions ---
3 |     classDef new fill:#98fb98,color:#000
4 |     classDef changed fill:#add8e6,color:#000
5 |     classDef unchanged fill:#f0f0f0,color:#000
6 |     classDef dispatcher fill:#f9e79f,color:#000,stroke:#333,stroke-width:1px
7 |     classDef container fill:#f5f5f5,color:#000,stroke:#ccc
8 | 
9 |     %% --- Component Tree ---
10 |     subgraph "Entry Point"
11 |       A["gemini.tsx"]
12 |     end
13 | 
14 |     subgraph "State & Logic Wrapper"
15 |       B["AppContainer.tsx"]
16 |     end
17 | 
18 |     subgraph "Primary Layout"
19 |       C["App.tsx"]
20 |     end
21 | 
22 |     A -.-> B
23 |     B -.-> C
24 | 
25 |     subgraph "UI Containers"
26 |         direction LR
27 |         C -.-> D["MainContent"]
28 |         C -.-> G["Composer"]
29 |         C -.-> F["DialogManager"]
30 |         C -.-> E["Notifications"]
31 |     end
32 | 
33 |     subgraph "MainContent"
34 |         direction TB
35 |         D -.-> H["AppHeader"]
36 |         D -.-> I["HistoryItemDisplay"]:::dispatcher
37 |         D -.-> L["ShowMoreLines"]
38 |     end
39 | 
40 |     subgraph "Composer"
41 |         direction TB
42 |         G -.-> K_Prompt["InputPrompt"]
43 |         G -.-> K_Footer["Footer"]
44 |     end
45 | 
46 |     subgraph "DialogManager"
47 |         F -.-> J["Various Dialogs<br>(Auth, Theme, Settings, etc.)"]
48 |     end
49 | 
50 |     %% --- Apply Styles ---
51 |     class B,D,E,F,G,H,J,K_Prompt,L new
52 |     class A,C,I changed
53 |     class K_Footer unchanged
54 | 
55 |     %% --- Link Styles ---
56 |     %% MainContent Branch (Blue)
57 |     linkStyle 2,6,7,8 stroke:#64b5f6,stroke-width:2px
58 |     %% Composer Branch (Green)
59 |     linkStyle 3,9,10 stroke:#81c784,stroke-width:2px
60 |     %% DialogManager Branch (Orange)
61 |     linkStyle 4,11 stroke:#ffb74d,stroke-width:2px
62 |     %% Notifications Branch (Violet)
63 |     linkStyle 5 stroke:#ba68c8,stroke-width:2px
64 | 
```

tools/file-system.md
```
1 | # Gemini CLI file system tools
2 | 
3 | The Gemini CLI provides a comprehensive suite of tools for interacting with the
4 | local file system. These tools allow the Gemini model to read from, write to,
5 | list, search, and modify files and directories, all under your control and
6 | typically with confirmation for sensitive operations.
7 | 
8 | **Note:** All file system tools operate within a `rootDirectory` (usually the
9 | current working directory where you launched the CLI) for security. Paths that
10 | you provide to these tools are generally expected to be absolute or are resolved
11 | relative to this root directory.
12 | 
13 | ## 1. `list_directory` (ReadFolder)
14 | 
15 | `list_directory` lists the names of files and subdirectories directly within a
16 | specified directory path. It can optionally ignore entries matching provided
17 | glob patterns.
18 | 
19 | - **Tool name:** `list_directory`
20 | - **Display name:** ReadFolder
21 | - **File:** `ls.ts`
22 | - **Parameters:**
23 |   - `path` (string, required): The absolute path to the directory to list.
24 |   - `ignore` (array of strings, optional): A list of glob patterns to exclude
25 |     from the listing (e.g., `["*.log", ".git"]`).
26 |   - `respect_git_ignore` (boolean, optional): Whether to respect `.gitignore`
27 |     patterns when listing files. Defaults to `true`.
28 | - **Behavior:**
29 |   - Returns a list of file and directory names.
30 |   - Indicates whether each entry is a directory.
31 |   - Sorts entries with directories first, then alphabetically.
32 | - **Output (`llmContent`):** A string like:
33 |   `Directory listing for /path/to/your/folder:\n[DIR] subfolder1\nfile1.txt\nfile2.png`
34 | - **Confirmation:** No.
35 | 
36 | ## 2. `read_file` (ReadFile)
37 | 
38 | `read_file` reads and returns the content of a specified file. This tool handles
39 | text, images (PNG, JPG, GIF, WEBP, SVG, BMP), and PDF files. For text files, it
40 | can read specific line ranges. Other binary file types are generally skipped.
41 | 
42 | - **Tool name:** `read_file`
43 | - **Display name:** ReadFile
44 | - **File:** `read-file.ts`
45 | - **Parameters:**
46 |   - `path` (string, required): The absolute path to the file to read.
47 |   - `offset` (number, optional): For text files, the 0-based line number to
48 |     start reading from. Requires `limit` to be set.
49 |   - `limit` (number, optional): For text files, the maximum number of lines to
50 |     read. If omitted, reads a default maximum (e.g., 2000 lines) or the entire
51 |     file if feasible.
52 | - **Behavior:**
53 |   - For text files: Returns the content. If `offset` and `limit` are used,
54 |     returns only that slice of lines. Indicates if content was truncated due to
55 |     line limits or line length limits.
56 |   - For image and PDF files: Returns the file content as a base64-encoded data
57 |     structure suitable for model consumption.
58 |   - For other binary files: Attempts to identify and skip them, returning a
59 |     message indicating it's a generic binary file.
60 | - **Output:** (`llmContent`):
61 |   - For text files: The file content, potentially prefixed with a truncation
62 |     message (e.g.,
63 |     `[File content truncated: showing lines 1-100 of 500 total lines...]\nActual file content...`).
64 |   - For image/PDF files: An object containing `inlineData` with `mimeType` and
65 |     base64 `data` (e.g.,
66 |     `{ inlineData: { mimeType: 'image/png', data: 'base64encodedstring' } }`).
67 |   - For other binary files: A message like
68 |     `Cannot display content of binary file: /path/to/data.bin`.
69 | - **Confirmation:** No.
70 | 
71 | ## 3. `write_file` (WriteFile)
72 | 
73 | `write_file` writes content to a specified file. If the file exists, it will be
74 | overwritten. If the file doesn't exist, it (and any necessary parent
75 | directories) will be created.
76 | 
77 | - **Tool name:** `write_file`
78 | - **Display name:** WriteFile
79 | - **File:** `write-file.ts`
80 | - **Parameters:**
81 |   - `file_path` (string, required): The absolute path to the file to write to.
82 |   - `content` (string, required): The content to write into the file.
83 | - **Behavior:**
84 |   - Writes the provided `content` to the `file_path`.
85 |   - Creates parent directories if they don't exist.
86 | - **Output (`llmContent`):** A success message, e.g.,
87 |   `Successfully overwrote file: /path/to/your/file.txt` or
88 |   `Successfully created and wrote to new file: /path/to/new/file.txt`.
89 | - **Confirmation:** Yes. Shows a diff of changes and asks for user approval
90 |   before writing.
91 | 
92 | ## 4. `glob` (FindFiles)
93 | 
94 | `glob` finds files matching specific glob patterns (e.g., `src/**/*.ts`,
95 | `*.md`), returning absolute paths sorted by modification time (newest first).
96 | 
97 | - **Tool name:** `glob`
98 | - **Display name:** FindFiles
99 | - **File:** `glob.ts`
100 | - **Parameters:**
101 |   - `pattern` (string, required): The glob pattern to match against (e.g.,
102 |     `"*.py"`, `"src/**/*.js"`).
103 |   - `path` (string, optional): The absolute path to the directory to search
104 |     within. If omitted, searches the tool's root directory.
105 |   - `case_sensitive` (boolean, optional): Whether the search should be
106 |     case-sensitive. Defaults to `false`.
107 |   - `respect_git_ignore` (boolean, optional): Whether to respect .gitignore
108 |     patterns when finding files. Defaults to `true`.
109 | - **Behavior:**
110 |   - Searches for files matching the glob pattern within the specified directory.
111 |   - Returns a list of absolute paths, sorted with the most recently modified
112 |     files first.
113 |   - Ignores common nuisance directories like `node_modules` and `.git` by
114 |     default.
115 | - **Output (`llmContent`):** A message like:
116 |   `Found 5 file(s) matching "*.ts" within src, sorted by modification time (newest first):\nsrc/file1.ts\nsrc/subdir/file2.ts...`
117 | - **Confirmation:** No.
118 | 
119 | ## 5. `search_file_content` (SearchText)
120 | 
121 | `search_file_content` searches for a regular expression pattern within the
122 | content of files in a specified directory. Can filter files by a glob pattern.
123 | Returns the lines containing matches, along with their file paths and line
124 | numbers.
125 | 
126 | - **Tool name:** `search_file_content`
127 | - **Display name:** SearchText
128 | - **File:** `grep.ts`
129 | - **Parameters:**
130 |   - `pattern` (string, required): The regular expression (regex) to search for
131 |     (e.g., `"function\s+myFunction"`).
132 |   - `path` (string, optional): The absolute path to the directory to search
133 |     within. Defaults to the current working directory.
134 |   - `include` (string, optional): A glob pattern to filter which files are
135 |     searched (e.g., `"*.js"`, `"src/**/*.{ts,tsx}"`). If omitted, searches most
136 |     files (respecting common ignores).
137 | - **Behavior:**
138 |   - Uses `git grep` if available in a Git repository for speed; otherwise, falls
139 |     back to system `grep` or a JavaScript-based search.
140 |   - Returns a list of matching lines, each prefixed with its file path (relative
141 |     to the search directory) and line number.
142 | - **Output (`llmContent`):** A formatted string of matches, e.g.:
143 |   ```
144 |   Found 3 matches for pattern "myFunction" in path "." (filter: "*.ts"):
145 |   ---
146 |   File: src/utils.ts
147 |   L15: export function myFunction() {
148 |   L22:   myFunction.call();
149 |   ---
150 |   File: src/index.ts
151 |   L5: import { myFunction } from './utils';
152 |   ---
153 |   ```
154 | - **Confirmation:** No.
155 | 
156 | ## 6. `replace` (Edit)
157 | 
158 | `replace` replaces text within a file. By default, replaces a single occurrence,
159 | but can replace multiple occurrences when `expected_replacements` is specified.
160 | This tool is designed for precise, targeted changes and requires significant
161 | context around the `old_string` to ensure it modifies the correct location.
162 | 
163 | - **Tool name:** `replace`
164 | - **Display name:** Edit
165 | - **File:** `edit.ts`
166 | - **Parameters:**
167 |   - `file_path` (string, required): The absolute path to the file to modify.
168 |   - `old_string` (string, required): The exact literal text to replace.
169 | 
170 |     **CRITICAL:** This string must uniquely identify the single instance to
171 |     change. It should include at least 3 lines of context _before_ and _after_
172 |     the target text, matching whitespace and indentation precisely. If
173 |     `old_string` is empty, the tool attempts to create a new file at `file_path`
174 |     with `new_string` as content.
175 | 
176 |   - `new_string` (string, required): The exact literal text to replace
177 |     `old_string` with.
178 |   - `expected_replacements` (number, optional): The number of occurrences to
179 |     replace. Defaults to `1`.
180 | 
181 | - **Behavior:**
182 |   - If `old_string` is empty and `file_path` does not exist, creates a new file
183 |     with `new_string` as content.
184 |   - If `old_string` is provided, it reads the `file_path` and attempts to find
185 |     exactly one occurrence of `old_string`.
186 |   - If one occurrence is found, it replaces it with `new_string`.
187 |   - **Enhanced Reliability (Multi-Stage Edit Correction):** To significantly
188 |     improve the success rate of edits, especially when the model-provided
189 |     `old_string` might not be perfectly precise, the tool incorporates a
190 |     multi-stage edit correction mechanism.
191 |     - If the initial `old_string` isn't found or matches multiple locations, the
192 |       tool can leverage the Gemini model to iteratively refine `old_string` (and
193 |       potentially `new_string`).
194 |     - This self-correction process attempts to identify the unique segment the
195 |       model intended to modify, making the `replace` operation more robust even
196 |       with slightly imperfect initial context.
197 | - **Failure conditions:** Despite the correction mechanism, the tool will fail
198 |   if:
199 |   - `file_path` is not absolute or is outside the root directory.
200 |   - `old_string` is not empty, but the `file_path` does not exist.
201 |   - `old_string` is empty, but the `file_path` already exists.
202 |   - `old_string` is not found in the file after attempts to correct it.
203 |   - `old_string` is found multiple times, and the self-correction mechanism
204 |     cannot resolve it to a single, unambiguous match.
205 | - **Output (`llmContent`):**
206 |   - On success:
207 |     `Successfully modified file: /path/to/file.txt (1 replacements).` or
208 |     `Created new file: /path/to/new_file.txt with provided content.`
209 |   - On failure: An error message explaining the reason (e.g.,
210 |     `Failed to edit, 0 occurrences found...`,
211 |     `Failed to edit, expected 1 occurrences but found 2...`).
212 | - **Confirmation:** Yes. Shows a diff of the proposed changes and asks for user
213 |   approval before writing to the file.
214 | 
215 | These file system tools provide a foundation for the Gemini CLI to understand
216 | and interact with your local project context.
```

tools/index.md
```
1 | # Gemini CLI tools
2 | 
3 | The Gemini CLI includes built-in tools that the Gemini model uses to interact
4 | with your local environment, access information, and perform actions. These
5 | tools enhance the CLI's capabilities, enabling it to go beyond text generation
6 | and assist with a wide range of tasks.
7 | 
8 | ## Overview of Gemini CLI tools
9 | 
10 | In the context of the Gemini CLI, tools are specific functions or modules that
11 | the Gemini model can request to be executed. For example, if you ask Gemini to
12 | "Summarize the contents of `my_document.txt`," the model will likely identify
13 | the need to read that file and will request the execution of the `read_file`
14 | tool.
15 | 
16 | The core component (`packages/core`) manages these tools, presents their
17 | definitions (schemas) to the Gemini model, executes them when requested, and
18 | returns the results to the model for further processing into a user-facing
19 | response.
20 | 
21 | These tools provide the following capabilities:
22 | 
23 | - **Access local information:** Tools allow Gemini to access your local file
24 |   system, read file contents, list directories, etc.
25 | - **Execute commands:** With tools like `run_shell_command`, Gemini can run
26 |   shell commands (with appropriate safety measures and user confirmation).
27 | - **Interact with the web:** Tools can fetch content from URLs.
28 | - **Take actions:** Tools can modify files, write new files, or perform other
29 |   actions on your system (again, typically with safeguards).
30 | - **Ground responses:** By using tools to fetch real-time or specific local
31 |   data, Gemini's responses can be more accurate, relevant, and grounded in your
32 |   actual context.
33 | 
34 | ## How to use Gemini CLI tools
35 | 
36 | To use Gemini CLI tools, provide a prompt to the Gemini CLI. The process works
37 | as follows:
38 | 
39 | 1.  You provide a prompt to the Gemini CLI.
40 | 2.  The CLI sends the prompt to the core.
41 | 3.  The core, along with your prompt and conversation history, sends a list of
42 |     available tools and their descriptions/schemas to the Gemini API.
43 | 4.  The Gemini model analyzes your request. If it determines that a tool is
44 |     needed, its response will include a request to execute a specific tool with
45 |     certain parameters.
46 | 5.  The core receives this tool request, validates it, and (often after user
47 |     confirmation for sensitive operations) executes the tool.
48 | 6.  The output from the tool is sent back to the Gemini model.
49 | 7.  The Gemini model uses the tool's output to formulate its final answer, which
50 |     is then sent back through the core to the CLI and displayed to you.
51 | 
52 | You will typically see messages in the CLI indicating when a tool is being
53 | called and whether it succeeded or failed.
54 | 
55 | ## Security and confirmation
56 | 
57 | Many tools, especially those that can modify your file system or execute
58 | commands (`write_file`, `edit`, `run_shell_command`), are designed with safety
59 | in mind. The Gemini CLI will typically:
60 | 
61 | - **Require confirmation:** Prompt you before executing potentially sensitive
62 |   operations, showing you what action is about to be taken.
63 | - **Utilize sandboxing:** All tools are subject to restrictions enforced by
64 |   sandboxing (see [Sandboxing in the Gemini CLI](../cli/sandbox.md)). This means
65 |   that when operating in a sandbox, any tools (including MCP servers) you wish
66 |   to use must be available _inside_ the sandbox environment. For example, to run
67 |   an MCP server through `npx`, the `npx` executable must be installed within the
68 |   sandbox's Docker image or be available in the `sandbox-exec` environment.
69 | 
70 | It's important to always review confirmation prompts carefully before allowing a
71 | tool to proceed.
72 | 
73 | ## Learn more about Gemini CLI's tools
74 | 
75 | Gemini CLI's built-in tools can be broadly categorized as follows:
76 | 
77 | - **[File System Tools](./file-system.md):** For interacting with files and
78 |   directories (reading, writing, listing, searching, etc.).
79 | - **[Shell Tool](./shell.md) (`run_shell_command`):** For executing shell
80 |   commands.
81 | - **[Web Fetch Tool](./web-fetch.md) (`web_fetch`):** For retrieving content
82 |   from URLs.
83 | - **[Web Search Tool](./web-search.md) (`google_web_search`):** For searching
84 |   the web.
85 | - **[Multi-File Read Tool](./multi-file.md) (`read_many_files`):** A specialized
86 |   tool for reading content from multiple files or directories.
87 | - **[Memory Tool](./memory.md) (`save_memory`):** For saving and recalling
88 |   information across sessions.
89 | 
90 | Additionally, these tools incorporate:
91 | 
92 | - **[MCP servers](./mcp-server.md)**: MCP servers act as a bridge between the
93 |   Gemini model and your local environment or other services like APIs.
94 | - **[Sandboxing](../cli/sandbox.md)**: Sandboxing isolates the model and its
95 |   changes from your environment to reduce potential risk.
```

tools/mcp-server.md
```
1 | # MCP servers with the Gemini CLI
2 | 
3 | This document provides a guide to configuring and using Model Context Protocol
4 | (MCP) servers with the Gemini CLI.
5 | 
6 | ## What is an MCP server?
7 | 
8 | An MCP server is an application that exposes tools and resources to the Gemini
9 | CLI through the Model Context Protocol, allowing it to interact with external
10 | systems and data sources. MCP servers act as a bridge between the Gemini model
11 | and your local environment or other services like APIs.
12 | 
13 | An MCP server enables the Gemini CLI to:
14 | 
15 | - **Discover tools:** List available tools, their descriptions, and parameters
16 |   through standardized schema definitions.
17 | - **Execute tools:** Call specific tools with defined arguments and receive
18 |   structured responses.
19 | - **Access resources:** Read data from specific resources (though the Gemini CLI
20 |   primarily focuses on tool execution).
21 | 
22 | With an MCP server, you can extend the Gemini CLI's capabilities to perform
23 | actions beyond its built-in features, such as interacting with databases, APIs,
24 | custom scripts, or specialized workflows.
25 | 
26 | ## Core Integration Architecture
27 | 
28 | The Gemini CLI integrates with MCP servers through a sophisticated discovery and
29 | execution system built into the core package (`packages/core/src/tools/`):
30 | 
31 | ### Discovery Layer (`mcp-client.ts`)
32 | 
33 | The discovery process is orchestrated by `discoverMcpTools()`, which:
34 | 
35 | 1. **Iterates through configured servers** from your `settings.json`
36 |    `mcpServers` configuration
37 | 2. **Establishes connections** using appropriate transport mechanisms (Stdio,
38 |    SSE, or Streamable HTTP)
39 | 3. **Fetches tool definitions** from each server using the MCP protocol
40 | 4. **Sanitizes and validates** tool schemas for compatibility with the Gemini
41 |    API
42 | 5. **Registers tools** in the global tool registry with conflict resolution
43 | 
44 | ### Execution Layer (`mcp-tool.ts`)
45 | 
46 | Each discovered MCP tool is wrapped in a `DiscoveredMCPTool` instance that:
47 | 
48 | - **Handles confirmation logic** based on server trust settings and user
49 |   preferences
50 | - **Manages tool execution** by calling the MCP server with proper parameters
51 | - **Processes responses** for both the LLM context and user display
52 | - **Maintains connection state** and handles timeouts
53 | 
54 | ### Transport Mechanisms
55 | 
56 | The Gemini CLI supports three MCP transport types:
57 | 
58 | - **Stdio Transport:** Spawns a subprocess and communicates via stdin/stdout
59 | - **SSE Transport:** Connects to Server-Sent Events endpoints
60 | - **Streamable HTTP Transport:** Uses HTTP streaming for communication
61 | 
62 | ## How to set up your MCP server
63 | 
64 | The Gemini CLI uses the `mcpServers` configuration in your `settings.json` file
65 | to locate and connect to MCP servers. This configuration supports multiple
66 | servers with different transport mechanisms.
67 | 
68 | ### Configure the MCP server in settings.json
69 | 
70 | You can configure MCP servers in your `settings.json` file in two main ways:
71 | through the top-level `mcpServers` object for specific server definitions, and
72 | through the `mcp` object for global settings that control server discovery and
73 | execution.
74 | 
75 | #### Global MCP Settings (`mcp`)
76 | 
77 | The `mcp` object in your `settings.json` allows you to define global rules for
78 | all MCP servers.
79 | 
80 | - **`mcp.serverCommand`** (string): A global command to start an MCP server.
81 | - **`mcp.allowed`** (array of strings): A list of MCP server names to allow. If
82 |   this is set, only servers from this list (matching the keys in the
83 |   `mcpServers` object) will be connected to.
84 | - **`mcp.excluded`** (array of strings): A list of MCP server names to exclude.
85 |   Servers in this list will not be connected to.
86 | 
87 | **Example:**
88 | 
89 | ```json
90 | {
91 |   "mcp": {
92 |     "allowed": ["my-trusted-server"],
93 |     "excluded": ["experimental-server"]
94 |   }
95 | }
96 | ```
97 | 
98 | #### Server-Specific Configuration (`mcpServers`)
99 | 
100 | The `mcpServers` object is where you define each individual MCP server you want
101 | the CLI to connect to.
102 | 
103 | ### Configuration Structure
104 | 
105 | Add an `mcpServers` object to your `settings.json` file:
106 | 
107 | ```json
108 | { ...file contains other config objects
109 |   "mcpServers": {
110 |     "serverName": {
111 |       "command": "path/to/server",
112 |       "args": ["--arg1", "value1"],
113 |       "env": {
114 |         "API_KEY": "$MY_API_TOKEN"
115 |       },
116 |       "cwd": "./server-directory",
117 |       "timeout": 30000,
118 |       "trust": false
119 |     }
120 |   }
121 | }
122 | ```
123 | 
124 | ### Configuration Properties
125 | 
126 | Each server configuration supports the following properties:
127 | 
128 | #### Required (one of the following)
129 | 
130 | - **`command`** (string): Path to the executable for Stdio transport
131 | - **`url`** (string): SSE endpoint URL (e.g., `"http://localhost:8080/sse"`)
132 | - **`httpUrl`** (string): HTTP streaming endpoint URL
133 | 
134 | #### Optional
135 | 
136 | - **`args`** (string[]): Command-line arguments for Stdio transport
137 | - **`headers`** (object): Custom HTTP headers when using `url` or `httpUrl`
138 | - **`env`** (object): Environment variables for the server process. Values can
139 |   reference environment variables using `$VAR_NAME` or `${VAR_NAME}` syntax
140 | - **`cwd`** (string): Working directory for Stdio transport
141 | - **`timeout`** (number): Request timeout in milliseconds (default: 600,000ms =
142 |   10 minutes)
143 | - **`trust`** (boolean): When `true`, bypasses all tool call confirmations for
144 |   this server (default: `false`)
145 | - **`includeTools`** (string[]): List of tool names to include from this MCP
146 |   server. When specified, only the tools listed here will be available from this
147 |   server (allowlist behavior). If not specified, all tools from the server are
148 |   enabled by default.
149 | - **`excludeTools`** (string[]): List of tool names to exclude from this MCP
150 |   server. Tools listed here will not be available to the model, even if they are
151 |   exposed by the server. **Note:** `excludeTools` takes precedence over
152 |   `includeTools` - if a tool is in both lists, it will be excluded.
153 | - **`targetAudience`** (string): The OAuth Client ID allowlisted on the
154 |   IAP-protected application you are trying to access. Used with
155 |   `authProviderType: 'service_account_impersonation'`.
156 | - **`targetServiceAccount`** (string): The email address of the Google Cloud
157 |   Service Account to impersonate. Used with
158 |   `authProviderType: 'service_account_impersonation'`.
159 | 
160 | ### OAuth Support for Remote MCP Servers
161 | 
162 | The Gemini CLI supports OAuth 2.0 authentication for remote MCP servers using
163 | SSE or HTTP transports. This enables secure access to MCP servers that require
164 | authentication.
165 | 
166 | #### Automatic OAuth Discovery
167 | 
168 | For servers that support OAuth discovery, you can omit the OAuth configuration
169 | and let the CLI discover it automatically:
170 | 
171 | ```json
172 | {
173 |   "mcpServers": {
174 |     "discoveredServer": {
175 |       "url": "https://api.example.com/sse"
176 |     }
177 |   }
178 | }
179 | ```
180 | 
181 | The CLI will automatically:
182 | 
183 | - Detect when a server requires OAuth authentication (401 responses)
184 | - Discover OAuth endpoints from server metadata
185 | - Perform dynamic client registration if supported
186 | - Handle the OAuth flow and token management
187 | 
188 | #### Authentication Flow
189 | 
190 | When connecting to an OAuth-enabled server:
191 | 
192 | 1. **Initial connection attempt** fails with 401 Unauthorized
193 | 2. **OAuth discovery** finds authorization and token endpoints
194 | 3. **Browser opens** for user authentication (requires local browser access)
195 | 4. **Authorization code** is exchanged for access tokens
196 | 5. **Tokens are stored** securely for future use
197 | 6. **Connection retry** succeeds with valid tokens
198 | 
199 | #### Browser Redirect Requirements
200 | 
201 | **Important:** OAuth authentication requires that your local machine can:
202 | 
203 | - Open a web browser for authentication
204 | - Receive redirects on `http://localhost:7777/oauth/callback`
205 | 
206 | This feature will not work in:
207 | 
208 | - Headless environments without browser access
209 | - Remote SSH sessions without X11 forwarding
210 | - Containerized environments without browser support
211 | 
212 | #### Managing OAuth Authentication
213 | 
214 | Use the `/mcp auth` command to manage OAuth authentication:
215 | 
216 | ```bash
217 | # List servers requiring authentication
218 | /mcp auth
219 | 
220 | # Authenticate with a specific server
221 | /mcp auth serverName
222 | 
223 | # Re-authenticate if tokens expire
224 | /mcp auth serverName
225 | ```
226 | 
227 | #### OAuth Configuration Properties
228 | 
229 | - **`enabled`** (boolean): Enable OAuth for this server
230 | - **`clientId`** (string): OAuth client identifier (optional with dynamic
231 |   registration)
232 | - **`clientSecret`** (string): OAuth client secret (optional for public clients)
233 | - **`authorizationUrl`** (string): OAuth authorization endpoint (auto-discovered
234 |   if omitted)
235 | - **`tokenUrl`** (string): OAuth token endpoint (auto-discovered if omitted)
236 | - **`scopes`** (string[]): Required OAuth scopes
237 | - **`redirectUri`** (string): Custom redirect URI (defaults to
238 |   `http://localhost:7777/oauth/callback`)
239 | - **`tokenParamName`** (string): Query parameter name for tokens in SSE URLs
240 | - **`audiences`** (string[]): Audiences the token is valid for
241 | 
242 | #### Token Management
243 | 
244 | OAuth tokens are automatically:
245 | 
246 | - **Stored securely** in `~/.gemini/mcp-oauth-tokens.json`
247 | - **Refreshed** when expired (if refresh tokens are available)
248 | - **Validated** before each connection attempt
249 | - **Cleaned up** when invalid or expired
250 | 
251 | #### Authentication Provider Type
252 | 
253 | You can specify the authentication provider type using the `authProviderType`
254 | property:
255 | 
256 | - **`authProviderType`** (string): Specifies the authentication provider. Can be
257 |   one of the following:
258 |   - **`dynamic_discovery`** (default): The CLI will automatically discover the
259 |     OAuth configuration from the server.
260 |   - **`google_credentials`**: The CLI will use the Google Application Default
261 |     Credentials (ADC) to authenticate with the server. When using this provider,
262 |     you must specify the required scopes.
263 |   - **`service_account_impersonation`**: The CLI will impersonate a Google Cloud
264 |     Service Account to authenticate with the server. This is useful for
265 |     accessing IAP-protected services (this was specifically designed for Cloud
266 |     Run services).
267 | 
268 | #### Google Credentials
269 | 
270 | ```json
271 | {
272 |   "mcpServers": {
273 |     "googleCloudServer": {
274 |       "httpUrl": "https://my-gcp-service.run.app/mcp",
275 |       "authProviderType": "google_credentials",
276 |       "oauth": {
277 |         "scopes": ["https://www.googleapis.com/auth/userinfo.email"]
278 |       }
279 |     }
280 |   }
281 | }
282 | ```
283 | 
284 | #### Service Account Impersonation
285 | 
286 | To authenticate with a server using Service Account Impersonation, you must set
287 | the `authProviderType` to `service_account_impersonation` and provide the
288 | following properties:
289 | 
290 | - **`targetAudience`** (string): The OAuth Client ID allowslisted on the
291 |   IAP-protected application you are trying to access.
292 | - **`targetServiceAccount`** (string): The email address of the Google Cloud
293 |   Service Account to impersonate.
294 | 
295 | The CLI will use your local Application Default Credentials (ADC) to generate an
296 | OIDC ID token for the specified service account and audience. This token will
297 | then be used to authenticate with the MCP server.
298 | 
299 | #### Setup Instructions
300 | 
301 | 1. **[Create](https://cloud.google.com/iap/docs/oauth-client-creation) or use an
302 |    existing OAuth 2.0 client ID.** To use an existing OAuth 2.0 client ID,
303 |    follow the steps in
304 |    [How to share OAuth Clients](https://cloud.google.com/iap/docs/sharing-oauth-clients).
305 | 2. **Add the OAuth ID to the allowlist for
306 |    [programmatic access](https://cloud.google.com/iap/docs/sharing-oauth-clients#programmatic_access)
307 |    for the application.** Since Cloud Run is not yet a supported resource type
308 |    in gcloud iap, you must allowlist the Client ID on the project.
309 | 3. **Create a service account.**
310 |    [Documentation](https://cloud.google.com/iam/docs/service-accounts-create#creating),
311 |    [Cloud Console Link](https://console.cloud.google.com/iam-admin/serviceaccounts)
312 | 4. **Add both the service account and users to the IAP Policy** in the
313 |    "Security" tab of the Cloud Run service itself or via gcloud.
314 | 5. **Grant all users and groups** who will access the MCP Server the necessary
315 |    permissions to
316 |    [impersonate the service account](https://cloud.google.com/docs/authentication/use-service-account-impersonation)
317 |    (i.e., `roles/iam.serviceAccountTokenCreator`).
318 | 6. **[Enable](https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com)
319 |    the IAM Credentials API** for your project.
320 | 
321 | ### Example Configurations
322 | 
323 | #### Python MCP Server (Stdio)
324 | 
325 | ```json
326 | {
327 |   "mcpServers": {
328 |     "pythonTools": {
329 |       "command": "python",
330 |       "args": ["-m", "my_mcp_server", "--port", "8080"],
331 |       "cwd": "./mcp-servers/python",
332 |       "env": {
333 |         "DATABASE_URL": "$DB_CONNECTION_STRING",
334 |         "API_KEY": "${EXTERNAL_API_KEY}"
335 |       },
336 |       "timeout": 15000
337 |     }
338 |   }
339 | }
340 | ```
341 | 
342 | #### Node.js MCP Server (Stdio)
343 | 
344 | ```json
345 | {
346 |   "mcpServers": {
347 |     "nodeServer": {
348 |       "command": "node",
349 |       "args": ["dist/server.js", "--verbose"],
350 |       "cwd": "./mcp-servers/node",
351 |       "trust": true
352 |     }
353 |   }
354 | }
355 | ```
356 | 
357 | #### Docker-based MCP Server
358 | 
359 | ```json
360 | {
361 |   "mcpServers": {
362 |     "dockerizedServer": {
363 |       "command": "docker",
364 |       "args": [
365 |         "run",
366 |         "-i",
367 |         "--rm",
368 |         "-e",
369 |         "API_KEY",
370 |         "-v",
371 |         "${PWD}:/workspace",
372 |         "my-mcp-server:latest"
373 |       ],
374 |       "env": {
375 |         "API_KEY": "$EXTERNAL_SERVICE_TOKEN"
376 |       }
377 |     }
378 |   }
379 | }
380 | ```
381 | 
382 | #### HTTP-based MCP Server
383 | 
384 | ```json
385 | {
386 |   "mcpServers": {
387 |     "httpServer": {
388 |       "httpUrl": "http://localhost:3000/mcp",
389 |       "timeout": 5000
390 |     }
391 |   }
392 | }
393 | ```
394 | 
395 | #### HTTP-based MCP Server with Custom Headers
396 | 
397 | ```json
398 | {
399 |   "mcpServers": {
400 |     "httpServerWithAuth": {
401 |       "httpUrl": "http://localhost:3000/mcp",
402 |       "headers": {
403 |         "Authorization": "Bearer your-api-token",
404 |         "X-Custom-Header": "custom-value",
405 |         "Content-Type": "application/json"
406 |       },
407 |       "timeout": 5000
408 |     }
409 |   }
410 | }
411 | ```
412 | 
413 | #### MCP Server with Tool Filtering
414 | 
415 | ```json
416 | {
417 |   "mcpServers": {
418 |     "filteredServer": {
419 |       "command": "python",
420 |       "args": ["-m", "my_mcp_server"],
421 |       "includeTools": ["safe_tool", "file_reader", "data_processor"],
422 |       // "excludeTools": ["dangerous_tool", "file_deleter"],
423 |       "timeout": 30000
424 |     }
425 |   }
426 | }
427 | ```
428 | 
429 | ### SSE MCP Server with SA Impersonation
430 | 
431 | ```json
432 | {
433 |   "mcpServers": {
434 |     "myIapProtectedServer": {
435 |       "url": "https://my-iap-service.run.app/sse",
436 |       "authProviderType": "service_account_impersonation",
437 |       "targetAudience": "YOUR_IAP_CLIENT_ID.apps.googleusercontent.com",
438 |       "targetServiceAccount": "your-sa@your-project.iam.gserviceaccount.com"
439 |     }
440 |   }
441 | }
442 | ```
443 | 
444 | ## Discovery Process Deep Dive
445 | 
446 | When the Gemini CLI starts, it performs MCP server discovery through the
447 | following detailed process:
448 | 
449 | ### 1. Server Iteration and Connection
450 | 
451 | For each configured server in `mcpServers`:
452 | 
453 | 1. **Status tracking begins:** Server status is set to `CONNECTING`
454 | 2. **Transport selection:** Based on configuration properties:
455 |    - `httpUrl` → `StreamableHTTPClientTransport`
456 |    - `url` → `SSEClientTransport`
457 |    - `command` → `StdioClientTransport`
458 | 3. **Connection establishment:** The MCP client attempts to connect with the
459 |    configured timeout
460 | 4. **Error handling:** Connection failures are logged and the server status is
461 |    set to `DISCONNECTED`
462 | 
463 | ### 2. Tool Discovery
464 | 
465 | Upon successful connection:
466 | 
467 | 1. **Tool listing:** The client calls the MCP server's tool listing endpoint
468 | 2. **Schema validation:** Each tool's function declaration is validated
469 | 3. **Tool filtering:** Tools are filtered based on `includeTools` and
470 |    `excludeTools` configuration
471 | 4. **Name sanitization:** Tool names are cleaned to meet Gemini API
472 |    requirements:
473 |    - Invalid characters (non-alphanumeric, underscore, dot, hyphen) are replaced
474 |      with underscores
475 |    - Names longer than 63 characters are truncated with middle replacement
476 |      (`___`)
477 | 
478 | ### 3. Conflict Resolution
479 | 
480 | When multiple servers expose tools with the same name:
481 | 
482 | 1. **First registration wins:** The first server to register a tool name gets
483 |    the unprefixed name
484 | 2. **Automatic prefixing:** Subsequent servers get prefixed names:
485 |    `serverName__toolName`
486 | 3. **Registry tracking:** The tool registry maintains mappings between server
487 |    names and their tools
488 | 
489 | ### 4. Schema Processing
490 | 
491 | Tool parameter schemas undergo sanitization for Gemini API compatibility:
492 | 
493 | - **`$schema` properties** are removed
494 | - **`additionalProperties`** are stripped
495 | - **`anyOf` with `default`** have their default values removed (Vertex AI
496 |   compatibility)
497 | - **Recursive processing** applies to nested schemas
498 | 
499 | ### 5. Connection Management
500 | 
501 | After discovery:
502 | 
503 | - **Persistent connections:** Servers that successfully register tools maintain
504 |   their connections
505 | - **Cleanup:** Servers that provide no usable tools have their connections
506 |   closed
507 | - **Status updates:** Final server statuses are set to `CONNECTED` or
508 |   `DISCONNECTED`
509 | 
510 | ## Tool Execution Flow
511 | 
512 | When the Gemini model decides to use an MCP tool, the following execution flow
513 | occurs:
514 | 
515 | ### 1. Tool Invocation
516 | 
517 | The model generates a `FunctionCall` with:
518 | 
519 | - **Tool name:** The registered name (potentially prefixed)
520 | - **Arguments:** JSON object matching the tool's parameter schema
521 | 
522 | ### 2. Confirmation Process
523 | 
524 | Each `DiscoveredMCPTool` implements sophisticated confirmation logic:
525 | 
526 | #### Trust-based Bypass
527 | 
528 | ```typescript
529 | if (this.trust) {
530 |   return false; // No confirmation needed
531 | }
532 | ```
533 | 
534 | #### Dynamic Allow-listing
535 | 
536 | The system maintains internal allow-lists for:
537 | 
538 | - **Server-level:** `serverName` → All tools from this server are trusted
539 | - **Tool-level:** `serverName.toolName` → This specific tool is trusted
540 | 
541 | #### User Choice Handling
542 | 
543 | When confirmation is required, users can choose:
544 | 
545 | - **Proceed once:** Execute this time only
546 | - **Always allow this tool:** Add to tool-level allow-list
547 | - **Always allow this server:** Add to server-level allow-list
548 | - **Cancel:** Abort execution
549 | 
550 | ### 3. Execution
551 | 
552 | Upon confirmation (or trust bypass):
553 | 
554 | 1. **Parameter preparation:** Arguments are validated against the tool's schema
555 | 2. **MCP call:** The underlying `CallableTool` invokes the server with:
556 | 
557 |    ```typescript
558 |    const functionCalls = [
559 |      {
560 |        name: this.serverToolName, // Original server tool name
561 |        args: params,
562 |      },
563 |    ];
564 |    ```
565 | 
566 | 3. **Response processing:** Results are formatted for both LLM context and user
567 |    display
568 | 
569 | ### 4. Response Handling
570 | 
571 | The execution result contains:
572 | 
573 | - **`llmContent`:** Raw response parts for the language model's context
574 | - **`returnDisplay`:** Formatted output for user display (often JSON in markdown
575 |   code blocks)
576 | 
577 | ## How to interact with your MCP server
578 | 
579 | ### Using the `/mcp` Command
580 | 
581 | The `/mcp` command provides comprehensive information about your MCP server
582 | setup:
583 | 
584 | ```bash
585 | /mcp
586 | ```
587 | 
588 | This displays:
589 | 
590 | - **Server list:** All configured MCP servers
591 | - **Connection status:** `CONNECTED`, `CONNECTING`, or `DISCONNECTED`
592 | - **Server details:** Configuration summary (excluding sensitive data)
593 | - **Available tools:** List of tools from each server with descriptions
594 | - **Discovery state:** Overall discovery process status
595 | 
596 | ### Example `/mcp` Output
597 | 
598 | ```
599 | MCP Servers Status:
600 | 
601 | 📡 pythonTools (CONNECTED)
602 |   Command: python -m my_mcp_server --port 8080
603 |   Working Directory: ./mcp-servers/python
604 |   Timeout: 15000ms
605 |   Tools: calculate_sum, file_analyzer, data_processor
606 | 
607 | 🔌 nodeServer (DISCONNECTED)
608 |   Command: node dist/server.js --verbose
609 |   Error: Connection refused
610 | 
611 | 🐳 dockerizedServer (CONNECTED)
612 |   Command: docker run -i --rm -e API_KEY my-mcp-server:latest
613 |   Tools: docker__deploy, docker__status
614 | 
615 | Discovery State: COMPLETED
616 | ```
617 | 
618 | ### Tool Usage
619 | 
620 | Once discovered, MCP tools are available to the Gemini model like built-in
621 | tools. The model will automatically:
622 | 
623 | 1. **Select appropriate tools** based on your requests
624 | 2. **Present confirmation dialogs** (unless the server is trusted)
625 | 3. **Execute tools** with proper parameters
626 | 4. **Display results** in a user-friendly format
627 | 
628 | ## Status Monitoring and Troubleshooting
629 | 
630 | ### Connection States
631 | 
632 | The MCP integration tracks several states:
633 | 
634 | #### Server Status (`MCPServerStatus`)
635 | 
636 | - **`DISCONNECTED`:** Server is not connected or has errors
637 | - **`CONNECTING`:** Connection attempt in progress
638 | - **`CONNECTED`:** Server is connected and ready
639 | 
640 | #### Discovery State (`MCPDiscoveryState`)
641 | 
642 | - **`NOT_STARTED`:** Discovery hasn't begun
643 | - **`IN_PROGRESS`:** Currently discovering servers
644 | - **`COMPLETED`:** Discovery finished (with or without errors)
645 | 
646 | ### Common Issues and Solutions
647 | 
648 | #### Server Won't Connect
649 | 
650 | **Symptoms:** Server shows `DISCONNECTED` status
651 | 
652 | **Troubleshooting:**
653 | 
654 | 1. **Check configuration:** Verify `command`, `args`, and `cwd` are correct
655 | 2. **Test manually:** Run the server command directly to ensure it works
656 | 3. **Check dependencies:** Ensure all required packages are installed
657 | 4. **Review logs:** Look for error messages in the CLI output
658 | 5. **Verify permissions:** Ensure the CLI can execute the server command
659 | 
660 | #### No Tools Discovered
661 | 
662 | **Symptoms:** Server connects but no tools are available
663 | 
664 | **Troubleshooting:**
665 | 
666 | 1. **Verify tool registration:** Ensure your server actually registers tools
667 | 2. **Check MCP protocol:** Confirm your server implements the MCP tool listing
668 |    correctly
669 | 3. **Review server logs:** Check stderr output for server-side errors
670 | 4. **Test tool listing:** Manually test your server's tool discovery endpoint
671 | 
672 | #### Tools Not Executing
673 | 
674 | **Symptoms:** Tools are discovered but fail during execution
675 | 
676 | **Troubleshooting:**
677 | 
678 | 1. **Parameter validation:** Ensure your tool accepts the expected parameters
679 | 2. **Schema compatibility:** Verify your input schemas are valid JSON Schema
680 | 3. **Error handling:** Check if your tool is throwing unhandled exceptions
681 | 4. **Timeout issues:** Consider increasing the `timeout` setting
682 | 
683 | #### Sandbox Compatibility
684 | 
685 | **Symptoms:** MCP servers fail when sandboxing is enabled
686 | 
687 | **Solutions:**
688 | 
689 | 1. **Docker-based servers:** Use Docker containers that include all dependencies
690 | 2. **Path accessibility:** Ensure server executables are available in the
691 |    sandbox
692 | 3. **Network access:** Configure sandbox to allow necessary network connections
693 | 4. **Environment variables:** Verify required environment variables are passed
694 |    through
695 | 
696 | ### Debugging Tips
697 | 
698 | 1. **Enable debug mode:** Run the CLI with `--debug` for verbose output
699 | 2. **Check stderr:** MCP server stderr is captured and logged (INFO messages
700 |    filtered)
701 | 3. **Test isolation:** Test your MCP server independently before integrating
702 | 4. **Incremental setup:** Start with simple tools before adding complex
703 |    functionality
704 | 5. **Use `/mcp` frequently:** Monitor server status during development
705 | 
706 | ## Important Notes
707 | 
708 | ### Security Considerations
709 | 
710 | - **Trust settings:** The `trust` option bypasses all confirmation dialogs. Use
711 |   cautiously and only for servers you completely control
712 | - **Access tokens:** Be security-aware when configuring environment variables
713 |   containing API keys or tokens
714 | - **Sandbox compatibility:** When using sandboxing, ensure MCP servers are
715 |   available within the sandbox environment
716 | - **Private data:** Using broadly scoped personal access tokens can lead to
717 |   information leakage between repositories
718 | 
719 | ### Performance and Resource Management
720 | 
721 | - **Connection persistence:** The CLI maintains persistent connections to
722 |   servers that successfully register tools
723 | - **Automatic cleanup:** Connections to servers providing no tools are
724 |   automatically closed
725 | - **Timeout management:** Configure appropriate timeouts based on your server's
726 |   response characteristics
727 | - **Resource monitoring:** MCP servers run as separate processes and consume
728 |   system resources
729 | 
730 | ### Schema Compatibility
731 | 
732 | - **Property stripping:** The system automatically removes certain schema
733 |   properties (`$schema`, `additionalProperties`) for Gemini API compatibility
734 | - **Name sanitization:** Tool names are automatically sanitized to meet API
735 |   requirements
736 | - **Conflict resolution:** Tool name conflicts between servers are resolved
737 |   through automatic prefixing
738 | 
739 | This comprehensive integration makes MCP servers a powerful way to extend the
740 | Gemini CLI's capabilities while maintaining security, reliability, and ease of
741 | use.
742 | 
743 | ## Returning Rich Content from Tools
744 | 
745 | MCP tools are not limited to returning simple text. You can return rich,
746 | multi-part content, including text, images, audio, and other binary data in a
747 | single tool response. This allows you to build powerful tools that can provide
748 | diverse information to the model in a single turn.
749 | 
750 | All data returned from the tool is processed and sent to the model as context
751 | for its next generation, enabling it to reason about or summarize the provided
752 | information.
753 | 
754 | ### How It Works
755 | 
756 | To return rich content, your tool's response must adhere to the MCP
757 | specification for a
758 | [`CallToolResult`](https://modelcontextprotocol.io/specification/2025-06-18/server/tools#tool-result).
759 | The `content` field of the result should be an array of `ContentBlock` objects.
760 | The Gemini CLI will correctly process this array, separating text from binary
761 | data and packaging it for the model.
762 | 
763 | You can mix and match different content block types in the `content` array. The
764 | supported block types include:
765 | 
766 | - `text`
767 | - `image`
768 | - `audio`
769 | - `resource` (embedded content)
770 | - `resource_link`
771 | 
772 | ### Example: Returning Text and an Image
773 | 
774 | Here is an example of a valid JSON response from an MCP tool that returns both a
775 | text description and an image:
776 | 
777 | ```json
778 | {
779 |   "content": [
780 |     {
781 |       "type": "text",
782 |       "text": "Here is the logo you requested."
783 |     },
784 |     {
785 |       "type": "image",
786 |       "data": "BASE64_ENCODED_IMAGE_DATA_HERE",
787 |       "mimeType": "image/png"
788 |     },
789 |     {
790 |       "type": "text",
791 |       "text": "The logo was created in 2025."
792 |     }
793 |   ]
794 | }
795 | ```
796 | 
797 | When the Gemini CLI receives this response, it will:
798 | 
799 | 1.  Extract all the text and combine it into a single `functionResponse` part
800 |     for the model.
801 | 2.  Present the image data as a separate `inlineData` part.
802 | 3.  Provide a clean, user-friendly summary in the CLI, indicating that both text
803 |     and an image were received.
804 | 
805 | This enables you to build sophisticated tools that can provide rich, multi-modal
806 | context to the Gemini model.
807 | 
808 | ## MCP Prompts as Slash Commands
809 | 
810 | In addition to tools, MCP servers can expose predefined prompts that can be
811 | executed as slash commands within the Gemini CLI. This allows you to create
812 | shortcuts for common or complex queries that can be easily invoked by name.
813 | 
814 | ### Defining Prompts on the Server
815 | 
816 | Here's a small example of a stdio MCP server that defines prompts:
817 | 
818 | ```ts
819 | import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
820 | import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
821 | import { z } from 'zod';
822 | 
823 | const server = new McpServer({
824 |   name: 'prompt-server',
825 |   version: '1.0.0',
826 | });
827 | 
828 | server.registerPrompt(
829 |   'poem-writer',
830 |   {
831 |     title: 'Poem Writer',
832 |     description: 'Write a nice haiku',
833 |     argsSchema: { title: z.string(), mood: z.string().optional() },
834 |   },
835 |   ({ title, mood }) => ({
836 |     messages: [
837 |       {
838 |         role: 'user',
839 |         content: {
840 |           type: 'text',
841 |           text: `Write a haiku${mood ? ` with the mood ${mood}` : ''} called ${title}. Note that a haiku is 5 syllables followed by 7 syllables followed by 5 syllables `,
842 |         },
843 |       },
844 |     ],
845 |   }),
846 | );
847 | 
848 | const transport = new StdioServerTransport();
849 | await server.connect(transport);
850 | ```
851 | 
852 | This can be included in `settings.json` under `mcpServers` with:
853 | 
854 | ```json
855 | {
856 |   "mcpServers": {
857 |     "nodeServer": {
858 |       "command": "node",
859 |       "args": ["filename.ts"]
860 |     }
861 |   }
862 | }
863 | ```
864 | 
865 | ### Invoking Prompts
866 | 
867 | Once a prompt is discovered, you can invoke it using its name as a slash
868 | command. The CLI will automatically handle parsing arguments.
869 | 
870 | ```bash
871 | /poem-writer --title="Gemini CLI" --mood="reverent"
872 | ```
873 | 
874 | or, using positional arguments:
875 | 
876 | ```bash
877 | /poem-writer "Gemini CLI" reverent
878 | ```
879 | 
880 | When you run this command, the Gemini CLI executes the `prompts/get` method on
881 | the MCP server with the provided arguments. The server is responsible for
882 | substituting the arguments into the prompt template and returning the final
883 | prompt text. The CLI then sends this prompt to the model for execution. This
884 | provides a convenient way to automate and share common workflows.
885 | 
886 | ## Managing MCP Servers with `gemini mcp`
887 | 
888 | While you can always configure MCP servers by manually editing your
889 | `settings.json` file, the Gemini CLI provides a convenient set of commands to
890 | manage your server configurations programmatically. These commands streamline
891 | the process of adding, listing, and removing MCP servers without needing to
892 | directly edit JSON files.
893 | 
894 | ### Adding a Server (`gemini mcp add`)
895 | 
896 | The `add` command configures a new MCP server in your `settings.json`. Based on
897 | the scope (`-s, --scope`), it will be added to either the user config
898 | `~/.gemini/settings.json` or the project config `.gemini/settings.json` file.
899 | 
900 | **Command:**
901 | 
902 | ```bash
903 | gemini mcp add [options] <name> <commandOrUrl> [args...]
904 | ```
905 | 
906 | - `<name>`: A unique name for the server.
907 | - `<commandOrUrl>`: The command to execute (for `stdio`) or the URL (for
908 |   `http`/`sse`).
909 | - `[args...]`: Optional arguments for a `stdio` command.
910 | 
911 | **Options (Flags):**
912 | 
913 | - `-s, --scope`: Configuration scope (user or project). [default: "project"]
914 | - `-t, --transport`: Transport type (stdio, sse, http). [default: "stdio"]
915 | - `-e, --env`: Set environment variables (e.g. -e KEY=value).
916 | - `-H, --header`: Set HTTP headers for SSE and HTTP transports (e.g. -H
917 |   "X-Api-Key: abc123" -H "Authorization: Bearer abc123").
918 | - `--timeout`: Set connection timeout in milliseconds.
919 | - `--trust`: Trust the server (bypass all tool call confirmation prompts).
920 | - `--description`: Set the description for the server.
921 | - `--include-tools`: A comma-separated list of tools to include.
922 | - `--exclude-tools`: A comma-separated list of tools to exclude.
923 | 
924 | #### Adding an stdio server
925 | 
926 | This is the default transport for running local servers.
927 | 
928 | ```bash
929 | # Basic syntax
930 | gemini mcp add <name> <command> [args...]
931 | 
932 | # Example: Adding a local server
933 | gemini mcp add my-stdio-server -e API_KEY=123 /path/to/server arg1 arg2 arg3
934 | 
935 | # Example: Adding a local python server
936 | gemini mcp add python-server python server.py --port 8080
937 | ```
938 | 
939 | #### Adding an HTTP server
940 | 
941 | This transport is for servers that use the streamable HTTP transport.
942 | 
943 | ```bash
944 | # Basic syntax
945 | gemini mcp add --transport http <name> <url>
946 | 
947 | # Example: Adding an HTTP server
948 | gemini mcp add --transport http http-server https://api.example.com/mcp/
949 | 
950 | # Example: Adding an HTTP server with an authentication header
951 | gemini mcp add --transport http secure-http https://api.example.com/mcp/ --header "Authorization: Bearer abc123"
952 | ```
953 | 
954 | #### Adding an SSE server
955 | 
956 | This transport is for servers that use Server-Sent Events (SSE).
957 | 
958 | ```bash
959 | # Basic syntax
960 | gemini mcp add --transport sse <name> <url>
961 | 
962 | # Example: Adding an SSE server
963 | gemini mcp add --transport sse sse-server https://api.example.com/sse/
964 | 
965 | # Example: Adding an SSE server with an authentication header
966 | gemini mcp add --transport sse secure-sse https://api.example.com/sse/ --header "Authorization: Bearer abc123"
967 | ```
968 | 
969 | ### Listing Servers (`gemini mcp list`)
970 | 
971 | To view all MCP servers currently configured, use the `list` command. It
972 | displays each server's name, configuration details, and connection status.
973 | 
974 | **Command:**
975 | 
976 | ```bash
977 | gemini mcp list
978 | ```
979 | 
980 | **Example Output:**
981 | 
982 | ```sh
983 | ✓ stdio-server: command: python3 server.py (stdio) - Connected
984 | ✓ http-server: https://api.example.com/mcp (http) - Connected
985 | ✗ sse-server: https://api.example.com/sse (sse) - Disconnected
986 | ```
987 | 
988 | ### Removing a Server (`gemini mcp remove`)
989 | 
990 | To delete a server from your configuration, use the `remove` command with the
991 | server's name.
992 | 
993 | **Command:**
994 | 
995 | ```bash
996 | gemini mcp remove <name>
997 | ```
998 | 
999 | **Example:**
1000 | 
1001 | ```bash
1002 | gemini mcp remove my-server
1003 | ```
1004 | 
1005 | This will find and delete the "my-server" entry from the `mcpServers` object in
1006 | the appropriate `settings.json` file based on the scope (`-s, --scope`).
```

tools/memory.md
```
1 | # Memory Tool (`save_memory`)
2 | 
3 | This document describes the `save_memory` tool for the Gemini CLI.
4 | 
5 | ## Description
6 | 
7 | Use `save_memory` to save and recall information across your Gemini CLI
8 | sessions. With `save_memory`, you can direct the CLI to remember key details
9 | across sessions, providing personalized and directed assistance.
10 | 
11 | ### Arguments
12 | 
13 | `save_memory` takes one argument:
14 | 
15 | - `fact` (string, required): The specific fact or piece of information to
16 |   remember. This should be a clear, self-contained statement written in natural
17 |   language.
18 | 
19 | ## How to use `save_memory` with the Gemini CLI
20 | 
21 | The tool appends the provided `fact` to a special `GEMINI.md` file located in
22 | the user's home directory (`~/.gemini/GEMINI.md`). This file can be configured
23 | to have a different name.
24 | 
25 | Once added, the facts are stored under a `## Gemini Added Memories` section.
26 | This file is loaded as context in subsequent sessions, allowing the CLI to
27 | recall the saved information.
28 | 
29 | Usage:
30 | 
31 | ```
32 | save_memory(fact="Your fact here.")
33 | ```
34 | 
35 | ### `save_memory` examples
36 | 
37 | Remember a user preference:
38 | 
39 | ```
40 | save_memory(fact="My preferred programming language is Python.")
41 | ```
42 | 
43 | Store a project-specific detail:
44 | 
45 | ```
46 | save_memory(fact="The project I'm currently working on is called 'gemini-cli'.")
47 | ```
48 | 
49 | ## Important notes
50 | 
51 | - **General usage:** This tool should be used for concise, important facts. It
52 |   is not intended for storing large amounts of data or conversational history.
53 | - **Memory file:** The memory file is a plain text Markdown file, so you can
54 |   view and edit it manually if needed.
```

tools/multi-file.md
```
1 | # Multi File Read Tool (`read_many_files`)
2 | 
3 | This document describes the `read_many_files` tool for the Gemini CLI.
4 | 
5 | ## Description
6 | 
7 | Use `read_many_files` to read content from multiple files specified by paths or
8 | glob patterns. The behavior of this tool depends on the provided files:
9 | 
10 | - For text files, this tool concatenates their content into a single string.
11 | - For image (e.g., PNG, JPEG), PDF, audio (MP3, WAV), and video (MP4, MOV)
12 |   files, it reads and returns them as base64-encoded data, provided they are
13 |   explicitly requested by name or extension.
14 | 
15 | `read_many_files` can be used to perform tasks such as getting an overview of a
16 | codebase, finding where specific functionality is implemented, reviewing
17 | documentation, or gathering context from multiple configuration files.
18 | 
19 | **Note:** `read_many_files` looks for files following the provided paths or glob
20 | patterns. A directory path such as `"/docs"` will return an empty result; the
21 | tool requires a pattern such as `"/docs/*"` or `"/docs/*.md"` to identify the
22 | relevant files.
23 | 
24 | ### Arguments
25 | 
26 | `read_many_files` takes the following arguments:
27 | 
28 | - `paths` (list[string], required): An array of glob patterns or paths relative
29 |   to the tool's target directory (e.g., `["src/**/*.ts"]`,
30 |   `["README.md", "docs/*", "assets/logo.png"]`).
31 | - `exclude` (list[string], optional): Glob patterns for files/directories to
32 |   exclude (e.g., `["**/*.log", "temp/"]`). These are added to default excludes
33 |   if `useDefaultExcludes` is true.
34 | - `include` (list[string], optional): Additional glob patterns to include. These
35 |   are merged with `paths` (e.g., `["*.test.ts"]` to specifically add test files
36 |   if they were broadly excluded, or `["images/*.jpg"]` to include specific image
37 |   types).
38 | - `recursive` (boolean, optional): Whether to search recursively. This is
39 |   primarily controlled by `**` in glob patterns. Defaults to `true`.
40 | - `useDefaultExcludes` (boolean, optional): Whether to apply a list of default
41 |   exclusion patterns (e.g., `node_modules`, `.git`, non image/pdf binary files).
42 |   Defaults to `true`.
43 | - `respect_git_ignore` (boolean, optional): Whether to respect .gitignore
44 |   patterns when finding files. Defaults to true.
45 | 
46 | ## How to use `read_many_files` with the Gemini CLI
47 | 
48 | `read_many_files` searches for files matching the provided `paths` and `include`
49 | patterns, while respecting `exclude` patterns and default excludes (if enabled).
50 | 
51 | - For text files: it reads the content of each matched file (attempting to skip
52 |   binary files not explicitly requested as image/PDF) and concatenates it into a
53 |   single string, with a separator `--- {filePath} ---` between the content of
54 |   each file. Uses UTF-8 encoding by default.
55 | - The tool inserts a `--- End of content ---` after the last file.
56 | - For image and PDF files: if explicitly requested by name or extension (e.g.,
57 |   `paths: ["logo.png"]` or `include: ["*.pdf"]`), the tool reads the file and
58 |   returns its content as a base64 encoded string.
59 | - The tool attempts to detect and skip other binary files (those not matching
60 |   common image/PDF types or not explicitly requested) by checking for null bytes
61 |   in their initial content.
62 | 
63 | Usage:
64 | 
65 | ```
66 | read_many_files(paths=["Your files or paths here."], include=["Additional files to include."], exclude=["Files to exclude."], recursive=False, useDefaultExcludes=false, respect_git_ignore=true)
67 | ```
68 | 
69 | ## `read_many_files` examples
70 | 
71 | Read all TypeScript files in the `src` directory:
72 | 
73 | ```
74 | read_many_files(paths=["src/**/*.ts"])
75 | ```
76 | 
77 | Read the main README, all Markdown files in the `docs` directory, and a specific
78 | logo image, excluding a specific file:
79 | 
80 | ```
81 | read_many_files(paths=["README.md", "docs/**/*.md", "assets/logo.png"], exclude=["docs/OLD_README.md"])
82 | ```
83 | 
84 | Read all JavaScript files but explicitly include test files and all JPEGs in an
85 | `images` folder:
86 | 
87 | ```
88 | read_many_files(paths=["**/*.js"], include=["**/*.test.js", "images/**/*.jpg"], useDefaultExcludes=False)
89 | ```
90 | 
91 | ## Important notes
92 | 
93 | - **Binary file handling:**
94 |   - **Image/PDF/Audio/Video files:** The tool can read common image types (PNG,
95 |     JPEG, etc.), PDF, audio (mp3, wav), and video (mp4, mov) files, returning
96 |     them as base64 encoded data. These files _must_ be explicitly targeted by
97 |     the `paths` or `include` patterns (e.g., by specifying the exact filename
98 |     like `video.mp4` or a pattern like `*.mov`).
99 |   - **Other binary files:** The tool attempts to detect and skip other types of
100 |     binary files by examining their initial content for null bytes. The tool
101 |     excludes these files from its output.
102 | - **Performance:** Reading a very large number of files or very large individual
103 |   files can be resource-intensive.
104 | - **Path specificity:** Ensure paths and glob patterns are correctly specified
105 |   relative to the tool's target directory. For image/PDF files, ensure the
106 |   patterns are specific enough to include them.
107 | - **Default excludes:** Be aware of the default exclusion patterns (like
108 |   `node_modules`, `.git`) and use `useDefaultExcludes=False` if you need to
109 |   override them, but do so cautiously.
```

tools/shell.md
```
1 | # Shell Tool (`run_shell_command`)
2 | 
3 | This document describes the `run_shell_command` tool for the Gemini CLI.
4 | 
5 | ## Description
6 | 
7 | Use `run_shell_command` to interact with the underlying system, run scripts, or
8 | perform command-line operations. `run_shell_command` executes a given shell
9 | command, including interactive commands that require user input (e.g., `vim`,
10 | `git rebase -i`) if the `tools.shell.enableInteractiveShell` setting is set to
11 | `true`.
12 | 
13 | On Windows, commands are executed with `cmd.exe /c`. On other platforms, they
14 | are executed with `bash -c`.
15 | 
16 | ### Arguments
17 | 
18 | `run_shell_command` takes the following arguments:
19 | 
20 | - `command` (string, required): The exact shell command to execute.
21 | - `description` (string, optional): A brief description of the command's
22 |   purpose, which will be shown to the user.
23 | - `directory` (string, optional): The directory (relative to the project root)
24 |   in which to execute the command. If not provided, the command runs in the
25 |   project root.
26 | 
27 | ## How to use `run_shell_command` with the Gemini CLI
28 | 
29 | When using `run_shell_command`, the command is executed as a subprocess.
30 | `run_shell_command` can start background processes using `&`. The tool returns
31 | detailed information about the execution, including:
32 | 
33 | - `Command`: The command that was executed.
34 | - `Directory`: The directory where the command was run.
35 | - `Stdout`: Output from the standard output stream.
36 | - `Stderr`: Output from the standard error stream.
37 | - `Error`: Any error message reported by the subprocess.
38 | - `Exit Code`: The exit code of the command.
39 | - `Signal`: The signal number if the command was terminated by a signal.
40 | - `Background PIDs`: A list of PIDs for any background processes started.
41 | 
42 | Usage:
43 | 
44 | ```
45 | run_shell_command(command="Your commands.", description="Your description of the command.", directory="Your execution directory.")
46 | ```
47 | 
48 | ## `run_shell_command` examples
49 | 
50 | List files in the current directory:
51 | 
52 | ```
53 | run_shell_command(command="ls -la")
54 | ```
55 | 
56 | Run a script in a specific directory:
57 | 
58 | ```
59 | run_shell_command(command="./my_script.sh", directory="scripts", description="Run my custom script")
60 | ```
61 | 
62 | Start a background server:
63 | 
64 | ```
65 | run_shell_command(command="npm run dev &", description="Start development server in background")
66 | ```
67 | 
68 | ## Configuration
69 | 
70 | You can configure the behavior of the `run_shell_command` tool by modifying your
71 | `settings.json` file or by using the `/settings` command in the Gemini CLI.
72 | 
73 | ### Enabling Interactive Commands
74 | 
75 | To enable interactive commands, you need to set the
76 | `tools.shell.enableInteractiveShell` setting to `true`. This will use `node-pty`
77 | for shell command execution, which allows for interactive sessions. If
78 | `node-pty` is not available, it will fall back to the `child_process`
79 | implementation, which does not support interactive commands.
80 | 
81 | **Example `settings.json`:**
82 | 
83 | ```json
84 | {
85 |   "tools": {
86 |     "shell": {
87 |       "enableInteractiveShell": true
88 |     }
89 |   }
90 | }
91 | ```
92 | 
93 | ### Showing Color in Output
94 | 
95 | To show color in the shell output, you need to set the `tools.shell.showColor`
96 | setting to `true`. **Note: This setting only applies when
97 | `tools.shell.enableInteractiveShell` is enabled.**
98 | 
99 | **Example `settings.json`:**
100 | 
101 | ```json
102 | {
103 |   "tools": {
104 |     "shell": {
105 |       "showColor": true
106 |     }
107 |   }
108 | }
109 | ```
110 | 
111 | ### Setting the Pager
112 | 
113 | You can set a custom pager for the shell output by setting the
114 | `tools.shell.pager` setting. The default pager is `cat`. **Note: This setting
115 | only applies when `tools.shell.enableInteractiveShell` is enabled.**
116 | 
117 | **Example `settings.json`:**
118 | 
119 | ```json
120 | {
121 |   "tools": {
122 |     "shell": {
123 |       "pager": "less"
124 |     }
125 |   }
126 | }
127 | ```
128 | 
129 | ## Interactive Commands
130 | 
131 | The `run_shell_command` tool now supports interactive commands by integrating a
132 | pseudo-terminal (pty). This allows you to run commands that require real-time
133 | user input, such as text editors (`vim`, `nano`), terminal-based UIs (`htop`),
134 | and interactive version control operations (`git rebase -i`).
135 | 
136 | When an interactive command is running, you can send input to it from the Gemini
137 | CLI. To focus on the interactive shell, press `ctrl+f`. The terminal output,
138 | including complex TUIs, will be rendered correctly.
139 | 
140 | ## Important notes
141 | 
142 | - **Security:** Be cautious when executing commands, especially those
143 |   constructed from user input, to prevent security vulnerabilities.
144 | - **Error handling:** Check the `Stderr`, `Error`, and `Exit Code` fields to
145 |   determine if a command executed successfully.
146 | - **Background processes:** When a command is run in the background with `&`,
147 |   the tool will return immediately and the process will continue to run in the
148 |   background. The `Background PIDs` field will contain the process ID of the
149 |   background process.
150 | 
151 | ## Environment Variables
152 | 
153 | When `run_shell_command` executes a command, it sets the `GEMINI_CLI=1`
154 | environment variable in the subprocess's environment. This allows scripts or
155 | tools to detect if they are being run from within the Gemini CLI.
156 | 
157 | ## Command Restrictions
158 | 
159 | You can restrict the commands that can be executed by the `run_shell_command`
160 | tool by using the `tools.core` and `tools.exclude` settings in your
161 | configuration file.
162 | 
163 | - `tools.core`: To restrict `run_shell_command` to a specific set of commands,
164 |   add entries to the `core` list under the `tools` category in the format
165 |   `run_shell_command(<command>)`. For example,
166 |   `"tools": {"core": ["run_shell_command(git)"]}` will only allow `git`
167 |   commands. Including the generic `run_shell_command` acts as a wildcard,
168 |   allowing any command not explicitly blocked.
169 | - `tools.exclude`: To block specific commands, add entries to the `exclude` list
170 |   under the `tools` category in the format `run_shell_command(<command>)`. For
171 |   example, `"tools": {"exclude": ["run_shell_command(rm)"]}` will block `rm`
172 |   commands.
173 | 
174 | The validation logic is designed to be secure and flexible:
175 | 
176 | 1.  **Command Chaining Disabled**: The tool automatically splits commands
177 |     chained with `&&`, `||`, or `;` and validates each part separately. If any
178 |     part of the chain is disallowed, the entire command is blocked.
179 | 2.  **Prefix Matching**: The tool uses prefix matching. For example, if you
180 |     allow `git`, you can run `git status` or `git log`.
181 | 3.  **Blocklist Precedence**: The `tools.exclude` list is always checked first.
182 |     If a command matches a blocked prefix, it will be denied, even if it also
183 |     matches an allowed prefix in `tools.core`.
184 | 
185 | ### Command Restriction Examples
186 | 
187 | **Allow only specific command prefixes**
188 | 
189 | To allow only `git` and `npm` commands, and block all others:
190 | 
191 | ```json
192 | {
193 |   "tools": {
194 |     "core": ["run_shell_command(git)", "run_shell_command(npm)"]
195 |   }
196 | }
197 | ```
198 | 
199 | - `git status`: Allowed
200 | - `npm install`: Allowed
201 | - `ls -l`: Blocked
202 | 
203 | **Block specific command prefixes**
204 | 
205 | To block `rm` and allow all other commands:
206 | 
207 | ```json
208 | {
209 |   "tools": {
210 |     "core": ["run_shell_command"],
211 |     "exclude": ["run_shell_command(rm)"]
212 |   }
213 | }
214 | ```
215 | 
216 | - `rm -rf /`: Blocked
217 | - `git status`: Allowed
218 | - `npm install`: Allowed
219 | 
220 | **Blocklist takes precedence**
221 | 
222 | If a command prefix is in both `tools.core` and `tools.exclude`, it will be
223 | blocked.
224 | 
225 | ```json
226 | {
227 |   "tools": {
228 |     "core": ["run_shell_command(git)"],
229 |     "exclude": ["run_shell_command(git push)"]
230 |   }
231 | }
232 | ```
233 | 
234 | - `git push origin main`: Blocked
235 | - `git status`: Allowed
236 | 
237 | **Block all shell commands**
238 | 
239 | To block all shell commands, add the `run_shell_command` wildcard to
240 | `tools.exclude`:
241 | 
242 | ```json
243 | {
244 |   "tools": {
245 |     "exclude": ["run_shell_command"]
246 |   }
247 | }
248 | ```
249 | 
250 | - `ls -l`: Blocked
251 | - `any other command`: Blocked
252 | 
253 | ## Security Note for `excludeTools`
254 | 
255 | Command-specific restrictions in `excludeTools` for `run_shell_command` are
256 | based on simple string matching and can be easily bypassed. This feature is
257 | **not a security mechanism** and should not be relied upon to safely execute
258 | untrusted code. It is recommended to use `coreTools` to explicitly select
259 | commands that can be executed.
```

tools/web-fetch.md
```
1 | # Web Fetch Tool (`web_fetch`)
2 | 
3 | This document describes the `web_fetch` tool for the Gemini CLI.
4 | 
5 | ## Description
6 | 
7 | Use `web_fetch` to summarize, compare, or extract information from web pages.
8 | The `web_fetch` tool processes content from one or more URLs (up to 20) embedded
9 | in a prompt. `web_fetch` takes a natural language prompt and returns a generated
10 | response.
11 | 
12 | ### Arguments
13 | 
14 | `web_fetch` takes one argument:
15 | 
16 | - `prompt` (string, required): A comprehensive prompt that includes the URL(s)
17 |   (up to 20) to fetch and specific instructions on how to process their content.
18 |   For example:
19 |   `"Summarize https://example.com/article and extract key points from https://another.com/data"`.
20 |   The prompt must contain at least one URL starting with `http://` or
21 |   `https://`.
22 | 
23 | ## How to use `web_fetch` with the Gemini CLI
24 | 
25 | To use `web_fetch` with the Gemini CLI, provide a natural language prompt that
26 | contains URLs. The tool will ask for confirmation before fetching any URLs. Once
27 | confirmed, the tool will process URLs through Gemini API's `urlContext`.
28 | 
29 | If the Gemini API cannot access the URL, the tool will fall back to fetching
30 | content directly from the local machine. The tool will format the response,
31 | including source attribution and citations where possible. The tool will then
32 | provide the response to the user.
33 | 
34 | Usage:
35 | 
36 | ```
37 | web_fetch(prompt="Your prompt, including a URL such as https://google.com.")
38 | ```
39 | 
40 | ## `web_fetch` examples
41 | 
42 | Summarize a single article:
43 | 
44 | ```
45 | web_fetch(prompt="Can you summarize the main points of https://example.com/news/latest")
46 | ```
47 | 
48 | Compare two articles:
49 | 
50 | ```
51 | web_fetch(prompt="What are the differences in the conclusions of these two papers: https://arxiv.org/abs/2401.0001 and https://arxiv.org/abs/2401.0002?")
52 | ```
53 | 
54 | ## Important notes
55 | 
56 | - **URL processing:** `web_fetch` relies on the Gemini API's ability to access
57 |   and process the given URLs.
58 | - **Output quality:** The quality of the output will depend on the clarity of
59 |   the instructions in the prompt.
```

tools/web-search.md
```
1 | # Web Search Tool (`google_web_search`)
2 | 
3 | This document describes the `google_web_search` tool.
4 | 
5 | ## Description
6 | 
7 | Use `google_web_search` to perform a web search using Google Search via the
8 | Gemini API. The `google_web_search` tool returns a summary of web results with
9 | sources.
10 | 
11 | ### Arguments
12 | 
13 | `google_web_search` takes one argument:
14 | 
15 | - `query` (string, required): The search query.
16 | 
17 | ## How to use `google_web_search` with the Gemini CLI
18 | 
19 | The `google_web_search` tool sends a query to the Gemini API, which then
20 | performs a web search. `google_web_search` will return a generated response
21 | based on the search results, including citations and sources.
22 | 
23 | Usage:
24 | 
25 | ```
26 | google_web_search(query="Your query goes here.")
27 | ```
28 | 
29 | ## `google_web_search` examples
30 | 
31 | Get information on a topic:
32 | 
33 | ```
34 | google_web_search(query="latest advancements in AI-powered code generation")
35 | ```
36 | 
37 | ## Important notes
38 | 
39 | - **Response returned:** The `google_web_search` tool returns a processed
40 |   summary, not a raw list of search results.
41 | - **Citations:** The response includes citations to the sources used to generate
42 |   the summary.
```
