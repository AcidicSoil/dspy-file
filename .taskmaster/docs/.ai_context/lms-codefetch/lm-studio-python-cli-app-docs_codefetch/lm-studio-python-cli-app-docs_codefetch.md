Project Structure:
├── 0_app
│   ├── 0_root
│   │   ├── api-changelog.md
│   │   ├── index.md
│   │   ├── offline.md
│   │   └── system-requirements.md
│   ├── 1_basics
│   │   ├── _connect-apps.md
│   │   ├── _keychords.md
│   │   ├── _troubleshooting.md
│   │   ├── chat.md
│   │   ├── download-model.md
│   │   ├── index.md
│   │   └── rag.md
│   ├── 2_plugins
│   │   └── mcp
│   │       ├── deeplink.md
│   │       └── index.md
│   ├── 3_modelyaml
│   │   ├── index.md
│   │   └── publish.md
│   ├── 3_presets
│   │   ├── import.md
│   │   ├── index.md
│   │   ├── publish.md
│   │   ├── pull.md
│   │   └── push.md
│   ├── 4_api
│   │   ├── 1_endpoints
│   │   │   ├── openai.md
│   │   │   └── rest.md
│   │   ├── _embeddings.md
│   │   ├── _index.md
│   │   ├── headless.md
│   │   ├── index.md
│   │   ├── structured-output.md
│   │   ├── tools.md
│   │   └── ttl-and-auto-evict.md
│   ├── 5_advanced
│   │   ├── _branching.md
│   │   ├── _context.md
│   │   ├── _errors.md
│   │   ├── _vision.md
│   │   ├── import-model.md
│   │   ├── per-model.md
│   │   ├── prompt-template.md
│   │   └── speculative-decoding.md
│   └── 6_user-interface
│       ├── languages.md
│       ├── modes.md
│       └── themes.md
├── 1_python
│   ├── 1_getting-started
│   │   ├── project-setup.md
│   │   └── repl.md
│   ├── 1_llm-prediction
│   │   ├── _index.md
│   │   ├── cancelling-predictions.md
│   │   ├── chat-completion.md
│   │   ├── completion.md
│   │   ├── image-input.md
│   │   ├── parameters.md
│   │   ├── speculative-decoding.md
│   │   ├── structured-response.md
│   │   └── working-with-chats.md
│   ├── 2_agent
│   │   ├── _index.md
│   │   ├── act.md
│   │   └── tools.md
│   ├── 3_embedding
│   │   └── index.md
│   ├── 4_tokenization
│   │   └── index.md
│   ├── 5_manage-models
│   │   ├── _download-models.md
│   │   ├── list-downloaded.md
│   │   ├── list-loaded.md
│   │   └── loading.md
│   ├── 6_model-info
│   │   ├── get-context-length.md
│   │   ├── get-load-config.md
│   │   └── get-model-info.md
│   ├── _7_api-reference
│   │   ├── act.md
│   │   ├── chat.md
│   │   ├── complete.md
│   │   ├── count-tokens.md
│   │   ├── embed.md
│   │   ├── llm-load-model-config.md
│   │   ├── llm-namespace.md
│   │   ├── llm-prediction-config-input.md
│   │   ├── lmstudioclient.md
│   │   ├── model.md
│   │   ├── respond.md
│   │   ├── system-namespace.md
│   │   └── tokenize.md
│   ├── _more
│   │   └── _apply-prompt-template.md
│   └── index.md
├── 2_typescript
│   ├── 2_llm-prediction
│   │   ├── _index.md
│   │   ├── cancelling-predictions.md
│   │   ├── chat-completion.md
│   │   ├── completion.md
│   │   ├── image-input.md
│   │   ├── parameters.md
│   │   ├── speculative-decoding.md
│   │   ├── structured-response.md
│   │   └── working-with-chats.md
│   ├── 3_agent
│   │   ├── _index.md
│   │   ├── act.md
│   │   └── tools.md
│   ├── 3_plugins
│   │   ├── 1_tools-provider
│   │   │   ├── custom-configuration.md
│   │   │   ├── handling-aborts.md
│   │   │   ├── index.md
│   │   │   ├── multiple-tools.md
│   │   │   ├── single-tool.md
│   │   │   └── status-reports-and-warnings.md
│   │   ├── 2_prompt-preprocessor
│   │   │   ├── custom-configuration.md
│   │   │   ├── custom-status-report.md
│   │   │   ├── examples.md
│   │   │   ├── handling-aborts.md
│   │   │   └── index.md
│   │   ├── 3_generator
│   │   │   ├── index.md
│   │   │   ├── text-only-generators.md
│   │   │   └── tool-calling-generators.md
│   │   ├── 4_custom-configuration
│   │   │   ├── accessing-config.md
│   │   │   ├── config-ts.md
│   │   │   ├── defining-new-fields.md
│   │   │   └── index.md
│   │   ├── 5_publish-plugins
│   │   │   └── index.md
│   │   ├── dependencies.md
│   │   └── index.md
│   ├── 4_embedding
│   │   └── index.md
│   ├── 5_tokenization
│   │   └── index.md
│   ├── 6_manage-models
│   │   ├── _download-models.md
│   │   ├── list-downloaded.md
│   │   ├── list-loaded.md
│   │   └── loading.md
│   ├── 7_api-reference
│   │   ├── _act.md
│   │   ├── _chat.md
│   │   ├── _complete.md
│   │   ├── _count-tokens.md
│   │   ├── _embed.md
│   │   ├── _llm-namespace.md
│   │   ├── _lmstudioclient.md
│   │   ├── _model.md
│   │   ├── _respond.md
│   │   ├── _system-namespace.md
│   │   ├── _tokenize.md
│   │   ├── llm-load-model-config.md
│   │   └── llm-prediction-config-input.md
│   ├── 8_model-info
│   │   ├── _get-load-config.md
│   │   ├── get-context-length.md
│   │   └── get-model-info.md
│   ├── _more
│   │   └── _apply-prompt-template.md
│   ├── index.md
│   └── project-setup.md
├── 3_cli
│   ├── _lms-load.md
│   ├── get.md
│   ├── index.md
│   ├── load.md
│   ├── log-stream.md
│   ├── ls.md
│   ├── ps.md
│   ├── push.md
│   ├── server-start.md
│   ├── server-status.md
│   ├── server-stop.md
│   └── unload.md
├── CONTRIBUTING.md
├── README.md
├── _configuration
│   ├── _load.md
│   ├── inference.md
│   └── lm-runtimes.md
├── _template_dont_edit.md
└── codefetch.config.mjs


_template_dont_edit.md
```
1 | ---
2 | title: Introduction
3 | description: Quick start
4 | ---
5 | 
6 | Welcome to the LM Studio documentation!
7 | 
8 | ## Code Snippets
9 | 
10 | Configurations that look good:
11 | 
12 | 1. title + 1 variant
13 | 2. no title + 2+ variants
14 | 
15 | ```lms_code_snippet
16 |   variants:
17 |     TypeScript:
18 |       language: typescript
19 |       code: |
20 |         // Multi-line TypeScript code
21 |         function hello() {
22 |           console.log("hey")
23 |           return "world"
24 |         }
25 | 
26 |     Python:
27 |       language: python
28 |       code: |
29 |         # Multi-line Python code
30 |         def hello():
31 |             print("hey")
32 |             return "world"
33 | ```
34 | 
35 | ```lms_code_snippet
36 |   title: "generator.py"
37 |   variants:
38 |     Python:
39 |       language: python
40 |       code: |
41 |         # Multi-line Python code
42 |         def hello():
43 |             print("hey")
44 |             return "world"
45 | ```
46 | 
47 | <br></br>
48 | 
49 | ```lms_hstack
50 | 
51 | # Column 1
52 | 
53 | ~~~js
54 | console.log("Hello from the code block");
55 | ~~~
56 | 
57 | :::split:::
58 | 
59 | # Column 2
60 | Second column markdown content here
61 | 
62 | ```
63 | 
64 | <br><br>
65 | 
66 | ```ts
67 | // index.ts
68 | import { LMStudioClient } from "@lmstudio/sdk";
69 | 
70 | // Create a client to connect to LM Studio, then load a model
71 | async function main() {
72 |   const client = new LMStudioClient();
73 |   const model = await client.llm.load("meta-llama-3-8b");
74 | 
75 |   const prediction = model.predict("Once upon a time, there was a");
76 | 
77 |   for await (const text of prediction) {
78 |     process.stdout.write(text);
79 |   }
80 | }
81 | 
82 | main();
83 | ```
84 | 
85 | ```lms_notice
86 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
87 | ```
88 | 
89 | ```lms_protip
90 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
91 | ```
92 | 
93 | ```lms_warning
94 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
95 | ```
96 | 
97 | ### Params
98 | 
99 | List of formatted parameters
100 | 
101 | ### Parameters 
102 | 
103 | ```lms_params
104 | - name: "[path]"
105 |   type: "string"
106 |   optional: true
107 |   description: "The path of the model to load. If not provided, you will be prompted to select one"
108 | - name: "--ttl"
109 |   type: "number"
110 |   optional: true
111 |   description: "If provided, when the model is not used for this number of seconds, it will be unloaded"
112 | - name: "--gpu"
113 |   type: "string"
114 |   optional: true
115 |   description: "How much to offload to the GPU. Values: 0-1, off, max"
116 | - name: "--context-length"
117 |   type: "number"
118 |   optional: true
119 |   description: "The number of tokens to consider as context when generating text"
120 | - name: "--identifier"
121 |   type: "string"
122 |   optional: true
123 |   description: "The identifier to assign to the loaded model for API reference"
124 | ```
125 | 
126 | ## What is LM Studio?
127 | 
128 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec
129 | suscipit ultricies, `code which is inline` nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
130 | 
131 | ```lms_download_options
132 | repository: user/model
133 | options:
134 |   - name: "meta-llama-3-8b"
135 |     description: "Meta Llama 3 8B"
136 |     version: "1.0.0"
137 |     size: "1.2 GB"
138 |     download: "https://example.com/meta-llama-3-8b.zip"
139 |     license: "MIT"
140 | 
141 |   - name: "meta-llama-3-8b"
142 |     description: "Meta Llama 3 8B"
143 |     version: "1.0.0"
144 |     size: "1.2 GB"
145 |     download: "https://example.com/meta-llama-3-8b.zip"
146 |     license: "MIT"
147 | ```
148 | 
149 | <img src="/assets/hero-dark-classic@2x.png" alt="LM Studio" data-caption="Some caption and a [link](https://lmstudio.ai)" />
150 | 
151 | ## Main Features
152 | 
153 | Some of the main features of LM Studio are:
154 | 
155 | | Feature       | Description                                                           |
156 | | ------------- | --------------------------------------------------------------------- |
157 | | **Feature 1** | Lorem ipsum dolor sit amet, consectetur adipiscing elit.              |
158 | | **Feature 2** | Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc. |
159 | | **Feature 3** | Nec suscipit nunc nunc nec. Nullam.                                   |
160 | 
161 | ## How to use this documentation
162 | 
163 | This documentation is divided into the following sections:
164 | 
165 | - **Quick Start**: Get started with LM Studio in minutes.
166 | - **API Reference**: Learn how to use the LM Studio API.
```

1_python/index.md
```
1 | ---
2 | title: "`lmstudio-python` (Python SDK)"
3 | sidebar_title: "Introduction"
4 | description: "Getting started with LM Studio's Python SDK"
5 | ---
6 | 
7 | `lmstudio-python` provides you a set APIs to interact with LLMs, embeddings models, and agentic flows.
8 | 
9 | ## Installing the SDK
10 | 
11 | `lmstudio-python` is available as a PyPI package. You can install it using pip.
12 | 
13 | ```lms_code_snippet
14 |   variants:
15 |     pip:
16 |       language: bash
17 |       code: |
18 |         pip install lmstudio
19 | ```
20 | 
21 | For the source code and open source contribution, visit [lmstudio-python](https://github.com/lmstudio-ai/lmstudio-python) on GitHub.
22 | 
23 | ## Features
24 | 
25 | - Use LLMs to [respond in chats](./python/llm-prediction/chat-completion) or predict [text completions](./python/llm-prediction/completion)
26 | - Define functions as tools, and turn LLMs into [autonomous agents](./python/agent) that run completely locally
27 | - [Load](./python/manage-models/loading), [configure](./python/llm-prediction/parameters), and [unload](./python/manage-models/loading) models from memory
28 | - Generate embeddings for text, and more!
29 | 
30 | ## Quick Example: Chat with a Llama Model
31 | 
32 | ```lms_code_snippet
33 |   variants:
34 |     "Python (convenience API)":
35 |       language: python
36 |       code: |
37 |         import lmstudio as lms
38 | 
39 |         model = lms.llm("llama-3.2-1b-instruct")
40 |         result = model.respond("What is the meaning of life?")
41 | 
42 |         print(result)
43 | 
44 |     "Python (scoped resource API)":
45 |       language: python
46 |       code: |
47 |         import lmstudio as lms
48 | 
49 |         with lms.Client() as client:
50 |             model = client.llm.model("llama-3.2-1b-instruct")
51 |             result = model.respond("What is the meaning of life?")
52 | 
53 |             print(result)
54 | 
55 |     "Python (asynchronous API)":
56 |       language: python
57 |       code: |
58 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
59 |         # Requires Python SDK version 1.5.0 or later
60 |         import lmstudio as lms
61 | 
62 |         async with lms.AsyncClient() as client:
63 |             model = await client.llm.model("llama-3.2-1b-instruct")
64 |             result = await model.respond("What is the meaning of life?")
65 | 
66 |             print(result)
67 | ```
68 | 
69 | ### Getting Local Models
70 | 
71 | The above code requires the Llama 3.2 1B model.
72 | If you don't have the model, run the following command in the terminal to download it.
73 | 
74 | ```bash
75 | lms get llama-3.2-1b-instruct
76 | ```
77 | 
78 | Read more about `lms get` in LM Studio's CLI [here](./cli/get).
79 | 
80 | # Interactive Convenience, Deterministic Resource Management, or Structured Concurrency?
81 | 
82 | As shown in the example above, there are three distinct approaches for working
83 | with the LM Studio Python SDK.
84 | 
85 | The first is the interactive convenience API (listed as "Python (convenience API)"
86 | in examples), which focuses on the use of a default LM Studio client instance for
87 | convenient interactions at a synchronous Python prompt, or when using Jupyter notebooks.
88 | 
89 | The second is a synchronous scoped resource API (listed as "Python (scoped resource API)"
90 | in examples), which uses context managers to ensure that allocated resources
91 | (such as network connections) are released deterministically, rather than
92 | potentially remaining open until the entire process is terminated.
93 | 
94 | The last is an asynchronous structured concurrency API (listed as "Python (asynchronous API)" in
95 | examples), which is designed for use in asynchronous programs that follow the design principles of
96 | ["structured concurrency"](https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/)
97 | in order to ensure the background tasks handling the SDK's connections to the API server host
98 | are managed correctly. Asynchronous applications which do not adhere to those design principles
99 | will need to rely on threaded access to the synchronous scoped resource API rather than attempting
100 | to use the SDK's native asynchronous API. Python SDK version 1.5.0 is the first version to fully
101 | support the asynchronous API.
102 | 
103 | Some examples are common between the interactive convenience API and the synchronous scoped
104 | resource API. These examples are listed as "Python (synchronous API)".
105 | 
106 | ## Timeouts in the synchronous API
107 | 
108 | *Required Python SDK version*: **1.5.0**
109 | 
110 | Starting in Python SDK version 1.5.0, the synchronous API defaults to timing out after 60 seconds
111 | with no activity when waiting for a response or streaming event notification from the API server.
112 | 
113 | The number of seconds to wait for responses and event notifications can be adjusted using the
114 | `lmstudio.set_sync_api_timeout()` function. Setting the timeout to `None` disables the timeout
115 | entirely (restoring the behaviour of previous SDK versions).
116 | 
117 | The current synchronous API timeout can be queried using the `lmstudio.get_sync_api_timeout()`
118 | function.
119 | 
120 | ## Timeouts in the asynchronous API
121 | 
122 | *Required Python SDK version*: **1.5.0**
123 | 
124 | As asynchronous coroutines support cancellation, there is no specific timeout support implemented
125 | in the asynchronous API. Instead, general purpose async timeout mechanisms, such as
126 | [`asyncio.wait_for()`](https://docs.python.org/3/library/asyncio-task.html#asyncio.wait_for) or
127 | [`anyio.move_on_after()`](https://anyio.readthedocs.io/en/stable/cancellation.html#timeouts),
128 | should be used.
```

3_cli/_lms-load.md
```
1 | ---
2 | title: "`lms load`"
3 | description: Use the lms CLI to load or unload models
4 | ---
5 | 
6 | ### `lms load`
7 | 
8 | ```bash
9 | lms load --model <model-name> --path <path-to-model>
10 | ```
```

3_cli/get.md
```
1 | ---
2 | title: "`lms get`"
3 | sidebar_title: "`lms get`"
4 | description: Search and download models from the command line.
5 | index: 4
6 | ---
7 | 
8 | The `lms get` command allows you to search and download models from online repositories. If no model is specified, it shows staff-picked recommendations.
9 | 
10 | Models you download via `lms get` will be stored in your LM Studio model directory. 
11 | 
12 | ### Parameters
13 | ```lms_params
14 | - name: "[search term]"
15 |   type: "string"
16 |   optional: true
17 |   description: "The model to download. For specific quantizations, append '@' (e.g., 'llama-3.1-8b@q4_k_m')"
18 | - name: "--mlx"
19 |   type: "flag"
20 |   optional: true
21 |   description: "Include MLX models in search results"
22 | - name: "--gguf"
23 |   type: "flag"
24 |   optional: true
25 |   description: "Include GGUF models in search results"
26 | - name: "--limit"
27 |   type: "number"
28 |   optional: true
29 |   description: "Limit the number of model options shown"
30 | - name: "--always-show-all-results"
31 |   type: "flag"
32 |   optional: true
33 |   description: "Always show search results, even with exact matches"
34 | - name: "--always-show-download-options"
35 |   type: "flag"
36 |   optional: true
37 |   description: "Always show quantization options, even with exact matches"
38 | - name: "--yes"
39 |   type: "flag"
40 |   optional: true
41 |   description: "Skip all confirmations. Uses first match and recommended quantization"
42 | ```
43 | 
44 | ## Download a model
45 | 
46 | Download a model by name:
47 | 
48 | ```shell
49 | lms get llama-3.1-8b
50 | ```
51 | 
52 | ### Specify quantization
53 | 
54 | Download a specific model quantization:
55 | 
56 | ```shell
57 | lms get llama-3.1-8b@q4_k_m
58 | ```
59 | 
60 | ### Filter by format
61 | 
62 | Show only MLX or GGUF models:
63 | 
64 | ```shell
65 | lms get --mlx
66 | lms get --gguf
67 | ```
68 | 
69 | ### Control search results
70 | 
71 | Limit the number of results:
72 | 
73 | ```shell
74 | lms get --limit 5
75 | ```
76 | 
77 | Always show all options:
78 | 
79 | ```shell
80 | lms get --always-show-all-results
81 | lms get --always-show-download-options
82 | ```
83 | 
84 | ### Automated downloads
85 | 
86 | For scripting, skip all prompts:
87 | 
88 | ```shell
89 | lms get llama-3.1-8b --yes
90 | ```
91 | 
92 | This will automatically select the first matching model and recommended quantization for your hardware.
```

3_cli/index.md
```
1 | ---
2 | title: "`lms` — LM Studio's CLI"
3 | sidebar_title: "Introduction"
4 | description: Get starting with the `lms` command line utility.
5 | index: 1
6 | ---
7 | 
8 | LM Studio ships with `lms`, a command line tool for scripting and automating your local LLM workflows.
9 | 
10 | `lms` is **MIT Licensed** and is developed in this repository on GitHub: https://github.com/lmstudio-ai/lms
11 | 
12 | <hr>
13 | 
14 | ```lms_info
15 | 👉 You need to run LM Studio _at least once_ before you can use `lms`.
16 | ```
17 | 
18 | ### Install `lms`
19 | 
20 | `lms` ships with LM Studio and can be found under `/bin` in the LM Studio's working directory.
21 | 
22 | Use the following commands to add `lms` to your system path.
23 | 
24 | #### Bootstrap `lms` on macOS or Linux
25 | 
26 | Run the following command in your terminal:
27 | 
28 | ```bash
29 | ~/.lmstudio/bin/lms bootstrap
30 | ```
31 | 
32 | #### Bootstrap `lms` on Windows
33 | 
34 | Run the following command in **PowerShell**:
35 | 
36 | ```shell
37 | cmd /c %USERPROFILE%/.lmstudio/bin/lms.exe bootstrap
38 | ```
39 | 
40 | #### Verify the installation
41 | 
42 | Open a **new terminal window** and run `lms`.
43 | 
44 | This is the current output you will get:
45 | 
46 | ```bash
47 | $ lms
48 | lms - LM Studio CLI - v0.2.22
49 | GitHub: https://github.com/lmstudio-ai/lmstudio-cli
50 | 
51 | Usage
52 | lms <subcommand>
53 | 
54 | where <subcommand> can be one of:
55 | 
56 | - status - Prints the status of LM Studio
57 | - server - Commands for managing the local server
58 | - ls - List all downloaded models
59 | - ps - List all loaded models
60 | - load - Load a model
61 | - unload - Unload a model
62 | - create - Create a new project with scaffolding
63 | - log - Log operations. Currently only supports streaming logs from LM Studio via `lms log stream`
64 | - version - Prints the version of the CLI
65 | - bootstrap - Bootstrap the CLI
66 | 
67 | For more help, try running `lms <subcommand> --help`
68 | ```
69 | 
70 | ### Use `lms` to automate and debug your workflows
71 | 
72 | ### Start and stop the local server
73 | 
74 | ```bash
75 | lms server start
76 | lms server stop
77 | ```
78 | 
79 | ### List the local models on the machine
80 | 
81 | ```bash
82 | lms ls
83 | ```
84 | 
85 | This will reflect the current LM Studio models directory, which you set in **📂 My Models** tab in the app.
86 | 
87 | ### List the currently loaded models
88 | 
89 | ```bash
90 | lms ps
91 | ```
92 | 
93 | ### Load a model (with options)
94 | 
95 | ```bash
96 | lms load [--gpu=max|auto|0.0-1.0] [--context-length=1-N]
97 | ```
98 | 
99 | `--gpu=1.0` means 'attempt to offload 100% of the computation to the GPU'.
100 | 
101 | - Optionally, assign an identifier to your local LLM:
102 | 
103 | ```bash
104 | lms load TheBloke/phi-2-GGUF --identifier="gpt-4-turbo"
105 | ```
106 | 
107 | This is useful if you want to keep the model identifier consistent.
108 | 
109 | ### Unload models
110 | 
111 | ```
112 | lms unload [--all]
113 | ```
```

3_cli/load.md
```
1 | ---
2 | title: "`lms load`"
3 | sidebar_title: "`lms load`"
4 | description: Load a model into memory, set context length, GPU offload, TTL, or estimate memory usage without loading.
5 | index: 2
6 | ---
7 | 
8 | The `lms load` command loads a model into memory. You can optionally set parameters such as context length, GPU offload, and TTL.
9 | 
10 | ### Parameters 
11 | ```lms_params
12 | - name: "[path]"
13 |   type: "string"
14 |   optional: true
15 |   description: "The path of the model to load. If not provided, you will be prompted to select one"
16 | - name: "--ttl"
17 |   type: "number"
18 |   optional: true
19 |   description: "If provided, when the model is not used for this number of seconds, it will be unloaded"
20 | - name: "--gpu"
21 |   type: "string"
22 |   optional: true
23 |   description: "How much to offload to the GPU. Values: 0-1, off, max"
24 | - name: "--context-length"
25 |   type: "number"
26 |   optional: true
27 |   description: "The number of tokens to consider as context when generating text"
28 | - name: "--identifier"
29 |   type: "string"
30 |   optional: true
31 |   description: "The identifier to assign to the loaded model for API reference"
32 | - name: "--estimate-only"
33 |   type: "boolean"
34 |   optional: true
35 |   description: "Print a resource (memory) estimate and exit without loading the model"
36 | ```
37 | 
38 | ## Load a model
39 | 
40 | Load a model into memory by running the following command:
41 | 
42 | ```shell
43 | lms load <model_key>
44 | ```
45 | 
46 | You can find the `model_key` by first running [`lms ls`](/docs/cli/ls) to list your locally downloaded models.
47 | 
48 | ### Set a custom identifier
49 | 
50 | Optionally, you can assign a custom identifier to the loaded model for API reference:
51 | 
52 | ```shell
53 | lms load <model_key> --identifier "my-custom-identifier"
54 | ```
55 | 
56 | You will then be able to refer to this model by the identifier `my_model` in subsequent commands and API calls (`model` parameter).
57 | 
58 | ### Set context length
59 | 
60 | You can set the context length when loading a model using the `--context-length` flag:
61 | 
62 | ```shell
63 | lms load <model_key> --context-length 4096
64 | ```
65 | 
66 | This determines how many tokens the model will consider as context when generating text.
67 | 
68 | ### Set GPU offload
69 | 
70 | Control GPU memory usage with the `--gpu` flag:
71 | 
72 | ```shell
73 | lms load <model_key> --gpu 0.5    # Offload 50% of layers to GPU
74 | lms load <model_key> --gpu max    # Offload all layers to GPU
75 | lms load <model_key> --gpu off    # Disable GPU offloading
76 | ```
77 | 
78 | If not specified, LM Studio will automatically determine optimal GPU usage.
79 | 
80 | ### Set TTL
81 | 
82 | Set an auto-unload timer with the `--ttl` flag (in seconds):
83 | 
84 | ```shell
85 | lms load <model_key> --ttl 3600   # Unload after 1 hour of inactivity
86 | ```
87 | 
88 | ### Estimate resources without loading
89 | 
90 | Preview memory requirements before loading a model using `--estimate-only`:
91 | 
92 | ```shell
93 | lms load --estimate-only <model_key>
94 | ```
95 | 
96 | Optional flags such as `--context-length` and `--gpu` are honored and reflected in the estimate. The estimator accounts for factors like context length, flash attention, and whether the model is vision‑enabled.
97 | 
98 | Example:
99 | 
100 | ```bash
101 | $ lms load --estimate-only gpt-oss-120b
102 | Model: openai/gpt-oss-120b
103 | Estimated GPU Memory:   65.68 GB
104 | Estimated Total Memory: 65.68 GB
105 | 
106 | Estimate: This model may be loaded based on your resource guardrails settings.
107 | ```
108 | 
109 | ## Operate on a remote LM Studio instance
110 | 
111 | `lms load` supports the `--host` flag to connect to a remote LM Studio instance. 
112 | 
113 | ```shell
114 | lms load <model_key> --host <host>
115 | ```
116 | 
117 | For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
```

3_cli/log-stream.md
```
1 | ---
2 | title: "`lms log stream`"
3 | sidebar_title: "`lms log stream`"
4 | description: Stream logs from LM Studio. Useful for debugging prompts sent to the model.
5 | index: -1
6 | ---
7 | 
8 | `lms log stream` lets you inspect the exact strings LM Studio sends to and receives from models, and (new in 0.3.26) stream server logs. This is useful for debugging prompt templates, model IO, and server operations.
9 | 
10 | <hr>
11 | 
12 | ```lms_protip
13 | If you haven't already, bootstrap `lms` on your machine by following the instructions [here](/docs/cli).
14 | ```
15 | 
16 | ### Quick start (model input)
17 | 
18 | By default, `lms log stream` shows the formatted user message that is sent to the model:
19 | 
20 | ```shell
21 | lms log stream
22 | ```
23 | 
24 | Send a message in Chat or call the local HTTP API to see logs.
25 | 
26 | ### Choose a source
27 | 
28 | Use `--source` to select which logs to stream:
29 | 
30 | - `--source model` (default) — model IO
31 | - `--source server` — HTTP API server logs (startup, endpoints, status)
32 | 
33 | Example (server logs):
34 | 
35 | ```shell
36 | lms log stream --source server
37 | ```
38 | 
39 | ### Filter model logs
40 | 
41 | When streaming `--source model`, filter by direction:
42 | 
43 | - `--filter input` — formatted user message sent to the model
44 | - `--filter output` — model output (printed after completion)
45 | - `--filter input,output` — both user input and model output
46 | 
47 | Examples:
48 | 
49 | ```shell
50 | # Only the formatted user input
51 | lms log stream --source model --filter input
52 | 
53 | # Only the model output (emitted once the message completes)
54 | lms log stream --source model --filter output
55 | 
56 | # Both directions
57 | lms log stream --source model --filter input,output
58 | ```
59 | 
60 | Note: model output is queued and printed once the message completes.
61 | 
62 | ### JSON output and stats
63 | 
64 | - Append `--json` to emit machine‑readable JSON logs:
65 | 
66 | ```shell
67 | lms log stream --source model --filter input,output --json
68 | ```
69 | 
70 | - Append `--stats` (model source) to include tokens/sec and related metrics:
71 | 
72 | ```shell
73 | lms log stream --source model --filter output --stats
74 | ```
75 | 
76 | ### Example (model input and output)
77 | 
78 | ```bash
79 | $ lms log stream --source model --filter input,output
80 | Streaming logs from LM Studio
81 | 
82 | timestamp: 9/15/2025, 3:16:39 PM
83 | type: llm.prediction.input
84 | modelIdentifier: gpt-oss-20b-mlx
85 | modelPath: lmstudio-community/gpt-oss-20b-mlx-8bit
86 | input:
87 | <|start|>system<|message|>...<|end|><|start|>user<|message|>hello<|end|><|start|>assistant
88 | 
89 | timestamp: 9/15/2025, 3:16:40 PM
90 | type: llm.prediction.output
91 | modelIdentifier: gpt-oss-20b-mlx
92 | output:
93 | Hello! 👋 How can I assist you today?
94 | ```
```

3_cli/ls.md
```
1 | ---
2 | title: "`lms ls`"
3 | sidebar_title: "`lms ls`"
4 | description: List all downloaded models in your LM Studio installation.
5 | index: 8
6 | ---
7 | 
8 | The `lms ls` command displays a list of all models downloaded to your machine, including their size, architecture, and parameters.
9 | 
10 | ### Parameters
11 | ```lms_params
12 | - name: "--llm"
13 |   type: "flag"
14 |   optional: true
15 |   description: "Show only LLMs. When not set, all models are shown"
16 | - name: "--embedding"
17 |   type: "flag"
18 |   optional: true
19 |   description: "Show only embedding models"
20 | - name: "--json"
21 |   type: "flag"
22 |   optional: true
23 |   description: "Output the list in JSON format"
24 | - name: "--detailed"
25 |   type: "flag"
26 |   optional: true
27 |   description: "Show detailed information about each model"
28 | ```
29 | 
30 | ## List all models
31 | 
32 | Show all downloaded models:
33 | 
34 | ```shell
35 | lms ls
36 | ```
37 | 
38 | Example output:
39 | ```
40 | You have 47 models, taking up 160.78 GB of disk space.
41 | 
42 | LLMs (Large Language Models)                       PARAMS      ARCHITECTURE           SIZE
43 | lmstudio-community/meta-llama-3.1-8b-instruct          8B         Llama            4.92 GB
44 | hugging-quants/llama-3.2-1b-instruct                   1B         Llama            1.32 GB
45 | mistral-7b-instruct-v0.3                                         Mistral           4.08 GB
46 | zeta                                                   7B         Qwen2            4.09 GB
47 | 
48 | ... (abbreviated in this example) ...
49 | 
50 | Embedding Models                                   PARAMS      ARCHITECTURE           SIZE
51 | text-embedding-nomic-embed-text-v1.5@q4_k_m                     Nomic BERT        84.11 MB
52 | text-embedding-bge-small-en-v1.5                     33M           BERT           24.81 MB
53 | ```
54 | 
55 | ### Filter by model type
56 | 
57 | List only LLM models:
58 | ```shell
59 | lms ls --llm
60 | ```
61 | 
62 | List only embedding models:
63 | ```shell
64 | lms ls --embedding
65 | ```
66 | 
67 | ### Additional output formats
68 | 
69 | Get detailed information about models:
70 | ```shell
71 | lms ls --detailed
72 | ```
73 | 
74 | Output in JSON format:
75 | ```shell
76 | lms ls --json
77 | ```
78 | 
79 | ## Operate on a remote LM Studio instance
80 | 
81 | `lms ls` supports the `--host` flag to connect to a remote LM Studio instance:
82 | 
83 | ```shell
84 | lms ls --host <host>
85 | ```
86 | 
87 | For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
```

3_cli/ps.md
```
1 | ---
2 | title: "`lms ps`"
3 | sidebar_title: "`lms ps`"
4 | description: Show information about currently loaded models from the command line.
5 | ---
6 | 
7 | The `lms ps` command displays information about all models currently loaded in memory.
8 | 
9 | ## List loaded models
10 | 
11 | Show all currently loaded models:
12 | 
13 | ```shell
14 | lms ps
15 | ```
16 | 
17 | Example output:
18 | ```
19 |    LOADED MODELS
20 | 
21 | Identifier: unsloth/deepseek-r1-distill-qwen-1.5b
22 |   • Type:  LLM
23 |   • Path: unsloth/DeepSeek-R1-Distill-Qwen-1.5B-GGUF/DeepSeek-R1-Distill-Qwen-1.5B-Q4_K_M.gguf
24 |   • Size: 1.12 GB
25 |   • Architecture: Qwen2
26 | ```
27 | 
28 | ### JSON output
29 | 
30 | Get the list in machine-readable format:
31 | ```shell
32 | lms ps --json
33 | ```
34 | 
35 | ## Operate on a remote LM Studio instance
36 | 
37 | `lms ps` supports the `--host` flag to connect to a remote LM Studio instance:
38 | 
39 | ```shell
40 | lms ps --host <host>
41 | ```
42 | 
43 | For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
```

3_cli/push.md
```
1 | ---
2 | title: "`lms push`"
3 | sidebar_title: "`lms push`"
4 | description: Upload a plugin, preset, or `model.yaml` to the LM Studio Hub.
5 | index: 9
6 | ---
7 | 
8 | The `lms push` command packages the contents of the current directory and uploads
9 | it to the LM Studio Hub. You can use it to share presets, plugins, or
10 | [`model.yaml`](http://modelyaml.org) files.
11 | 
12 | ### Parameters
13 | ```lms_params
14 | - name: "--overrides"
15 |   type: "string"
16 |   optional: true
17 |   description: "A JSON string of values to override in the manifest or metadata"
18 | - name: "--write-revision"
19 |   type: "flag"
20 |   optional: true
21 |   description: "Write the returned revision number to `manifest.json`"
22 | ```
23 | 
24 | ## Upload a Plugin, Preset, or `model.yaml`
25 | 
26 | Run `lms push` inside the directory that contains your plugin, preset, or `model.yaml` file:
27 | 
28 | 1. Navigate to the directory of your plugin, preset, or `model.yaml` file:
29 | ```shell
30 | cd path/to/your/directory
31 | ```
32 | 2. Run the command:
33 | ```shell
34 | lms push
35 | ```
36 | 
37 | The command uploads the artifact and prints the revision number. When used with
38 | `--write-revision`, the revision number is also written to the `manifest.json`
39 | file so you can track revisions in version control.
40 | 
41 | This command works for [presets](/docs/app/presets),
42 | [plugins](/docs/typescript/plugins), and `model.yaml` files.
43 | 
44 | ### Example Usage with `--overrides`
45 | You can use the `--overrides` parameter to modify the metadata before pushing:
46 | 
47 | ```shell
48 | lms push --overrides '{"description": "new-description"}'
49 | ```
50 | 
```

3_cli/server-start.md
```
1 | ---
2 | title: "`lms server start`"
3 | sidebar_title: "`lms server start`"
4 | description: Start the LM Studio local server with customizable port and logging options.
5 | index: 5
6 | ---
7 | 
8 | The `lms server start` command launches the LM Studio local server, allowing you to interact with loaded models via HTTP API calls.
9 | 
10 | ### Parameters
11 | ```lms_params
12 | - name: "--port"
13 |   type: "number"
14 |   optional: true
15 |   description: "Port to run the server on. If not provided, uses the last used port"
16 | - name: "--cors"
17 |   type: "flag"
18 |   optional: true
19 |   description: "Enable CORS support for web application development. When not set, CORS is disabled"
20 | ```
21 | 
22 | ## Start the server
23 | 
24 | Start the server with default settings:
25 | 
26 | ```shell
27 | lms server start
28 | ```
29 | 
30 | ### Specify a custom port
31 | 
32 | Run the server on a specific port:
33 | 
34 | ```shell
35 | lms server start --port 3000
36 | ```
37 | 
38 | ### Enable CORS support
39 | 
40 | For usage with web applications or some VS Code extensions, you may need to enable CORS support:
41 | 
42 | ```shell
43 | lms server start --cors
44 | ```
45 | 
46 | Note that enabling CORS may expose your server to security risks, so use it only when necessary.
47 | 
48 | ### Check the server status
49 | 
50 | See [`lms server status`](/docs/cli/server-status) for more information on checking the status of the server.
```

3_cli/server-status.md
```
1 | ---
2 | title: "`lms server status`"
3 | sidebar_title: "`lms server status`"
4 | description: Check the status of your running LM Studio server instance.
5 | index: 5
6 | ---
7 | 
8 | The `lms server status` command displays the current status of the LM Studio local server, including whether it's running and its configuration.
9 | 
10 | ### Parameters
11 | ```lms_params
12 | - name: "--json"
13 |   type: "flag"
14 |   optional: true
15 |   description: "Output the status in JSON format"
16 | - name: "--verbose"
17 |   type: "flag"
18 |   optional: true
19 |   description: "Enable detailed logging output"
20 | - name: "--quiet"
21 |   type: "flag"
22 |   optional: true
23 |   description: "Suppress all logging output"
24 | - name: "--log-level"
25 |   type: "string"
26 |   optional: true
27 |   description: "The level of logging to use. Defaults to 'info'"
28 | ```
29 | 
30 | ## Check server status
31 | 
32 | Get the basic status of the server:
33 | 
34 | ```shell
35 | lms server status
36 | ```
37 | 
38 | Example output:
39 | ```
40 | The server is running on port 1234.
41 | ```
42 | 
43 | ### Example usage
44 | 
45 | ```console
46 | ➜  ~ lms server start
47 | Starting server...
48 | Waking up LM Studio service...
49 | Success! Server is now running on port 1234
50 | 
51 | ➜  ~ lms server status
52 | The server is running on port 1234.
53 | ```
54 | 
55 | ### JSON output
56 | 
57 | Get the status in machine-readable JSON format:
58 | 
59 | ```shell
60 | lms server status --json --quiet
61 | ```
62 | 
63 | Example output:
64 | ```json
65 | {"running":true,"port":1234}
66 | ```
67 | 
68 | ### Control logging output
69 | 
70 | Adjust logging verbosity:
71 | 
72 | ```shell
73 | lms server status --verbose
74 | lms server status --quiet
75 | lms server status --log-level debug
76 | ```
77 | 
78 | You can only use one logging control flag at a time (`--verbose`, `--quiet`, or `--log-level`).
```

3_cli/server-stop.md
```
1 | ---
2 | title: "`lms server stop`"
3 | sidebar_title: "`lms server stop`"
4 | description: Stop the running LM Studio server instance.
5 | index: 7
6 | ---
7 | 
8 | The `lms server stop` command gracefully stops the running LM Studio server.
9 | 
10 | ## Stop the server
11 | 
12 | Stop the running server instance:
13 | 
14 | ```shell
15 | lms server stop
16 | ```
17 | 
18 | Example output:
19 | ```
20 | Stopped the server on port 1234.
21 | ```
22 | 
23 | Any active request will be terminated when the server is stopped. You can restart the server using [`lms server start`](/docs/cli/server-start).
```

3_cli/unload.md
```
1 | ---
2 | title: "`lms unload`"
3 | sidebar_title: "`lms unload`"
4 | description: Unload one or all models from memory using the command line.
5 | index: 3
6 | ---
7 | 
8 | The `lms unload` command unloads a model from memory. You can optionally specify a model key to unload a specific model, or use the `--all` flag to unload all models.
9 | 
10 | ### Parameters
11 | ```lms_params
12 | - name: "[model_key]"
13 |   type: "string"
14 |   optional: true
15 |   description: "The key of the model to unload. If not provided, you will be prompted to select one"
16 | - name: "--all"
17 |   type: "flag"
18 |   optional: true
19 |   description: "Unload all currently loaded models"
20 | - name: "--host"
21 |   type: "string"
22 |   optional: true
23 |   description: "The host address of a remote LM Studio instance to connect to"
24 | ```
25 | 
26 | ## Unload a specific model
27 | 
28 | Unload a single model from memory by running:
29 | 
30 | ```shell
31 | lms unload <model_key>
32 | ```
33 | 
34 | If no model key is provided, you will be prompted to select from currently loaded models.
35 | 
36 | ## Unload all models
37 | 
38 | To unload all currently loaded models at once:
39 | 
40 | ```shell
41 | lms unload --all
42 | ```
43 | 
44 | ## Operate on a remote LM Studio instance
45 | 
46 | `lms unload` supports the `--host` flag to connect to a remote LM Studio instance:
47 | 
48 | ```shell
49 | lms unload <model_key> --host <host>
50 | ```
51 | 
52 | For this to work, the remote LM Studio instance must be running and accessible from your local machine, e.g. be accessible on the same subnet.
```

_configuration/_load.md
```
1 | ---
2 | title: Load parameters
3 | description: Configurable parameters for load in LM Studio
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

_configuration/inference.md
```
1 | ---
2 | title: Inference parameters
3 | description: Configurable parameters for inference in LM Studio
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

_configuration/lm-runtimes.md
```
1 | ---
2 | title: LM Runtimes
3 | description: Downloading, installing, and using different LM Runtimes in LM Studio
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/0_root/api-changelog.md
```
1 | ---
2 | title: API Changelog
3 | description: LM Studio API Changelog - new features and updates
4 | index: 2
5 | ---
6 | 
7 | ###### LM Studio 0.3.29 • 2025‑10‑06
8 | 
9 | ### OpenAI `/v1/responses` and variant listing
10 | 
11 | - New OpenAI‑compatible endpoint: `POST /v1/responses`.
12 |   - Stateful interactions via `previous_response_id`.
13 |   - Custom tool calling and Remote MCP support (opt‑in).
14 |   - Reasoning support with `reasoning.effort` for `openai/gpt‑oss‑20b`.
15 |   - Streaming via SSE when `stream: true`.
16 | - CLI: `lms ls --variants` lists all variants for multi‑variant models.
17 | - Docs: [/docs/app/api/endpoints/openai](/docs/app/api/endpoints/openai). Full release notes: [/blog/lmstudio-v0.3.29](/blog/lmstudio-v0.3.29).
18 | 
19 | ---
20 | 
21 | ###### LM Studio 0.3.27 • 2025‑09‑24
22 | 
23 | ### CLI: model resource estimates, status, and interrupts
24 | 
25 | - New: `lms load --estimate-only <model>` prints estimated GPU and total memory before loading. Honors `--context-length` and `--gpu`, and uses an improved estimator that now accounts for flash attention and vision models.
26 | - `lms chat`: press `Ctrl+C` to interrupt an ongoing prediction.
27 | - `lms ps --json` now reports each model's generation status and the number of queued prediction requests.
28 | - CLI color contrast improved for light mode.
29 | - See docs: [/docs/cli/load](/docs/cli/load). Full release notes: [/blog/lmstudio-v0.3.27](/blog/lmstudio-v0.3.27).
30 | 
31 | ---
32 | 
33 | ###### LM Studio 0.3.26 • 2025‑09‑15
34 | 
35 | ### CLI log streaming: server + model
36 | 
37 | - `lms log stream` now supports multiple sources and filters.
38 |   - `--source server` streams HTTP server logs (startup, endpoints, status)
39 |   - `--source model --filter input,output` streams formatted user input and model output
40 |   - Append `--json` for machine‑readable logs; `--stats` adds tokens/sec and related metrics (model source)
41 | - See usage and examples: [/docs/cli/log-stream](/docs/cli/log-stream). Full release notes: [/blog/lmstudio-v0.3.26](/blog/lmstudio-v0.3.26).
42 | 
43 | ---
44 | 
45 | ###### LM Studio 0.3.25 • 2025‑09‑04
46 | 
47 | ### New model support (API)
48 | 
49 | - Added support for NVIDIA Nemotron‑Nano‑v2 with tool‑calling via the OpenAI‑compatible endpoints [‡](/blog/lmstudio-v0.3.25).
50 | - Added support for Google EmbeddingGemma for the `/v1/embeddings` endpoint [‡](/blog/lmstudio-v0.3.25).
51 | 
52 | ---
53 | 
54 | ###### LM Studio 0.3.24 • 2025‑08‑28
55 | 
56 | ### Seed‑OSS tool‑calling and template fixes
57 | 
58 | - Added support for ByteDance/Seed‑OSS including tool‑calling and prompt‑template compatibility fixes in the OpenAI‑compatible API [‡](/blog/lmstudio-v0.3.24).
59 | - Fixed cases where tool calls were not parsed for certain prompt templates [‡](/blog/lmstudio-v0.3.24).
60 | 
61 | ---
62 | 
63 | ###### LM Studio 0.3.23 • 2025‑08‑12
64 | 
65 | ### Reasoning content and tool‑calling reliability
66 | 
67 | - For `gpt‑oss` on `POST /v1/chat/completions`, reasoning content moves out of `message.content` and into `choices.message.reasoning` (non‑streaming) and `choices.delta.reasoning` (streaming), aligning with `o3‑mini` [‡](/blog/lmstudio-v0.3.23).
68 | - Tool names are normalized (e.g., snake_case) before being provided to the model to improve tool‑calling reliability [‡](/blog/lmstudio-v0.3.23).
69 | - Fixed errors for certain tools‑containing requests to `POST /v1/chat/completions` (e.g., "reading 'properties'") and non‑streaming tool‑call failures [‡](/blog/lmstudio-v0.3.23).
70 | 
71 | ---
72 | 
73 | ###### LM Studio 0.3.19 • 2025‑07‑21
74 | 
75 | ### Bug fixes for streaming and tool calls
76 | 
77 | - Corrected usage statistics returned by OpenAI‑compatible streaming responses [‡](https://lmstudio.ai/blog/lmstudio-v0.3.19#:~:text=,OpenAI%20streaming%20responses%20were%20incorrect).
78 | - Improved handling of parallel tool calls via the streaming API [‡](https://lmstudio.ai/blog/lmstudio-v0.3.19#:~:text=,API%20were%20not%20handled%20correctly).
79 | - Fixed parsing of correct tool calls for certain Mistral models [‡](https://lmstudio.ai/blog/lmstudio-v0.3.19#:~:text=,Ryzen%20AI%20PRO%20300%20series).
80 | 
81 | ---
82 | 
83 | ###### LM Studio 0.3.18 • 2025‑07‑10
84 | 
85 | ### Streaming options and tool‑calling improvements
86 | 
87 | - Added support for the `stream_options` object on OpenAI‑compatible endpoints. Setting `stream_options.include_usage` to `true` returns prompt and completion token usage during streaming [‡](https://lmstudio.ai/blog/lmstudio-v0.3.18#:~:text=%2A%20Added%20support%20for%20%60,to%20support%20more%20prompt%20templates).
88 | - Errors returned from streaming endpoints now follow the correct format expected by OpenAI clients [‡](https://lmstudio.ai/blog/lmstudio-v0.3.18#:~:text=,with%20proper%20chat%20templates).
89 | - Tool‑calling support added for Mistral v13 tokenizer models, using proper chat templates [‡](https://lmstudio.ai/blog/lmstudio-v0.3.18#:~:text=,with%20proper%20chat%20templates).
90 | - The `response_format.type` field now accepts `"text"` in chat‑completion requests [‡](https://lmstudio.ai/blog/lmstudio-v0.3.18#:~:text=,that%20are%20split%20across%20multiple).
91 | - Fixed bugs where parallel tool calls split across multiple chunks were dropped and where root‑level `$defs` in tool definitions were stripped [‡](https://lmstudio.ai/blog/lmstudio-v0.3.18#:~:text=,being%20stripped%20in%20tool%20definitions).
92 | 
93 | ---
94 | 
95 | ###### LM Studio 0.3.17 • 2025‑06‑25
96 | 
97 | ### Tool‑calling reliability and token‑count updates
98 | 
99 | - Token counts now include the system prompt and tool definitions [‡](https://lmstudio.ai/blog/lmstudio-v0.3.17#:~:text=,have%20a%20URL%20in%20the). This makes usage reporting more accurate for both the UI and the API.
100 | - Tool‑call argument tokens are streamed as they are generated [‡](https://lmstudio.ai/blog/lmstudio-v0.3.17#:~:text=Build%206), improving responsiveness when using streamed function calls.
101 | - Various fixes improve MCP and tool‑calling reliability, including correct handling of tools that omit a `parameters` object and preventing hangs when an MCP server reloads [‡](https://lmstudio.ai/blog/lmstudio-v0.3.17#:~:text=,tool%20calls%20would%20hang%20indefinitely).
102 | 
103 | ---
104 | ###### LM Studio 0.3.16 • 2025‑05‑23
105 | 
106 | ### Model capabilities in `GET /models`
107 | 
108 | - The OpenAI‑compatible REST API (`/api/v0`) now returns a `capabilities` array in the `GET /models` response. Each model lists its supported capabilities (e.g. `"tool_use"`) [‡](https://lmstudio.ai/blog/lmstudio-v0.3.16#:~:text=,response) so clients can programmatically discover tool‑enabled models.
109 | - Fixed a streaming bug where an empty function name string was appended after the first packet of streamed tool calls [‡](https://lmstudio.ai/blog/lmstudio-v0.3.16#:~:text=%2A%20Bugfix%3A%20%5BOpenAI,packet%20of%20streamed%20function%20calls).
110 | ---
111 | 
112 | ###### [👾 LM Studio 0.3.15](/blog/lmstudio-v0.3.15) • 2025-04-24
113 | 
114 | ### Improved Tool Use API Support
115 | 
116 | OpenAI-like REST API now supports the `tool_choice` parameter:
117 | 
118 | ```json
119 | {
120 |   "tool_choice": "auto" // or "none", "required"
121 | }
122 | ```
123 | 
124 | - `"tool_choice": "none"` — Model will not call tools
125 | - `"tool_choice": "auto"` — Model decides
126 | - `"tool_choice": "required"` — Model must call tools (llama.cpp only)
127 | 
128 | Chunked responses now set `"finish_reason": "tool_calls"` when appropriate.
129 | 
130 | ---
131 | 
132 | ###### [👾 LM Studio 0.3.14](/blog/lmstudio-v0.3.14) • 2025-03-27
133 | 
134 | ### [API/SDK] Preset Support
135 | 
136 | RESTful API and SDKs support specifying presets in requests.
137 | 
138 | _(example needed)_
139 | 
140 | ###### [👾 LM Studio 0.3.10](/blog/lmstudio-v0.3.10) • 2025-02-18
141 | 
142 | ### Speculative Decoding API
143 | 
144 | Enable speculative decoding in API requests with `"draft_model"`:
145 | 
146 | ```json
147 | {
148 |   "model": "deepseek-r1-distill-qwen-7b",
149 |   "draft_model": "deepseek-r1-distill-qwen-0.5b",
150 |   "messages": [ ... ]
151 | }
152 | ```
153 | 
154 | Responses now include a `stats` object for speculative decoding:
155 | 
156 | ```json
157 | "stats": {
158 |   "tokens_per_second": ...,
159 |   "draft_model": "...",
160 |   "total_draft_tokens_count": ...,
161 |   "accepted_draft_tokens_count": ...,
162 |   "rejected_draft_tokens_count": ...,
163 |   "ignored_draft_tokens_count": ...
164 | }
165 | ```
166 | 
167 | ---
168 | 
169 | ###### [👾 LM Studio 0.3.9](blog/lmstudio-v0.3.9) • 2025-01-30
170 | 
171 | ### Idle TTL and Auto Evict
172 | 
173 | Set a TTL (in seconds) for models loaded via API requests (docs article: [Idle TTL and Auto-Evict](/docs/api/ttl-and-auto-evict))
174 | 
175 | ```diff
176 | curl http://localhost:1234/api/v0/chat/completions \
177 |   -H "Content-Type: application/json" \
178 |   -d '{
179 |     "model": "deepseek-r1-distill-qwen-7b",
180 |     "messages": [ ... ]
181 | +   "ttl": 300,
182 | }'
183 | ```
184 | 
185 | With `lms`:
186 | 
187 | ```
188 | lms load --ttl <seconds>
189 | ```
190 | 
191 | ### Separate `reasoning_content` in Chat Completion responses
192 | 
193 | For DeepSeek R1 models, get reasoning content in a separate field. See more [here](/blog/lmstudio-v0.3.9#separate-reasoningcontent-in-chat-completion-responses).
194 | 
195 | Turn this on in App Settings > Developer.
196 | 
197 | ---
198 | 
199 | <br>
200 | 
201 | ###### [👾 LM Studio 0.3.6](blog/lmstudio-v0.3.6) • 2025-01-06
202 | 
203 | ### Tool and Function Calling API
204 | 
205 | Use any LLM that supports Tool Use and Function Calling through the OpenAI-like API.
206 | 
207 | Docs: [Tool Use and Function Calling](/docs/api/tools).
208 | 
209 | ---
210 | 
211 | <br>
212 | 
213 | ###### [👾 LM Studio 0.3.5](blog/lmstudio-v0.3.5) • 2024-10-22
214 | 
215 | ### Introducing `lms get`: download models from the terminal
216 | 
217 | You can now download models directly from the terminal using a keyword
218 | 
219 | ```bash
220 | lms get deepseek-r1
221 | ```
222 | 
223 | or a full Hugging Face URL
224 | 
225 | ```bash
226 | lms get <hugging face url>
227 | ```
228 | 
229 | To filter for MLX models only, add `--mlx` to the command.
230 | 
231 | ```bash
232 | lms get deepseek-r1 --mlx
233 | ```
```

0_app/0_root/index.md
```
1 | ---
2 | title: LM Studio Docs
3 | description: Learn how to run Llama, DeepSeek, Qwen, Phi, and other LLMs locally with LM Studio.
4 | index: 1
5 | ---
6 | 
7 | To get LM Studio, head over to the [Downloads page](/download) and download an installer for your operating system.
8 | 
9 | LM Studio is available for macOS, Windows, and Linux.
10 | 
11 | <br />
12 | 
13 | ## What can I do with LM Studio?
14 | 
15 | 1. Download and run local LLMs like gpt-oss or Llama, Qwen
16 | 2. Use a simple and flexible chat interface
17 | 3. Connect MCP servers and use them with local models
18 | 4. Search & download functionality (via Hugging Face 🤗)
19 | 5. Serve local models on OpenAI-like endpoints, locally and on the network
20 | 6. Manage your local models, prompts, and configurations
21 | 
22 | <br />
23 | 
24 | ## System requirements
25 | 
26 | LM Studio generally supports Apple Silicon Macs, x64/ARM64 Windows PCs, and x64 Linux PCs.
27 | 
28 | Consult the [System Requirements](app/system-requirements) page for more detailed information.
29 | 
30 | <br />
31 | 
32 | ## Run llama.cpp (GGUF) or MLX models
33 | 
34 | LM Studio supports running LLMs on Mac, Windows, and Linux using [`llama.cpp`](https://github.com/ggerganov/llama.cpp).
35 | 
36 | On Apple Silicon Macs, LM Studio also supports running LLMs using Apple's [`MLX`](https://github.com/ml-explore/mlx).
37 | 
38 | To install or manage LM Runtimes, press `⌘` `Shift` `R` on Mac or `Ctrl` `Shift` `R` on Windows/Linux.
39 | 
40 | <br />
41 | 
42 | ## LM Studio as an MCP client
43 | 
44 | You can install MCP servers in LM Studio and use them with your local models.
45 | 
46 | See the docs for more: [Use MCP server](/docs/app/plugins/mcp).
47 | 
48 | If you're develping an MCP server, check out [Add to LM Studio Button](/docs/app/plugins/mcp/deeplink).
49 | 
50 | <br />
51 | 
52 | ## Run an LLM like `gpt-oss`, `Llama`, `Qwen`, `Mistral`, or `DeepSeek R1` on your computer
53 | 
54 | To run an LLM on your computer you first need to download the model weights.
55 | 
56 | You can do this right within LM Studio! See [Download an LLM](app/basics/download-model) for guidance.
57 | 
58 | <br />
59 | 
60 | ## Chat with documents entirely offline on your computer
61 | 
62 | You can attach documents to your chat messages and interact with them entirely offline, also known as "RAG".
63 | 
64 | Read more about how to use this feature in the [Chat with Documents](app/basics/rag) guide.
65 | 
66 | ## Use LM Studio's API from your own apps and scripts
67 | 
68 | LM Studio provides a REST API that you can use to interact with your local models from your own apps and scripts.
69 | 
70 | - [OpenAI Compatibility API](api/openai-api)
71 | - [LM Studio REST API (beta)](api/rest-api)
72 | 
73 | <br />
74 | 
75 | ## Community
76 | 
77 | Join the LM Studio community on [Discord](https://discord.gg/aPQfnNkxGC) to ask questions, share knowledge, and get help from other users and the LM Studio team.
```

0_app/0_root/offline.md
```
1 | ---
2 | title: Offline Operation
3 | description: LM Studio can operate entirely offline, just make sure to get some model files first.
4 | index: 4
5 | ---
6 | 
7 | ```lms_notice
8 | In general, LM Studio does not require the internet in order to work. This includes core functions like chatting with models, chatting with documents, or running a local server, none of which require the internet.
9 | ```
10 | 
11 | ### Operations that do NOT require connectivity
12 | 
13 | #### Using downloaded LLMs
14 | 
15 | Once you have an LLM onto your machine, the model will run locally and you should be good to go entirely offline. Nothing you enter into LM Studio when chatting with LLMs leaves your device.
16 | 
17 | #### Chatting with documents (RAG)
18 | 
19 | When you drag and drop a document into LM Studio to chat with it or perform RAG, that document stays on your machine. All document processing is done locally, and nothing you upload into LM Studio leaves the application.
20 | 
21 | #### Running a local server
22 | 
23 | LM Studio can be used as a server to provide LLM inferencing on localhost or the local network. Requests to LM Studio use OpenAI endpoints and return OpenAI-like response objects, but stay local.
24 | 
25 | ### Operations that require connectivity
26 | 
27 | Several operations, described below, rely on internet connectivity. Once you get an LLM onto your machine, you should be good to go entirely offline.
28 | 
29 | #### Searching for models
30 | 
31 | When you search for models in the Discover tab, LM Studio makes network requests (e.g. to huggingface.co). Search will not work without internet connection.
32 | 
33 | #### Downloading new models
34 | 
35 | In order to download models you need a stable (and decently fast) internet connection. You can also 'sideload' models (use models that were procured outside the app). See instructions for [sideloading models](/docs/advanced/sideload).
36 | 
37 | #### Discover tab's model catalog
38 | 
39 | Any given version of LM Studio ships with an initial model catalog built-in. The entries in the catalog are typically the state of the online catalog near the moment we cut the release. However, in order to show stats and download options for each model, we need to make network requests (e.g. to huggingface.co).
40 | 
41 | #### Downloading runtimes
42 | 
43 | [LM Runtimes](advanced/lm-runtimes) are individually packaged software libraries, or LLM engines, that allow running certain formats of models (e.g. `llama.cpp`). As of LM Studio 0.3.0 (read the [announcement](https://lmstudio.ai/blog/lmstudio-v0.3.0)) it's easy to download and even hot-swap runtimes without a full LM Studio update. To check for available runtimes, and to download them, we need to make network requests.
44 | 
45 | #### Checking for app updates
46 | 
47 | On macOS and Windows, LM Studio has a built-in app updater that's capable. The linux in-app updater [is in the works](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues/89). When you open LM Studio, the app updater will make a network request to check if there are any new updates available. If there's a new version, the app will show you a notification to update now or later.
48 | Without internet connectivity you will not be able to update the app via the in-app updater.
```

0_app/0_root/system-requirements.md
```
1 | ---
2 | title: System Requirements
3 | description: Supported CPU, GPU types for LM Studio on Mac (M1/M2/M3/M4), Windows (x64/ARM), and Linux (x64)
4 | index: 3
5 | ---
6 | 
7 | ## macOS
8 | 
9 | - Chip: Apple Silicon (M1/M2/M3/M4).
10 | - macOS 13.4 or newer is required.
11 |   - For MLX models, macOS 14.0 or newer is required.
12 | - 16GB+ RAM recommended.
13 |   - You may still be able to use LM Studio on 8GB Macs, but stick to smaller models and modest context sizes.
14 | - Intel-based Macs are currently not supported. Chime in [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues/9) if you are interested in this.
15 | 
16 | ## Windows
17 | 
18 | LM Studio is supported on both x64 and ARM (Snapdragon X Elite) based systems.
19 | 
20 | - CPU: AVX2 instruction set support is required (for x64)
21 | - RAM: LLMs can consume a lot of RAM. At least 16GB of RAM is recommended.
22 | - GPU: at least 4GB of dedicated VRAM is recommended.
23 | 
24 | ## Linux
25 | 
26 | - LM Studio for Linux is distributed as an AppImage.
27 | - Ubuntu 20.04 or newer is required
28 | - x64 only, aarch64 not yet supported
29 | - Ubuntu versions newer than 22 are not well tested. Let us know if you're running into issues by opening a bug [here](https://github.com/lmstudio-ai/lmstudio-bug-tracker).
30 | - CPU:
31 |   - LM Studio ships with AVX2 support by default
```

0_app/1_basics/_connect-apps.md
```
1 | ---
2 | title: Connect apps to LM Studio
3 | description: Getting started with connecting applications to LM Studio
4 | ---
5 | 
6 | LM Studio comes with a few built-in themes for app-wide color palettes.
7 | 
8 | <hr>
9 | 
10 | ### Selecting a Theme
11 | 
12 | You can choose a theme in the Settings tab.
13 | 
14 | Choosing the "Auto" option will automatically switch between Light and Dark themes based on your system settings.
15 | 
16 | ```lms_protip
17 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
18 | ```
19 | ###### To get to the Settings page, you need to be on [Power User mode](/docs/modes) or higher.
20 | 
21 | <hr>
22 | 
23 | ### Community
24 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/1_basics/_keychords.md
```
1 | ---
2 | title: Keyboard Shortcuts
3 | description: Learn about the keyboard shortcuts in LM Studio
4 | ---
5 | 
6 | Starting LM Studio 0.3.0, you can switch between the following modes:
7 | 
8 | - **User**
9 | - **Power User**
10 | - **Developer**
11 | 
12 | <hr>
13 | 
14 | ### Selecting a Mode
15 | 
16 | Select a mode using the segmented control at the bottom bar of the app.
17 | 
18 | <img =>
19 | 
20 | ### Which mode should I choose?
21 | 
22 | #### `User`
23 | Show only the chat interface, no configuration parameters whatsoever. The best choice for beginners or anyone who's content with default settings.
24 | 
25 | #### `Power User`
26 | Use LM Studio in this mode if you want access to configurable [load](/docs/configuration/load) and [inference](/docs/configuration/inference) parameters and advanced chat features such as [insert, edit, &amp; continue](/docs/advanced/context) messages (of either role, user or assistant).
27 | 
28 | #### `Developer`
29 | Full access to every configurable parameter in LM Studio, including [keyboard shortcuts](/docs/keychords) and development
```

0_app/1_basics/_troubleshooting.md
```
1 | ---
2 | title: Troubleshooting
3 | description: Getting unstuck and solving common issues
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
9 | 
10 | ## Reporting bugs 
11 | If you encounter any issues with LM Studio, please open an issue on the [LM Studio GitHub repository](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
12 | 
13 | ## Common issues
14 | - [Issue one](#issue-one)
15 | - [Issue two](#issue-two)
16 | - [Issue three](#issue-three)
17 | - [Issue four](#issue-four)
18 | 
19 | 
20 | ### Issue one
21 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
22 | 
23 | ### Issue two
24 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
25 | 
26 | ### Issue three
27 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
28 | 
29 | ### Issue four
30 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/1_basics/chat.md
```
1 | ---
2 | title: Manage chats
3 | description: Manage conversation threads with LLMs
4 | index: 2
5 | ---
6 | 
7 | LM Studio has a ChatGPT-like interface for chatting with local LLMs. You can create many different conversation threads and manage them in folders.
8 | 
9 | <hr>
10 | 
11 | ### Create a new chat
12 | 
13 | You can create a new chat by clicking the "+" button or by using a keyboard shortcut: `⌘` + `N` on Mac, or `ctrl` + `N` on Windows / Linux.
14 | 
15 | ### Create a folder
16 | 
17 | Create a new folder by clicking the new folder button or by pressing: `⌘` + `shift` + `N` on Mac, or `ctrl` + `shift` + `N` on Windows / Linux.
18 | 
19 | ### Drag and drop
20 | 
21 | You can drag and drop chats in and out of folders, and even drag folders into folders!
22 | 
23 | ### Duplicate chats
24 | 
25 | You can duplicate a whole chat conversation by clicking the `•••` menu and selecting "Duplicate". If the chat has any files in it, they will be duplicated too.
26 | 
27 | ## FAQ
28 | 
29 | #### Where are chats stored in the file system?
30 | 
31 | Right-click on a chat and choose "Reveal in Finder" / "Show in File Explorer".
32 | Conversations are stored in JSON format. It is NOT recommended to edit them manually, nor to rely on their structure.
33 | 
34 | #### Does the model learn from chats?
35 | 
36 | The model doesn't 'learn' from chats. The model only 'knows' the content that is present in the chat or is provided to it via configuration options such as the "system prompt".
37 | 
38 | ## Conversations folder filesystem path
39 | 
40 | Mac / Linux:
41 | 
42 | ```shell
43 | ~/.lmstudio/conversations/
44 | ```
45 | 
46 | Windows:
47 | 
48 | ```ps
49 | %USERPROFILE%\.lmstudio\conversations
50 | ```
51 | 
52 | <hr>
53 | 
54 | ### Community
55 | 
56 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/1_basics/download-model.md
```
1 | ---
2 | title: Download an LLM
3 | description: Discover and download supported LLMs in LM Studio
4 | index: 3
5 | ---
6 | 
7 | LM Studio comes with a built-in model downloader that let's you download any supported model from [Hugging Face](https://huggingface.co).
8 | 
9 | <img src="/assets/docs/discover.png" style="width: 500px; margin-top:30px" data-caption="Download models from the Discover tab in LM Studio" />
10 | 
11 | <hr>
12 | 
13 | ### Searching for models
14 | 
15 | You can search for models by keyword (e.g. `llama`, `gemma`, `lmstudio`), or by providing a specific `user/model` string. You can even insert full Hugging Face URLs into the search bar!
16 | 
17 | ###### Pro tip: you can jump to the Discover tab from anywhere by pressing `⌘` + `2` on Mac, or `ctrl` + `2` on Windows / Linux.
18 | 
19 | ### Which download option to choose?
20 | 
21 | You will often see several options for any given model named things like `Q3_K_S`, `Q_8` etc. These are all copies of the same model, provided in varying degrees of fidelity. The `Q` represents a technique called "Quantization", which roughly means compressing model files in size, while giving up some degree of quality.
22 | 
23 | Choose a 4-bit option or higher if your machine is capable enough for running it.
24 | 
25 | <img src="/assets/docs/search.png" style="" data-caption="Hugging Face search results in LM Studio" />
26 | 
27 | <hr>
28 | 
29 | `Advanced`
30 | 
31 | ### Changing the models directory
32 | 
33 | You can change the models directory by heading to My Models
34 | 
35 | <img src="/assets/docs/change-models-dir.png" style="width:80%" data-caption="Manage your models directory in the My Models tab">
36 | 
37 | <hr>
38 | 
39 | ### Community
40 | 
41 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/1_basics/index.md
```
1 | ---
2 | title: Get started with LM Studio
3 | sidebar_title: Overview
4 | description: Download and run Large Language Models like Qwen, Mistral, Gemma, or gpt-oss in LM Studio.
5 | index: 1
6 | ---
7 | 
8 | Double check computer meets the minimum [system requirements](/docs/system-requirements).
9 | 
10 | <br>
11 | 
12 | ```lms_info
13 | You might sometimes see terms such as `open-source models` or `open-weights models`. Different models might be released under different licenses and varying degrees of 'openness'. In order to run a model locally, you need to be able to get access to its "weights", often distributed as one or more files that end with `.gguf`, `.safetensors` etc.
14 | ```
15 | 
16 | <hr>
17 | 
18 | ## Getting up and running
19 | 
20 | First, **install the latest version of LM Studio**. You can get it from [here](/download).
21 | 
22 | Once you're all set up, you need to **download your first LLM**.
23 | 
24 | ### 1. Download an LLM to your computer
25 | 
26 | Head over to the Discover tab to download models. Pick one of the curated options or search for models by search query (e.g. `"Llama"`). See more in-depth information about downloading models [here](/docs/basics/download-models).
27 | 
28 | <img src="/assets/docs/discover.png" style="width: 500px; margin-top:30px" data-caption="The Discover tab in LM Studio" />
29 | 
30 | ### 2. Load a model to memory
31 | 
32 | Head over to the **Chat** tab, and
33 | 
34 | 1. Open the model loader
35 | 2. Select one of the models you downloaded (or [sideloaded](/docs/advanced/sideload)).
36 | 3. Optionally, choose load configuration parameters.
37 | 
38 | <img src="/assets/docs/loader.png" data-caption="Quickly open the model loader with `cmd` + `L` on macOS or `ctrl` + `L` on Windows/Linux" />
39 | 
40 | ##### What does loading a model mean?
41 | 
42 | Loading a model typically means allocating memory to be able to accommodate the model's weights and other parameters in your computer's RAM.
43 | 
44 | ### 3. Chat!
45 | 
46 | Once the model is loaded, you can start a back-and-forth conversation with the model in the Chat tab.
47 | 
48 | <img src="/assets/docs/chat.png" data-caption="LM Studio on macOS" />
49 | 
50 | <hr>
51 | 
52 | ### Community
53 | 
54 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/1_basics/rag.md
```
1 | ---
2 | title: Chat with Documents
3 | description: How to provide local documents to an LLM as additional context
4 | index: 4
5 | ---
6 | 
7 | You can attach document files (`.docx`, `.pdf`, `.txt`) to chat sessions in LM Studio.
8 | 
9 | This will provide additional context to LLMs you chat with through the app.
10 | 
11 | <hr>
12 | 
13 | ## Terminology
14 | 
15 | - **Retrieval**: Identifying relevant portion of a long source document
16 | - **Query**: The input to the retrieval operation
17 | - **RAG**: Retrieval-Augmented Generation\*
18 | - **Context**: the 'working memory' of an LLM. Has a maximum size
19 | 
20 | ###### \* In this context, 'Generation' means the output of the LLM.
21 | ###### Context sizes are measured in "tokens". One token is often about 3/4 of a word.
22 | 
23 | ## RAG vs. Full document 'in context'
24 | 
25 | If the document is short enough (i.e., if it fits in the model's context), LM Studio will add the file contents to the conversation in full. This is particularly useful for models that support longer context sizes such as Meta's Llama 3.1 and Mistral Nemo.
26 | 
27 | If the document is very long, LM Studio will opt into using "Retrieval Augmented Generation", frequently referred to as "RAG". RAG means attempting to fish out relevant bits of a very long document (or several documents) and providing them to the model for reference. This technique sometimes works really well, but sometimes it requires some tuning and experimentation.
28 | 
29 | ## Tip for successful RAG
30 | 
31 | provide as much context in your query as possible. Mention terms, ideas, and words you expect to be in the relevant source material. This will often increase the chance the system will provide useful context to the LLM. As always, experimentation is the best way to find what works best.
```

0_app/3_modelyaml/index.md
```
1 | ---
2 | title: "Introduction to `model.yaml`"
3 | description: Describe models with the cross-platform `model.yaml` specification.
4 | index: 5
5 | socialCard: 
6 |   url: https://files.lmstudio.ai/modelyaml-card.jpg
7 |   alt: "model.yaml logo"
8 | ---
9 | 
10 | `Draft`
11 | 
12 | [`model.yaml`](https://modelyaml.org) describes a model and all of its variants in a single portable file. Models in LM Studio's [model catalog](https://lmstudio.ai/models) are all implemented using model.yaml.
13 | 
14 | This allows abstracting away the underlying format (GGUF, MLX, etc) and presenting a single entry point for a given model. Furthermore, the model.yaml file supports baking in additional metadata, load and inference options, and even custom logic (e.g. enable/disable thinking).
15 | 
16 | **You can clone existing model.yaml files on the LM Studio Hub and even [publish your own](./modelyaml/publish)!**
17 | 
18 | ## Core fields
19 | 
20 | ### `model`
21 | 
22 | The canonical identifier in the form `publisher/model`.
23 | 
24 | ```yaml
25 | model: qwen/qwen3-8b
26 | ```
27 | 
28 | ### `base`
29 | 
30 | Points to the "concrete" model files or other virtual models. Each entry uses a unique `key` and one or more `sources` from which the file can be fetched.
31 | 
32 | The snippet below demonstrates a case where the model (`qwen/qwen3-8b`) can resolve to one of 3 different concrete models.
33 | 
34 | ```yaml
35 | model: qwen/qwen3-8b
36 | base:
37 |   - key: lmstudio-community/qwen3-8b-gguf
38 |     sources:
39 |       - type: huggingface
40 |         user: lmstudio-community
41 |         repo: Qwen3-8B-GGUF
42 |   - key: lmstudio-community/qwen3-8b-mlx-4bit
43 |     sources:
44 |       - type: huggingface
45 |         user: lmstudio-community
46 |         repo: Qwen3-8B-MLX-4bit
47 |   - key: lmstudio-community/qwen3-8b-mlx-8bit
48 |     sources:
49 |       - type: huggingface
50 |         user: lmstudio-community
51 |         repo: Qwen3-8B-MLX-8bit
52 | ```
53 | 
54 | Concrete model files refer to the actual weights.
55 | 
56 | ### `metadataOverrides`
57 | 
58 | Overrides the base model's metadata. This is useful for presentation purposes, for example in LM Studio's model catalog or in app model search. It is not used for any functional changes to the model.
59 | 
60 | ```yaml
61 | metadataOverrides:
62 |   domain: llm
63 |   architectures:
64 |     - qwen3
65 |   compatibilityTypes:
66 |     - gguf
67 |     - safetensors
68 |   paramsStrings:
69 |     - 8B
70 |   minMemoryUsageBytes: 4600000000
71 |   contextLengths:
72 |     - 40960
73 |   vision: false
74 |   reasoning: true
75 |   trainedForToolUse: true
76 | ```
77 | 
78 | ### `config`
79 | 
80 | Use this to "bake in" default runtime settings (such as sampling parameters) and even load time options.
81 | This works similarly to [Per Model Defaults](/docs/app/advanced/per-model).
82 | 
83 | - `operation:` inference time parameters
84 | - `load:` load time parameters
85 | 
86 | ```yaml
87 | config:
88 |   operation:
89 |     fields:
90 |       - key: llm.prediction.topKSampling
91 |         value: 20
92 |       - key: llm.prediction.temperature
93 |         value: 0.7
94 |   load:
95 |     fields:
96 |       - key: llm.load.contextLength
97 |         value: 42690
98 | ```
99 | 
100 | ### `customFields`
101 | 
102 | Define model-specific custom fields.
103 | 
104 | ```yaml
105 | customFields:
106 |   - key: enableThinking
107 |     displayName: Enable Thinking
108 |     description: Controls whether the model will think before replying
109 |     type: boolean
110 |     defaultValue: true
111 |     effects:
112 |       - type: setJinjaVariable
113 |         variable: enable_thinking
114 | ```
115 | 
116 | In order for the above example to work, the jinja template needs to have a variable named `enable_thinking`.
117 | 
118 | ## Complete example
119 | 
120 | Taken from https://lmstudio.ai/models/qwen/qwen3-8b
121 | 
122 | ```yaml
123 | # model.yaml is an open standard for defining cross-platform, composable AI models
124 | # Learn more at https://modelyaml.org
125 | model: qwen/qwen3-8b
126 | base:
127 |   - key: lmstudio-community/qwen3-8b-gguf
128 |     sources:
129 |       - type: huggingface
130 |         user: lmstudio-community
131 |         repo: Qwen3-8B-GGUF
132 |   - key: lmstudio-community/qwen3-8b-mlx-4bit
133 |     sources:
134 |       - type: huggingface
135 |         user: lmstudio-community
136 |         repo: Qwen3-8B-MLX-4bit
137 |   - key: lmstudio-community/qwen3-8b-mlx-8bit
138 |     sources:
139 |       - type: huggingface
140 |         user: lmstudio-community
141 |         repo: Qwen3-8B-MLX-8bit
142 | metadataOverrides:
143 |   domain: llm
144 |   architectures:
145 |     - qwen3
146 |   compatibilityTypes:
147 |     - gguf
148 |     - safetensors
149 |   paramsStrings:
150 |     - 8B
151 |   minMemoryUsageBytes: 4600000000
152 |   contextLengths:
153 |     - 40960
154 |   vision: false
155 |   reasoning: true
156 |   trainedForToolUse: true
157 | config:
158 |   operation:
159 |     fields:
160 |       - key: llm.prediction.topKSampling
161 |         value: 20
162 |       - key: llm.prediction.minPSampling
163 |         value:
164 |           checked: true
165 |           value: 0
166 | customFields:
167 |   - key: enableThinking
168 |     displayName: Enable Thinking
169 |     description: Controls whether the model will think before replying
170 |     type: boolean
171 |     defaultValue: true
172 |     effects:
173 |       - type: setJinjaVariable
174 |         variable: enable_thinking
175 | ```
176 | 
177 | The [GitHub specification](https://github.com/modelyaml/modelyaml) contains further details and the latest schema.
```

0_app/3_modelyaml/publish.md
```
1 | ---
2 | title: Publish a `model.yaml`
3 | description: Upload your model definition to the LM Studio Hub.
4 | index: 7
5 | ---
6 | 
7 | Share portable models by uploading a [`model.yaml`](./) to your page on the LM Studio Hub.
8 | 
9 | After you publish a model.yaml to the LM Studio Hub, it will be available for other users to download with `lms get`.
10 | 
11 | ###### Note: `model.yaml` refers to metadata only. This means it does not include the actual model weights.
12 | 
13 | # Quickstart
14 | 
15 | The easiest way to get started is by cloning an existing model, modifying it, and then running `lms push`.
16 | 
17 | For example, you can clone the Qwen 3 8B model:
18 | 
19 | ```shell
20 | lms clone qwen/qwen3-8b
21 | ```
22 | 
23 | This will result in a local copy `model.yaml`, `README` and other metadata files. Importantly, this does NOT download the model weights.
24 | 
25 | ```lms_terminal
26 | ➜ ls
27 | README.md     manifest.json    model.yaml    thumbnail.png
28 | ```
29 | 
30 | ## Change the publisher to your user
31 | 
32 | The first part in the `model:` field should be the username of the publisher. Change it to a username of a user or organization for which you have write access.
33 | 
34 | ```diff
35 | - model: qwen/qwen3-8b
36 | + model: your-user-here/qwen3-8b
37 | base:
38 |   - key: lmstudio-community/qwen3-8b-gguf
39 |     sources:
40 | # ... the rest of the file
41 | ```
42 | 
43 | ## Sign in
44 | 
45 | Authenticate with the Hub from the command line:
46 | 
47 | ```shell
48 | lms login
49 | ```
50 | 
51 | The CLI will print an authentication URL. After you approve access, the session token is saved locally so you can publish models.
52 | 
53 | ## Publish your model
54 | 
55 | Run the push command in the directory containing `model.yaml`:
56 | 
57 | ```shell
58 | lms push
59 | ```
60 | 
61 | The command packages the file, uploads it, and prints a revision number for the new version.
62 | 
63 | ### Override metadata at publish time
64 | 
65 | Use `--overrides` to tweak fields without editing the file:
66 | 
67 | ```shell
68 | lms push --overrides '{"description": "Qwen 3 8B model"}'
69 | ```
70 | 
71 | ## Downloading a model and using it in LM Studio
72 | 
73 | After publishing, the model appears under your user or organization profile on the LM Studio Hub.
74 | 
75 | It can then be downloaded with:
76 | 
77 | ```shell
78 | lms get my-user/my-model
79 | ```
```

0_app/3_presets/import.md
```
1 | ---
2 | title: Importing and Sharing
3 | description: You can import preset files directly from disk, or pull presets made by others via URL.
4 | index: 2
5 | ---
6 | 
7 | You can import preset by file or URL. This is useful for sharing presets with others, or for importing presets from other users.
8 | 
9 | <hr>
10 | 
11 | # Import Presets
12 | 
13 | First, click the presets dropdown in the sidebar. You will see a list of your presets along with 2 buttons: `+ New Preset` and `Import`.
14 | 
15 | Click the `Import` button to import a preset.
16 | 
17 | <img src="/assets/docs/preset-import-button.png" data-caption="Import Presets" />
18 | 
19 | ## Import Presets from File
20 | 
21 | Once you click the Import button, you can select the source of the preset you want to import. You can either import from a file or from a URL.
22 | <img src="/assets/docs/import-preset-from-file.png" data-caption="Import one or more Presets from file" />
23 | 
24 | ## Import Presets from URL
25 | 
26 | Presets that are [published](/docs/app/presets/publish) to the LM Studio Hub can be imported by providing their URL.
27 | 
28 | Importing public presets does not require logging in within LM Studio.
29 | 
30 | <img src="/assets/docs/import-preset-from-url.png" data-caption="Import Presets by URL" />
31 | 
32 | ### Using `lms` CLI
33 | You can also use the CLI to import presets from URL. This is useful for sharing presets with others.
34 | 
35 | ```
36 | lms get {author}/{preset-name}
37 | ```
38 | 
39 | Example:
40 | ```bash
41 | lms get neil/qwen3-thinking
42 | ```
43 | 
44 | 
45 | ### Find your config-presets directory
46 | 
47 | LM Studio manages config presets on disk. Presets are local and private by default. You or others can choose to share them by sharing the file.
48 | 
49 | Click on the `•••` button in the Preset dropdown and select "Reveal in Finder" (or "Show in Explorer" on Windows).
50 | <img src="/assets/docs/preset-reveal-in-finder.png" data-caption="Reveal Preset in your local file system" />
51 | 
52 | This will download the preset file and automatically surface it in the preset dropdown in the app. 
53 | 
54 | ### Where Hub shared presets are stored
55 | Presets you share, and ones you download from the LM Studio Hub are saved in `~/.lmstudio/hub` on macOS and Linux, or `%USERPROFILE%\.lmstudio\hub` on Windows. 
```

0_app/3_presets/index.md
```
1 | ---
2 | title: Config Presets
3 | sidebar_title: Overview
4 | description: Save your system prompts and other parameters as Presets for easy reuse across chats.
5 | index: 1
6 | ---
7 | 
8 | Presets are a way to bundle together a system prompt and other parameters into a single configuration that can be easily reused across different chats.
9 | 
10 | New in 0.3.15: You can [import](/docs/app/presets/import) Presets from file or URL, and even [publish](/docs/app/presets/publish) your own Presets to share with others on to the LM Studio Hub.
11 | <hr>
12 | 
13 | ## Saving, resetting, and deselecting Presets
14 | 
15 | Below is the anatomy of the Preset manager:
16 | 
17 | <img src="/assets/docs/preset-widget-anatomy.png" style="width:70%" data-caption="The anatomy of the Preset manager in the settings sidebar.">
18 | 
19 | ## Importing, Publishing, and Updating Downloaded Presets
20 | 
21 | Presets are JSON files. You can share them by sending around the JSON, or you can share them by publishing them to the LM Studio Hub.
22 | You can also import Presets from other users by URL. See the [Import](/docs/app/presets/import) and [Publish](/docs/app/presets/publish) sections for more details.
23 | 
24 | ## Example: Build your own Prompt Library
25 | 
26 | You can create your own prompt library by using Presets.
27 | 
28 | <video autoplay loop muted playsinline style="width:60vh;" data-caption="Save collections of parameters as a Preset for easy reuse." class="border border-border">
29 |   <source src="https://files.lmstudio.ai/presets.mp4" type="video/mp4">
30 |   Your browser does not support the video tag.
31 | </video>
32 | 
33 | In addition to system prompts, every parameter under the Advanced Configuration sidebar can be recorded in a named Preset.
34 | 
35 | For example, you might want to always use a certain Temperature, Top P, or Max Tokens for a particular use case. You can save these settings as a Preset (with or without a system prompt) and easily switch between them.
36 | 
37 | #### The Use Case for Presets
38 | 
39 | - Save your system prompts, inference parameters as a named `Preset`.
40 | - Easily switch between different use cases, such as reasoning, creative writing, multi-turn conversations, or brainstorming.
41 | 
42 | ## Where Presets are stored
43 | 
44 | Presets are stored in the following directory:
45 | 
46 | #### macOS or Linux
47 | 
48 | ```xml
49 | ~/.lmstudio/config-presets
50 | ```
51 | 
52 | #### Windows
53 | 
54 | ```xml
55 | %USERPROFILE%\.lmstudio\config-presets
56 | ```
57 | 
58 | ### Migration from LM Studio 0.2.\* Presets
59 | 
60 | - Presets you've saved in LM Studio 0.2.\* are automatically readable in 0.3.3 with no migration step needed.
61 | - If you save **new changes** in a **legacy preset**, it'll be **copied** to a new format upon save.
62 |   - The old files are NOT deleted.
63 | - Notable difference: Load parameters are not included in the new preset format.
64 |   - Favor editing the model's default config in My Models. See [how to do it here](/docs/configuration/per-model).
65 | 
66 | <hr>
67 | 
68 | ### Community
69 | 
70 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/3_presets/publish.md
```
1 | ---
2 | title: Publish Your Presets
3 | sidebar_title: Publish a Preset
4 | description: Publish your Presets to the LM Studio Hub. Share your Presets with the community or with your colleagues.
5 | index: 3
6 | ---
7 | 
8 | `Feature In Preview`
9 | 
10 | Starting LM Studio 0.3.15, you can publish your Presets to the LM Studio community. This allows you to share your Presets with others and import Presets from other users.
11 | 
12 | This feature is early and we would love to hear your feedback. Please report bugs and feedback to bugs@lmstudio.ai.
13 | 
14 | ---
15 | 
16 | ## Step 1: Click the Publish Button
17 | 
18 | Identify the Preset you want to publish in the Preset dropdown. Click the `•••` button and select "Publish" from the menu.
19 | 
20 | <img src="/assets/docs/preset-publish-new.png" data-caption="Click the Publish button to publish your Preset to the LM Studio Hub." />
21 | 
22 | ## Step 2: Set the Preset Details
23 | 
24 | You will be prompted to set the details of your Preset. This includes the name (slug) and optional description. 
25 | 
26 | Community presets are public and can be used by anyone on the internet!
27 | 
28 | <img src="/assets/docs/preset-publish-details.png" data-caption="Set the details of your Preset before publishing." />
29 | 
30 | #### Privacy and Terms
31 | For good measure, visit the [Privacy Policy](https://lmstudio.ai/hub-privacy) and [Terms of Service](https://lmstudio.ai/hub-terms) to understand what's suitable to share on the Hub, and how data is handled. Community presets are public and visible to everyone. Make sure you agree to what these documents say before publishing your Preset.
```

0_app/3_presets/pull.md
```
1 | ---
2 | title: Pull Updates
3 | description: How to pull the latest revisions of your Presets, or presets you have imported from others.
4 | index: 4
5 | ---
6 | `Feature In Preview`
7 | 
8 | You can pull the latest revisions of your Presets, or presets you have imported from others. This is useful for keeping your Presets up to date with the latest changes.
9 | 
10 | <hr>
11 | 
12 | ## How to Pull Updates
13 | Click the `•••` button in the Preset dropdown and select "Pull" from the menu.
14 | 
15 | <img src="/assets/docs/preset-pull-latest.png" data-caption="Pull the latest revisions of your or imported Presets." />
16 | 
17 | ## Your Presets vs Others'
18 | 
19 | Both your published Presets and other downloaded Presets can be pulled and updated the same way.
```

0_app/3_presets/push.md
```
1 | ---
2 | title: Push New Revisions
3 | description: Publish new revisions of your Presets to the LM Studio Hub.
4 | index: 5
5 | ---
6 | 
7 | `Feature In Preview`
8 | 
9 | Starting LM Studio 0.3.15, you can publish your Presets to the LM Studio community. This allows you to share your Presets with others and import Presets from other users.
10 | 
11 | This feature is early and we would love to hear your feedback. Please report bugs and feedback to bugs@lmstudio.ai.
12 | 
13 | ---
14 | 
15 | ## Published Presets
16 | 
17 | Presets you share on the LM Studio Hub can be updated.
18 | 
19 | <img src="/assets/docs/preset-cloud-indicator.png" data-caption="Your shared Presets are marked with a cloud icon." />
20 | 
21 | ## Step 1: Make Changes and Commit
22 | 
23 | Make any changes to your Preset, both in parameters that are already included in the Preset, or by adding new parameters.
24 | 
25 | ## Step 2: Click the Push Button
26 | Once changes are committed, you will see a `Push` button. Click it to push your changes to the Hub. 
27 | 
28 | Pushing changes will result in a new revision of your Preset on the Hub.
29 | 
30 | <img src="/assets/docs/preset-push-button.png" data-caption="Click the Push button to push your changes to the Hub." />
```

0_app/4_api/_embeddings.md
```
1 | ---
2 | title: Embeddings
3 | description: Use embedding models in LM Studio
4 | ---
5 | 
6 | ### Page
7 | 
8 | lorem ipsum dolor sit amet, consectetur adipiscing elit. nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. nullam.
```

0_app/4_api/_index.md
```
1 | ---
2 | title: Using LM Studio's APIs
3 | description: Use LM Studio programatically from your code
4 | ---
5 | 
6 | Intro about LM Studio SDKs in general and what capabilities are supported.
7 | 
8 | (should probably reference [Running LM Studio as a server](/docs/headless))
9 | 
10 | ## How to get started
11 | 
12 | Language specific introductions are provided to help new users get started:
13 | 
14 | * [Getting started with the LM Studio Python SDK](/docs/sdk/python)
15 | * [Getting started with the LM Studio Typescript SDK](/docs/sdk/typescript)
16 | 
17 | ## Next steps
18 | 
19 | The remainder of this SDK documentation then covers specific operations in detail
20 | for each language, with example code provided for:
21 | 
22 | * the Python convenience API (intended primarily for interactive use)
23 | * the Python client instance API (which offers more explicit resource management)
24 | * the Typescript SDK
```

0_app/4_api/headless.md
```
1 | ---
2 | title: "Run LM Studio as a service (headless)"
3 | sidebar_title: "Headless Mode"
4 | description: "GUI-less operation of LM Studio: run in the background, start on machine login, and load models on demand"
5 | index: 2
6 | ---
7 | 
8 | LM Studio can be run as a service without the GUI. This is useful for running LM Studio on a server or in the background on your local machine. This works on Mac, Windows, and Linux machines with a graphical user interface.
9 | 
10 | <br />
11 | 
12 | ## Run LM Studio as a service
13 | 
14 | Running LM Studio as a service consists of several new features intended to make it more efficient to use LM Studio as a developer tool.
15 | 
16 | 1. The ability to run LM Studio without the GUI
17 | 2. The ability to start the LM Studio LLM server on machine login, headlessly
18 | 3. On-demand model loading
19 | 
20 | <br />
21 | 
22 | ## Run the LLM service on machine login
23 | 
24 | To enable this, head to app settings (`Cmd` / `Ctrl` + `,`) and check the box to run the LLM server on login.
25 | 
26 | <img src="/assets/docs/headless-settings.png" style="" data-caption="Enable the LLM server to start on machine login" />
27 | 
28 | When this setting is enabled, exiting the app will minimize it to the system tray, and the LLM server will continue to run in the background.
29 | 
30 | <br />
31 | 
32 | ## Just-In-Time (JIT) model loading for OpenAI endpoints
33 | 
34 | Useful when utilizing LM Studio as an LLM service with other frontends or applications.
35 | 
36 | <img src="/assets/docs/jit-loading.png" style="" data-caption="Load models on demand" />
37 | 
38 | <br />
39 | 
40 | #### When JIT loading is ON:
41 | 
42 | - Call to `/v1/models` will return all downloaded models, not only the ones loaded into memory
43 | - Calls to inference endpoints will load the model into memory if it's not already loaded
44 | 
45 | #### When JIT loading is OFF:
46 | 
47 | - Call to `/v1/models` will return only the models loaded into memory
48 | - You have to first load the model into memory before being able to use it
49 | 
50 | ##### What about auto unloading?
51 | 
52 | As of LM Studio 0.3.5, auto unloading is not yet in place. Models that are loaded via JIT loading will remain in memory until you unload them.
53 | We expect to implement more sophisticated memory management in the near future. Let us know if you have any feedback or suggestions.
54 | 
55 | <br />
56 | 
57 | ## Auto Server Start
58 | 
59 | Your last server state will be saved and restored on app or service launch.
60 | 
61 | To achieve this programmatically, you can use the following command:
62 | 
63 | ```bash
64 | lms server start
65 | ```
66 | 
67 | ```lms_protip
68 | If you haven't already, bootstrap `lms` on your machine by following the instructions [here](/docs/cli).
69 | ```
70 | 
71 | <br />
72 | 
73 | ### Community
74 | 
75 | Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
76 | 
77 | Please report bugs and issues in the [lmstudio-bug-tracker](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues) GitHub repository.
```

0_app/4_api/index.md
```
1 | ---
2 | title: LM Studio as a Local LLM API Server
3 | sidebar_title: Overview
4 | description: Run an LLM API server on localhost with LM Studio
5 | ---
6 | 
7 | You can serve local LLMs from LM Studio's Developer tab, either on localhost or on the network.
8 | 
9 | LM Studio's APIs can be used through an [OpenAI compatibility mode](/docs/app/api/endpoints/openai), enhanced [REST API](/docs/app/api/endpoints/rest), or through a client library like [lmstudio-js](/docs/api/sdk).
10 | 
11 | #### API options
12 | 
13 | - [TypeScript SDK](/docs/typescript) - `lmstudio-js`
14 | - [Python SDK](/docs/python) - `lmstudio-python`
15 | - [LM Studio REST API](/docs/app/api/endpoints/rest) (new, in beta)
16 | - [OpenAI Compatibility endpoints](/docs/app/api/endpoints/openai)
17 | 
18 | <img src="/assets/docs/server.png" style="" data-caption="Load and server LLMs from LM Studio" />
```

0_app/4_api/structured-output.md
```
1 | ---
2 | title: Structured Output
3 | description: Enforce LLM response formats using JSON schemas.
4 | ---
5 | 
6 | You can enforce a particular response format from an LLM by providing a JSON schema to the `/v1/chat/completions` endpoint, via LM Studio's REST API (or via any OpenAI client).
7 | 
8 | <hr>
9 | 
10 | ### Start LM Studio as a server
11 | To use LM Studio programmatically from your own code, run LM Studio as a local server.
12 | 
13 | You can turn on the server from the "Developer" tab in LM Studio, or via the `lms` CLI:
14 | 
15 | ```
16 | lms server start
17 | ```
18 | ###### Install `lms` by running `npx lmstudio install-cli`
19 | 
20 | This will allow you to interact with LM Studio via an OpenAI-like REST API. For an intro to LM Studio's OpenAI-like API, see [Running LM Studio as a server](/docs/basics/server).
21 | 
22 | <br>
23 | 
24 | ### Structured Output
25 | 
26 | The API supports structured JSON outputs through the `/v1/chat/completions` endpoint when given a [JSON schema](https://json-schema.org/overview/what-is-jsonschema). Doing this will cause the LLM to respond in valid JSON conforming to the schema provided.
27 | 
28 | It follows the same format as OpenAI's recently announced [Structured Output](https://platform.openai.com/docs/guides/structured-outputs) API and is expected to work via the OpenAI client SDKs.
29 | 
30 | **Example using `curl`**
31 | 
32 | This example demonstrates a structured output request using the `curl` utility.
33 | 
34 | To run this example on Mac or Linux, use any terminal. On Windows, use [Git Bash](https://git-scm.com/download/win).
35 | 
36 | ```bash
37 | curl http://{{hostname}}:{{port}}/v1/chat/completions \
38 |   -H "Content-Type: application/json" \
39 |   -d '{
40 |     "model": "{{model}}",
41 |     "messages": [
42 |       {
43 |         "role": "system",
44 |         "content": "You are a helpful jokester."
45 |       },
46 |       {
47 |         "role": "user",
48 |         "content": "Tell me a joke."
49 |       }
50 |     ],
51 |     "response_format": {
52 |       "type": "json_schema",
53 |       "json_schema": {
54 |         "name": "joke_response",
55 |         "strict": "true",
56 |         "schema": {
57 |           "type": "object",
58 |           "properties": {
59 |             "joke": {
60 |               "type": "string"
61 |             }
62 |           },
63 |           "required": ["joke"]
64 |         }
65 |       }
66 |     },
67 |     "temperature": 0.7,
68 |     "max_tokens": 50,
69 |     "stream": false
70 |   }'
71 | ```
72 | 
73 | All parameters recognized by `/v1/chat/completions` will be honored, and the JSON schema should be provided in the `json_schema` field of `response_format`.
74 | 
75 | The JSON object will be provided in `string` form in the typical response field, `choices[0].message.content`, and will need to be parsed into a JSON object.
76 | 
77 | **Example using `python`**
78 | ```python
79 | from openai import OpenAI
80 | import json
81 | 
82 | # Initialize OpenAI client that points to the local LM Studio server
83 | client = OpenAI(
84 |     base_url="http://localhost:1234/v1",
85 |     api_key="lm-studio"
86 | )
87 | 
88 | # Define the conversation with the AI
89 | messages = [
90 |     {"role": "system", "content": "You are a helpful AI assistant."},
91 |     {"role": "user", "content": "Create 1-3 fictional characters"}
92 | ]
93 | 
94 | # Define the expected response structure
95 | character_schema = {
96 |     "type": "json_schema",
97 |     "json_schema": {
98 |         "name": "characters",
99 |         "schema": {
100 |             "type": "object",
101 |             "properties": {
102 |                 "characters": {
103 |                     "type": "array",
104 |                     "items": {
105 |                         "type": "object",
106 |                         "properties": {
107 |                             "name": {"type": "string"},
108 |                             "occupation": {"type": "string"},
109 |                             "personality": {"type": "string"},
110 |                             "background": {"type": "string"}
111 |                         },
112 |                         "required": ["name", "occupation", "personality", "background"]
113 |                     },
114 |                     "minItems": 1,
115 |                 }
116 |             },
117 |             "required": ["characters"]
118 |         },
119 |     }
120 | }
121 | 
122 | # Get response from AI
123 | response = client.chat.completions.create(
124 |     model="your-model",
125 |     messages=messages,
126 |     response_format=character_schema,
127 | )
128 | 
129 | # Parse and display the results
130 | results = json.loads(response.choices[0].message.content)
131 | print(json.dumps(results, indent=2))
132 | ```
133 | 
134 | **Important**: Not all models are capable of structured output, particularly LLMs below 7B parameters.
135 | 
136 | Check the model card README if you are unsure if the model supports structured output.
137 | 
138 | ### Structured output engine
139 | 
140 | - For `GGUF` models: utilize `llama.cpp`'s grammar-based sampling APIs.
141 | - For `MLX` models: using [Outlines](https://github.com/dottxt-ai/outlines). 
142 | 
143 | The MLX implementation is available on Github: [lmstudio-ai/mlx-engine](https://github.com/lmstudio-ai/mlx-engine).
144 | 
145 | <hr>
146 | 
147 | ### Community
148 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/4_api/tools.md
```
1 | ---
2 | title: Tool Use
3 | sidebar_title: Tools and Function Calling
4 | description: Enable LLMs to interact with external functions and APIs.
5 | ---
6 | 
7 | Tool use enables LLMs to request calls to external functions and APIs through the `/v1/chat/completions` endpoint, via LM Studio's REST API (or via any OpenAI client). This expands their functionality far beyond text output.
8 | 
9 | <hr>
10 | 
11 | ## Quick Start
12 | 
13 | ### 1. Start LM Studio as a server
14 | 
15 | To use LM Studio programmatically from your own code, run LM Studio as a local server.
16 | 
17 | You can turn on the server from the "Developer" tab in LM Studio, or via the `lms` CLI:
18 | 
19 | ```bash
20 | lms server start
21 | ```
22 | 
23 | ###### Install `lms` by running `npx lmstudio install-cli`
24 | 
25 | This will allow you to interact with LM Studio via an OpenAI-like REST API. For an intro to LM Studio's OpenAI-like API, see [Running LM Studio as a server](/docs/basics/server).
26 | 
27 | ### 2. Load a Model
28 | 
29 | You can load a model from the "Chat" or "Developer" tabs in LM Studio, or via the `lms` CLI:
30 | 
31 | ```bash
32 | lms load
33 | ```
34 | 
35 | ### 3. Copy, Paste, and Run an Example!
36 | 
37 | - `Curl`
38 |   - [Single Turn Tool Call Request](#example-using-curl)
39 | - `Python`
40 |   - [Single Turn Tool Call + Tool Use](#single-turn-example)
41 |   - [Multi-Turn Example](#multi-turn-example)
42 |   - [Advanced Agent Example](#advanced-agent-example)
43 | 
44 | <br>
45 | 
46 | ## Tool Use
47 | 
48 | ### What really is "Tool Use"?
49 | 
50 | Tool use describes:
51 | 
52 | - LLMs output text requesting functions to be called (LLMs cannot directly execute code)
53 | - Your code executes those functions
54 | - Your code feeds the results back to the LLM.
55 | 
56 | ### High-level flow
57 | 
58 | ```xml
59 | ┌──────────────────────────┐
60 | │ SETUP: LLM + Tool list   │
61 | └──────────┬───────────────┘
62 |            ▼
63 | ┌──────────────────────────┐
64 | │    Get user input        │◄────┐
65 | └──────────┬───────────────┘     │
66 |            ▼                     │
67 | ┌──────────────────────────┐     │
68 | │ LLM prompted w/messages  │     │
69 | └──────────┬───────────────┘     │
70 |            ▼                     │
71 |      Needs tools?                │
72 |       │         │                │
73 |     Yes         No               │
74 |       │         │                │
75 |       ▼         └────────────┐   │
76 | ┌─────────────┐              │   │
77 | │Tool Response│              │   │
78 | └──────┬──────┘              │   │
79 |        ▼                     │   │
80 | ┌─────────────┐              │   │
81 | │Execute tools│              │   │
82 | └──────┬──────┘              │   │
83 |        ▼                     ▼   │
84 | ┌─────────────┐          ┌───────────┐
85 | │Add results  │          │  Normal   │
86 | │to messages  │          │ response  │
87 | └──────┬──────┘          └─────┬─────┘
88 |        │                       ▲
89 |        └───────────────────────┘
90 | ```
91 | 
92 | ### In-depth flow
93 | 
94 | LM Studio supports tool use through the `/v1/chat/completions` endpoint when given function definitions in the `tools` parameter of the request body. Tools are specified as an array of function definitions that describe their parameters and usage, like:
95 | 
96 | It follows the same format as OpenAI's [Function Calling](https://platform.openai.com/docs/guides/function-calling) API and is expected to work via the OpenAI client SDKs.
97 | 
98 | We will use [lmstudio-community/Qwen2.5-7B-Instruct-GGUF](https://model.lmstudio.ai/download/lmstudio-community/Qwen2.5-7B-Instruct-GGUF) as the model in this example flow.
99 | 
100 | 1. You provide a list of tools to an LLM. These are the tools that the model can _request_ calls to.
101 |    For example:
102 | 
103 |    ```json
104 |    // the list of tools is model-agnostic
105 |    [
106 |      {
107 |        "type": "function",
108 |        "function": {
109 |          "name": "get_delivery_date",
110 |          "description": "Get the delivery date for a customer's order",
111 |          "parameters": {
112 |            "type": "object",
113 |            "properties": {
114 |              "order_id": {
115 |                "type": "string"
116 |              }
117 |            },
118 |            "required": ["order_id"]
119 |          }
120 |        }
121 |      }
122 |    ]
123 |    ```
124 | 
125 |    This list will be injected into the `system` prompt of the model depending on the model's chat template. For `Qwen2.5-Instruct`, this looks like:
126 | 
127 |    ```json
128 |    <|im_start|>system
129 |    You are Qwen, created by Alibaba Cloud. You are a helpful assistant.
130 | 
131 |    # Tools
132 | 
133 |    You may call one or more functions to assist with the user query.
134 | 
135 |    You are provided with function signatures within <tools></tools> XML tags:
136 |    <tools>
137 |    {"type": "function", "function": {"name": "get_delivery_date", "description": "Get the delivery date for a customer's order", "parameters": {"type": "object", "properties": {"order_id": {"type": "string"}}, "required": ["order_id"]}}}
138 |    </tools>
139 | 
140 |    For each function call, return a json object with function name and arguments within <tool_call></tool_call> XML tags:
141 |    <tool_call>
142 |    {"name": <function-name>, "arguments": <args-json-object>}
143 |    </tool_call><|im_end|>
144 |    ```
145 | 
146 |    **Important**: The model can only _request_ calls to these tools because LLMs _cannot_ directly call functions, APIs, or any other tools. They can only output text, which can then be parsed to programmatically call the functions.
147 | 
148 | 2. When prompted, the LLM can then decide to either:
149 | 
150 |    - (a) Call one or more tools
151 | 
152 |    ```xml
153 |    User: Get me the delivery date for order 123
154 |    Model: <tool_call>
155 |    {"name": "get_delivery_date", "arguments": {"order_id": "123"}}
156 |    </tool_call>
157 |    ```
158 | 
159 |    - (b) Respond normally
160 | 
161 |    ```xml
162 |    User: Hi
163 |    Model: Hello! How can I assist you today?
164 |    ```
165 | 
166 | 3. LM Studio parses the text output from the model into an OpenAI-compliant `chat.completion` response object.
167 | 
168 |    - If the model was given access to `tools`, LM Studio will attempt to parse the tool calls into the `response.choices[0].message.tool_calls` field of the `chat.completion` response object.
169 |    - If LM Studio cannot parse any **correctly formatted** tool calls, it will simply return the response to the standard `response.choices[0].message.content` field.
170 |    - **Note**: Smaller models and models that were not trained for tool use may output improperly formatted tool calls, resulting in LM Studio being unable to parse them into the `tool_calls` field. This is useful for troubleshooting when you do not receive `tool_calls` as expected. Example of an improperly formatting `Qwen2.5-Instruct` tool call:
171 | 
172 |    ```xml
173 |    <tool_call>
174 |    ["name": "get_delivery_date", function: "date"]
175 |    </tool_call>
176 |    ```
177 | 
178 |    > Note that the brackets are incorrect, and the call does not follow the `name, argument` format.
179 | 
180 | 4. Your code parses the `chat.completion` response to check for tool calls from the model, then calls the appropriate tools with the parameters specified by the model. Your code then adds both:
181 | 
182 |    1. The model's tool call message
183 |    2. The result of the tool call
184 | 
185 |    To the `messages` array to send back to the model
186 | 
187 |    ```python
188 |    # pseudocode, see examples for copy-paste snippets
189 |    if response.has_tool_calls:
190 |        for each tool_call:
191 |            # Extract function name & args
192 |            function_to_call = tool_call.name     # e.g. "get_delivery_date"
193 |            args = tool_call.arguments            # e.g. {"order_id": "123"}
194 | 
195 |            # Execute the function
196 |            result = execute_function(function_to_call, args)
197 | 
198 |            # Add result to conversation
199 |            add_to_messages([
200 |                ASSISTANT_TOOL_CALL_MESSAGE,      # The request to use the tool
201 |                TOOL_RESULT_MESSAGE               # The tool's response
202 |            ])
203 |    else:
204 |        # Normal response without tools
205 |        add_to_messages(response.content)
206 |    ```
207 | 
208 | 5. The LLM is then prompted again with the updated messages array, but without access to tools. This is because:
209 |    - The LLM already has the tool results in the conversation history
210 |    - We want the LLM to provide a final response to the user, not call more tools
211 |    ```python
212 |    # Example messages
213 |    messages = [
214 |        {"role": "user", "content": "When will order 123 be delivered?"},
215 |        {"role": "assistant", "function_call": {
216 |            "name": "get_delivery_date",
217 |            "arguments": {"order_id": "123"}
218 |        }},
219 |        {"role": "tool", "content": "2024-03-15"},
220 |    ]
221 |    response = client.chat.completions.create(
222 |        model="lmstudio-community/qwen2.5-7b-instruct",
223 |        messages=messages
224 |    )
225 |    ```
226 |    The `response.choices[0].message.content` field after this call may be something like:
227 |    ```xml
228 |    Your order #123 will be delivered on March 15th, 2024
229 |    ```
230 | 6. The loop continues back at step 2 of the flow
231 | 
232 | Note: This is the `pedantic` flow for tool use. However, you can certainly experiment with this flow to best fit your use case.
233 | 
234 | <br>
235 | 
236 | ## Supported Models
237 | 
238 | Through LM Studio, **all** models support at least some degree of tool use.
239 | 
240 | However, there are currently two levels of support that may impact the quality of the experience: Native and Default.
241 | 
242 | Models with Native tool use support will have a hammer badge in the app, and generally perform better in tool use scenarios.
243 | 
244 | ### Native tool use support
245 | 
246 | "Native" tool use support means that both:
247 | 
248 | 1. The model has a chat template that supports tool use (usually means the model has been trained for tool use)
249 |    - This is what will be used to format the `tools` array into the system prompt and tell them model how to format tool calls
250 |    - Example: [Qwen2.5-Instruct chat template](https://huggingface.co/mlx-community/Qwen2.5-7B-Instruct-4bit/blob/c26a38f6a37d0a51b4e9a1eb3026530fa35d9fed/tokenizer_config.json#L197)
251 | 2. LM Studio supports that model's tool use format
252 |    - Required for LM Studio to properly input the chat history into the chat template, and parse the tool calls the model outputs into the `chat.completion` object
253 | 
254 | Models that currently have native tool use support in LM Studio (subject to change):
255 | 
256 | - Qwen
257 |   - `GGUF` [lmstudio-community/Qwen2.5-7B-Instruct-GGUF](https://model.lmstudio.ai/download/lmstudio-community/Qwen2.5-7B-Instruct-GGUF) (4.68 GB)
258 |   - `MLX` [mlx-community/Qwen2.5-7B-Instruct-4bit](https://model.lmstudio.ai/download/mlx-community/Qwen2.5-7B-Instruct-4bit) (4.30 GB)
259 | - Llama-3.1, Llama-3.2
260 |   - `GGUF` [lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF](https://model.lmstudio.ai/download/lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF) (4.92 GB)
261 |   - `MLX` [mlx-community/Meta-Llama-3.1-8B-Instruct-8bit](https://model.lmstudio.ai/download/mlx-community/Meta-Llama-3.1-8B-Instruct-8bit) (8.54 GB)
262 | - Mistral
263 |   - `GGUF` [bartowski/Ministral-8B-Instruct-2410-GGUF](https://model.lmstudio.ai/download/bartowski/Ministral-8B-Instruct-2410-GGUF) (4.67 GB)
264 |   - `MLX` [mlx-community/Ministral-8B-Instruct-2410-4bit](https://model.lmstudio.ai/download/mlx-community/Ministral-8B-Instruct-2410-4bit) (4.67 GB GB)
265 | 
266 | ### Default tool use support
267 | 
268 | "Default" tool use support means that **either**:
269 | 
270 | 1. The model does not have chat template that supports tool use (usually means the model has not been trained for tool use)
271 | 2. LM Studio does not currently support that model's tool use format
272 | 
273 | Under the hood, default tool use works by:
274 | 
275 | - Giving models a custom system prompt and a default tool call format to use
276 | - Converting `tool` role messages to the `user` role so that chat templates without the `tool` role are compatible
277 | - Converting `assistant` role `tool_calls` into the default tool call format
278 | 
279 | Results will vary by model.
280 | 
281 | You can see the default format by running `lms log stream` in your terminal, then sending a chat completion request with `tools` to a model that doesn't have Native tool use support. The default format is subject to change.
282 | 
283 | <details>
284 | <summary>Expand to see example of default tool use format</summary>
285 | 
286 | ```bash
287 | -> % lms log stream
288 | Streaming logs from LM Studio
289 | 
290 | timestamp: 11/13/2024, 9:35:15 AM
291 | type: llm.prediction.input
292 | modelIdentifier: gemma-2-2b-it
293 | modelPath: lmstudio-community/gemma-2-2b-it-GGUF/gemma-2-2b-it-Q4_K_M.gguf
294 | input: "<start_of_turn>system
295 | You are a tool-calling AI. You can request calls to available tools with this EXACT format:
296 | [TOOL_REQUEST]{"name": "tool_name", "arguments": {"param1": "value1"}}[END_TOOL_REQUEST]
297 | 
298 | AVAILABLE TOOLS:
299 | {
300 |   "type": "toolArray",
301 |   "tools": [
302 |     {
303 |       "type": "function",
304 |       "function": {
305 |         "name": "get_delivery_date",
306 |         "description": "Get the delivery date for a customer's order",
307 |         "parameters": {
308 |           "type": "object",
309 |           "properties": {
310 |             "order_id": {
311 |               "type": "string"
312 |             }
313 |           },
314 |           "required": [
315 |             "order_id"
316 |           ]
317 |         }
318 |       }
319 |     }
320 |   ]
321 | }
322 | 
323 | RULES:
324 | - Only use tools from AVAILABLE TOOLS
325 | - Include all required arguments
326 | - Use one [TOOL_REQUEST] block per tool
327 | - Never use [TOOL_RESULT]
328 | - If you decide to call one or more tools, there should be no other text in your message
329 | 
330 | Examples:
331 | "Check Paris weather"
332 | [TOOL_REQUEST]{"name": "get_weather", "arguments": {"location": "Paris"}}[END_TOOL_REQUEST]
333 | 
334 | "Send email to John about meeting and open browser"
335 | [TOOL_REQUEST]{"name": "send_email", "arguments": {"to": "John", "subject": "meeting"}}[END_TOOL_REQUEST]
336 | [TOOL_REQUEST]{"name": "open_browser", "arguments": {}}[END_TOOL_REQUEST]
337 | 
338 | Respond conversationally if no matching tools exist.<end_of_turn>
339 | <start_of_turn>user
340 | Get me delivery date for order 123<end_of_turn>
341 | <start_of_turn>model
342 | "
343 | ```
344 | 
345 | If the model follows this format exactly to call tools, i.e:
346 | 
347 | ```
348 | [TOOL_REQUEST]{"name": "get_delivery_date", "arguments": {"order_id": "123"}}[END_TOOL_REQUEST]
349 | ```
350 | 
351 | Then LM Studio will be able to parse those tool calls into the `chat.completions` object, just like for natively supported models.
352 | 
353 | </details>
354 | 
355 | All models that don't have native tool use support will have default tool use support.
356 | 
357 | <br>
358 | 
359 | ## Example using `curl`
360 | 
361 | This example demonstrates a model requesting a tool call using the `curl` utility.
362 | 
363 | To run this example on Mac or Linux, use any terminal. On Windows, use [Git Bash](https://git-scm.com/download/win).
364 | 
365 | ```bash
366 | curl http://localhost:1234/v1/chat/completions \
367 |   -H "Content-Type: application/json" \
368 |   -d '{
369 |     "model": "lmstudio-community/qwen2.5-7b-instruct",
370 |     "messages": [{"role": "user", "content": "What dell products do you have under $50 in electronics?"}],
371 |     "tools": [
372 |       {
373 |         "type": "function",
374 |         "function": {
375 |           "name": "search_products",
376 |           "description": "Search the product catalog by various criteria. Use this whenever a customer asks about product availability, pricing, or specifications.",
377 |           "parameters": {
378 |             "type": "object",
379 |             "properties": {
380 |               "query": {
381 |                 "type": "string",
382 |                 "description": "Search terms or product name"
383 |               },
384 |               "category": {
385 |                 "type": "string",
386 |                 "description": "Product category to filter by",
387 |                 "enum": ["electronics", "clothing", "home", "outdoor"]
388 |               },
389 |               "max_price": {
390 |                 "type": "number",
391 |                 "description": "Maximum price in dollars"
392 |               }
393 |             },
394 |             "required": ["query"],
395 |             "additionalProperties": false
396 |           }
397 |         }
398 |       }
399 |     ]
400 |   }'
401 | ```
402 | 
403 | All parameters recognized by `/v1/chat/completions` will be honored, and the array of available tools should be provided in the `tools` field.
404 | 
405 | If the model decides that the user message would be best fulfilled with a tool call, an array of tool call request objects will be provided in the response field, `choices[0].message.tool_calls`.
406 | 
407 | The `finish_reason` field of the top-level response object will also be populated with `"tool_calls"`.
408 | 
409 | An example response to the above `curl` request will look like:
410 | 
411 | ```bash
412 | {
413 |   "id": "chatcmpl-gb1t1uqzefudice8ntxd9i",
414 |   "object": "chat.completion",
415 |   "created": 1730913210,
416 |   "model": "lmstudio-community/qwen2.5-7b-instruct",
417 |   "choices": [
418 |     {
419 |       "index": 0,
420 |       "logprobs": null,
421 |       "finish_reason": "tool_calls",
422 |       "message": {
423 |         "role": "assistant",
424 |         "tool_calls": [
425 |           {
426 |             "id": "365174485",
427 |             "type": "function",
428 |             "function": {
429 |               "name": "search_products",
430 |               "arguments": "{\"query\":\"dell\",\"category\":\"electronics\",\"max_price\":50}"
431 |             }
432 |           }
433 |         ]
434 |       }
435 |     }
436 |   ],
437 |   "usage": {
438 |     "prompt_tokens": 263,
439 |     "completion_tokens": 34,
440 |     "total_tokens": 297
441 |   },
442 |   "system_fingerprint": "lmstudio-community/qwen2.5-7b-instruct"
443 | }
444 | ```
445 | 
446 | In plain english, the above response can be thought of as the model saying:
447 | 
448 | > "Please call the `search_products` function, with arguments:
449 | >
450 | > - 'dell' for the `query` parameter,
451 | > - 'electronics' for the `category` parameter
452 | > - '50' for the `max_price` parameter
453 | >
454 | > and give me back the results"
455 | 
456 | The `tool_calls` field will need to be parsed to call actual functions/APIs. The below examples demonstrate how.
457 | 
458 | <br>
459 | 
460 | ## Examples using `python`
461 | 
462 | Tool use shines when paired with program languages like python, where you can implement the functions specified in the `tools` field to programmatically call them when the model requests.
463 | 
464 | ### Single-turn example
465 | 
466 | Below is a simple single-turn (model is only called once) example of enabling a model to call a function called `say_hello` that prints a hello greeting to the console:
467 | 
468 | `single-turn-example.py`
469 | 
470 | ```python
471 | from openai import OpenAI
472 | 
473 | # Connect to LM Studio
474 | client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")
475 | 
476 | # Define a simple function
477 | def say_hello(name: str) -> str:
478 |     print(f"Hello, {name}!")
479 | 
480 | # Tell the AI about our function
481 | tools = [
482 |     {
483 |         "type": "function",
484 |         "function": {
485 |             "name": "say_hello",
486 |             "description": "Says hello to someone",
487 |             "parameters": {
488 |                 "type": "object",
489 |                 "properties": {
490 |                     "name": {
491 |                         "type": "string",
492 |                         "description": "The person's name"
493 |                     }
494 |                 },
495 |                 "required": ["name"]
496 |             }
497 |         }
498 |     }
499 | ]
500 | 
501 | # Ask the AI to use our function
502 | response = client.chat.completions.create(
503 |     model="lmstudio-community/qwen2.5-7b-instruct",
504 |     messages=[{"role": "user", "content": "Can you say hello to Bob the Builder?"}],
505 |     tools=tools
506 | )
507 | 
508 | # Get the name the AI wants to use a tool to say hello to
509 | # (Assumes the AI has requested a tool call and that tool call is say_hello)
510 | tool_call = response.choices[0].message.tool_calls[0]
511 | name = eval(tool_call.function.arguments)["name"]
512 | 
513 | # Actually call the say_hello function
514 | say_hello(name) # Prints: Hello, Bob the Builder!
515 | 
516 | ```
517 | 
518 | Running this script from the console should yield results like:
519 | 
520 | ```xml
521 | -> % python single-turn-example.py
522 | Hello, Bob the Builder!
523 | ```
524 | 
525 | Play around with the name in
526 | 
527 | ```python
528 | messages=[{"role": "user", "content": "Can you say hello to Bob the Builder?"}]
529 | ```
530 | 
531 | to see the model call the `say_hello` function with different names.
532 | 
533 | ### Multi-turn example
534 | 
535 | Now for a slightly more complex example.
536 | 
537 | In this example, we'll:
538 | 
539 | 1. Enable the model to call a `get_delivery_date` function
540 | 2. Hand the result of calling that function back to the model, so that it can fulfill the user's request in plain text
541 | 
542 | <details>
543 | <summary><code>multi-turn-example.py</code> (click to expand) </summary>
544 | 
545 | ```python
546 | from datetime import datetime, timedelta
547 | import json
548 | import random
549 | from openai import OpenAI
550 | 
551 | # Point to the local server
552 | client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")
553 | model = "lmstudio-community/qwen2.5-7b-instruct"
554 | 
555 | 
556 | def get_delivery_date(order_id: str) -> datetime:
557 |     # Generate a random delivery date between today and 14 days from now
558 |     # in a real-world scenario, this function would query a database or API
559 |     today = datetime.now()
560 |     random_days = random.randint(1, 14)
561 |     delivery_date = today + timedelta(days=random_days)
562 |     print(
563 |         f"\nget_delivery_date function returns delivery date:\n\n{delivery_date}",
564 |         flush=True,
565 |     )
566 |     return delivery_date
567 | 
568 | 
569 | tools = [
570 |     {
571 |         "type": "function",
572 |         "function": {
573 |             "name": "get_delivery_date",
574 |             "description": "Get the delivery date for a customer's order. Call this whenever you need to know the delivery date, for example when a customer asks 'Where is my package'",
575 |             "parameters": {
576 |                 "type": "object",
577 |                 "properties": {
578 |                     "order_id": {
579 |                         "type": "string",
580 |                         "description": "The customer's order ID.",
581 |                     },
582 |                 },
583 |                 "required": ["order_id"],
584 |                 "additionalProperties": False,
585 |             },
586 |         },
587 |     }
588 | ]
589 | 
590 | messages = [
591 |     {
592 |         "role": "system",
593 |         "content": "You are a helpful customer support assistant. Use the supplied tools to assist the user.",
594 |     },
595 |     {
596 |         "role": "user",
597 |         "content": "Give me the delivery date and time for order number 1017",
598 |     },
599 | ]
600 | 
601 | # LM Studio
602 | response = client.chat.completions.create(
603 |     model=model,
604 |     messages=messages,
605 |     tools=tools,
606 | )
607 | 
608 | print("\nModel response requesting tool call:\n", flush=True)
609 | print(response, flush=True)
610 | 
611 | # Extract the arguments for get_delivery_date
612 | # Note this code assumes we have already determined that the model generated a function call.
613 | tool_call = response.choices[0].message.tool_calls[0]
614 | arguments = json.loads(tool_call.function.arguments)
615 | 
616 | order_id = arguments.get("order_id")
617 | 
618 | # Call the get_delivery_date function with the extracted order_id
619 | delivery_date = get_delivery_date(order_id)
620 | 
621 | assistant_tool_call_request_message = {
622 |     "role": "assistant",
623 |     "tool_calls": [
624 |         {
625 |             "id": response.choices[0].message.tool_calls[0].id,
626 |             "type": response.choices[0].message.tool_calls[0].type,
627 |             "function": response.choices[0].message.tool_calls[0].function,
628 |         }
629 |     ],
630 | }
631 | 
632 | # Create a message containing the result of the function call
633 | function_call_result_message = {
634 |     "role": "tool",
635 |     "content": json.dumps(
636 |         {
637 |             "order_id": order_id,
638 |             "delivery_date": delivery_date.strftime("%Y-%m-%d %H:%M:%S"),
639 |         }
640 |     ),
641 |     "tool_call_id": response.choices[0].message.tool_calls[0].id,
642 | }
643 | 
644 | # Prepare the chat completion call payload
645 | completion_messages_payload = [
646 |     messages[0],
647 |     messages[1],
648 |     assistant_tool_call_request_message,
649 |     function_call_result_message,
650 | ]
651 | 
652 | # Call the OpenAI API's chat completions endpoint to send the tool call result back to the model
653 | # LM Studio
654 | response = client.chat.completions.create(
655 |     model=model,
656 |     messages=completion_messages_payload,
657 | )
658 | 
659 | print("\nFinal model response with knowledge of the tool call result:\n", flush=True)
660 | print(response.choices[0].message.content, flush=True)
661 | 
662 | ```
663 | 
664 | </details>
665 | 
666 | Running this script from the console should yield results like:
667 | 
668 | ```xml
669 | -> % python multi-turn-example.py
670 | 
671 | Model response requesting tool call:
672 | 
673 | ChatCompletion(id='chatcmpl-wwpstqqu94go4hvclqnpwn', choices=[Choice(finish_reason='tool_calls', index=0, logprobs=None, message=ChatCompletionMessage(content=None, refusal=None, role='assistant', function_call=None, tool_calls=[ChatCompletionMessageToolCall(id='377278620', function=Function(arguments='{"order_id":"1017"}', name='get_delivery_date'), type='function')]))], created=1730916196, model='lmstudio-community/qwen2.5-7b-instruct', object='chat.completion', service_tier=None, system_fingerprint='lmstudio-community/qwen2.5-7b-instruct', usage=CompletionUsage(completion_tokens=24, prompt_tokens=223, total_tokens=247, completion_tokens_details=None, prompt_tokens_details=None))
674 | 
675 | get_delivery_date function returns delivery date:
676 | 
677 | 2024-11-19 13:03:17.773298
678 | 
679 | Final model response with knowledge of the tool call result:
680 | 
681 | Your order number 1017 is scheduled for delivery on November 19, 2024, at 13:03 PM.
682 | ```
683 | 
684 | ### Advanced agent example
685 | 
686 | Building upon the principles above, we can combine LM Studio models with locally defined functions to create an "agent" - a system that pairs a language model with custom functions to understand requests and perform actions beyond basic text generation.
687 | 
688 | The agent in the below example can:
689 | 
690 | 1. Open safe urls in your default browser
691 | 2. Check the current time
692 | 3. Analyze directories in your file system
693 | 
694 | <details>
695 | <summary><code>agent-chat-example.py</code> (click to expand) </summary>
696 | 
697 | ```python
698 | import json
699 | from urllib.parse import urlparse
700 | import webbrowser
701 | from datetime import datetime
702 | import os
703 | from openai import OpenAI
704 | 
705 | # Point to the local server
706 | client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")
707 | model = "lmstudio-community/qwen2.5-7b-instruct"
708 | 
709 | 
710 | def is_valid_url(url: str) -> bool:
711 | 
712 |     try:
713 |         result = urlparse(url)
714 |         return bool(result.netloc)  # Returns True if there's a valid network location
715 |     except Exception:
716 |         return False
717 | 
718 | 
719 | def open_safe_url(url: str) -> dict:
720 |     # List of allowed domains (expand as needed)
721 |     SAFE_DOMAINS = {
722 |         "lmstudio.ai",
723 |         "github.com",
724 |         "google.com",
725 |         "wikipedia.org",
726 |         "weather.com",
727 |         "stackoverflow.com",
728 |         "python.org",
729 |         "docs.python.org",
730 |     }
731 | 
732 |     try:
733 |         # Add http:// if no scheme is present
734 |         if not url.startswith(('http://', 'https://')):
735 |             url = 'http://' + url
736 | 
737 |         # Validate URL format
738 |         if not is_valid_url(url):
739 |             return {"status": "error", "message": f"Invalid URL format: {url}"}
740 | 
741 |         # Parse the URL and check domain
742 |         parsed_url = urlparse(url)
743 |         domain = parsed_url.netloc.lower()
744 |         base_domain = ".".join(domain.split(".")[-2:])
745 | 
746 |         if base_domain in SAFE_DOMAINS:
747 |             webbrowser.open(url)
748 |             return {"status": "success", "message": f"Opened {url} in browser"}
749 |         else:
750 |             return {
751 |                 "status": "error",
752 |                 "message": f"Domain {domain} not in allowed list",
753 |             }
754 |     except Exception as e:
755 |         return {"status": "error", "message": str(e)}
756 | 
757 | 
758 | def get_current_time() -> dict:
759 |     """Get the current system time with timezone information"""
760 |     try:
761 |         current_time = datetime.now()
762 |         timezone = datetime.now().astimezone().tzinfo
763 |         formatted_time = current_time.strftime("%Y-%m-%d %H:%M:%S %Z")
764 |         return {
765 |             "status": "success",
766 |             "time": formatted_time,
767 |             "timezone": str(timezone),
768 |             "timestamp": current_time.timestamp(),
769 |         }
770 |     except Exception as e:
771 |         return {"status": "error", "message": str(e)}
772 | 
773 | 
774 | def analyze_directory(path: str = ".") -> dict:
775 |     """Count and categorize files in a directory"""
776 |     try:
777 |         stats = {
778 |             "total_files": 0,
779 |             "total_dirs": 0,
780 |             "file_types": {},
781 |             "total_size_bytes": 0,
782 |         }
783 | 
784 |         for entry in os.scandir(path):
785 |             if entry.is_file():
786 |                 stats["total_files"] += 1
787 |                 ext = os.path.splitext(entry.name)[1].lower() or "no_extension"
788 |                 stats["file_types"][ext] = stats["file_types"].get(ext, 0) + 1
789 |                 stats["total_size_bytes"] += entry.stat().st_size
790 |             elif entry.is_dir():
791 |                 stats["total_dirs"] += 1
792 |                 # Add size of directory contents
793 |                 for root, _, files in os.walk(entry.path):
794 |                     for file in files:
795 |                         try:
796 |                             stats["total_size_bytes"] += os.path.getsize(os.path.join(root, file))
797 |                         except (OSError, FileNotFoundError):
798 |                             continue
799 | 
800 |         return {"status": "success", "stats": stats, "path": os.path.abspath(path)}
801 |     except Exception as e:
802 |         return {"status": "error", "message": str(e)}
803 | 
804 | 
805 | tools = [
806 |     {
807 |         "type": "function",
808 |         "function": {
809 |             "name": "open_safe_url",
810 |             "description": "Open a URL in the browser if it's deemed safe",
811 |             "parameters": {
812 |                 "type": "object",
813 |                 "properties": {
814 |                     "url": {
815 |                         "type": "string",
816 |                         "description": "The URL to open",
817 |                     },
818 |                 },
819 |                 "required": ["url"],
820 |             },
821 |         },
822 |     },
823 |     {
824 |         "type": "function",
825 |         "function": {
826 |             "name": "get_current_time",
827 |             "description": "Get the current system time with timezone information",
828 |             "parameters": {
829 |                 "type": "object",
830 |                 "properties": {},
831 |                 "required": [],
832 |             },
833 |         },
834 |     },
835 |     {
836 |         "type": "function",
837 |         "function": {
838 |             "name": "analyze_directory",
839 |             "description": "Analyze the contents of a directory, counting files and folders",
840 |             "parameters": {
841 |                 "type": "object",
842 |                 "properties": {
843 |                     "path": {
844 |                         "type": "string",
845 |                         "description": "The directory path to analyze. Defaults to current directory if not specified.",
846 |                     },
847 |                 },
848 |                 "required": [],
849 |             },
850 |         },
851 |     },
852 | ]
853 | 
854 | 
855 | def process_tool_calls(response, messages):
856 |     """Process multiple tool calls and return the final response and updated messages"""
857 |     # Get all tool calls from the response
858 |     tool_calls = response.choices[0].message.tool_calls
859 | 
860 |     # Create the assistant message with tool calls
861 |     assistant_tool_call_message = {
862 |         "role": "assistant",
863 |         "tool_calls": [
864 |             {
865 |                 "id": tool_call.id,
866 |                 "type": tool_call.type,
867 |                 "function": tool_call.function,
868 |             }
869 |             for tool_call in tool_calls
870 |         ],
871 |     }
872 | 
873 |     # Add the assistant's tool call message to the history
874 |     messages.append(assistant_tool_call_message)
875 | 
876 |     # Process each tool call and collect results
877 |     tool_results = []
878 |     for tool_call in tool_calls:
879 |         # For functions with no arguments, use empty dict
880 |         arguments = (
881 |             json.loads(tool_call.function.arguments)
882 |             if tool_call.function.arguments.strip()
883 |             else {}
884 |         )
885 | 
886 |         # Determine which function to call based on the tool call name
887 |         if tool_call.function.name == "open_safe_url":
888 |             result = open_safe_url(arguments["url"])
889 |         elif tool_call.function.name == "get_current_time":
890 |             result = get_current_time()
891 |         elif tool_call.function.name == "analyze_directory":
892 |             path = arguments.get("path", ".")
893 |             result = analyze_directory(path)
894 |         else:
895 |             # llm tried to call a function that doesn't exist, skip
896 |             continue
897 | 
898 |         # Add the result message
899 |         tool_result_message = {
900 |             "role": "tool",
901 |             "content": json.dumps(result),
902 |             "tool_call_id": tool_call.id,
903 |         }
904 |         tool_results.append(tool_result_message)
905 |         messages.append(tool_result_message)
906 | 
907 |     # Get the final response
908 |     final_response = client.chat.completions.create(
909 |         model=model,
910 |         messages=messages,
911 |     )
912 | 
913 |     return final_response
914 | 
915 | 
916 | def chat():
917 |     messages = [
918 |         {
919 |             "role": "system",
920 |             "content": "You are a helpful assistant that can open safe web links, tell the current time, and analyze directory contents. Use these capabilities whenever they might be helpful.",
921 |         }
922 |     ]
923 | 
924 |     print(
925 |         "Assistant: Hello! I can help you open safe web links, tell you the current time, and analyze directory contents. What would you like me to do?"
926 |     )
927 |     print("(Type 'quit' to exit)")
928 | 
929 |     while True:
930 |         # Get user input
931 |         user_input = input("\nYou: ").strip()
932 | 
933 |         # Check for quit command
934 |         if user_input.lower() == "quit":
935 |             print("Assistant: Goodbye!")
936 |             break
937 | 
938 |         # Add user message to conversation
939 |         messages.append({"role": "user", "content": user_input})
940 | 
941 |         try:
942 |             # Get initial response
943 |             response = client.chat.completions.create(
944 |                 model=model,
945 |                 messages=messages,
946 |                 tools=tools,
947 |             )
948 | 
949 |             # Check if the response includes tool calls
950 |             if response.choices[0].message.tool_calls:
951 |                 # Process all tool calls and get final response
952 |                 final_response = process_tool_calls(response, messages)
953 |                 print("\nAssistant:", final_response.choices[0].message.content)
954 | 
955 |                 # Add assistant's final response to messages
956 |                 messages.append(
957 |                     {
958 |                         "role": "assistant",
959 |                         "content": final_response.choices[0].message.content,
960 |                     }
961 |                 )
962 |             else:
963 |                 # If no tool call, just print the response
964 |                 print("\nAssistant:", response.choices[0].message.content)
965 | 
966 |                 # Add assistant's response to messages
967 |                 messages.append(
968 |                     {
969 |                         "role": "assistant",
970 |                         "content": response.choices[0].message.content,
971 |                     }
972 |                 )
973 | 
974 |         except Exception as e:
975 |             print(f"\nAn error occurred: {str(e)}")
976 |             exit(1)
977 | 
978 | 
979 | if __name__ == "__main__":
980 |     chat()
981 | 
982 | ```
983 | 
984 | </details>
985 | 
986 | Running this script from the console will allow you to chat with the agent:
987 | 
988 | ```xml
989 | -> % python agent-example.py
990 | Assistant: Hello! I can help you open safe web links, tell you the current time, and analyze directory contents. What would you like me to do?
991 | (Type 'quit' to exit)
992 | 
993 | You: What time is it?
994 | 
995 | Assistant: The current time is 14:11:40 (EST) as of November 6, 2024.
996 | 
997 | You: What time is it now?
998 | 
999 | Assistant: The current time is 14:13:59 (EST) as of November 6, 2024.
1000 | 
1001 | You: Open lmstudio.ai
1002 | 
1003 | Assistant: The link to lmstudio.ai has been opened in your default web browser.
1004 | 
1005 | You: What's in my current directory?
1006 | 
1007 | Assistant: Your current directory at `/Users/matt/project` contains a total of 14 files and 8 directories. Here's the breakdown:
1008 | 
1009 | - Files without an extension: 3
1010 | - `.mjs` files: 2
1011 | - `.ts` (TypeScript) files: 3
1012 | - Markdown (`md`) file: 1
1013 | - JSON files: 4
1014 | - TOML file: 1
1015 | 
1016 | The total size of these items is 1,566,990,604 bytes.
1017 | 
1018 | You: Thank you!
1019 | 
1020 | Assistant: You're welcome! If you have any other questions or need further assistance, feel free to ask.
1021 | 
1022 | You:
1023 | ```
1024 | 
1025 | ### Streaming
1026 | 
1027 | When streaming through `/v1/chat/completions` (`stream=true`), tool calls are sent in chunks. Function names and arguments are sent in pieces via `chunk.choices[0].delta.tool_calls.function.name` and `chunk.choices[0].delta.tool_calls.function.arguments`.
1028 | 
1029 | For example, to call `get_current_weather(location="San Francisco")`, the streamed `ChoiceDeltaToolCall` in each `chunk.choices[0].delta.tool_calls[0]` object will look like:
1030 | 
1031 | ```py
1032 | ChoiceDeltaToolCall(index=0, id='814890118', function=ChoiceDeltaToolCallFunction(arguments='', name='get_current_weather'), type='function')
1033 | ChoiceDeltaToolCall(index=0, id=None, function=ChoiceDeltaToolCallFunction(arguments='{"', name=None), type=None)
1034 | ChoiceDeltaToolCall(index=0, id=None, function=ChoiceDeltaToolCallFunction(arguments='location', name=None), type=None)
1035 | ChoiceDeltaToolCall(index=0, id=None, function=ChoiceDeltaToolCallFunction(arguments='":"', name=None), type=None)
1036 | ChoiceDeltaToolCall(index=0, id=None, function=ChoiceDeltaToolCallFunction(arguments='San Francisco', name=None), type=None)
1037 | ChoiceDeltaToolCall(index=0, id=None, function=ChoiceDeltaToolCallFunction(arguments='"}', name=None), type=None)
1038 | ```
1039 | 
1040 | These chunks must be accumulated throughout the stream to form the complete function signature for execution.
1041 | 
1042 | The below example shows how to create a simple tool-enhanced chatbot through the `/v1/chat/completions` streaming endpoint (`stream=true`).
1043 | 
1044 | <details>
1045 | <summary><code>tool-streaming-chatbot.py</code> (click to expand) </summary>
1046 | 
1047 | ```python
1048 | from openai import OpenAI
1049 | import time
1050 | 
1051 | client = OpenAI(base_url="http://127.0.0.1:1234/v1", api_key="lm-studio")
1052 | MODEL = "lmstudio-community/qwen2.5-7b-instruct"
1053 | 
1054 | TIME_TOOL = {
1055 |     "type": "function",
1056 |     "function": {
1057 |         "name": "get_current_time",
1058 |         "description": "Get the current time, only if asked",
1059 |         "parameters": {"type": "object", "properties": {}},
1060 |     },
1061 | }
1062 | 
1063 | def get_current_time():
1064 |     return {"time": time.strftime("%H:%M:%S")}
1065 | 
1066 | def process_stream(stream, add_assistant_label=True):
1067 |     """Handle streaming responses from the API"""
1068 |     collected_text = ""
1069 |     tool_calls = []
1070 |     first_chunk = True
1071 | 
1072 |     for chunk in stream:
1073 |         delta = chunk.choices[0].delta
1074 | 
1075 |         # Handle regular text output
1076 |         if delta.content:
1077 |             if first_chunk:
1078 |                 print()
1079 |                 if add_assistant_label:
1080 |                     print("Assistant:", end=" ", flush=True)
1081 |                 first_chunk = False
1082 |             print(delta.content, end="", flush=True)
1083 |             collected_text += delta.content
1084 | 
1085 |         # Handle tool calls
1086 |         elif delta.tool_calls:
1087 |             for tc in delta.tool_calls:
1088 |                 if len(tool_calls) <= tc.index:
1089 |                     tool_calls.append({
1090 |                         "id": "", "type": "function",
1091 |                         "function": {"name": "", "arguments": ""}
1092 |                     })
1093 |                 tool_calls[tc.index] = {
1094 |                     "id": (tool_calls[tc.index]["id"] + (tc.id or "")),
1095 |                     "type": "function",
1096 |                     "function": {
1097 |                         "name": (tool_calls[tc.index]["function"]["name"] + (tc.function.name or "")),
1098 |                         "arguments": (tool_calls[tc.index]["function"]["arguments"] + (tc.function.arguments or ""))
1099 |                     }
1100 |                 }
1101 |     return collected_text, tool_calls
1102 | 
1103 | def chat_loop():
1104 |     messages = []
1105 |     print("Assistant: Hi! I am an AI agent empowered with the ability to tell the current time (Type 'quit' to exit)")
1106 | 
1107 |     while True:
1108 |         user_input = input("\nYou: ").strip()
1109 |         if user_input.lower() == "quit":
1110 |             break
1111 | 
1112 |         messages.append({"role": "user", "content": user_input})
1113 | 
1114 |         # Get initial response
1115 |         response_text, tool_calls = process_stream(
1116 |             client.chat.completions.create(
1117 |                 model=MODEL,
1118 |                 messages=messages,
1119 |                 tools=[TIME_TOOL],
1120 |                 stream=True,
1121 |                 temperature=0.2
1122 |             )
1123 |         )
1124 | 
1125 |         if not tool_calls:
1126 |             print()
1127 | 
1128 |         text_in_first_response = len(response_text) > 0
1129 |         if text_in_first_response:
1130 |             messages.append({"role": "assistant", "content": response_text})
1131 | 
1132 |         # Handle tool calls if any
1133 |         if tool_calls:
1134 |             tool_name = tool_calls[0]["function"]["name"]
1135 |             print()
1136 |             if not text_in_first_response:
1137 |                 print("Assistant:", end=" ", flush=True)
1138 |             print(f"**Calling Tool: {tool_name}**")
1139 |             messages.append({"role": "assistant", "tool_calls": tool_calls})
1140 | 
1141 |             # Execute tool calls
1142 |             for tool_call in tool_calls:
1143 |                 if tool_call["function"]["name"] == "get_current_time":
1144 |                     result = get_current_time()
1145 |                     messages.append({
1146 |                         "role": "tool",
1147 |                         "content": str(result),
1148 |                         "tool_call_id": tool_call["id"]
1149 |                     })
1150 | 
1151 |             # Get final response after tool execution
1152 |             final_response, _ = process_stream(
1153 |                 client.chat.completions.create(
1154 |                     model=MODEL,
1155 |                     messages=messages,
1156 |                     stream=True
1157 |                 ),
1158 |                 add_assistant_label=False
1159 |             )
1160 | 
1161 |             if final_response:
1162 |                 print()
1163 |                 messages.append({"role": "assistant", "content": final_response})
1164 | 
1165 | if __name__ == "__main__":
1166 |     chat_loop()
1167 | ```
1168 | 
1169 | </details>
1170 | 
1171 | You can chat with the bot by running this script from the console:
1172 | 
1173 | ```xml
1174 | -> % python tool-streaming-chatbot.py
1175 | Assistant: Hi! I am an AI agent empowered with the ability to tell the current time (Type 'quit' to exit)
1176 | 
1177 | You: Tell me a joke, then tell me the current time
1178 | 
1179 | Assistant: Sure! Here's a light joke for you: Why don't scientists trust atoms? Because they make up everything.
1180 | 
1181 | Now, let me get the current time for you.
1182 | 
1183 | **Calling Tool: get_current_time**
1184 | 
1185 | The current time is 18:49:31. Enjoy your day!
1186 | 
1187 | You:
1188 | ```
1189 | 
1190 | ## Community
1191 | 
1192 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/4_api/ttl-and-auto-evict.md
```
1 | ---
2 | title: Idle TTL and Auto-Evict
3 | description: Optionally auto-unload idle models after a certain amount of time (TTL)
4 | index: 2
5 | ---
6 | 
7 | LM Studio 0.3.9 (b1) introduces the ability to set a _time-to-live_ (TTL) for API models, and optionally auto-evict previously loaded models before loading new ones.
8 | 
9 | These features complement LM Studio's [on-demand model loading (JIT)](https://lmstudio.ai/blog/lmstudio-v0.3.5#on-demand-model-loading) to automate efficient memory management and reduce the need for manual intervention.
10 | 
11 | ## Background
12 | 
13 | - `JIT loading` makes it easy to use your LM Studio models in other apps: you don't need to manually load the model first before being able to use it. However, this also means that models can stay loaded in memory even when they're not being used. `[Default: enabled]`
14 | 
15 | - (New) `Idle TTL` (technically: Time-To-Live) defines how long a model can stay loaded in memory without receiving any requests. When the TTL expires, the model is automatically unloaded from memory. You can set a TTL using the `ttl` field in your request payload. `[Default: 60 minutes]`
16 | 
17 | - (New) `Auto-Evict` is a feature that unloads previously JIT loaded models before loading new ones. This enables easy switching between models from client apps without having to manually unload them first. You can enable or disable this feature in Developer tab > Server Settings. `[Default: enabled]`
18 | 
19 | ## Idle TTL
20 | 
21 | **Use case**: imagine you're using an app like [Zed](https://github.com/zed-industries/zed/blob/main/crates/lmstudio/src/lmstudio.rs#L340), [Cline](https://github.com/cline/cline/blob/main/src/api/providers/lmstudio.ts), or [Continue.dev](https://docs.continue.dev/customize/model-providers/more/lmstudio) to interact with LLMs served by LM Studio. These apps leverage JIT to load models on-demand the first time you use them.
22 | 
23 | **Problem**: When you're not actively using a model, you might don't want it to remain loaded in memory.
24 | 
25 | **Solution**: Set a TTL for models loaded via API requests. The idle timer resets every time the model receives a request, so it won't disappear while you use it. A model is considered idle if it's not doing any work. When the idle TTL expires, the model is automatically unloaded from memory.
26 | 
27 | ### Set App-default Idle TTL
28 | 
29 | By default, JIT-loaded models have a TTL of 60 minutes. You can configure a default TTL value for any model loaded via JIT like so:
30 | 
31 | <img src="/assets/docs/app-default-ttl.png" style="width: 500px; " data-caption="Set a default TTL value. Will be used for all JIT loaded models unless specified otherwise in the request payload" />
32 | 
33 | ### Set per-model TTL-model in API requests
34 | 
35 | When JIT loading is enabled, the **first request** to a model will load it into memory. You can specify a TTL for that model in the request payload.
36 | 
37 | This works for requests targeting both the [OpenAI compatibility API](openai-api) and the [LM Studio's REST API](rest-api):
38 | 
39 | <br>
40 | 
41 | ```diff
42 | curl http://localhost:1234/api/v0/chat/completions \
43 |   -H "Content-Type: application/json" \
44 |   -d '{
45 |     "model": "deepseek-r1-distill-qwen-7b",
46 | +   "ttl": 300,
47 |     "messages": [ ... ]
48 | }'
49 | ```
50 | 
51 | ###### This will set a TTL of 5 minutes (300 seconds) for this model if it is JIT loaded.
52 | 
53 | ### Set TTL for models loaded with `lms`
54 | 
55 | By default, models loaded with `lms load` do not have a TTL, and will remain loaded in memory until you manually unload them.
56 | 
57 | You can set a TTL for a model loaded with `lms` like so:
58 | 
59 | ```bash
60 | lms load <model> --ttl 3600
61 | ```
62 | 
63 | ###### Load a `<model>` with a TTL of 1 hour (3600 seconds)
64 | 
65 | ### Specify TTL when loading models in the server tab
66 | 
67 | You can also set a TTL when loading a model in the server tab like so
68 | 
69 | <img src="/assets/docs/ttl-server-model.png" style="width: 100%;" data-caption="Set a TTL value when loading a model in the server tab" />
70 | 
71 | ## Configure Auto-Evict for JIT loaded models
72 | 
73 | With this setting, you can ensure new models loaded via JIT automatically unload previously loaded models first.
74 | 
75 | This is useful when you want to switch between models from another app without worrying about memory building up with unused models.
76 | 
77 | <img src="/assets/docs/auto-evict-and-ttl.png" style="width: 500px; margin-top:30px" data-caption="Enable or disable Auto-Evict for JIT loaded models in the Developer tab > Server Settings" />
78 | 
79 | **When Auto-Evict is ON** (default):
80 | 
81 | - At most `1` model is kept loaded in memory at a time (when loaded via JIT)
82 | - Non-JIT loaded models are not affected
83 | 
84 | **When Auto-Evict is OFF**:
85 | 
86 | - Switching models from an external app will keep previous models loaded in memory
87 | - Models will remain loaded until either:
88 |   - Their TTL expires
89 |   - You manually unload them
90 | 
91 | This feature works in tandem with TTL to provide better memory management for your workflow.
92 | 
93 | ### Nomenclature
94 | 
95 | `TTL`: Time-To-Live, is a term borrowed from networking protocols and cache systems. It defines how long a resource can remain allocated before it's considered stale and evicted.
```

0_app/5_advanced/_branching.md
```
1 | ---
2 | title: Branch conversation
3 | description: Fork, clone, and branch a conversation in LM Studio
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/5_advanced/_context.md
```
1 | ---
2 | title: Context construction
3 | description: Inserting Assistant and User messages to construct a conversation context for a given purpose
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/5_advanced/_errors.md
```
1 | ---
2 | title: Errors
3 | description: Common errors, what they mean, and how to fix them
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/5_advanced/_vision.md
```
1 | ---
2 | title: Image Input
3 | description: Using models that can understand image inputs
4 | ---
5 | 
6 | ### Page
7 | 
8 | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc nec suscipit ultricies, nunc nunc ultricies nunc, nec suscipit nunc nunc nec. Nullam.
```

0_app/5_advanced/import-model.md
```
1 | ---
2 | title: Import Models
3 | description: Use model files you've downloaded outside of LM Studio
4 | index: 6
5 | ---
6 | 
7 | You can use compatible models you've downloaded outside of LM Studio by placing them in the expected directory structure.
8 | 
9 | <hr>
10 | 
11 | ### Use `lms import` (experimental)
12 | 
13 | To import a `GGUF` model you've downloaded outside of LM Studio, run the following command in your terminal:
14 | 
15 | ```bash
16 | lms import <path/to/model.gguf>
17 | ```
18 | 
19 | ###### Follow the interactive prompt to complete the import process.
20 | 
21 | ### LM Studio's expected models directory structure
22 | 
23 | <img src="/assets/docs/reveal-models-dir.png" style="width:80%" data-caption="Manage your models directory in the My Models tab">
24 | 
25 | LM Studio aims to preserves the directory structure of models downloaded from Hugging Face. The expected directory structure is as follows:
26 | 
27 | ```xml
28 | ~/.lmstudio/models/
29 | └── publisher/
30 |     └── model/
31 |         └── model-file.gguf
32 | ```
33 | 
34 | For example, if you have a model named `ocelot-v1` published by `infra-ai`, the structure would look like this:
35 | 
36 | ```xml
37 | ~/.lmstudio/models/
38 | └── infra-ai/
39 |     └── ocelot-v1/
40 |         └── ocelot-v1-instruct-q4_0.gguf
41 | ```
42 | 
43 | <hr>
44 | 
45 | ### Community
46 | 
47 | Chat with other LM Studio users, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/5_advanced/per-model.md
```
1 | ---
2 | title: Per-model Defaults
3 | description: You can set default settings for each model in LM Studio
4 | ---
5 | 
6 | `Advanced`
7 | 
8 | You can set default load settings for each model in LM Studio.
9 | 
10 | When the model is loaded anywhere in the app (including through [`lms load`](/docs/cli#load-a-model-with-options)) these settings will be used.
11 | 
12 | <hr>
13 | 
14 | ### Setting default parameters for a model
15 | 
16 | Head to the My Models tab and click on the gear ⚙️ icon to edit the model's default parameters.
17 | 
18 | <img src="/assets/docs/model-settings-gear.png" style="width:80%" data-caption="Click on the gear icon to edit the default load settings for a model.">
19 | 
20 | This will open a dialog where you can set the default parameters for the model.
21 | 
22 | <video autoplay loop muted playsinline style="width:50%" data-caption="You can set the default parameters for a model in this dialog.">
23 |   <source src="https://files.lmstudio.ai/default-params.mp4" type="video/mp4">
24 |   Your browser does not support the video tag.
25 | </video>
26 | 
27 | Next time you load the model, these settings will be used.
28 | 
29 | 
30 | ```lms_protip
31 | #### Reasons to set default load parameters (not required, totally optional)
32 | 
33 | - Set a particular GPU offload settings for a given model
34 | - Set a particular context size for a given model
35 | - Whether or not to utilize Flash Attention for a given model
36 | 
37 | ```
38 | 
39 | 
40 | 
41 | 
42 | ## Advanced Topics
43 | 
44 | ### Changing load settings before loading a model
45 | 
46 | When you load a model, you can optionally change the default load settings.
47 | 
48 | <img src="/assets/docs/load-model.png" style="width:80%" data-caption="You can change the load settings before loading a model.">
49 | 
50 | ### Saving your changes as the default settings for a model
51 | 
52 | If you make changes to load settings when you load a model, you can save them as the default settings for that model.
53 | 
54 | <img src="/assets/docs/save-load-changes.png" style="width:80%" data-caption="If you make changes to load settings when you load a model, you can save them as the default settings for that model.">
55 | 
56 | 
57 | <hr>
58 | 
59 | ### Community
60 | Chat with other LM Studio power users, discuss configs, models, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/5_advanced/prompt-template.md
```
1 | ---
2 | title: Prompt Template
3 | description: "Optionally set or modify the model's prompt template"
4 | ---
5 | 
6 | `Advanced`
7 | 
8 | By default, LM Studio will automatically configure the prompt template based on the model file's metadata. 
9 | 
10 | However, you can customize the prompt template for any model.
11 | 
12 | <hr>
13 | 
14 | 
15 | ### Overriding the Prompt Template for a Specific Model
16 | 
17 | Head over to the My Models tab and click on the gear ⚙️ icon to edit the model's default parameters.
18 | ###### Pro tip: you can jump to the My Models tab from anywhere by pressing `⌘` + `3` on Mac, or `ctrl` + `3` on Windows / Linux.
19 | 
20 | ### Customize the Prompt Template
21 | 
22 | ###### 💡 In most cases you don't need to change the prompt template
23 | 
24 | When a model doesn't come with a prompt template information, LM Studio will surface the `Prompt Template` config box in the **🧪 Advanced Configuration** sidebar.
25 | 
26 | <img src="/assets/docs/prompt-template.png" style="width:80%" data-caption="The Prompt Template config box in the chat sidebar">
27 | 
28 | You can make this config box always show up by right clicking the sidebar and selecting **Always Show Prompt Template**.
29 | 
30 | ### Prompt template options
31 | 
32 | #### Jinja Template
33 | You can express the prompt template in Jinja.
34 | 
35 | ###### 💡 [Jinja](https://en.wikipedia.org/wiki/Jinja_(template_engine)) is a templating engine used to encode the prompt template in several popular LLM model file formats.
36 | 
37 | #### Manual
38 | 
39 | You can also express the prompt template manually by specifying message role prefixes and suffixes.
40 | 
41 | <hr>
42 | 
43 | #### Reasons you might want to edit the prompt template:
44 | 1. The model's metadata is incorrect, incomplete, or LM Studio doesn't recognize it
45 | 2. The model does not have a prompt template in its metadata (e.g. custom or older models)
46 | 3. You want to customize the prompt template for a specific use case
```

0_app/5_advanced/speculative-decoding.md
```
1 | ---
2 | title: Speculative Decoding
3 | description: "Speed up generation with a draft model"
4 | index: 1
5 | ---
6 | 
7 | `Advanced`
8 | 
9 | Speculative decoding is a technique that can substantially increase the generation speed of large language models (LLMs) without reducing response quality.
10 | 
11 | <hr>
12 | 
13 | ## What is Speculative Decoding
14 | 
15 | Speculative decoding relies on the collaboration of two models:
16 | 
17 | - A larger, "main" model
18 | - A smaller, faster "draft" model
19 | 
20 | During generation, the draft model rapidly proposes potential tokens (subwords), which the main model can verify faster than it would take it to generate them from scratch. To maintain quality, the main model only accepts tokens that match what it would have generated. After the last accepted draft token, the main model always generates one additional token.
21 | 
22 | For a model to be used as a draft model, it must have the same "vocabulary" as the main model.
23 | 
24 | ## How to enable Speculative Decoding
25 | 
26 | On `Power User` mode or higher, load a model, then select a `Draft Model` within the `Speculative Decoding` section of the chat sidebar:
27 | 
28 | <img src="/assets/docs/speculative-decoding-setting.png" style="width:80%; margin-top: 20px; border: 1px solid rgba(0,0,0,0.2);" data-caption="The Speculative Decoding section of the chat sidebar">
29 | 
30 | ### Finding compatible draft models
31 | 
32 | You might see the following when you open the dropdown:
33 | 
34 | <img src="/assets/docs/speculative-decoding-no-compatible.png" style="width:40%; margin-top: 20px; border: 1px solid rgba(0,0,0,0.2);" data-caption="No compatible draft models">
35 | 
36 | Try to download a lower parameter variant of the model you have loaded, if it exists. If no smaller versions of your model exist, find a pairing that does.
37 | 
38 | For example:
39 | 
40 | <center style="margin: 20px;">
41 | 
42 | |          Main Model          |          Draft Model          |
43 | | :--------------------------: | :---------------------------: |
44 | |    Llama 3.1 8B Instruct     |     Llama 3.2 1B Instruct     |
45 | |    Qwen 2.5 14B Instruct     |    Qwen 2.5 0.5B Instruct     |
46 | | DeepSeek R1 Distill Qwen 32B | DeepSeek R1 Distill Qwen 1.5B |
47 | 
48 | </center>
49 | 
50 | Once you have both a main and draft model loaded, simply begin chatting to enable speculative decoding.
51 | 
52 | ## Key factors affecting performance
53 | 
54 | Speculative decoding speed-up is generally dependent on two things:
55 | 
56 | 1. How small and fast the _draft model_ is compared with the _main model_
57 | 2. How often the draft model is able to make "good" suggestions
58 | 
59 | In simple terms, you want to choose a draft model that's much smaller than the main model. And some prompts will work better than others.
60 | 
61 | ### An important trade-off
62 | 
63 | Running a draft model alongside a main model to enable speculative decoding requires more **computation and resources** than running the main model on its own.
64 | 
65 | The key to faster generation of the main model is choosing a draft model that's both small and capable enough.
66 | 
67 | Here are general guidelines for the **maximum** draft model size you should select based on main model size (in parameters):
68 | 
69 | <center style="margin: 20px;">
70 | 
71 | | Main Model Size | Max Draft Model Size to Expect Speed-Ups |
72 | | :-------------: | :--------------------------------------: |
73 | |       3B        |                    -                     |
74 | |       7B        |                    1B                    |
75 | |       14B       |                    3B                    |
76 | |       32B       |                    7B                    |
77 | 
78 | </center>
79 | 
80 | Generally, the larger the size difference is between the main model and the draft model, the greater the speed-up.
81 | 
82 | Note: if the draft model is not fast enough or effective enough at making "good" suggestions to the main model, the generation speed will not increase, and could actually decrease.
83 | 
84 | ### Prompt dependent
85 | 
86 | One thing you will likely notice when using speculative decoding is that the generation speed is not consistent across all prompts.
87 | 
88 | The reason that the speed-up is not consistent across all prompts is because for some prompts, the draft model is less likely to make "good" suggestions to the main model.
89 | 
90 | Here are some extreme examples that illustrate this concept:
91 | 
92 | #### 1. Discrete Example: Mathematical Question
93 | 
94 | Prompt: "What is the quadratic equation formula?"
95 | 
96 | In this case, both a 70B model and a 0.5B model are both very likely to give the standard formula `x = (-b ± √(b² - 4ac))/(2a)`. So if the draft model suggested this formula as the next tokens, the target model would likely accept it, making this an ideal case for speculative decoding to work efficiently.
97 | 
98 | #### 2. Creative Example: Story Generation
99 | 
100 | Prompt: "Write a story that begins: 'The door creaked open...'"
101 | 
102 | In this case, the smaller model's draft tokens are likely be rejected more often by the larger model, as each next word could branch into countless valid possibilities.
103 | 
104 | While "4" is the only reasonable answer to "2+2", this story could continue with "revealing a monster", "as the wind howled", "and Sarah froze", or hundreds of other perfectly valid continuations, making the smaller model's specific word predictions much less likely to match the larger
105 | model's choices.
```

0_app/6_user-interface/languages.md
```
1 | ---
2 | title: LM Studio in your language
3 | sidebar_title: Languages
4 | description: LM Studio is available in English, Chinese, Spanish, French, German, Korean, Russian, and 26+ more languages.
5 | ---
6 | 
7 | LM Studio is available in `English`, `Spanish`, `Japanese`, `Chinese`, `German`, `Norwegian`, `Turkish`, `Russian`, `Korean`, `Polish`, `Vietnamese`, `Czech`, `Ukrainian`, `Portuguese (BR,PT)` and many more languages thanks to incredible  community localizers.
8 | 
9 | <hr>
10 | 
11 | ### Selecting a Language
12 | 
13 | You can choose a language in the Settings tab.
14 | 
15 | Use the dropdown menu under Preferences > Language.
16 | 
17 | ```lms_protip
18 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
19 | ```
20 | 
21 | ###### To get to the Settings page, you need to be on [Power User mode](/docs/modes) or higher.
22 | 
23 | <hr>
24 | 
25 | #### Big thank you to community localizers 🙏
26 | 
27 | - Spanish [@xtianpaiva](https://github.com/xtianpaiva), [@AlexisGross](https://github.com/AlexisGross), [@Tonband](https://github.com/Tonband)
28 | - Norwegian [@Exlo84](https://github.com/Exlo84)
29 | - German [@marcelMaier](https://github.com/marcelMaier), [@Goekdeniz-Guelmez](https://github.com/Goekdeniz-Guelmez)
30 | - Romanian (ro) [@alexandrughinea](https://github.com/alexandrughinea)
31 | - Turkish (tr) [@progesor](https://github.com/progesor), [@nossbar](https://github.com/nossbar)
32 | - Russian [@shelomitsky](https://github.com/shelomitsky), [@mlatysh](https://github.com/mlatysh), [@Adjacentai](https://github.com/Adjacentai), [@HostFly](https://github.com/HostFly), [@MotyaDev](https://github.com/MotyaDev), [@Autumn-Whisper](https://github.com/Autumn-Whisper), [@seropheem](https://github.com/seropheem)
33 | - Korean [@williamjeong2](https://github.com/williamjeong2)
34 | - Polish [@danieltechdev](https://github.com/danieltechdev)
35 | - Czech [@ladislavsulc](https://github.com/ladislavsulc)
36 | - Vietnamese [@trinhvanminh](https://github.com/trinhvanminh), [@godkyo98](https://github.com/godkyo98)
37 | - Portuguese (BR) [@Sm1g00l](https://github.com/Sm1g00l), [@altiereslima](https://github.com/altiereslima)
38 | - Portuguese (PT) [@catarino](https://github.com/catarino)
39 | - Chinese (zh-CN) [@neotan](https://github.com/neotan), [@SweetDream0256](https://github.com/SweetDream0256), [@enKl03B](https://github.com/enKl03B), [@evansrrr](https://github.com/evansrrr), [@xkonglong](https://github.com/xkonglong), [@shadow01a](https://github.com/shadow01a)
40 | - Chinese (zh-HK), (zh-TW) [@neotan](https://github.com/neotan), [ceshizhuanyong895](https://github.com/ceshizhuanyong895), [@BrassaiKao](https://github.com/BrassaiKao)
41 | - Chinese (zh-Hant) [@kywarai](https://github.com/kywarai), [ceshizhuanyong895](https://github.com/ceshizhuanyong895)
42 | - Ukrainian (uk) [@hmelenok](https://github.com/hmelenok)
43 | - Japanese (ja) [@digitalsp](https://github.com/digitalsp)
44 | - Dutch (nl) [@alaaf11](https://github.com/alaaf11)
45 | - Italian (it) [@fralapo](https://github.com/fralapo), [@Bl4ck-D0g](https://github.com/Bl4ck-D0g), [@nikypalma](https://github.com/nikypalma)
46 | - Indonesian (id) [@dwirx](https://github.com/dwirx)
47 | - Greek (gr) [@ilikecatgirls](https://github.com/ilikecatgirls)
48 | - Swedish (sv) [@reinew](https://github.com/reinew)
49 | - Catalan (ca) [@Gopro3010](https://github.com/Gopro3010)
50 | - French [@Plexi09](https://github.com/Plexi09)
51 | - Finnish (fi) [@divergentti](https://github.com/divergentti)
52 | - Bengali (bn) [@AbiruzzamanMolla](https://github.com/AbiruzzamanMolla)
53 | - Malayalam (ml) [@prasanthc41m](https://github.com/prasanthc41m)
54 | - Thai (th) [@gnoparus](https://github.com/gnoparus)
55 | - Bosnian (bs) [@0haris0](https://github.com/0haris0)
56 | - Bulgarian (bg) [@DenisZekiria](https://github.com/DenisZekiria)
57 | - Hindi (hi) [@suhailtajshaik](https://github.com/suhailtajshaik)
58 | - Hungarian (hu) [@Mekemoka](https://github.com/Mekemoka)
59 | - Persian (Farsi) (fa) [@mohammad007kh](https://github.com/mohammad007kh), [@darwindev](https://github.com/darwindev)
60 | - Arabic (ar) [@haqbany](https://github.com/haqbany)
61 | 
62 | Still under development (due to lack of RTL support in LM Studio)
63 | 
64 | - Hebrew: [@NHLOCAL](https://github.com/NHLOCAL)
65 | 
66 | #### Contributing to LM Studio localization
67 | 
68 | If you want to improve existing translations or contribute new ones, you're more than welcome to jump in.
69 | 
70 | LM Studio strings are maintained in https://github.com/lmstudio-ai/localization.
71 | 
72 | See instructions for contributing [here](https://github.com/lmstudio-ai/localization/blob/main/README.md).
```

0_app/6_user-interface/modes.md
```
1 | ---
2 | title: User, Power User, or Developer
3 | sidebar_title: UI Modes
4 | description: Hide or reveal advanced features
5 | ---
6 | 
7 | Starting LM Studio 0.3.0, you can switch between the following modes:
8 | 
9 | - **User**
10 | - **Power User**
11 | - **Developer**
12 | 
13 | <hr>
14 | 
15 | ### Selecting a Mode
16 | 
17 | You can configure LM Studio to run in increasing levels of configurability.
18 | 
19 | Select between User, Power User, and Developer.
20 | 
21 | <img src="/assets/docs/modes.png" style="width: 500px; margin-top:30px" data-caption="Choose a mode at the bottom of the app" />
22 | 
23 | ### Which mode should I choose?
24 | 
25 | #### `User`
26 | 
27 | Show only the chat interface, and auto-configure everything. This is the best choice for beginners or anyone who's happy with the default settings.
28 | 
29 | #### `Power User`
30 | 
31 | Use LM Studio in this mode if you want access to configurable [load](/docs/configuration/load) and [inference](/docs/configuration/inference) parameters as well as advanced chat features such as [insert, edit, &amp; continue](/docs/advanced/context) (for either role, user or assistant).
32 | 
33 | #### `Developer`
34 | 
35 | Full access to all aspects in LM Studio. This includes keyboard shortcuts and development features. Check out the Developer section under Settings for more.
```

0_app/6_user-interface/themes.md
```
1 | ---
2 | title: Color Themes
3 | description: Customize LM Studio's color theme
4 | ---
5 | 
6 | LM Studio comes with a few built-in themes for app-wide color palettes.
7 | 
8 | <hr>
9 | 
10 | ### Selecting a Theme
11 | 
12 | You can choose a theme in the Settings tab. 
13 | 
14 | Choosing the "Auto" option will automatically switch between Light and Dark themes based on your system settings.
15 | 
16 | ```lms_protip
17 | You can jump to Settings from anywhere in the app by pressing `cmd` + `,` on macOS or `ctrl` + `,` on Windows/Linux.
18 | ```
19 | ###### To get to the Settings page, you need to be on [Power User mode](/docs/modes) or higher.
20 | 
```

1_python/1_llm-prediction/_index.md
```
1 | ---
2 | title: Predicting with LLMs
3 | sidebar_title: Overview
4 | description: APIs to predict with LLMs managed by LM Studio.
5 | index: 1
6 | ---
7 | 
8 | Something about how MLX and llama.cpp engines are chosen automatically based on the model you're using.
9 | 
10 | TODO: ...
```

1_python/1_llm-prediction/cancelling-predictions.md
```
1 | ---
2 | title: Cancelling Predictions
3 | description: Stop an ongoing prediction in `lmstudio-python`
4 | ---
5 | 
6 | One benefit of using the streaming API is the ability to cancel the
7 | prediction request based on criteria that can't be represented using
8 | the `stopStrings` or `maxPredictedTokens` configuration settings.
9 | 
10 | The following snippet illustrates cancelling the request in response
11 | to an application specification cancellation condition (such as polling
12 | an event set by another thread).
13 | 
14 | ```lms_code_snippet
15 |   variants:
16 |     "Python (convenience API)":
17 |       language: python
18 |       code: |
19 |         import lmstudio as lms
20 |         model = lms.llm()
21 | 
22 |         prediction_stream = model.respond_stream("What is the meaning of life?")
23 |         cancelled = False
24 |         for fragment in prediction_stream:
25 |             if ...: # Cancellation condition will be app specific
26 |                 cancelled = True
27 |                 prediction_stream.cancel()
28 |                 # Note: it is recommended to let the iteration complete,
29 |                 # as doing so allows the partial result to be recorded.
30 |                 # Breaking the loop *is* permitted, but means the partial result
31 |                 # and final prediction stats won't be available to the client
32 |         # The stream allows the prediction result to be retrieved after iteration
33 |         if not cancelled:
34 |             print(prediction_stream.result())
35 | 
36 |     "Python (scoped resource API)":
37 |       language: python
38 |       code: |
39 |         import lmstudio as lms
40 | 
41 |         with lms.Client() as client:
42 |             model = client.llm.model()
43 | 
44 |             prediction_stream = model.respond_stream("What is the meaning of life?")
45 |             cancelled = False
46 |             for fragment in prediction_stream:
47 |                 if ...: # Cancellation condition will be app specific
48 |                     cancelled = True
49 |                     prediction_stream.cancel()
50 |                     # Note: it is recommended to let the iteration complete,
51 |                     # as doing so allows the partial result to be recorded.
52 |                     # Breaking the loop *is* permitted, but means the partial result
53 |                     # and final prediction stats won't be available to the client
54 |             # The stream allows the prediction result to be retrieved after iteration
55 |             if not cancelled:
56 |                 print(prediction_stream.result())
57 | 
58 |     "Python (asynchronous API)":
59 |       language: python
60 |       code: |
61 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
62 |         # Requires Python SDK version 1.5.0 or later
63 |         import lmstudio as lms
64 | 
65 |         async with lms.AsyncClient() as client:
66 |             model = await client.llm.model()
67 | 
68 |             prediction_stream = await model.respond_stream("What is the meaning of life?")
69 |             cancelled = False
70 |             async for fragment in prediction_stream:
71 |                 if ...: # Cancellation condition will be app specific
72 |                     cancelled = True
73 |                     await prediction_stream.cancel()
74 |                     # Note: it is recommended to let the iteration complete,
75 |                     # as doing so allows the partial result to be recorded.
76 |                     # Breaking the loop *is* permitted, but means the partial result
77 |                     # and final prediction stats won't be available to the client
78 |             # The stream allows the prediction result to be retrieved after iteration
79 |             if not cancelled:
80 |                 print(prediction_stream.result())
81 | 
82 | ```
```

1_python/1_llm-prediction/chat-completion.md
```
1 | ---
2 | title: Chat Completions
3 | sidebar_title: Chat
4 | description: APIs for a multi-turn chat conversations with an LLM
5 | index: 2
6 | ---
7 | 
8 | Use `llm.respond(...)` to generate completions for a chat conversation.
9 | 
10 | ## Quick Example: Generate a Chat Response
11 | 
12 | The following snippet shows how to obtain the AI's response to a quick chat prompt.
13 | 
14 | ```lms_code_snippet
15 |   variants:
16 |     "Python (convenience API)":
17 |       language: python
18 |       code: |
19 |         import lmstudio as lms
20 | 
21 |         model = lms.llm()
22 |         print(model.respond("What is the meaning of life?"))
23 | 
24 |     "Python (scoped resource API)":
25 |       language: python
26 |       code: |
27 |         import lmstudio as lms
28 | 
29 |         with lms.Client() as client:
30 |             model = client.llm.model()
31 |             print(model.respond("What is the meaning of life?"))
32 | 
33 |     "Python (asynchronous API)":
34 |       language: python
35 |       code: |
36 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
37 |         # Requires Python SDK version 1.5.0 or later
38 |         import lmstudio as lms
39 | 
40 |         async with lms.AsyncClient() as client:
41 |             model = await client.llm.model()
42 |             print(await model.respond("What is the meaning of life?"))
43 | 
44 | ```
45 | 
46 | ## Streaming a Chat Response
47 | 
48 | The following snippet shows how to stream the AI's response to a chat prompt,
49 | displaying text fragments as they are received (rather than waiting for the
50 | entire response to be generated before displaying anything).
51 | 
52 | ```lms_code_snippet
53 |   variants:
54 |     "Python (convenience API)":
55 |       language: python
56 |       code: |
57 |         import lmstudio as lms
58 |         model = lms.llm()
59 | 
60 |         for fragment in model.respond_stream("What is the meaning of life?"):
61 |             print(fragment.content, end="", flush=True)
62 |         print() # Advance to a new line at the end of the response
63 | 
64 |     "Python (scoped resource API)":
65 |       language: python
66 |       code: |
67 |         import lmstudio as lms
68 | 
69 |         with lms.Client() as client:
70 |             model = client.llm.model()
71 | 
72 |             for fragment in model.respond_stream("What is the meaning of life?"):
73 |                 print(fragment.content, end="", flush=True)
74 |             print() # Advance to a new line at the end of the response
75 | 
76 |     "Python (asynchronous API)":
77 |       language: python
78 |       code: |
79 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
80 |         # Requires Python SDK version 1.5.0 or later
81 |         import lmstudio as lms
82 | 
83 |         async with lms.AsyncClient() as client:
84 |             model = await client.llm.model()
85 | 
86 |             async for fragment in model.respond_stream("What is the meaning of life?"):
87 |                 print(fragment.content, end="", flush=True)
88 |             print() # Advance to a new line at the end of the response
89 | 
90 | ```
91 | 
92 | ## Cancelling a Chat Response
93 | 
94 | See the [Cancelling a Prediction](./cancelling-predictions) section for how to cancel a prediction in progress.
95 | 
96 | ## Obtain a Model
97 | 
98 | First, you need to get a model handle.
99 | This can be done using the top-level `llm` convenience API,
100 | or the `model` method in the `llm` namespace when using the scoped resource API.
101 | For example, here is how to use Qwen2.5 7B Instruct.
102 | 
103 | ```lms_code_snippet
104 |   variants:
105 |     "Python (convenience API)":
106 |       language: python
107 |       code: |
108 |         import lmstudio as lms
109 | 
110 |         model = lms.llm("qwen2.5-7b-instruct")
111 | 
112 |     "Python (scoped resource API)":
113 |       language: python
114 |       code: |
115 |         import lmstudio as lms
116 | 
117 |         with lms.Client() as client:
118 |             model = client.llm.model("qwen2.5-7b-instruct")
119 | 
120 |     "Python (asynchronous API)":
121 |       language: python
122 |       code: |
123 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
124 |         # Requires Python SDK version 1.5.0 or later
125 |         import lmstudio as lms
126 | 
127 |         async with lms.AsyncClient() as client:
128 |             model = await client.llm.model("qwen2.5-7b-instruct")
129 | 
130 | ```
131 | 
132 | There are other ways to get a model handle. See [Managing Models in Memory](./../manage-models/loading) for more info.
133 | 
134 | ## Manage Chat Context
135 | 
136 | The input to the model is referred to as the "context".
137 | Conceptually, the model receives a multi-turn conversation as input,
138 | and it is asked to predict the assistant's response in that conversation.
139 | 
140 | ```lms_code_snippet
141 |   variants:
142 |     "Constructing a Chat object":
143 |       language: python
144 |       code: |
145 |         import lmstudio as lms
146 | 
147 |         # Create a chat with an initial system prompt.
148 |         chat = lms.Chat("You are a resident AI philosopher.")
149 | 
150 |         # Build the chat context by adding messages of relevant types.
151 |         chat.add_user_message("What is the meaning of life?")
152 |         # ... continued in next example
153 | 
154 |   "From chat history data":
155 |       language: python
156 |       code: |
157 |         import lmstudio as lms
158 | 
159 |         # Create a chat object from a chat history dict
160 |         chat = lms.Chat.from_history({
161 |             "messages": [
162 |                 { "role": "system", "content": "You are a resident AI philosopher." },
163 |                 { "role": "user", "content": "What is the meaning of life?" },
164 |             ]
165 |         })
166 |         # ... continued in next example
167 | 
168 | ```
169 | 
170 | See [Working with Chats](./working-with-chats) for more information on managing chat context.
171 | 
172 | <!-- , and [`Chat`](./../api-reference/chat) for API reference for the `Chat` class. -->
173 | 
174 | ## Generate a response
175 | 
176 | You can ask the LLM to predict the next response in the chat context using the `respond()` method.
177 | 
178 | ```lms_code_snippet
179 |   variants:
180 |     "Non-streaming (synchronous API)":
181 |       language: python
182 |       code: |
183 |         # The `chat` object is created in the previous step.
184 |         result = model.respond(chat)
185 | 
186 |         print(result)
187 | 
188 |     "Streaming (synchronous API)":
189 |       language: python
190 |       code: |
191 |         # The `chat` object is created in the previous step.
192 |         prediction_stream = model.respond_stream(chat)
193 | 
194 |         for fragment in prediction_stream:
195 |             print(fragment.content, end="", flush=True)
196 |         print() # Advance to a new line at the end of the response
197 | 
198 |     "Non-streaming (asynchronous API)":
199 |       language: python
200 |       code: |
201 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
202 |         # Requires Python SDK version 1.5.0 or later
203 |         # The `chat` object is created in the previous step.
204 |         result = await model.respond(chat)
205 | 
206 |         print(result)
207 | 
208 |     "Streaming (asynchronous API)":
209 |       language: python
210 |       code: |
211 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
212 |         # Requires Python SDK version 1.5.0 or later
213 |         # The `chat` object is created in the previous step.
214 |         prediction_stream = await model.respond_stream(chat)
215 | 
216 |         async for fragment in prediction_stream:
217 |             print(fragment.content, end="", flush=True)
218 |         print() # Advance to a new line at the end of the response
219 | 
220 | ```
221 | 
222 | ## Customize Inferencing Parameters
223 | 
224 | You can pass in inferencing parameters via the `config` keyword parameter on `.respond()`.
225 | 
226 | ```lms_code_snippet
227 |   variants:
228 |     "Non-streaming (synchronous API)":
229 |       language: python
230 |       code: |
231 |         result = model.respond(chat, config={
232 |             "temperature": 0.6,
233 |             "maxTokens": 50,
234 |         })
235 | 
236 |     "Streaming (synchronous API)":
237 |       language: python
238 |       code: |
239 |         prediction_stream = model.respond_stream(chat, config={
240 |             "temperature": 0.6,
241 |             "maxTokens": 50,
242 |         })
243 | 
244 |     "Non-streaming (asynchronous API)":
245 |       language: python
246 |       code: |
247 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
248 |         # Requires Python SDK version 1.5.0 or later
249 |         result = await model.respond(chat, config={
250 |             "temperature": 0.6,
251 |             "maxTokens": 50,
252 |         })
253 | 
254 |     "Streaming (asynchronous API)":
255 |       language: python
256 |       code: |
257 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
258 |         # Requires Python SDK version 1.5.0 or later
259 |         prediction_stream = await model.respond_stream(chat, config={
260 |             "temperature": 0.6,
261 |             "maxTokens": 50,
262 |         })
263 | 
264 | ```
265 | 
266 | See [Configuring the Model](./parameters) for more information on what can be configured.
267 | 
268 | ## Print prediction stats
269 | 
270 | You can also print prediction metadata, such as the model used for generation, number of generated
271 | tokens, time to first token, and stop reason.
272 | 
273 | ```lms_code_snippet
274 |   variants:
275 |     "Non-streaming":
276 |       language: python
277 |       code: |
278 |         # `result` is the response from the model.
279 |         print("Model used:", result.model_info.display_name)
280 |         print("Predicted tokens:", result.stats.predicted_tokens_count)
281 |         print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
282 |         print("Stop reason:", result.stats.stop_reason)
283 | 
284 |     "Streaming":
285 |       language: python
286 |       code: |
287 |         # After iterating through the prediction fragments,
288 |         # the overall prediction result may be obtained from the stream
289 |         result = prediction_stream.result()
290 | 
291 |         print("Model used:", result.model_info.display_name)
292 |         print("Predicted tokens:", result.stats.predicted_tokens_count)
293 |         print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
294 |         print("Stop reason:", result.stats.stop_reason)
295 | 
296 | ```
297 | 
298 | Both the non-streaming and streaming result access is consistent across the synchronous and
299 | asynchronous APIs, as `prediction_stream.result()` is a non-blocking API that raises an exception
300 | if no result is available (either because the prediction is still running, or because the
301 | prediction request failed). Prediction streams also offer a blocking (synchronous API) or
302 | awaitable (asynchronous API) `prediction_stream.wait_for_result()` method that internally handles
303 | iterating the stream to completion before returning the result.
304 | 
305 | ## Example: Multi-turn Chat
306 | 
307 | ```lms_code_snippet
308 |   title: "chatbot.py"
309 |   variants:
310 |     "Python (convenience API)":
311 |       language: python
312 |       code: |
313 |         import lmstudio as lms
314 | 
315 |         model = lms.llm()
316 |         chat = lms.Chat("You are a task focused AI assistant")
317 | 
318 |         while True:
319 |             try:
320 |                 user_input = input("You (leave blank to exit): ")
321 |             except EOFError:
322 |                 print()
323 |                 break
324 |             if not user_input:
325 |                 break
326 |             chat.add_user_message(user_input)
327 |             prediction_stream = model.respond_stream(
328 |                 chat,
329 |                 on_message=chat.append,
330 |             )
331 |             print("Bot: ", end="", flush=True)
332 |             for fragment in prediction_stream:
333 |                 print(fragment.content, end="", flush=True)
334 |             print()
335 | 
336 | ```
337 | 
338 | ### Progress Callbacks
339 | 
340 | Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
341 | If you want to get updates on the progress of this process, you can provide a float callback to `respond`
342 | that receives a float from 0.0-1.0 representing prompt processing progress.
343 | 
344 | ```lms_code_snippet
345 |   variants:
346 |     "Python (convenience API)":
347 |       language: python
348 |       code: |
349 |         import lmstudio as lms
350 | 
351 |         llm = lms.llm()
352 | 
353 |         response = llm.respond(
354 |             "What is LM Studio?",
355 |             on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% complete")),
356 |         )
357 | 
358 |     "Python (scoped resource API)":
359 |       language: python
360 |       code: |
361 |         import lmstudio as lms
362 | 
363 |         with lms.Client() as client:
364 |             llm = client.llm.model()
365 | 
366 |             response = llm.respond(
367 |                 "What is LM Studio?",
368 |                 on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% complete")),
369 |             )
370 | 
371 |     "Python (asynchronous API)":
372 |       language: python
373 |       code: |
374 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
375 |         # Requires Python SDK version 1.5.0 or later
376 |         import lmstudio as lms
377 | 
378 |         async with lms.AsyncClient() as client:
379 |             llm = await client.llm.model()
380 | 
381 |             response = await llm.respond(
382 |                 "What is LM Studio?",
383 |                 on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% complete")),
384 |             )
385 | 
386 | 
387 | ```
388 | 
389 | In addition to `on_prompt_processing_progress`, the other available progress callbacks are:
390 | 
391 | - `on_first_token`: called after prompt processing is complete and the first token is being emitted.
392 |   Does not receive any arguments (use the streaming iteration API or `on_prediction_fragment`
393 |   to process tokens as they are emitted).
394 | - `on_prediction_fragment`: called for each prediction fragment received by the client.
395 |   Receives the same prediction fragments as iterating over the stream iteration API.
396 | - `on_message`: called with an assistant response message when the prediction is complete.
397 |   Intended for appending received messages to a chat history instance.
```

1_python/1_llm-prediction/completion.md
```
1 | ---
2 | title: Text Completions
3 | description: "Provide a string input for the model to complete"
4 | ---
5 | 
6 | Use `llm.complete(...)` to generate text completions from a loaded language model.
7 | Text completions mean sending a non-formatted string to the model with the expectation that the model will complete the text.
8 | 
9 | This is different from multi-turn chat conversations. For more information on chat completions, see [Chat Completions](./chat-completion).
10 | 
11 | ## 1. Instantiate a Model
12 | 
13 | First, you need to load a model to generate completions from.
14 | This can be done using the top-level `llm` convenience API,
15 | or the `model` method in the `llm` namespace when using the scoped resource API.
16 | For example, here is how to use Qwen2.5 7B Instruct.
17 | 
18 | 
19 | ```lms_code_snippet
20 |   variants:
21 |     "Python (convenience API)":
22 |       language: python
23 |       code: |
24 |         import lmstudio as lms
25 | 
26 |         model = lms.llm("qwen2.5-7b-instruct")
27 | 
28 |     "Python (scoped resource API)":
29 |       language: python
30 |       code: |
31 |         import lmstudio as lms
32 | 
33 |         with lms.Client() as client:
34 |             model = client.llm.model("qwen2.5-7b-instruct")
35 | 
36 |     "Python (asynchronous API)":
37 |       language: python
38 |       code: |
39 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
40 |         # Requires Python SDK version 1.5.0 or later
41 |         import lmstudio as lms
42 | 
43 |         async with lms.AsyncClient() as client:
44 |             model = await client.llm.model("qwen2.5-7b-instruct")
45 | 
46 | ```
47 | 
48 | ## 2. Generate a Completion
49 | 
50 | Once you have a loaded model, you can generate completions by passing a string to the `complete` method on the `llm` handle.
51 | 
52 | ```lms_code_snippet
53 |   variants:
54 |     "Non-streaming (synchronous API)":
55 |       language: python
56 |       code: |
57 |         # The `chat` object is created in the previous step.
58 |         result = model.complete("My name is", config={"maxTokens": 100})
59 | 
60 |         print(result)
61 | 
62 |     "Streaming (synchronous API)":
63 |       language: python
64 |       code: |
65 |         # The `chat` object is created in the previous step.
66 |         prediction_stream = model.complete_stream("My name is", config={"maxTokens": 100})
67 | 
68 |         for fragment in prediction_stream:
69 |             print(fragment.content, end="", flush=True)
70 |         print() # Advance to a new line at the end of the response
71 | 
72 |     "Non-streaming (asynchronous API)":
73 |       language: python
74 |       code: |
75 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
76 |         # Requires Python SDK version 1.5.0 or later
77 |         # The `chat` object is created in the previous step.
78 |         result = await model.complete("My name is", config={"maxTokens": 100})
79 | 
80 |         print(result)
81 | 
82 |     "Streaming (asynchronous API)":
83 |       language: python
84 |       code: |
85 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
86 |         # Requires Python SDK version 1.5.0 or later
87 |         # The `chat` object is created in the previous step.
88 |         prediction_stream = await model.complete_stream("My name is", config={"maxTokens": 100})
89 | 
90 |         async for fragment in prediction_stream:
91 |             print(fragment.content, end="", flush=True)
92 |         print() # Advance to a new line at the end of the response
93 | 
94 | ```
95 | 
96 | ## 3. Print Prediction Stats
97 | 
98 | You can also print prediction metadata, such as the model used for generation, number of generated tokens, time to first token, and stop reason.
99 | 
100 | ```lms_code_snippet
101 |   variants:
102 |     "Non-streaming":
103 |       language: python
104 |       code: |
105 |         # `result` is the response from the model.
106 |         print("Model used:", result.model_info.display_name)
107 |         print("Predicted tokens:", result.stats.predicted_tokens_count)
108 |         print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
109 |         print("Stop reason:", result.stats.stop_reason)
110 | 
111 |     "Streaming":
112 |       language: python
113 |       code: |
114 |         # After iterating through the prediction fragments,
115 |         # the overall prediction result may be obtained from the stream
116 |         result = prediction_stream.result()
117 | 
118 |         print("Model used:", result.model_info.display_name)
119 |         print("Predicted tokens:", result.stats.predicted_tokens_count)
120 |         print("Time to first token (seconds):", result.stats.time_to_first_token_sec)
121 |         print("Stop reason:", result.stats.stop_reason)
122 | 
123 | ```
124 | 
125 | Both the non-streaming and streaming result access is consistent across the synchronous and
126 | asynchronous APIs, as `prediction_stream.result()` is a non-blocking API that raises an exception
127 | if no result is available (either because the prediction is still running, or because the
128 | prediction request failed). Prediction streams also offer a blocking (synchronous API) or
129 | awaitable (asynchronous API) `prediction_stream.wait_for_result()` method that internally handles
130 | iterating the stream to completion before returning the result.
131 | 
132 | ## Example: Get an LLM to Simulate a Terminal
133 | 
134 | Here's an example of how you might use the `complete` method to simulate a terminal.
135 | 
136 | ```lms_code_snippet
137 |   title: "terminal-sim.py"
138 |   variants:
139 |     "Python (convenience API)":
140 |       language: python
141 |       code: |
142 |         import lmstudio as lms
143 | 
144 |         model = lms.llm()
145 |         console_history = []
146 | 
147 |         while True:
148 |             try:
149 |                 user_command = input("$ ")
150 |             except EOFError:
151 |                 print()
152 |                 break
153 |             if user_command.strip() == "exit":
154 |                 break
155 |             console_history.append(f"$ {user_command}")
156 |             history_prompt = "\n".join(console_history)
157 |             prediction_stream = model.complete_stream(
158 |                 history_prompt,
159 |                 config={ "stopStrings": ["$"] },
160 |             )
161 |             for fragment in prediction_stream:
162 |                 print(fragment.content, end="", flush=True)
163 |             print()
164 |             console_history.append(prediction_stream.result().content)
165 | 
166 | ```
167 | 
168 | ## Customize Inferencing Parameters
169 | 
170 | You can pass in inferencing parameters via the `config` keyword parameter on `.complete()`.
171 | 
172 | ```lms_code_snippet
173 |   variants:
174 |     "Non-streaming (synchronous API)":
175 |       language: python
176 |       code: |
177 |         result = model.complete(initial_text, config={
178 |             "temperature": 0.6,
179 |             "maxTokens": 50,
180 |         })
181 | 
182 |     "Streaming (synchronous API)":
183 |       language: python
184 |       code: |
185 |         prediction_stream = model.complete_stream(initial_text, config={
186 |             "temperature": 0.6,
187 |             "maxTokens": 50,
188 |         })
189 | 
190 |     "Non-streaming (asynchronous API)":
191 |       language: python
192 |       code: |
193 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
194 |         # Requires Python SDK version 1.5.0 or later
195 |         result = await model.complete(initial_text, config={
196 |             "temperature": 0.6,
197 |             "maxTokens": 50,
198 |         })
199 | 
200 |     "Streaming (asynchronous API)":
201 |       language: python
202 |       code: |
203 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
204 |         # Requires Python SDK version 1.5.0 or later
205 |         prediction_stream = await model.complete_stream(initial_text, config={
206 |             "temperature": 0.6,
207 |             "maxTokens": 50,
208 |         })
209 | 
210 | ```
211 | 
212 | See [Configuring the Model](./parameters) for more information on what can be configured.
213 | 
214 | ### Progress Callbacks
215 | 
216 | Long prompts will often take a long time to first token, i.e. it takes the model a long time to process your prompt.
217 | If you want to get updates on the progress of this process, you can provide a float callback to `complete`
218 | that receives a float from 0.0-1.0 representing prompt processing progress.
219 | 
220 | ```lms_code_snippet
221 |   variants:
222 |     "Python (convenience API)":
223 |       language: python
224 |       code: |
225 |         import lmstudio as lms
226 | 
227 |         llm = lms.llm()
228 | 
229 |         completion = llm.complete(
230 |             "My name is",
231 |             on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% complete")),
232 |         )
233 | 
234 |     "Python (scoped resource API)":
235 |       language: python
236 |       code: |
237 |         import lmstudio as lms
238 | 
239 |         with lms.Client() as client:
240 |             llm = client.llm.model()
241 | 
242 |             completion = llm.complete(
243 |                 "My name is",
244 |                 on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% processed")),
245 |             )
246 | 
247 |     "Python (asynchronous API)":
248 |       language: python
249 |       code: |
250 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
251 |         # Requires Python SDK version 1.5.0 or later
252 |         import lmstudio as lms
253 | 
254 |         async with lms.AsyncClient() as client:
255 |             llm = await client.llm.model()
256 | 
257 |             completion = await llm.complete(
258 |                 "My name is",
259 |                 on_prompt_processing_progress = (lambda progress: print(f"{progress*100}% processed")),
260 |             )
261 | 
262 | ```
263 | 
264 | In addition to `on_prompt_processing_progress`, the other available progress callbacks are:
265 | 
266 | * `on_first_token`: called after prompt processing is complete and the first token is being emitted.
267 |   Does not receive any arguments (use the streaming iteration API or `on_prediction_fragment`
268 |   to process tokens as they are emitted).
269 | * `on_prediction_fragment`: called for each prediction fragment received by the client.
270 |   Receives the same prediction fragments as iterating over the stream iteration API.
271 | * `on_message`: called with an assistant response message when the prediction is complete.
272 |   Intended for appending received messages to a chat history instance.
```

1_python/1_llm-prediction/image-input.md
```
1 | ---
2 | title: Image Input
3 | description: API for passing images as input to the model
4 | index: 2
5 | ---
6 | 
7 | *Required Python SDK version*: **1.1.0**
8 | 
9 | Some models, known as VLMs (Vision-Language Models), can accept images as input. You can pass images to the model using the `.respond()` method.
10 | 
11 | ### Prerequisite: Get a VLM (Vision-Language Model)
12 | 
13 | If you don't yet have a VLM, you can download a model like `qwen2-vl-2b-instruct` using the following command:
14 | 
15 | ```bash
16 | lms get qwen2-vl-2b-instruct
17 | ```
18 | 
19 | ## 1. Instantiate the Model
20 | 
21 | Connect to LM Studio and obtain a handle to the VLM (Vision-Language Model) you want to use.
22 | 
23 | ```lms_code_snippet
24 |   variants:
25 |     "Python (convenience API)":
26 |       language: python
27 |       code: |
28 |         import lmstudio as lms
29 | 
30 |         model = lms.llm("qwen2-vl-2b-instruct")
31 | 
32 |     "Python (scoped resource API)":
33 |       language: python
34 |       code: |
35 |         import lmstudio as lms
36 | 
37 |         with lms.Client() as client:
38 |             model = client.llm.model("qwen2-vl-2b-instruct")
39 | 
40 |     "Python (asynchronous API)":
41 |       language: python
42 |       code: |
43 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
44 |         # Requires Python SDK version 1.5.0 or later
45 |         import lmstudio as lms
46 | 
47 |         async with lms.AsyncClient() as client:
48 |             model = await client.llm.model("qwen2-vl-2b-instruct")
49 | 
50 | ```
51 | 
52 | ## 2. Prepare the Image
53 | 
54 | Use the `prepare_image()` function or `files` namespace method to
55 | get a handle to the image that can subsequently be passed to the model.
56 | 
57 | ```lms_code_snippet
58 |   variants:
59 |     "Python (convenience API)":
60 |       language: python
61 |       code: |
62 |         import lmstudio as lms
63 | 
64 |         image_path = "/path/to/image.jpg" # Replace with the path to your image
65 |         image_handle = lms.prepare_image(image_path)
66 | 
67 |     "Python (scoped resource API)":
68 |       language: python
69 |       code: |
70 |         import lmstudio as lms
71 | 
72 |         with lms.Client() as client:
73 |             image_path = "/path/to/image.jpg" # Replace with the path to your image
74 |             image_handle = client.files.prepare_image(image_path)
75 | 
76 |     "Python (asynchronous API)":
77 |       language: python
78 |       code: |
79 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
80 |         # Requires Python SDK version 1.5.0 or later
81 |         import lmstudio as lms
82 | 
83 |         async with lms.AsyncClient() as client:
84 |             image_path = "/path/to/image.jpg" # Replace with the path to your image
85 |             image_handle = await client.files.prepare_image(image_path)
86 | 
87 | ```
88 | 
89 | If you only have the raw data of the image, you can supply the raw data directly as a bytes
90 | object without having to write it to disk first. Due to this feature, binary filesystem
91 | paths are *not* supported (as they will be handled as malformed image data rather than as
92 | filesystem paths).
93 | 
94 | Binary IO objects are also accepted as local file inputs.
95 | 
96 | The LM Studio server supports JPEG, PNG, and WebP image formats.
97 | 
98 | ## 3. Pass the Image to the Model in `.respond()`
99 | 
100 | Generate a prediction by passing the image to the model in the `.respond()` method.
101 | 
102 | ```lms_code_snippet
103 |   variants:
104 |     "Python (convenience API)":
105 |       language: python
106 |       code: |
107 |         import lmstudio as lms
108 | 
109 |         image_path = "/path/to/image.jpg" # Replace with the path to your image
110 |         image_handle = lms.prepare_image(image_path)
111 |         model = lms.llm("qwen2-vl-2b-instruct")
112 |         chat = lms.Chat()
113 |         chat.add_user_message("Describe this image please", images=[image_handle])
114 |         prediction = model.respond(chat)
115 | 
116 |     "Python (scoped resource API)":
117 |       language: python
118 |       code: |
119 |         import lmstudio as lms
120 | 
121 |         with lms.Client() as client:
122 |             image_path = "/path/to/image.jpg" # Replace with the path to your image
123 |             image_handle = client.files.prepare_image(image_path)
124 |             model = client.llm.model("qwen2-vl-2b-instruct")
125 |             chat = lms.Chat()
126 |             chat.add_user_message("Describe this image please", images=[image_handle])
127 |             prediction = model.respond(chat)
128 | 
129 |     "Python (asynchronous API)":
130 |       language: python
131 |       code: |
132 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
133 |         # Requires Python SDK version 1.5.0 or later
134 |         import lmstudio as lms
135 | 
136 |         async with lms.AsyncClient() as client:
137 |             image_path = "/path/to/image.jpg" # Replace with the path to your image
138 |             image_handle = client.files.prepare_image(image_path)
139 |             model = await client.llm.model("qwen2-vl-2b-instruct")
140 |             chat = lms.Chat()
141 |             chat.add_user_message("Describe this image please", images=[image_handle])
142 |             prediction = await model.respond(chat)
143 | 
144 | ```
```

1_python/1_llm-prediction/parameters.md
```
1 | ---
2 | title: Configuring the Model
3 | sidebar_title: Configuration Parameters
4 | description: APIs for setting inference-time and load-time parameters for your model
5 | ---
6 | 
7 | You can customize both inference-time and load-time parameters for your model. Inference parameters can be set on a per-request basis, while load parameters are set when loading the model.
8 | 
9 | # Inference Parameters
10 | 
11 | Set inference-time parameters such as `temperature`, `maxTokens`, `topP` and more.
12 | 
13 | ```lms_code_snippet
14 |   variants:
15 |     ".respond()":
16 |       language: python
17 |       code: |
18 |         result = model.respond(chat, config={
19 |             "temperature": 0.6,
20 |             "maxTokens": 50,
21 |         })
22 | 
23 |     ".complete()":
24 |       language: python
25 |       code: |
26 |         result = model.complete(chat, config={
27 |             "temperature": 0.6,
28 |             "maxTokens": 50,
29 |             "stopStrings": ["\n\n"],
30 |           })
31 | 
32 | ```
33 | 
34 | See [`LLMPredictionConfigInput`](./../../typescript/api-reference/llm-prediction-config-input) in the
35 | Typescript SDK documentation for all configurable fields.
36 | 
37 | Note that while `structured` can be set to a JSON schema definition as an inference-time configuration parameter
38 | (Zod schemas are not supported in the Python SDK), the preferred approach is to instead set the
39 | [dedicated `response_format` parameter](<(./structured-responses)>), which allows you to more rigorously
40 | enforce the structure of the output using a JSON or class based schema definition.
41 | 
42 | # Load Parameters
43 | 
44 | Set load-time parameters such as the context length, GPU offload ratio, and more.
45 | 
46 | ### Set Load Parameters with `.model()`
47 | 
48 | The `.model()` retrieves a handle to a model that has already been loaded, or loads a new one on demand (JIT loading).
49 | 
50 | **Note**: if the model is already loaded, the given configuration will be **ignored**.
51 | 
52 | ```lms_code_snippet
53 |   variants:
54 |     "Python (convenience API)":
55 |       language: python
56 |       code: |
57 |         import lmstudio as lms
58 | 
59 |         model = lms.llm("qwen2.5-7b-instruct", config={
60 |             "contextLength": 8192,
61 |             "gpu": {
62 |               "ratio": 0.5,
63 |             }
64 |         })
65 | 
66 |     "Python (scoped resource API)":
67 |       language: python
68 |       code: |
69 |         import lmstudio as lms
70 | 
71 |         with lms.Client() as client:
72 |             model = client.llm.model(
73 |                 "qwen2.5-7b-instruct",
74 |                 config={
75 |                     "contextLength": 8192,
76 |                     "gpu": {
77 |                       "ratio": 0.5,
78 |                     }
79 |                 }
80 |             )
81 | 
82 |     "Python (asynchronous API)":
83 |       language: python
84 |       code: |
85 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
86 |         # Requires Python SDK version 1.5.0 or later
87 |         import lmstudio as lms
88 | 
89 |         async with lms.AsyncClient() as client:
90 |             model = await client.llm.model(
91 |                 "qwen2.5-7b-instruct",
92 |                 config={
93 |                     "contextLength": 8192,
94 |                     "gpu": {
95 |                       "ratio": 0.5,
96 |                     }
97 |                 }
98 |             )
99 | 
100 | ```
101 | 
102 | See [`LLMLoadModelConfig`](./../../typescript/api-reference/llm-load-model-config) in the
103 | Typescript SDK documentation for all configurable fields.
104 | 
105 | ### Set Load Parameters with `.load_new_instance()`
106 | 
107 | The `.load_new_instance()` method creates a new model instance and loads it with the specified configuration.
108 | 
109 | ```lms_code_snippet
110 |   variants:
111 |     "Python (convenience API)":
112 |       language: python
113 |       code: |
114 |         import lmstudio as lms
115 | 
116 |         client = lms.get_default_client()
117 |         model = client.llm.load_new_instance("qwen2.5-7b-instruct", config={
118 |             "contextLength": 8192,
119 |             "gpu": {
120 |               "ratio": 0.5,
121 |             }
122 |         })
123 | 
124 |     "Python (scoped resource API)":
125 |       language: python
126 |       code: |
127 |         import lmstudio as lms
128 | 
129 |         with lms.Client() as client:
130 |             model = client.llm.load_new_instance(
131 |                 "qwen2.5-7b-instruct",
132 |                 config={
133 |                     "contextLength": 8192,
134 |                     "gpu": {
135 |                       "ratio": 0.5,
136 |                     }
137 |                 }
138 |             )
139 | 
140 |     "Python (asynchronous API)":
141 |       language: python
142 |       code: |
143 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
144 |         # Requires Python SDK version 1.5.0 or later
145 |         import lmstudio as lms
146 | 
147 |         async with lms.AsyncClient() as client:
148 |             model = await client.llm.load_new_instance(
149 |                 "qwen2.5-7b-instruct",
150 |                 config={
151 |                     "contextLength": 8192,
152 |                     "gpu": {
153 |                       "ratio": 0.5,
154 |                     }
155 |                 }
156 |             )
157 | 
158 | ```
159 | 
160 | See [`LLMLoadModelConfig`](./../../typescript/api-reference/llm-load-model-config) in the
161 | Typescript SDK documentation for all configurable fields.
```

1_python/1_llm-prediction/speculative-decoding.md
```
1 | ---
2 | title: Speculative Decoding
3 | description: API to use a draft model in speculative decoding in `lmstudio-python`
4 | index: 5
5 | ---
6 | 
7 | *Required Python SDK version*: **1.2.0**
8 | 
9 | Speculative decoding is a technique that can substantially increase the generation speed of large language models (LLMs) without reducing response quality. See [Speculative Decoding](./../../app/advanced/speculative-decoding) for more info.
10 | 
11 | To use speculative decoding in `lmstudio-python`, simply provide a `draftModel` parameter when performing the prediction. You do not need to load the draft model separately.
12 | 
13 | ```lms_code_snippet
14 |   variants:
15 |     "Non-streaming":
16 |       language: python
17 |       code: |
18 |         import lmstudio as lms
19 | 
20 |         main_model_key = "qwen2.5-7b-instruct"
21 |         draft_model_key = "qwen2.5-0.5b-instruct"
22 | 
23 |         model = lms.llm(main_model_key)
24 |         result = model.respond(
25 |             "What are the prime numbers between 0 and 100?",
26 |             config={
27 |                 "draftModel": draft_model_key,
28 |             }
29 |         )
30 | 
31 |         print(result)
32 |         stats = result.stats
33 |         print(f"Accepted {stats.accepted_draft_tokens_count}/{stats.predicted_tokens_count} tokens")
34 | 
35 | 
36 |     Streaming:
37 |       language: python
38 |       code: |
39 |         import lmstudio as lms
40 | 
41 |         main_model_key = "qwen2.5-7b-instruct"
42 |         draft_model_key = "qwen2.5-0.5b-instruct"
43 | 
44 |         model = lms.llm(main_model_key)
45 |         prediction_stream = model.respond_stream(
46 |             "What are the prime numbers between 0 and 100?",
47 |             config={
48 |                 "draftModel": draft_model_key,
49 |             }
50 |         )
51 |         for fragment in prediction_stream:
52 |             print(fragment.content, end="", flush=True)
53 |         print() # Advance to a new line at the end of the response
54 | 
55 |         stats = prediction_stream.result().stats
56 |         print(f"Accepted {stats.accepted_draft_tokens_count}/{stats.predicted_tokens_count} tokens")
57 | ```
```

1_python/1_llm-prediction/structured-response.md
```
1 | ---
2 | title: Structured Response
3 | description: Enforce a structured response from the model using Pydantic models or JSON Schema
4 | index: 4
5 | ---
6 | 
7 | You can enforce a particular response format from an LLM by providing a JSON schema to the `.respond()` method.
8 | This guarantees that the model's output conforms to the schema you provide.
9 | 
10 | The JSON schema can either be provided directly,
11 | or by providing an object that implements the `lmstudio.ModelSchema` protocol,
12 | such as `pydantic.BaseModel` or `lmstudio.BaseModel`.
13 | 
14 | The `lmstudio.ModelSchema` protocol is defined as follows:
15 | 
16 | ```python
17 | @runtime_checkable
18 | class ModelSchema(Protocol):
19 |     """Protocol for classes that provide a JSON schema for their model."""
20 | 
21 |     @classmethod
22 |     def model_json_schema(cls) -> DictSchema:
23 |         """Return a JSON schema dict describing this model."""
24 |         ...
25 | 
26 | ```
27 | 
28 | When a schema is provided, the prediction result's `parsed` field will contain a string-keyed dictionary that conforms
29 | to the given schema (for unstructured results, this field is a string field containing the same value as `content`).
30 | 
31 | 
32 | ## Enforce Using a Class Based Schema Definition
33 | 
34 | If you wish the model to generate JSON that satisfies a given schema,
35 | it is recommended to provide a class based schema definition using a library
36 | such as [`pydantic`](https://docs.pydantic.dev/) or [`msgspec`](https://jcristharif.com/msgspec/).
37 | 
38 | Pydantic models natively implement the `lmstudio.ModelSchema` protocol,
39 | while `lmstudio.BaseModel` is a `msgspec.Struct` subclass that implements `.model_json_schema()` appropriately.
40 | 
41 | #### Define a Class Based Schema
42 | 
43 | ```lms_code_snippet
44 |   variants:
45 |     "pydantic.BaseModel":
46 |       language: python
47 |       code: |
48 |         from pydantic import BaseModel
49 | 
50 |         # A class based schema for a book
51 |         class BookSchema(BaseModel):
52 |             title: str
53 |             author: str
54 |             year: int
55 | 
56 |     "lmstudio.BaseModel":
57 |       language: python
58 |       code: |
59 |         from lmstudio import BaseModel
60 | 
61 |         # A class based schema for a book
62 |         class BookSchema(BaseModel):
63 |             title: str
64 |             author: str
65 |             year: int
66 | 
67 | ```
68 | 
69 | #### Generate a Structured Response
70 | 
71 | ```lms_code_snippet
72 |   variants:
73 |     "Non-streaming":
74 |       language: python
75 |       code: |
76 |         result = model.respond("Tell me about The Hobbit", response_format=BookSchema)
77 |         book = result.parsed
78 | 
79 |         print(book)
80 |         #           ^
81 |         # Note that `book` is correctly typed as { title: string, author: string, year: number }
82 | 
83 |     Streaming:
84 |       language: python
85 |       code: |
86 |         prediction_stream = model.respond_stream("Tell me about The Hobbit", response_format=BookSchema)
87 | 
88 |         # Optionally stream the response
89 |         # for fragment in prediction:
90 |         #   print(fragment.content, end="", flush=True)
91 |         # print()
92 |         # Note that even for structured responses, the *fragment* contents are still only text
93 | 
94 |         # Get the final structured result
95 |         result = prediction_stream.result()
96 |         book = result.parsed
97 | 
98 |         print(book)
99 |         #           ^
100 |         # Note that `book` is correctly typed as { title: string, author: string, year: number }
101 | ```
102 | 
103 | ## Enforce Using a JSON Schema
104 | 
105 | You can also enforce a structured response using a JSON schema.
106 | 
107 | #### Define a JSON Schema
108 | 
109 | ```python
110 | # A JSON schema for a book
111 | schema = {
112 |   "type": "object",
113 |   "properties": {
114 |     "title": { "type": "string" },
115 |     "author": { "type": "string" },
116 |     "year": { "type": "integer" },
117 |   },
118 |   "required": ["title", "author", "year"],
119 | }
120 | ```
121 | 
122 | #### Generate a Structured Response
123 | 
124 | ```lms_code_snippet
125 |   variants:
126 |     "Non-streaming":
127 |       language: python
128 |       code: |
129 |         result = model.respond("Tell me about The Hobbit", response_format=schema)
130 |         book = result.parsed
131 | 
132 |         print(book)
133 |         #     ^
134 |         # Note that `book` is correctly typed as { title: string, author: string, year: number }
135 | 
136 |     Streaming:
137 |       language: python
138 |       code: |
139 |         prediction_stream = model.respond_stream("Tell me about The Hobbit", response_format=schema)
140 | 
141 |         # Stream the response
142 |         for fragment in prediction:
143 |             print(fragment.content, end="", flush=True)
144 |         print()
145 |         # Note that even for structured responses, the *fragment* contents are still only text
146 | 
147 |         # Get the final structured result
148 |         result = prediction_stream.result()
149 |         book = result.parsed
150 | 
151 |         print(book)
152 |         #     ^
153 |         # Note that `book` is correctly typed as { title: string, author: string, year: number }
154 | ```
155 | 
156 | <!--
157 | 
158 | TODO: Info about structured generation caveats
159 | 
160 |  ## Overview
161 | 
162 | Once you have [downloaded and loaded](/docs/basics/index) a large language model,
163 | you can use it to respond to input through the API. This article covers getting JSON structured output, but you can also
164 | [request text completions](/docs/api/sdk/completion),
165 | [request chat responses](/docs/api/sdk/chat-completion), and
166 | [use a vision-language model to chat about images](/docs/api/sdk/image-input).
167 | 
168 | ### Usage
169 | 
170 | Certain models are trained to output valid JSON data that conforms to
171 | a user-provided schema, which can be used programmatically in applications
172 | that need structured data. This structured data format is supported by both
173 | [`complete`](/docs/api/sdk/completion) and [`respond`](/docs/api/sdk/chat-completion)
174 | methods, and relies on Pydantic in Python and Zod in TypeScript.
175 | 
176 | ```lms_code_snippet
177 |   variants:
178 |     "Python (convenience API)":
179 |       language: python
180 |       code: |
181 |         import { LMStudioClient } from "@lmstudio/sdk";
182 |         import { z } from "zod";
183 | 
184 |         const Book = z.object({
185 |           title: z.string(),
186 |           author: z.string(),
187 |           year: z.number().int()
188 |         })
189 | 
190 |         const client = new LMStudioClient()
191 |         const llm = client.llm.model()
192 | 
193 |         const response = llm.respond(
194 |           "Tell me about The Hobbit.",
195 |           { structured: Book },
196 |         )
197 | 
198 |         console.log(response.content.title)
199 | ``` -->
```

1_python/1_llm-prediction/working-with-chats.md
```
1 | ---
2 | title: Working with Chats
3 | description: APIs for representing a chat conversation with an LLM
4 | ---
5 | 
6 | SDK methods such as `llm.respond()`, `llm.applyPromptTemplate()`, or `llm.act()`
7 | take in a chat parameter as an input.
8 | There are a few ways to represent a chat when using the SDK.
9 | 
10 | ## Option 1: Input a Single String
11 | 
12 | If your chat only has one single user message, you can use a single string to represent the chat.
13 | Here is an example with the `.respond` method.
14 | 
15 | ```lms_code_snippet
16 | variants:
17 |   "Single string":
18 |     language: python
19 |     code: |
20 |       prediction = llm.respond("What is the meaning of life?")
21 | ```
22 | 
23 | ## Option 2: Using the `Chat` Helper Class
24 | 
25 | For more complex tasks, it is recommended to use the `Chat` helper class.
26 | It provides various commonly used methods to manage the chat.
27 | Here is an example with the `Chat` class, where the initial system prompt
28 | is supplied when initializing the chat instance, and then the initial user
29 | message is added via the corresponding method call.
30 | 
31 | ```lms_code_snippet
32 | variants:
33 |   "Simple chat":
34 |     language: python
35 |     code: |
36 |       chat = Chat("You are a resident AI philosopher.")
37 |       chat.add_user_message("What is the meaning of life?")
38 | 
39 |       prediction = llm.respond(chat)
40 | ```
41 | 
42 | You can also quickly construct a `Chat` object using the `Chat.from_history` method.
43 | 
44 | ```lms_code_snippet
45 | variants:
46 |   "Chat history data":
47 |     language: python
48 |     code: |
49 |       chat = Chat.from_history({"messages": [
50 |         { "role": "system", "content": "You are a resident AI philosopher." },
51 |         { "role": "user", "content": "What is the meaning of life?" },
52 |       ]})
53 | 
54 |   "Single string":
55 |     language: python
56 |     code: |
57 |       # This constructs a chat with a single user message
58 |       chat = Chat.from_history("What is the meaning of life?")
59 | 
60 | ```
61 | 
62 | ## Option 3: Providing Chat History Data Directly
63 | 
64 | As the APIs that accept chat histories use `Chat.from_history` internally,
65 | they also accept the chat history data format as a regular dictionary:
66 | 
67 | ```lms_code_snippet
68 | variants:
69 |   "Chat history data":
70 |     language: python
71 |     code: |
72 |       prediction = llm.respond({"messages": [
73 |         { "role": "system", "content": "You are a resident AI philosopher." },
74 |         { "role": "user", "content": "What is the meaning of life?" },
75 |       ]})
76 | ```
```

1_python/1_getting-started/project-setup.md
```
1 | ---
2 | title: "Project Setup"
3 | sidebar_title: "Project Setup"
4 | description: "Set up your `lmstudio-python` app or script."
5 | index: 2
6 | ---
7 | 
8 | `lmstudio` is a library published on PyPI that allows you to use `lmstudio-python` in your own projects.
9 | It is open source and developed on GitHub.
10 | You can find the source code [here](https://github.com/lmstudio-ai/lmstudio-python).
11 | 
12 | ## Installing `lmstudio-python`
13 | 
14 | As it is published to PyPI, `lmstudio-python` may be installed using `pip`
15 | or your preferred project dependency manager (`pdm` and `uv` are shown, but other
16 | Python project management tools offer similar dependency addition commands).
17 | 
18 | ```lms_code_snippet
19 |   variants:
20 |     pip:
21 |       language: bash
22 |       code: |
23 |         pip install lmstudio
24 |     pdm:
25 |       language: bash
26 |       code: |
27 |         pdm add lmstudio
28 |     uv:
29 |       language: bash
30 |       code: |
31 |         uv add lmstudio
32 | ```
33 | 
34 | ## Customizing the server API host and TCP port
35 | 
36 | All of the examples in the documentation assume that the server API is running locally
37 | on one of the default application ports (Note: in Python SDK versions prior to 1.5.0, the
38 | SDK also required that the optional HTTP REST server be enabled).
39 | 
40 | The network location of the server API can be overridden by
41 | passing a `"host:port"` string when creating the client instance.
42 | 
43 | ```lms_code_snippet
44 |   variants:
45 |     "Python (convenience API)":
46 |       language: python
47 |       code: |
48 |         import lmstudio as lms
49 |         SERVER_API_HOST = "localhost:1234"
50 | 
51 |         # This must be the *first* convenience API interaction (otherwise the SDK
52 |         # implicitly creates a client that accesses the default server API host)
53 |         lms.configure_default_client(SERVER_API_HOST)
54 | 
55 |         # Note: the dedicated configuration API was added in lmstudio-python 1.3.0
56 |         # For compatibility with earlier SDK versions, it is still possible to use
57 |         # lms.get_default_client(SERVER_API_HOST) to configure the default client
58 | 
59 |     "Python (scoped resource API)":
60 |       language: python
61 |       code: |
62 |         import lmstudio as lms
63 |         SERVER_API_HOST = "localhost:1234"
64 | 
65 |         # When using the scoped resource API, each client instance
66 |         # can be configured to use a specific server API host
67 |         with lms.Client(SERVER_API_HOST) as client:
68 |             model = client.llm.model()
69 | 
70 |             for fragment in model.respond_stream("What is the meaning of life?"):
71 |                 print(fragment.content, end="", flush=True)
72 |             print() # Advance to a new line at the end of the response
73 | 
74 |     "Python (asynchronous API)":
75 |       language: python
76 |       code: |
77 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
78 |         # Requires Python SDK version 1.5.0 or later
79 |         import lmstudio as lms
80 |         SERVER_API_HOST = "localhost:1234"
81 | 
82 |         # When using the asynchronous API, each client instance
83 |         # can be configured to use a specific server API host
84 |         async with lms.AsyncClient(SERVER_API_HOST) as client:
85 |             model = await client.llm.model()
86 | 
87 |             for fragment in await model.respond_stream("What is the meaning of life?"):
88 |                 print(fragment.content, end="", flush=True)
89 |             print() # Advance to a new line at the end of the response
90 | ```
91 | 
92 | ### Checking a specified API server host is running
93 | 
94 | *Required Python SDK version*: **1.5.0**
95 | 
96 | While the most common connection pattern is to let the SDK raise an exception if it can't
97 | connect to the specified API server host, the SDK also supports running the API check directly
98 | without creating an SDK client instance first:
99 | 
100 | ```lms_code_snippet
101 |   variants:
102 |     "Python (synchronous API)":
103 |       language: python
104 |       code: |
105 |         import lmstudio as lms
106 |         SERVER_API_HOST = "localhost:1234"
107 | 
108 |         if lms.Client.is_valid_api_host(SERVER_API_HOST):
109 |             print(f"An LM Studio API server instance is available at {SERVER_API_HOST}")
110 |         else:
111 |             print("No LM Studio API server instance found at {SERVER_API_HOST}")
112 | 
113 |     "Python (asynchronous API)":
114 |       language: python
115 |       code: |
116 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
117 |         # Requires Python SDK version 1.5.0 or later
118 |         import lmstudio as lms
119 |         SERVER_API_HOST = "localhost:1234"
120 | 
121 |         if await lms.AsyncClient.is_valid_api_host(SERVER_API_HOST):
122 |             print(f"An LM Studio API server instance is available at {SERVER_API_HOST}")
123 |         else:
124 |             print("No LM Studio API server instance found at {SERVER_API_HOST}")
125 | ```
126 | 
127 | 
128 | ### Determining the default local API server port
129 | 
130 | *Required Python SDK version*: **1.5.0**
131 | 
132 | When no API server host is specified, the SDK queries a number of ports on the local loopback
133 | interface for a running API server instance. This scan is repeated for each new client instance
134 | created. Rather than letting the SDK perform this scan implicitly, the SDK also supports running
135 | the scan explicitly, and passing in the reported API server details when creating clients:
136 | 
137 | ```lms_code_snippet
138 |   variants:
139 |     "Python (synchronous API)":
140 |       language: python
141 |       code: |
142 |         import lmstudio as lms
143 | 
144 |         api_host = lms.Client.find_default_local_api_host()
145 |         if api_host is not None:
146 |             print(f"An LM Studio API server instance is available at {api_host}")
147 |           else:
148 |             print("No LM Studio API server instance found on any of the default local ports")
149 | 
150 |     "Python (asynchronous API)":
151 |       language: python
152 |       code: |
153 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
154 |         # Requires Python SDK version 1.5.0 or later
155 |         import lmstudio as lms
156 | 
157 |         api_host = await lms.AsyncClient.find_default_local_api_host()
158 |         if api_host is not None:
159 |             print(f"An LM Studio API server instance is available at {api_host}")
160 |           else:
161 |             print("No LM Studio API server instance found on any of the default local ports")
162 | ```
```

1_python/1_getting-started/repl.md
```
1 | ---
2 | title: "Using `lmstudio-python` in REPL"
3 | sidebar_title: "REPL Usage"
4 | description: "You can use `lmstudio-python` in REPL (Read-Eval-Print Loop) to interact with LLMs, manage models, and more."
5 | index: 2
6 | ---
7 | 
8 | To simplify interactive use, `lmstudio-python` offers a convenience API which manages
9 | its resources via `atexit` hooks, allowing a default synchronous client session
10 | to be used across multiple interactive commands.
11 | 
12 | This convenience API is shown in the examples throughout the documentation as the
13 | `Python (convenience API)` tab (alongside the `Python (scoped resource API)` examples,
14 | which use `with` statements to ensure deterministic cleanup of network communication
15 | resources).
16 | 
17 | The convenience API allows the standard Python REPL, or more flexible alternatives like
18 | Juypter Notebooks, to be used to interact with AI models loaded into LM Studio. For
19 | example:
20 | 
21 | ```lms_code_snippet
22 |   title: "Python REPL"
23 |   variants:
24 |     "Interactive chat session":
25 |       language: python
26 |       code: |
27 |         >>> import lmstudio as lms
28 |         >>> loaded_models = lms.list_loaded_models()
29 |         >>> for idx, model in enumerate(loaded_models):
30 |         ...     print(f"{idx:>3} {model}")
31 |         ...
32 |           0 LLM(identifier='qwen2.5-7b-instruct')
33 |         >>> model = loaded_models[0]
34 |         >>> chat = lms.Chat("You answer questions concisely")
35 |         >>> chat = lms.Chat("You answer questions concisely")
36 |         >>> chat.add_user_message("Tell me three fruits")
37 |         UserMessage(content=[TextData(text='Tell me three fruits')])
38 |         >>> print(model.respond(chat, on_message=chat.append))
39 |         Banana, apple, orange.
40 |         >>> chat.add_user_message("Tell me three more fruits")
41 |         UserMessage(content=[TextData(text='Tell me three more fruits')])
42 |         >>> print(model.respond(chat, on_message=chat.append))
43 |         Mango, strawberry, avocado.
44 |         >>> chat.add_user_message("How many fruits have you told me?")
45 |         UserMessage(content=[TextData(text='How many fruits have you told me?')])
46 |         >>> print(model.respond(chat, on_message=chat.append))
47 |         You asked for three initial fruits and three more, so I've listed a total of six fruits.
48 | 
49 | ```
50 | 
51 | While not primarily intended for use this way, the SDK's asynchronous structured concurrency API
52 | is compatible with the asynchronous Python REPL that is launched by `python -m asyncio`.
53 | For example:
54 | 
55 | ```lms_code_snippet
56 |   title: "Python REPL"
57 |   variants:
58 |     "Asynchronous chat session":
59 |       language: python
60 |       code: |
61 |         # Note: assumes use of the "python -m asyncio" asynchronous REPL (or equivalent)
62 |         # Requires Python SDK version 1.5.0 or later
63 |         >>> from contextlib import AsyncExitStack
64 |         >>> import lmstudio as lms
65 |         >>> resources = AsyncExitStack()
66 |         >>> client = await resources.enter_async_context(lms.AsyncClient())
67 |         >>> loaded_models = await client.llm.list_loaded()
68 |         >>> for idx, model in enumerate(loaded_models):
69 |         ...     print(f"{idx:>3} {model}")
70 |         ...
71 |           0 AsyncLLM(identifier='qwen2.5-7b-instruct-1m')
72 |         >>> model = loaded_models[0]
73 |         >>> chat = lms.Chat("You answer questions concisely")
74 |         >>> chat.add_user_message("Tell me three fruits")
75 |         UserMessage(content=[TextData(text='Tell me three fruits')])
76 |         >>> print(await model.respond(chat, on_message=chat.append))
77 |         Apple, banana, and orange.
78 |         >>> chat.add_user_message("Tell me three more fruits")
79 |         UserMessage(content=[TextData(text='Tell me three more fruits')])
80 |         >>> print(await model.respond(chat, on_message=chat.append))
81 |         Mango, strawberry, and pineapple.
82 |         >>> chat.add_user_message("How many fruits have you told me?")
83 |         UserMessage(content=[TextData(text='How many fruits have you told me?')])
84 |         >>> print(await model.respond(chat, on_message=chat.append))
85 |         You asked for three fruits initially, then three more, so I’ve listed six fruits in total.
86 | 
87 | ```
```

1_python/2_agent/_index.md
```
1 | ---
2 | title: Overview
3 | description: TODO...
4 | index: 1
5 | ---
6 | 
7 | ...
```

1_python/2_agent/act.md
```
1 | ---
2 | title: The `.act()` call
3 | description: How to use the `.act()` call to turn LLMs into autonomous agents that can perform tasks on your local machine.
4 | index: 1
5 | ---
6 | 
7 | ## Automatic tool calling
8 | 
9 | We introduce the concept of execution "rounds" to describe the combined process of running a tool, providing its output to the LLM, and then waiting for the LLM to decide what to do next.
10 | 
11 | **Execution Round**
12 | 
13 | ```
14 |  • run a tool ->
15 |  ↑   • provide the result to the LLM ->
16 |  │       • wait for the LLM to generate a response
17 |  │
18 |  └────────────────────────────────────────┘ └➔ (return)
19 | ```
20 | 
21 | A model might choose to run tools multiple times before returning a final result. For example, if the LLM is writing code, it might choose to compile or run the program, fix errors, and then run it again, rinse and repeat until it gets the desired result.
22 | 
23 | With this in mind, we say that the `.act()` API is an automatic "multi-round" tool calling API.
24 | 
25 | ### Quick Example
26 | 
27 | ```lms_code_snippet
28 |   variants:
29 |     "Python (convenience API)":
30 |       language: python
31 |       code: |
32 |         import lmstudio as lms
33 | 
34 |         def multiply(a: float, b: float) -> float:
35 |             """Given two numbers a and b. Returns the product of them."""
36 |             return a * b
37 | 
38 |         model = lms.llm("qwen2.5-7b-instruct")
39 |         model.act(
40 |           "What is the result of 12345 multiplied by 54321?",
41 |           [multiply],
42 |           on_message=print,
43 |         )
44 | ```
45 | 
46 | ### What does it mean for an LLM to "use a tool"?
47 | 
48 | LLMs are largely text-in, text-out programs. So, you may ask "how can an LLM use a tool?". The answer is that some LLMs are trained to ask the human to call the tool for them, and expect the tool output to to be provided back in some format.
49 | 
50 | Imagine you're giving computer support to someone over the phone. You might say things like "run this command for me ... OK what did it output? ... OK now click there and tell me what it says ...". In this case you're the LLM! And you're "calling tools" vicariously through the person on the other side of the line.
51 | 
52 | ### Running multiple tool calls in parallel
53 | 
54 | By default, version 1.4.0 and later of the Python SDK will only run a single tool call request at a time,
55 | even if the model requests multiple tool calls in a single response message. This ensures the requests will
56 | be processed correctly even if the tool implementations do not support multiple concurrent calls.
57 | 
58 | When the tool implementations are known to be thread-safe, and are both slow and frequent enough to be worth
59 | running in parallel, the `max_parallel_tool_calls` option specifies the maximum number of tool call requests
60 | that will be processed in parallel from a single model response. This value defaults to 1 (waiting for each
61 | tool call to complete before starting the next one). Setting this value to `None` will automatically scale
62 | the maximum number of parallel tool calls to a multiple of the number of CPU cores available to the process.
63 | 
64 | ### Important: Model Selection
65 | 
66 | The model selected for tool use will greatly impact performance.
67 | 
68 | Some general guidance when selecting a model:
69 | 
70 | - Not all models are capable of intelligent tool use
71 | - Bigger is better (i.e., a 7B parameter model will generally perform better than a 3B parameter model)
72 | - We've observed [Qwen2.5-7B-Instruct](https://model.lmstudio.ai/download/lmstudio-community/Qwen2.5-7B-Instruct-GGUF) to perform well in a wide variety of cases
73 | - This guidance may change
74 | 
75 | ### Example: Multiple Tools
76 | 
77 | The following code demonstrates how to provide multiple tools in a single `.act()` call.
78 | 
79 | ```lms_code_snippet
80 |   variants:
81 |     "Python (convenience API)":
82 |       language: python
83 |       code: |
84 |         import math
85 |         import lmstudio as lms
86 | 
87 |         def add(a: int, b: int) -> int:
88 |             """Given two numbers a and b, returns the sum of them."""
89 |             return a + b
90 | 
91 |         def is_prime(n: int) -> bool:
92 |             """Given a number n, returns True if n is a prime number."""
93 |             if n < 2:
94 |                 return False
95 |             sqrt = int(math.sqrt(n))
96 |             for i in range(2, sqrt):
97 |                 if n % i == 0:
98 |                     return False
99 |             return True
100 | 
101 |         model = lms.llm("qwen2.5-7b-instruct")
102 |         model.act(
103 |           "Is the result of 12345 + 45668 a prime? Think step by step.",
104 |           [add, is_prime],
105 |           on_message=print,
106 |         )
107 | ```
108 | 
109 | ### Example: Chat Loop with Create File Tool
110 | 
111 | The following code creates a conversation loop with an LLM agent that can create files.
112 | 
113 | ```lms_code_snippet
114 |   variants:
115 |     "Python (convenience API)":
116 |       language: python
117 |       code: |
118 |         import readline # Enables input line editing
119 |         from pathlib import Path
120 | 
121 |         import lmstudio as lms
122 | 
123 |         def create_file(name: str, content: str):
124 |             """Create a file with the given name and content."""
125 |             dest_path = Path(name)
126 |             if dest_path.exists():
127 |                 return "Error: File already exists."
128 |             try:
129 |                 dest_path.write_text(content, encoding="utf-8")
130 |             except Exception as exc:
131 |                 return "Error: {exc!r}"
132 |             return "File created."
133 | 
134 |         def print_fragment(fragment, round_index=0):
135 |             # .act() supplies the round index as the second parameter
136 |             # Setting a default value means the callback is also
137 |             # compatible with .complete() and .respond().
138 |             print(fragment.content, end="", flush=True)
139 | 
140 |         model = lms.llm()
141 |         chat = lms.Chat("You are a task focused AI assistant")
142 | 
143 |         while True:
144 |             try:
145 |                 user_input = input("You (leave blank to exit): ")
146 |             except EOFError:
147 |                 print()
148 |                 break
149 |             if not user_input:
150 |                 break
151 |             chat.add_user_message(user_input)
152 |             print("Bot: ", end="", flush=True)
153 |             model.act(
154 |                 chat,
155 |                 [create_file],
156 |                 on_message=chat.append,
157 |                 on_prediction_fragment=print_fragment,
158 |             )
159 |             print()
160 | 
161 | ```
162 | 
163 | ### Progress Callbacks
164 | 
165 | Complex interactions with a tool using agent may take some time to process.
166 | 
167 | The regular progress callbacks for any prediction request are available,
168 | but the expected capabilities differ from those for single round predictions.
169 | 
170 | * `on_prompt_processing_progress`: called during prompt processing for each
171 |   prediction round. Receives the progress ratio (as a float) and the round
172 |   index as positional arguments.
173 | * `on_first_token`: called after prompt processing is complete for each prediction round.
174 |   Receives the round index as its sole argument.
175 | * `on_prediction_fragment`: called for each prediction fragment received by the client.
176 |   Receives the prediction fragment and the round index as positional arguments.
177 | * `on_message`: called with an assistant response message when each prediction round is
178 |   complete, and with tool result messages as each tool call request is completed.
179 |   Intended for appending received messages to a chat history instance, and hence
180 |   does *not* receive the round index as an argument.
181 | 
182 | The following additional callbacks are available to monitor the prediction rounds:
183 | 
184 | * `on_round_start`: called before submitting the prediction request for each round.
185 |   Receives the round index as its sole argument.
186 | * `on_prediction_completed`: called after the prediction for the round has been completed,
187 |   but before any requested tool calls have been initiated. Receives the round's prediction
188 |   result as its sole argument. A round prediction result is a regular prediction result
189 |   with an additional `round_index` attribute.
190 | * `on_round_end`: called after any tool call requests for the round have been resolved.
191 | 
192 | Finally, applications may request notifications when agents emit invalid tool requests:
193 | 
194 | * `handle_invalid_tool_request`: called when a tool request was unable to be processed.
195 |   Receives the exception that is about to be reported, as well as the original tool
196 |   request that resulted in the problem. When no tool request is given, this is
197 |   purely a notification of an unrecoverable error before the agent interaction raises
198 |   the given exception (allowing the application to raise its own exception instead).
199 |   When a tool request is given, it indicates that rather than being raised locally,
200 |   the text description of the exception is going to be passed back to the agent
201 |   as the result of that failed tool request. In these cases, the callback may either
202 |   return `None` to indicate that the error description should be sent to the agent,
203 |   raise the given exception (or a different exception) locally, or return a text
204 |   string that should be sent to the agent instead of the error description.
205 | 
206 | For additional details on defining tools, and an example of overriding the invalid
207 | tool request handling to raise all exceptions locally instead of passing them to
208 | back the agent, refer to [Tool Definition](./tools.md).
```

1_python/2_agent/tools.md
```
1 | ---
2 | title: Tool Definition
3 | description: Define tools to be called by the LLM, and pass them to the model in the `act()` call.
4 | index: 2
5 | ---
6 | 
7 | You can define tools as regular Python functions and pass them to the model in the `act()` call.
8 | Alternatively, tools can be defined with `lmstudio.ToolFunctionDef` in order to control the
9 | name and description passed to the language model.
10 | 
11 | ## Anatomy of a Tool
12 | 
13 | Follow one of the following examples to define functions as tools (the first approach
14 | is typically going to be the most convenient):
15 | 
16 | ```lms_code_snippet
17 |   variants:
18 |     "Python function":
19 |       language: python
20 |       code: |
21 |         # Type hinted functions with clear names and docstrings
22 |         # may be used directly as tool definitions
23 |         def add(a: int, b: int) -> int:
24 |             """Given two numbers a and b, returns the sum of them."""
25 |             # The SDK ensures arguments are coerced to their specified types
26 |             return a + b
27 | 
28 |         # Pass `add` directly to `act()` as a tool definition
29 | 
30 |     "ToolFunctionDef.from_callable":
31 |       language: python
32 |       code: |
33 |         from lmstudio import ToolFunctionDef
34 | 
35 |         def cryptic_name(a: int, b: int) -> int:
36 |             return a + b
37 | 
38 |         # Type hinted functions with cryptic names and missing or poor docstrings
39 |         # can be turned into clear tool definitions with `from_callable`
40 |         tool_def = ToolFunctionDef.from_callable(
41 |           cryptic_name,
42 |           name="add",
43 |           description="Given two numbers a and b, returns the sum of them."
44 |         )
45 |         # Pass `tool_def` to `act()` as a tool definition
46 | 
47 |     "ToolFunctionDef":
48 |       language: python
49 |       code: |
50 |         from lmstudio import ToolFunctionDef
51 | 
52 |         def cryptic_name(a, b):
53 |             return a + b
54 | 
55 |         # Functions without type hints can be used without wrapping them
56 |         # at runtime by defining a tool function directly.
57 |         tool_def = ToolFunctionDef(
58 |           name="add",
59 |           description="Given two numbers a and b, returns the sum of them.",
60 |           parameters={
61 |             "a": int,
62 |             "b": int,
63 |           },
64 |           implementation=cryptic_name,
65 |         )
66 |         # Pass `tool_def` to `act()` as a tool definition
67 | 
68 | ```
69 | 
70 | **Important**: The tool name, description, and the parameter definitions are all passed to the model!
71 | 
72 | This means that your wording will affect the quality of the generation. Make sure to always provide a clear description of the tool so the model knows how to use it.
73 | 
74 | ## Tools with External Effects (like Computer Use or API Calls)
75 | 
76 | Tools can also have external effects, such as creating files or calling programs and even APIs. By implementing tools with external effects, you
77 | can essentially turn your LLMs into autonomous agents that can perform tasks on your local machine.
78 | 
79 | ## Example: `create_file_tool`
80 | 
81 | ### Tool Definition
82 | 
83 | ```lms_code_snippet
84 |   title: "create_file_tool.py"
85 |   variants:
86 |     Python:
87 |       language: python
88 |       code: |
89 |         from pathlib import Path
90 | 
91 |         def create_file(name: str, content: str):
92 |             """Create a file with the given name and content."""
93 |             dest_path = Path(name)
94 |             if dest_path.exists():
95 |                 return "Error: File already exists."
96 |             try:
97 |                 dest_path.write_text(content, encoding="utf-8")
98 |             except Exception as exc:
99 |                 return "Error: {exc!r}"
100 |             return "File created."
101 | 
102 | ```
103 | 
104 | ### Example code using the `create_file` tool:
105 | 
106 | ```lms_code_snippet
107 |   title: "example.py"
108 |   variants:
109 |     "Python (convenience API)":
110 |       language: python
111 |       code: |
112 |         import lmstudio as lms
113 |         from create_file_tool import create_file
114 | 
115 |         model = lms.llm("qwen2.5-7b-instruct")
116 |         model.act(
117 |           "Please create a file named output.txt with your understanding of the meaning of life.",
118 |           [create_file],
119 |         )
120 | ```
121 | 
122 | ## Handling tool calling errors
123 | 
124 | By default, version 1.3.0 and later of the Python SDK will automatically convert
125 | exceptions raised by tool calls to text and report them back to the language model.
126 | In many cases, when notified of an error in this way, a language model is able
127 | to either adjust its request to avoid the failure, or else accept the failure as
128 | a valid response to its request (consider a prompt like `Attempt to divide 1 by 0
129 | using the provided tool. Explain the result.`, where the expected
130 | response is an explanation of the `ZeroDivisionError` exception the Python
131 | interpreter raises when instructed to divide by zero).
132 | 
133 | This error handling behaviour can be overridden using the `handle_invalid_tool_request`
134 | callback. For example, the following code reverts the error handling back to raising
135 | exceptions locally in the client:
136 | 
137 | ```lms_code_snippet
138 |   title: "example.py"
139 |   variants:
140 |     "Python (convenience API)":
141 |       language: python
142 |       code: |
143 |         import lmstudio as lms
144 | 
145 |         def divide(numerator: float, denominator: float) -> float:
146 |             """Divide the given numerator by the given denominator. Return the result."""
147 |             return numerator / denominator
148 | 
149 |         model = lms.llm("qwen2.5-7b-instruct")
150 |         chat = Chat()
151 |         chat.add_user_message(
152 |             "Attempt to divide 1 by 0 using the tool. Explain the result."
153 |         )
154 | 
155 |         def _raise_exc_in_client(
156 |             exc: LMStudioPredictionError, request: ToolCallRequest | None
157 |         ) -> None:
158 |             raise exc
159 | 
160 |         act_result = llm.act(
161 |             chat,
162 |             [divide],
163 |             handle_invalid_tool_request=_raise_exc_in_client,
164 |         )
165 | ```
166 | 
167 | When a tool request is passed in, the callback results are processed as follows:
168 | 
169 | * `None`: the original exception text is passed to the LLM unmodified
170 | * a string: the returned string is passed to the LLM instead of the original
171 |   exception text
172 | * raising an exception (whether the passed in exception or a new exception):
173 |   the raised exception is propagated locally in the client, terminating the
174 |   prediction process
175 | 
176 | If no tool request is passed in, the callback invocation is a notification only,
177 | and the exception cannot be converted to text for passing pack to the LLM
178 | (although it can still be replaced with a different exception). These cases
179 | indicate failures in the expected communication with the server API that mean
180 | the prediction process cannot reasonably continue, so if the callback doesn't
181 | raise an exception, the calling code will raise the original exception directly.
```

1_python/3_embedding/index.md
```
1 | ---
2 | title: Embedding
3 | sidebar_title: Generating embedding vectors
4 | description: Generate text embeddings from input text
5 | ---
6 | 
7 | Generate embeddings for input text. Embeddings are vector representations of text that capture semantic meaning. Embeddings are a building block for RAG (Retrieval-Augmented Generation) and other similarity-based tasks.
8 | 
9 | ### Prerequisite: Get an Embedding Model
10 | 
11 | If you don't yet have an embedding model, you can download a model like `nomic-ai/nomic-embed-text-v1.5` using the following command:
12 | 
13 | ```bash
14 | lms get nomic-ai/nomic-embed-text-v1.5
15 | ```
16 | 
17 | ## Create Embeddings
18 | 
19 | To convert a string to a vector representation, pass it to the `embed` method on the corresponding embedding model handle.
20 | 
21 | ```lms_code_snippet
22 |   title: "example.py"
23 |   variants:
24 |     "Python (convenience API)":
25 |       language: python
26 |       code: |
27 |         import lmstudio as lms
28 | 
29 |         model = lms.embedding_model("nomic-embed-text-v1.5")
30 | 
31 |         embedding = model.embed("Hello, world!")
32 | 
33 | ```
```

1_python/5_manage-models/_download-models.md
```
1 | ---
2 | title: Download Models
3 | description: Download models to the machine running the LM Studio server
4 | ---
5 | 
6 | TODO: model downloading is available, but the current API is a bit awkward, so hold
7 |       off on documenting it until the interface is nicer to use
8 | 
9 | ## Overview
10 | 
11 | You can browse and download models using the LM Studio SDK just like you would
12 | in the Discover tab of the app itself. Once a model is downloaded, you can
13 | [load it](/docs/api/sdk/load-and-access-models) for inference.
14 | 
15 | ### Usage
16 | 
17 | Downloading models consists of three steps:
18 | 
19 | 1. Search for the model you want;
20 | 2. Find the download option you want (e.g. quantization) and
21 | 3. Download the model!
22 | 
23 | 
24 | TODO: Actually translate this example code from TS to Python
25 | 
26 | ```lms_code_snippet
27 |   variants:
28 |     "Python (convenience API)":
29 |       language: python
30 |       code: |
31 |         import { LMStudioClient } from "@lmstudio/sdk";
32 | 
33 |         const client = new LMStudioClient()
34 | 
35 |         # 1. Search for the model you want
36 |         # Specify any/all of searchTerm, limit, compatibilityTypes
37 |         const searchResults = client.repository.searchModels({
38 |           searchTerm: "llama 3.2 1b",    # Search for Llama 3.2 1B
39 |           limit: 5,                      # Get top 5 results
40 |           compatibilityTypes: ["gguf"],  # Only download GGUFs
41 |         })
42 | 
43 |         # 2. Find download options
44 |         const bestResult = searchResults[0];
45 |         const downloadOptions = bestResult.getDownloadOptions()
46 | 
47 |         # Let's download Q4_K_M, a good middle ground quantization
48 |         const desiredModel = downloadOptions.find(option => option.quantization === 'Q4_K_M')
49 | 
50 |         # 3. Download it!
51 |         const modelKey = desiredModel.download()
52 | 
53 |         # This returns a path you can use to load the model
54 |         const loadedModel = client.llm.model(modelKey)
55 | ```
56 | 
57 | ## Advanced Usage
58 | 
59 | ### Progress callbacks
60 | 
61 | TODO: TS/python differ in callback names
62 | 
63 | Model downloading can take a very long time, depending on your local network speed.
64 | If you want to get updates on the progress of this process, you can provide callbacks to `download`:
65 | one for progress updates and/or one when the download is being finalized
66 | (validating checksums, etc.)
67 | 
68 | ```lms_code_snippet
69 |   variants:
70 |     "Python (convenience API)":
71 |       language: python
72 |       code: |
73 |         import { LMStudioClient, type DownloadProgressUpdate } from "@lmstudio/sdk";
74 | 
75 |         function printProgressUpdate(update: DownloadProgressUpdate) {
76 |           process.stdout.write(`Downloaded ${update.downloadedBytes} bytes of ${update.totalBytes} total \
77 |                                 at ${update.speed_bytes_per_second} bytes/sec`)
78 |         }
79 | 
80 |         const client = new LMStudioClient()
81 | 
82 |         # ... Same code as before ...
83 | 
84 |         modelKey = desiredModel.download({
85 |           onProgress: printProgressUpdate,
86 |           onStartFinalizing: () => console.log("Finalizing..."),
87 |         })
88 | 
89 |         const loadedModel = client.llm.model(modelKey)
90 | 
91 |     "Python (scoped resource API)":
92 |       language: python
93 |       code: |
94 |         import lmstudio as lms
95 | 
96 |         def print_progress_update(update: lmstudio.DownloadProgressUpdate) -> None:
97 |             print(f"Downloaded {update.downloaded_bytes} bytes of {update.total_bytes} total \
98 |                     at {update.speed_bytes_per_second} bytes/sec")
99 | 
100 |         with lms.Client() as client:
101 |             # ... Same code as before ...
102 | 
103 |             model_key = desired_model.download(
104 |                 on_progress=print_progress_update,
105 |                 on_finalize: lambda: print("Finalizing download...")
106 |             )
107 | 
108 |     "Python (asynchronous API)":
109 |       language: python
110 |       code: |
111 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
112 |         # Requires Python SDK version 1.5.0 or later
113 |         import lmstudio as lms
114 | 
115 | ```
```

1_python/5_manage-models/list-downloaded.md
```
1 | ---
2 | title: List Downloaded Models
3 | description: APIs to list the available models in a given local environment
4 | ---
5 | 
6 | You can iterate through locally available models using the downloaded model listing methods.
7 | 
8 | The listing results offer `.model()` and `.load_new_instance()` methods, which allow the
9 | downloaded model reference to be converted in the full SDK handle for a loaded model.
10 | 
11 | ## Available Models on the LM Studio Server
12 | 
13 | ```lms_code_snippet
14 |   variants:
15 |     "Python (convenience API)":
16 |       language: python
17 |       code: |
18 |         import lmstudio as lms
19 | 
20 |         downloaded = lms.list_downloaded_models()
21 |         llm_only = lms.list_downloaded_models("llm")
22 |         embedding_only = lms.list_downloaded_models("embedding")
23 | 
24 |         for model in downloaded:
25 |             print(model)
26 | 
27 |     "Python (scoped resource API)":
28 |       language: python
29 |       code: |
30 |         import lmstudio as lms
31 | 
32 |         with lms.Client() as client:
33 |             downloaded = client.list_downloaded_models()
34 |             llm_only = client.llm.list_downloaded()
35 |             embedding_only = client.embedding.list_downloaded()
36 | 
37 |         for model in downloaded:
38 |             print(model)
39 | 
40 |     "Python (asynchronous API)":
41 |       language: python
42 |       code: |
43 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
44 |         # Requires Python SDK version 1.5.0 or later
45 |         import lmstudio as lms
46 | 
47 |         async with lms.AsyncClient() as client:
48 |             downloaded = await client.list_downloaded_models()
49 |             llm_only = await client.llm.list_downloaded()
50 |             embedding_only = await client.embedding.list_downloaded()
51 | 
52 |         for model in downloaded:
53 |             print(model)
54 | 
55 | ```
56 | This will give you results equivalent to using [`lms ls`](../../cli/ls) in the CLI.
57 | 
58 | 
59 | ### Example output:
60 | 
61 | ```python
62 | DownloadedLlm(model_key='qwen2.5-7b-instruct-1m', display_name='Qwen2.5 7B Instruct 1M', architecture='qwen2', vision=False)
63 | DownloadedEmbeddingModel(model_key='text-embedding-nomic-embed-text-v1.5', display_name='Nomic Embed Text v1.5', architecture='nomic-bert')
64 | ```
```

1_python/5_manage-models/list-loaded.md
```
1 | ---
2 | title: List Loaded Models
3 | description: Query which models are currently loaded
4 | ---
5 | 
6 | You can iterate through models loaded into memory using the functions and methods shown below.
7 | 
8 | The results are full SDK model handles, allowing access to all model functionality. 
9 | 
10 | 
11 | ## List Models Currently Loaded in Memory
12 | 
13 | This will give you results equivalent to using [`lms ps`](../../cli/ps) in the CLI.
14 | 
15 | ```lms_code_snippet
16 |   variants:
17 |     "Python (convenience API)":
18 |       language: python
19 |       code: |
20 |         import lmstudio as lms
21 | 
22 |         all_loaded_models = lms.list_loaded_models()
23 |         llm_only = lms.list_loaded_models("llm")
24 |         embedding_only = lms.list_loaded_models("embedding")
25 | 
26 |         print(all_loaded_models)
27 | 
28 |     Python (scoped resource API):
29 |       language: python
30 |       code: |
31 |         import lms
32 | 
33 |         with lms.Client() as client:
34 |             all_loaded_models = client.list_loaded_models()
35 |             llm_only = client.llm.list_loaded()
36 |             embedding_only = client.embedding.list_loaded()
37 | 
38 |             print(all_loaded_models)
39 | 
40 |     "Python (asynchronous API)":
41 |       language: python
42 |       code: |
43 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
44 |         # Requires Python SDK version 1.5.0 or later
45 |         import lmstudio as lms
46 | 
47 |         async with lms.AsyncClient() as client:
48 |             all_loaded_models = await client.list_loaded_models()
49 |             llm_only = await client.llm.list_loaded()
50 |             embedding_only = await client.embedding.list_loaded()
51 | 
52 |             print(all_loaded_models)
53 | 
54 | ```
```

1_python/5_manage-models/loading.md
```
1 | ---
2 | title: "Manage Models in Memory"
3 | sidebar_title: Load and Access Models
4 | description: APIs to load, access, and unload models from memory
5 | ---
6 | 
7 | AI models are huge. It can take a while to load them into memory. LM Studio's SDK allows you to precisely control this process.
8 | 
9 | **Model namespaces:**
10 | 
11 |   - LLMs are accessed through the `client.llm` namespace
12 |   - Embedding models are accessed through the `client.embedding` namespace
13 |   - `lmstudio.llm` is equivalent to `client.llm.model` on the default client
14 |   - `lmstudio.embedding_model` is equivalent to `client.embedding.model` on the default client
15 | 
16 | **Most commonly:**
17 |   - Use `.model()` to get any currently loaded model
18 |   - Use `.model("model-key")` to use a specific model
19 | 
20 | **Advanced (manual model management):**
21 |   - Use `.load_new_instance("model-key")` to load a new instance of a model
22 |   - Use `.unload("model-key")` or `model_handle.unload()` to unload a model from memory
23 | 
24 | ## Get the Current Model with `.model()`
25 | 
26 | If you already have a model loaded in LM Studio (either via the GUI or `lms load`),
27 | you can use it by calling `.model()` without any arguments.
28 | 
29 | ```lms_code_snippet
30 |   variants:
31 |     "Python (convenience API)":
32 |       language: python
33 |       code: |
34 |         import lmstudio as lms
35 | 
36 |         model = lms.llm()
37 | 
38 |     "Python (scoped resource API)":
39 |       language: python
40 |       code: |
41 |         import lmstudio as lms
42 | 
43 |         with lms.Client() as client:
44 |             model = client.llm.model()
45 | 
46 |     "Python (asynchronous API)":
47 |       language: python
48 |       code: |
49 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
50 |         # Requires Python SDK version 1.5.0 or later
51 |         import lmstudio as lms
52 | 
53 |         async with lms.AsyncClient() as client:
54 |             model = await client.llm.model()
55 | 
56 | ```
57 | 
58 | ## Get a Specific Model with `.model("model-key")`
59 | 
60 | If you want to use a specific model, you can provide the model key as an argument to `.model()`.
61 | 
62 | #### Get if Loaded, or Load if not
63 | Calling `.model("model-key")` will load the model if it's not already loaded, or return the existing instance if it is.
64 | 
65 | ```lms_code_snippet
66 |   variants:
67 |     "Python (convenience API)":
68 |       language: python
69 |       code: |
70 |         import lmstudio as lms
71 | 
72 |         model = lms.llm("llama-3.2-1b-instruct")
73 | 
74 |     "Python (scoped resource API)":
75 |       language: python
76 |       code: |
77 |         import lmstudio as lms
78 | 
79 |         with lms.Client() as client:
80 |             model = client.llm.model("llama-3.2-1b-instruct")
81 | 
82 |     "Python (asynchronous API)":
83 |       language: python
84 |       code: |
85 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
86 |         # Requires Python SDK version 1.5.0 or later
87 |         import lmstudio as lms
88 | 
89 |         async with lms.AsyncClient() as client:
90 |             model = await client.llm.model("llama-3.2-1b-instruct")
91 | 
92 | ```
93 | 
94 | <!--
95 | Learn more about the `.model()` method and the parameters it accepts in the [API Reference](../api-reference/model).
96 | -->
97 | 
98 | ## Load a New Instance of a Model with `.load_new_instance()`
99 | 
100 | Use `load_new_instance()` to load a new instance of a model, even if one already exists.
101 | This allows you to have multiple instances of the same or different models loaded at the same time.
102 | 
103 | ```lms_code_snippet
104 |   variants:
105 |     "Python (convenience API)":
106 |       language: python
107 |       code: |
108 |         import lmstudio as lms
109 | 
110 |         client = lms.get_default_client()
111 |         llama = client.llm.load_new_instance("llama-3.2-1b-instruct")
112 |         another_llama = client.llm.load_new_instance("llama-3.2-1b-instruct", "second-llama")
113 | 
114 |     "Python (scoped resource API)":
115 |       language: python
116 |       code: |
117 |         import lmstudio as lms
118 | 
119 |         with lms.Client() as client:
120 |             llama = client.llm.load_new_instance("llama-3.2-1b-instruct")
121 |             another_llama = client.llm.load_new_instance("llama-3.2-1b-instruct", "second-llama")
122 | 
123 |     "Python (asynchronous API)":
124 |       language: python
125 |       code: |
126 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
127 |         # Requires Python SDK version 1.5.0 or later
128 |         import lmstudio as lms
129 | 
130 |         async with lms.AsyncClient() as client:
131 |             llama = await client.llm.load_new_instance("llama-3.2-1b-instruct")
132 |             another_llama = await client.llm.load_new_instance("llama-3.2-1b-instruct", "second-llama")
133 | 
134 | ```
135 | 
136 | <!--
137 | Learn more about the `.load_new_instance()` method and the parameters it accepts in the [API Reference](../api-reference/load_new_instance).
138 | -->
139 | 
140 | ### Note about Instance Identifiers
141 | 
142 | If you provide an instance identifier that already exists, the server will throw an error.
143 | So if you don't really care, it's safer to not provide an identifier, in which case
144 | the server will generate one for you. You can always check in the server tab in LM Studio, too!
145 | 
146 | ## Unload a Model from Memory with `.unload()`
147 | 
148 | Once you no longer need a model, you can unload it by simply calling `unload()` on its handle.
149 | 
150 | ```lms_code_snippet
151 |   variants:
152 |     "Python (convenience API)":
153 |       language: python
154 |       code: |
155 |         import lmstudio as lms
156 | 
157 |         model = lms.llm()
158 |         model.unload()
159 | 
160 |     "Python (scoped resource API)":
161 |       language: python
162 |       code: |
163 |         import lmstudio as lms
164 | 
165 |         with lms.Client() as client:
166 |             model = client.llm.model()
167 |             model.unload()
168 | 
169 |     "Python (asynchronous API)":
170 |       language: python
171 |       code: |
172 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
173 |         # Requires Python SDK version 1.5.0 or later
174 |         import lmstudio as lms
175 | 
176 |         async with lms.AsyncClient() as client:
177 |             model = await client.llm.model()
178 |             await model.unload()
179 | 
180 | ```
181 | 
182 | ## Set Custom Load Config Parameters
183 | 
184 | You can also specify the same load-time configuration options when loading a model, such as Context Length and GPU offload. 
185 | 
186 | See [load-time configuration](../llm-prediction/parameters) for more.
187 | 
188 | ## Set an Auto Unload Timer (TTL)
189 | 
190 | You can specify a _time to live_ for a model you load, which is the idle time (in seconds)
191 | after the last request until the model unloads. See [Idle TTL](/docs/app/api/ttl-and-auto-evict) for more on this.
192 | 
193 | ```lms_protip
194 | If you specify a TTL to `model()`, it will only apply if `model()` loads
195 | a new instance, and will _not_ retroactively change the TTL of an existing instance.
196 | ```
197 | 
198 | ```lms_code_snippet
199 |   variants:
200 |     "Python (convenience API)":
201 |       language: python
202 |       code: |
203 |         import lmstudio as lms
204 | 
205 |         llama = lms.llm("llama-3.2-1b-instruct", ttl=3600)
206 | 
207 |     "Python (scoped resource API)":
208 |       language: python
209 |       code: |
210 |         import lmstudio as lms
211 | 
212 |         with lms.Client() as client:
213 |             llama = client.llm.model("llama-3.2-1b-instruct", ttl=3600)
214 | 
215 |     "Python (asynchronous API)":
216 |       language: python
217 |       code: |
218 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
219 |         # Requires Python SDK version 1.5.0 or later
220 |         import lmstudio as lms
221 | 
222 |         async with lms.AsyncClient() as client:
223 |             llama = await client.llm.model("llama-3.2-1b-instruct", ttl=3600)
224 | 
225 | ```
226 | 
227 | <!--
228 | (TODO?: Cover the JIT implications of setting a TTL, and the default TTL variations)
229 | -->
```

1_python/6_model-info/get-context-length.md
```
1 | ---
2 | title: Get Context Length
3 | description: API to get the maximum context length of a model.
4 | ---
5 | 
6 | LLMs and embedding models, due to their fundamental architecture, have a property called `context length`, and more specifically a **maximum** context length. Loosely speaking, this is how many tokens the models can "keep in memory" when generating text or embeddings. Exceeding this limit will result in the model behaving erratically.
7 | 
8 | ## Use the `get_context_length()` function on the model object
9 | 
10 | It's useful to be able to check the context length of a model, especially as an extra check before providing potentially long input to the model.
11 | 
12 | ```lms_code_snippet
13 |   title: "example.py"
14 |   variants:
15 |     "Python (convenience API)":
16 |       language: python
17 |       code: |
18 |         context_length = model.get_context_length()
19 | ```
20 | 
21 | The `model` in the above code snippet is an instance of a loaded model you get from the `llm.model` method. See [Manage Models in Memory](../manage-models/loading) for more information.
22 | 
23 | ### Example: Check if the input will fit in the model's context window
24 | 
25 | You can determine if a given conversation fits into a model's context by doing the following:
26 | 
27 | 1. Convert the conversation to a string using the prompt template.
28 | 2. Count the number of tokens in the string.
29 | 3. Compare the token count to the model's context length.
30 | 
31 | ```lms_code_snippet
32 |   variants:
33 |     "Python (convenience API)":
34 |       language: python
35 |       code: |
36 |         import lmstudio as lms
37 | 
38 |         def does_chat_fit_in_context(model: lms.LLM, chat: lms.Chat) -> bool:
39 |             # Convert the conversation to a string using the prompt template.
40 |             formatted = model.apply_prompt_template(chat)
41 |             # Count the number of tokens in the string.
42 |             token_count = len(model.tokenize(formatted))
43 |             # Get the current loaded context length of the model
44 |             context_length = model.get_context_length()
45 |             return token_count < context_length
46 | 
47 |         model = lms.llm()
48 | 
49 |         chat = lms.Chat.from_history({
50 |             "messages": [
51 |                 { "role": "user", "content": "What is the meaning of life." },
52 |                 { "role": "assistant", "content": "The meaning of life is..." },
53 |                 # ... More messages
54 |             ]
55 |         })
56 | 
57 |         print("Fits in context:", does_chat_fit_in_context(model, chat))
58 | 
59 | ```
```

1_python/6_model-info/get-load-config.md
```
1 | ---
2 | title: Get Load Config
3 | description: Get the load configuration of the model
4 | ---
5 | 
6 | *Required Python SDK version*: **1.2.0**
7 | 
8 | LM Studio allows you to configure certain parameters when loading a model
9 | [through the server UI](/docs/advanced/per-model) or [through the API](/docs/api/sdk/load-model).
10 | 
11 | You can retrieve the config with which a given model was loaded using the SDK.
12 | 
13 | In the below examples, the LLM reference can be replaced with an
14 | embedding model reference without requiring any other changes.
15 | 
16 | ```lms_protip
17 | Context length is a special case that [has its own method](/docs/api/sdk/get-context-length).
18 | ```
19 | 
20 | ```lms_code_snippet
21 |   variants:
22 |     "Python (convenience API)":
23 |       language: python
24 |       code: |
25 |         import lmstudio as lms
26 | 
27 |         model = lms.llm()
28 | 
29 |         print(model.get_load_config())
30 | 
31 |     "Python (scoped resource API)":
32 |       language: python
33 |       code: |
34 |         import lmstudio as lms
35 | 
36 |         with lms.Client() as client:
37 |             model = client.llm.model()
38 | 
39 |             print(model.get_load_config())
40 | 
41 |     "Python (asynchronous API)":
42 |       language: python
43 |       code: |
44 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
45 |         # Requires Python SDK version 1.5.0 or later
46 |         import lmstudio as lms
47 | 
48 |         async with lms.Client() as client:
49 |             model = await client.llm.model()
50 | 
51 |             print(await model.get_load_config())
52 | 
53 | ```
```

1_python/6_model-info/get-model-info.md
```
1 | ---
2 | title: Get Model Info
3 | description: Get information about the model
4 | ---
5 | 
6 | You can access general information and metadata about a model itself from a loaded
7 | instance of that model.
8 | 
9 | In the below examples, the LLM reference can be replaced with an
10 | embedding model reference without requiring any other changes.
11 | 
12 | ```lms_code_snippet
13 |   variants:
14 |     "Python (convenience API)":
15 |       language: python
16 |       code: |
17 |         import lmstudio as lms
18 | 
19 |         model = lms.llm()
20 | 
21 |         print(model.get_info())
22 | 
23 |     "Python (scoped resource API)":
24 |       language: python
25 |       code: |
26 |         import lmstudio as lms
27 | 
28 |         with lms.Client() as client:
29 |             model = client.llm.model()
30 | 
31 |             print(model.get_info())
32 | 
33 |     "Python (asynchronous API)":
34 |       language: python
35 |       code: |
36 |         # Note: assumes use of an async function or the "python -m asyncio" asynchronous REPL
37 |         # Requires Python SDK version 1.5.0 or later
38 |         import lmstudio as lms
39 | 
40 |         async with lms.AsyncClient() as client:
41 |             model = await client.llm.model()
42 | 
43 |             print(await model.get_info())
44 | 
45 | ```
46 | 
47 | ## Example output
48 | 
49 | ```python
50 | LlmInstanceInfo.from_dict({
51 |   "architecture": "qwen2",
52 |   "contextLength": 4096,
53 |   "displayName": "Qwen2.5 7B Instruct 1M",
54 |   "format": "gguf",
55 |   "identifier": "qwen2.5-7b-instruct",
56 |   "instanceReference": "lpFZPBQjhSZPrFevGyY6Leq8",
57 |   "maxContextLength": 1010000,
58 |   "modelKey": "qwen2.5-7b-instruct-1m",
59 |   "paramsString": "7B",
60 |   "path": "lmstudio-community/Qwen2.5-7B-Instruct-1M-GGUF/Qwen2.5-7B-Instruct-1M-Q4_K_M.gguf",
61 |   "sizeBytes": 4683073888,
62 |   "trainedForToolUse": true,
63 |   "type": "llm",
64 |   "vision": false
65 | })
66 | ```
```

1_python/_7_api-reference/act.md
```
1 | ---
2 | title: "`.act()`"
3 | sidebar_title: "`.act()`"
4 | description: ".act() - API reference for automatic tool use in a multi-turn chat conversation"
5 | index: 3
6 | ---
7 | 
8 | `.act()` is a method that generates automatic tool use in a multi-turn chat conversation.
```

1_python/_7_api-reference/chat.md
```
1 | ---
2 | title: "`Chat`"
3 | sidebar_title: "`Chat`"
4 | description: "`Chat` - API reference for representing a chat conversation with an LLM"
5 | index: 5
6 | ---
7 | 
8 | ...
```

1_python/_7_api-reference/complete.md
```
1 | ---
2 | title: "`.complete()`"
3 | sidebar_title: "`.complete()`"
4 | description: ".complete() - API reference for generating text completions from a loaded language model"
5 | index: 4
6 | ---
7 | 
8 | `.complete()` is a method that generates text completions from a loaded language model.
```

1_python/_7_api-reference/embed.md
```
1 | ---
2 | title: "`.embed()`"
3 | sidebar_title: "`.embed()`"
4 | description: ".embed() - API reference for generating embeddings from a loaded embedding model"
5 | ---
6 | 
7 | `.embed()` is a method that generates embeddings from a loaded embedding model.
```

1_python/_7_api-reference/llm-load-model-config.md
```
1 | ---
2 | title: "`LLMLoadModelConfig`"
3 | ---
4 | 
5 | ### Parameters
6 | 
7 | ```lms_params
8 | - name: gpu
9 |   description: |
10 |     How to distribute the work to your GPUs. See {@link GPUSetting} for more information.
11 |   public: true
12 |   type: GPUSetting
13 |   optional: true
14 | 
15 | - name: contextLength
16 |   description: |
17 |     The size of the context length in number of tokens. This will include both the prompts and the
18 |     responses. Once the context length is exceeded, the value set in
19 |     {@link LLMPredictionConfigBase#contextOverflowPolicy} is used to determine the behavior.
20 | 
21 |     See {@link LLMContextOverflowPolicy} for more information.
22 |   type: number
23 |   optional: true
24 | 
25 | - name: ropeFrequencyBase
26 |   description: |
27 |     Custom base frequency for rotary positional embeddings (RoPE).
28 | 
29 |     This advanced parameter adjusts how positional information is embedded in the model's
30 |     representations. Increasing this value may enable better performance at high context lengths by
31 |     modifying how the model processes position-dependent information.
32 |   type: number
33 |   optional: true
34 | 
35 | - name: ropeFrequencyScale
36 |   description: |
37 |     Scaling factor for RoPE (Rotary Positional Encoding) frequency.
38 | 
39 |     This factor scales the effective context window by modifying how positional information is
40 |     encoded. Higher values allow the model to handle longer contexts by making positional encoding
41 |     more granular, which can be particularly useful for extending a model beyond its original
42 |     training context length.
43 |   type: number
44 |   optional: true
45 | 
46 | - name: evalBatchSize
47 |   description: |
48 |     Number of input tokens to process together in a single batch during evaluation.
49 | 
50 |     Increasing this value typically improves processing speed and throughput by leveraging
51 |     parallelization, but requires more memory. Finding the optimal batch size often involves
52 |     balancing between performance gains and available hardware resources.
53 |   type: number
54 |   optional: true
55 | 
56 | - name: flashAttention
57 |   description: |
58 |     Enables Flash Attention for optimized attention computation.
59 | 
60 |     Flash Attention is an efficient implementation that reduces memory usage and speeds up
61 |     generation by optimizing how attention mechanisms are computed. This can significantly
62 |     improve performance on compatible hardware, especially for longer sequences.
63 |   type: boolean
64 |   optional: true
65 | 
66 | - name: keepModelInMemory
67 |   description: |
68 |     When enabled, prevents the model from being swapped out of system memory.
69 | 
70 |     This option reserves system memory for the model even when portions are offloaded to GPU,
71 |     ensuring faster access times when the model needs to be used. Improves performance
72 |     particularly for interactive applications, but increases overall RAM requirements.
73 |   type: boolean
74 |   optional: true
75 | 
76 | - name: seed
77 |   description: |
78 |     Random seed value for model initialization to ensure reproducible outputs.
79 | 
80 |     Setting a specific seed ensures that random operations within the model (like sampling)
81 |     produce the same results across different runs, which is important for reproducibility
82 |     in testing and development scenarios.
83 |   type: number
84 |   optional: true
85 | 
86 | - name: useFp16ForKVCache
87 |   description: |
88 |     When enabled, stores the key-value cache in half-precision (FP16) format.
89 | 
90 |     This option significantly reduces memory usage during inference by using 16-bit floating
91 |     point numbers instead of 32-bit for the attention cache. While this may slightly reduce
92 |     numerical precision, the impact on output quality is generally minimal for most applications.
93 |   type: boolean
94 |   optional: true
95 | 
96 | - name: tryMmap
97 |   description: |
98 |     Attempts to use memory-mapped (mmap) file access when loading the model.
99 | 
100 |     Memory mapping can improve initial load times by mapping model files directly from disk to
101 |     memory, allowing the operating system to handle paging. This is particularly beneficial for
102 |     quick startup, but may reduce performance if the model is larger than available system RAM,
103 |     causing frequent disk access.
104 |   type: boolean
105 |   optional: true
106 | 
107 | - name: numExperts
108 |   description: |
109 |     Specifies the number of experts to use for models with Mixture of Experts (MoE) architecture.
110 | 
111 |     MoE models contain multiple "expert" networks that specialize in different aspects of the task.
112 |     This parameter controls how many of these experts are active during inference, affecting both
113 |     performance and quality of outputs. Only applicable for models designed with the MoE architecture.
114 |   type: number
115 |   optional: true
116 | 
117 | - name: llamaKCacheQuantizationType
118 |   description: |
119 |     Quantization type for the Llama model's key cache.
120 | 
121 |     This option determines the precision level used to store the key component of the attention
122 |     mechanism's cache. Lower precision values (e.g., 4-bit or 8-bit quantization) significantly
123 |     reduce memory usage during inference but may slightly impact output quality. The effect varies
124 |     between different models, with some being more robust to quantization than others.
125 | 
126 |     Set to false to disable quantization and use full precision.
127 |   type: LLMLlamaCacheQuantizationType | false
128 |   optional: true
129 | 
130 | - name: llamaVCacheQuantizationType
131 |   description: |
132 |     Quantization type for the Llama model's value cache.
133 | 
134 |     Similar to the key cache quantization, this option controls the precision used for the value
135 |     component of the attention mechanism's cache. Reducing precision saves memory but may affect
136 |     generation quality. This option requires Flash Attention to be enabled to function properly.
137 | 
138 |     Different models respond differently to value cache quantization, so experimentation may be
139 |     needed to find the optimal setting for a specific use case. Set to false to disable quantization.
140 |   type: LLMLlamaCacheQuantizationType | false
141 |   optional: true
142 | ```
```

1_python/_7_api-reference/llm-namespace.md
```
1 | ---
2 | title: "`client.llm`"
3 | sidebar_title: "`client.llm` namespace"
4 | description: "`client.llm` - API reference for the llm namespace in an `LMStudioClient` instance"
5 | index: 6
6 | ---
7 | 
8 | ...
```

1_python/_7_api-reference/llm-prediction-config-input.md
```
1 | ---
2 | title: "`LLMPredictionConfigInput`"
3 | ---
4 | 
5 | ### Fields
6 | 
7 | ```lms_params
8 | - name: "maxTokens"
9 |   type: "number | false"
10 |   optional: true
11 |   description: "Number of tokens to predict at most. If set to false, the model will predict as many tokens as it wants.\n\nWhen the prediction is stopped because of this limit, the `stopReason` in the prediction stats will be set to `maxPredictedTokensReached`."
12 | 
13 | - name: "temperature"
14 |   type: "number"
15 |   optional: true
16 |   description: "The temperature parameter for the prediction model. A higher value makes the predictions more random, while a lower value makes the predictions more deterministic. The value should be between 0 and 1."
17 | 
18 | - name: "stopStrings"
19 |   type: "Array<string>"
20 |   optional: true
21 |   description: "An array of strings. If the model generates one of these strings, the prediction will stop.\n\nWhen the prediction is stopped because of this limit, the `stopReason` in the prediction stats will be set to `stopStringFound`."
22 | 
23 | - name: "toolCallStopStrings"
24 |   type: "Array<string>"
25 |   optional: true
26 |   description: "An array of strings. If the model generates one of these strings, the prediction will stop with the `stopReason` `toolCalls`."
27 | 
28 | - name: "contextOverflowPolicy"
29 |   type: "LLMContextOverflowPolicy"
30 |   optional: true
31 |   description: "The behavior for when the generated tokens length exceeds the context window size. The allowed values are:\n\n- `stopAtLimit`: Stop the prediction when the generated tokens length exceeds the context window size. If the generation is stopped because of this limit, the `stopReason` in the prediction stats will be set to `contextLengthReached`\n- `truncateMiddle`: Keep the system prompt and the first user message, truncate middle.\n- `rollingWindow`: Maintain a rolling window and truncate past messages."
32 | 
33 | - name: "structured"
34 |   type: "ZodType<TStructuredOutputType> | LLMStructuredPredictionSetting"
35 |   optional: true
36 |   description: "Configures the model to output structured JSON data that follows a specific schema defined using Zod.\n\nWhen you provide a Zod schema, the model will be instructed to generate JSON that conforms to that schema rather than free-form text.\n\nThis is particularly useful for extracting specific data points from model responses or when you need the output in a format that can be directly used by your application."
37 | 
38 | - name: "topKSampling"
39 |   type: "number"
40 |   optional: true
41 |   description: "Controls token sampling diversity by limiting consideration to the K most likely next tokens.\n\nFor example, if set to 40, only the 40 tokens with the highest probabilities will be considered for the next token selection. A lower value (e.g., 20) will make the output more focused and conservative, while a higher value (e.g., 100) allows for more creative and diverse outputs.\n\nTypical values range from 20 to 100."
42 | 
43 | - name: "repeatPenalty"
44 |   type: "number | false"
45 |   optional: true
46 |   description: "Applies a penalty to repeated tokens to prevent the model from getting stuck in repetitive patterns.\n\nA value of 1.0 means no penalty. Values greater than 1.0 increase the penalty. For example, 1.2 would reduce the probability of previously used tokens by 20%. This is particularly useful for preventing the model from repeating phrases or getting stuck in loops.\n\nSet to false to disable the penalty completely."
47 | 
48 | - name: "minPSampling"
49 |   type: "number | false"
50 |   optional: true
51 |   description: "Sets a minimum probability threshold that a token must meet to be considered for generation.\n\nFor example, if set to 0.05, any token with less than 5% probability will be excluded from consideration. This helps filter out unlikely or irrelevant tokens, potentially improving output quality.\n\nValue should be between 0 and 1. Set to false to disable this filter."
52 | 
53 | - name: "topPSampling"
54 |   type: "number | false"
55 |   optional: true
56 |   description: "Implements nucleus sampling by only considering tokens whose cumulative probabilities reach a specified threshold.\n\nFor example, if set to 0.9, the model will consider only the most likely tokens that together add up to 90% of the probability mass. This helps balance between diversity and quality by dynamically adjusting the number of tokens considered based on their probability distribution.\n\nValue should be between 0 and 1. Set to false to disable nucleus sampling."
57 | 
58 | - name: "xtcProbability"
59 |   type: "number | false"
60 |   optional: true
61 |   description: "Controls how often the XTC (Exclude Top Choices) sampling technique is applied during generation.\n\nXTC sampling can boost creativity and reduce clichés by occasionally filtering out common tokens. For example, if set to 0.3, there's a 30% chance that XTC sampling will be applied when generating each token.\n\nValue should be between 0 and 1. Set to false to disable XTC completely."
62 | 
63 | - name: "xtcThreshold"
64 |   type: "number | false"
65 |   optional: true
66 |   description: "Defines the lower probability threshold for the XTC (Exclude Top Choices) sampling technique.\n\nWhen XTC sampling is activated (based on xtcProbability), the algorithm identifies tokens with probabilities between this threshold and 0.5, then removes all such tokens except the least probable one. This helps introduce more diverse and unexpected tokens into the generation.\n\nOnly takes effect when xtcProbability is enabled."
67 | 
68 | - name: "cpuThreads"
69 |   type: "number"
70 |   optional: true
71 |   description: "Specifies the number of CPU threads to allocate for model inference.\n\nHigher values can improve performance on multi-core systems but may compete with other processes. For example, on an 8-core system, a value of 4-6 might provide good performance while leaving resources for other tasks.\n\nIf not specified, the system will use a default value based on available hardware."
72 | 
73 | - name: "draftModel"
74 |   type: "string"
75 |   optional: true
76 |   description: "The draft model to use for speculative decoding. Speculative decoding is a technique that can drastically increase the generation speed (up to 3x for larger models) by paring a main model with a smaller draft model.\n\nSee here for more information: https://lmstudio.ai/docs/advanced/speculative-decoding\n\nYou do not need to load the draft model yourself. Simply specifying its model key here is enough."
77 | ```
```

1_python/_7_api-reference/lmstudioclient.md
```
1 | ---
2 | title: "`LMStudioClient`"
3 | sidebar_title: "`LMStudioClient`"
4 | description: "LMStudioClient - API reference for the `LMStudioClient` class"
5 | index: 1
6 | ---
7 | 
8 | `LMStudioClient` is ...
```

1_python/_7_api-reference/model.md
```
1 | ---
2 | title: "`.model()`"
3 | sidebar_title: "`.model()`"
4 | description: ".model() - API reference for obtaining a model handle from an `LMStudioClient` instance"
5 | index: 2
6 | ---
7 | 
8 | `.model()` is a method that returns a model handle from an `LMStudioClient` instance.
9 | 
10 | TODO:
11 | 
12 | - Explain the difference between model(), model(key)
13 | - Explain when you're getting a loaded instance and when you're JIT loading a new one
```

1_python/_7_api-reference/respond.md
```
1 | ---
2 | title: "`.respond()`"
3 | sidebar_title: "`.respond()`"
4 | description: ".respond() - API reference for generating chat responses from a loaded language model"
5 | index: 2
6 | ---
7 | 
8 | `.respond()` is a method that generates chat responses from a loaded language model. 
```

1_python/_7_api-reference/system-namespace.md
```
1 | ---
2 | title: "`client.system`"
3 | sidebar_title: "`client.system` namespace"
4 | description: "`client.system` - API reference for the system namespace in an `LMStudioClient` instance"
5 | index: 6
6 | ---
7 | 
8 | ...
```

1_python/_more/_apply-prompt-template.md
```
1 | ---
2 | title: Apply Prompt Template
3 | description: Apply a model's prompt template to a conversation
4 | ---
5 | 
6 | ## Overview
7 | 
8 | LLMs (Large Language Models) operate on a text-in, text-out basis. Before processing conversations through these models, the input must be converted into a properly formatted string using a prompt template. If you need to inspect or work with this formatted string directly, the LM Studio SDK provides a streamlined way to apply a model's prompt template to your conversations.
9 | 
10 | ```lms_info
11 | You do not need to use this method when using `.respond`. It will automatically apply the prompt template for you.
12 | ```
13 | 
14 | ## Usage with a Chat
15 | 
16 | You can apply a prompt template to a `Chat` by using the `applyPromptTemplate` method. This method takes a `Chat` object as input and returns a formatted string.
17 | 
18 | ```lms_code_snippet
19 |   variants:
20 |     "Python (convenience API)":
21 |       language: python
22 |       code: |
23 |         import { Chat, LMStudioClient } from "@lmstudio/sdk";
24 | 
25 |         client = new LMStudioClient()
26 |         model = client.llm.model() # Use any loaded LLM
27 | 
28 |         chat = Chat.createEmpty()
29 |         chat.append("system", "You are a helpful assistant.")
30 |         chat.append("user", "What is LM Studio?")
31 |         
32 |         formatted = model.applyPromptTemplate(chat)
33 |         print(formatted)
34 | ```
35 | 
36 | ## Usage with an Array of Messages
37 | 
38 | The same method can also be used with any object that can be converted to a `Chat`, for example, an array of messages.
39 | 
40 | ```lms_code_snippet
41 |   variants:
42 |     "Python (convenience API)":
43 |       language: python
44 |       code: |
45 |         import { LMStudioClient } from "@lmstudio/sdk";
46 | 
47 |         client = new LMStudioClient()
48 |         model = client.llm.model() # Use any loaded LLM
49 | 
50 |         formatted = model.applyPromptTemplate([
51 |           { role: "system", content: "You are a helpful assistant." },
52 |           { role: "user", content: "What is LM Studio?" },
53 |         ])
54 |         print(formatted)
55 | ```
```

0_app/4_api/1_endpoints/openai.md
```
1 | ---
2 | title: OpenAI Compatibility API
3 | description: Send requests to Responses, Chat Completions (text and images), Completions, and Embeddings endpoints
4 | index: 1
5 | ---
6 | 
7 | Send requests to Responses, Chat Completions (text and images), Completions, and Embeddings endpoints.
8 | 
9 | <hr>
10 | 
11 | ### OpenAI-like API endpoints
12 | 
13 | LM Studio accepts requests on several OpenAI endpoints and returns OpenAI-like response objects.
14 | 
15 | #### Supported endpoints
16 | 
17 | ```
18 | GET  /v1/models
19 | POST /v1/responses
20 | POST /v1/chat/completions
21 | POST /v1/embeddings
22 | POST /v1/completions
23 | ```
24 | 
25 | ###### See below for more info about each endpoint
26 | 
27 | <hr>
28 | 
29 | ### Re-using an existing OpenAI client
30 | 
31 | ```lms_protip
32 | You can reuse existing OpenAI clients (in Python, JS, C#, etc) by switching up the "base URL" property to point to your LM Studio instead of OpenAI's servers.
33 | ```
34 | 
35 | #### Switching up the `base url` to point to LM Studio
36 | 
37 | ###### Note: The following examples assume the server port is `1234`
38 | 
39 | ##### Python
40 | 
41 | ```diff
42 | from openai import OpenAI
43 | 
44 | client = OpenAI(
45 | +    base_url="http://localhost:1234/v1"
46 | )
47 | 
48 | # ... the rest of your code ...
49 | ```
50 | 
51 | ##### Typescript
52 | 
53 | ```diff
54 | import OpenAI from 'openai';
55 | 
56 | const client = new OpenAI({
57 | +  baseUrl: "http://localhost:1234/v1"
58 | });
59 | 
60 | // ... the rest of your code ...
61 | ```
62 | 
63 | ##### cURL
64 | 
65 | ```diff
66 | - curl https://api.openai.com/v1/chat/completions \
67 | + curl http://localhost:1234/v1/chat/completions \
68 |   -H "Content-Type: application/json" \
69 |   -d '{
70 | -     "model": "gpt-4o-mini",
71 | +     "model": "use the model identifier from LM Studio here",
72 |      "messages": [{"role": "user", "content": "Say this is a test!"}],
73 |      "temperature": 0.7
74 |    }'
75 | ```
76 | 
77 | <hr>
78 | 
79 | ### Endpoints overview
80 | 
81 | #### `/v1/models`
82 | 
83 | - `GET` request
84 | - Lists the currently **loaded** models.
85 | 
86 | ##### cURL example
87 | 
88 | ```bash
89 | curl http://localhost:1234/v1/models
90 | ```
91 | 
92 | #### `/v1/responses`
93 | 
94 | - `POST` request
95 | - Create responses with an `input` field. Supports streaming, tool calling, reasoning, and stateful interactions via `previous_response_id`.
96 | - See OpenAI docs: https://platform.openai.com/docs/api-reference/responses
97 | 
98 | ##### cURL example (non‑streaming)
99 | 
100 | ```bash
101 | curl http://localhost:1234/v1/responses \
102 |   -H "Content-Type: application/json" \
103 |   -d '{
104 |     "model": "openai/gpt-oss-20b",
105 |     "input": "Provide a prime number less than 50",
106 |     "reasoning": { "effort": "low" }
107 |   }'
108 | ```
109 | 
110 | ##### Stateful follow‑up
111 | 
112 | Use the `id` from the previous response as `previous_response_id`.
113 | 
114 | ```bash
115 | curl http://localhost:1234/v1/responses \
116 |   -H "Content-Type: application/json" \
117 |   -d '{
118 |     "model": "openai/gpt-oss-20b",
119 |     "input": "Multiply it by 2",
120 |     "previous_response_id": "resp_123"
121 |   }'
122 | ```
123 | 
124 | ##### Streaming
125 | 
126 | ```bash
127 | curl http://localhost:1234/v1/responses \
128 |   -H "Content-Type: application/json" \
129 |   -d '{
130 |     "model": "openai/gpt-oss-20b",
131 |     "input": "Hello",
132 |     "stream": true
133 |   }'
134 | ```
135 | 
136 | You will receive SSE events like `response.created`, `response.output_text.delta`, and `response.completed`.
137 | 
138 | ##### Tools and Remote MCP (opt‑in)
139 | 
140 | Enable remote MCP in the app (Developer → Settings). Example payload using an MCP server tool:
141 | 
142 | ```bash
143 | curl http://localhost:1234/v1/responses \
144 |   -H "Content-Type: application/json" \
145 |   -d '{
146 |     "model": "openai/gpt-oss-20b",
147 |     "tools": [{
148 |       "type": "mcp",
149 |       "server_label": "tiktoken",
150 |       "server_url": "https://gitmcp.io/openai/tiktoken",
151 |       "allowed_tools": ["fetch_tiktoken_documentation"]
152 |     }],
153 |     "input": "What is the first sentence of the tiktoken documentation?"
154 |   }'
155 | ```
156 | 
157 | #### `/v1/chat/completions`
158 | 
159 | - `POST` request
160 | - Send a chat history and receive the assistant's response
161 | - Prompt template is applied automatically
162 | - You can provide inference parameters such as temperature in the payload. See [supported parameters](#supported-payload-parameters)
163 | - See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/chat) for more information
164 | - As always, keep a terminal window open with [`lms log stream`](/docs/cli/log-stream) to see what input the model receives
165 | 
166 | ##### Python example
167 | 
168 | ```python
169 | # Example: reuse your existing OpenAI setup
170 | from openai import OpenAI
171 | 
172 | # Point to the local server
173 | client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")
174 | 
175 | completion = client.chat.completions.create(
176 |   model="model-identifier",
177 |   messages=[
178 |     {"role": "system", "content": "Always answer in rhymes."},
179 |     {"role": "user", "content": "Introduce yourself."}
180 |   ],
181 |   temperature=0.7,
182 | )
183 | 
184 | print(completion.choices[0].message)
185 | ```
186 | 
187 | #### `/v1/embeddings`
188 | 
189 | - `POST` request
190 | - Send a string or array of strings and get an array of text embeddings (integer token IDs)
191 | - See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/embeddings) for more information
192 | 
193 | ##### Python example
194 | 
195 | ```python
196 | # Make sure to `pip install openai` first
197 | from openai import OpenAI
198 | client = OpenAI(base_url="http://localhost:1234/v1", api_key="lm-studio")
199 | 
200 | def get_embedding(text, model="model-identifier"):
201 |    text = text.replace("\n", " ")
202 |    return client.embeddings.create(input = [text], model=model).data[0].embedding
203 | 
204 | print(get_embedding("Once upon a time, there was a cat."))
205 | ```
206 | 
207 | #### `/v1/completions`
208 | 
209 | ```lms_warning
210 | This OpenAI-like endpoint is no longer supported by OpenAI.  LM Studio continues to support it.
211 | 
212 | Using this endpoint with chat-tuned models might result in unexpected behavior such as extraneous role tokens being emitted by the model.
213 | 
214 | 
215 | For best results, utilize a base model.
216 | ```
217 | 
218 | - `POST` request
219 | - Send a string and get the model's continuation of that string
220 | - See [supported payload parameters](#supported-payload-parameters)
221 | - Prompt template will NOT be applied, even if the model has one
222 | - See [OpenAI's documentation](https://platform.openai.com/docs/api-reference/completions) for more information
223 | - As always, keep a terminal window open with [`lms log stream`](/docs/cli/log-stream) to see what input the model receives
224 | 
225 | <hr>
226 | 
227 | ### Supported payload parameters
228 | 
229 | For an explanation for each parameter, see https://platform.openai.com/docs/api-reference/chat/create.
230 | 
231 | ```py
232 | model
233 | top_p
234 | top_k
235 | messages
236 | temperature
237 | max_tokens
238 | stream
239 | stop
240 | presence_penalty
241 | frequency_penalty
242 | logit_bias
243 | repeat_penalty
244 | seed
245 | ```
246 | 
247 | <hr>
248 | 
249 | ### Community
250 | 
251 | Chat with other LM Studio developers, discuss LLMs, hardware, and more on the [LM Studio Discord server](https://discord.gg/aPQfnNkxGC).
```

0_app/4_api/1_endpoints/rest.md
```
1 | ---
2 | title: LM Studio REST API (beta)
3 | description: "The REST API includes enhanced stats such as Token / Second and Time To First Token (TTFT), as well as rich information about models such as loaded vs unloaded, max context, quantization, and more."
4 | ---
5 | 
6 | `Experimental`
7 | 
8 | ##### Requires [LM Studio 0.3.6](/download) or newer. Still WIP, endpoints may change.
9 | 
10 | LM Studio now has its own REST API, in addition to OpenAI compatibility mode ([learn more](/docs/app/api/endpoints/openai)).
11 | 
12 | The REST API includes enhanced stats such as Token / Second and Time To First Token (TTFT), as well as rich information about models such as loaded vs unloaded, max context, quantization, and more.
13 | 
14 | #### Supported API Endpoints
15 | 
16 | - [`GET /api/v0/models`](#get-apiv0models) - List available models
17 | - [`GET /api/v0/models/{model}`](#get-apiv0modelsmodel) - Get info about a specific model
18 | - [`POST /api/v0/chat/completions`](#post-apiv0chatcompletions) - Chat Completions (messages -> assistant response)
19 | - [`POST /api/v0/completions`](#post-apiv0completions) - Text Completions (prompt -> completion)
20 | - [`POST /api/v0/embeddings`](#post-apiv0embeddings) - Text Embeddings (text -> embedding)
21 | 
22 | ###### 🚧 We are in the process of developing this interface. Let us know what's important to you on [Github](https://github.com/lmstudio-ai/lmstudio.js/issues) or by [email](mailto:bugs@lmstudio.ai).
23 | 
24 | ---
25 | 
26 | ### Start the REST API server
27 | 
28 | To start the server, run the following command:
29 | 
30 | ```bash
31 | lms server start
32 | ```
33 | 
34 | ```lms_protip
35 | You can run LM Studio as a service and get the server to auto-start on boot without launching the GUI. [Learn about Headless Mode](/docs/advanced/headless).
36 | ```
37 | 
38 | ## Endpoints
39 | 
40 | ### `GET /api/v0/models`
41 | 
42 | List all loaded and downloaded models
43 | 
44 | **Example request**
45 | 
46 | ```bash
47 | curl http://localhost:1234/api/v0/models
48 | ```
49 | 
50 | **Response format**
51 | 
52 | ```json
53 | {
54 |   "object": "list",
55 |   "data": [
56 |     {
57 |       "id": "qwen2-vl-7b-instruct",
58 |       "object": "model",
59 |       "type": "vlm",
60 |       "publisher": "mlx-community",
61 |       "arch": "qwen2_vl",
62 |       "compatibility_type": "mlx",
63 |       "quantization": "4bit",
64 |       "state": "not-loaded",
65 |       "max_context_length": 32768
66 |     },
67 |     {
68 |       "id": "meta-llama-3.1-8b-instruct",
69 |       "object": "model",
70 |       "type": "llm",
71 |       "publisher": "lmstudio-community",
72 |       "arch": "llama",
73 |       "compatibility_type": "gguf",
74 |       "quantization": "Q4_K_M",
75 |       "state": "not-loaded",
76 |       "max_context_length": 131072
77 |     },
78 |     {
79 |       "id": "text-embedding-nomic-embed-text-v1.5",
80 |       "object": "model",
81 |       "type": "embeddings",
82 |       "publisher": "nomic-ai",
83 |       "arch": "nomic-bert",
84 |       "compatibility_type": "gguf",
85 |       "quantization": "Q4_0",
86 |       "state": "not-loaded",
87 |       "max_context_length": 2048
88 |     }
89 |   ]
90 | }
91 | ```
92 | 
93 | ---
94 | 
95 | ### `GET /api/v0/models/{model}`
96 | 
97 | Get info about one specific model
98 | 
99 | **Example request**
100 | 
101 | ```bash
102 | curl http://localhost:1234/api/v0/models/qwen2-vl-7b-instruct
103 | ```
104 | 
105 | **Response format**
106 | 
107 | ```json
108 | {
109 |   "id": "qwen2-vl-7b-instruct",
110 |   "object": "model",
111 |   "type": "vlm",
112 |   "publisher": "mlx-community",
113 |   "arch": "qwen2_vl",
114 |   "compatibility_type": "mlx",
115 |   "quantization": "4bit",
116 |   "state": "not-loaded",
117 |   "max_context_length": 32768
118 | }
119 | ```
120 | 
121 | ---
122 | 
123 | ### `POST /api/v0/chat/completions`
124 | 
125 | Chat Completions API. You provide a messages array and receive the next assistant response in the chat.
126 | 
127 | **Example request**
128 | 
129 | ```bash
130 | curl http://localhost:1234/api/v0/chat/completions \
131 |   -H "Content-Type: application/json" \
132 |   -d '{
133 |     "model": "granite-3.0-2b-instruct",
134 |     "messages": [
135 |       { "role": "system", "content": "Always answer in rhymes." },
136 |       { "role": "user", "content": "Introduce yourself." }
137 |     ],
138 |     "temperature": 0.7,
139 |     "max_tokens": -1,
140 |     "stream": false
141 |   }'
142 | ```
143 | 
144 | **Response format**
145 | 
146 | ```json
147 | {
148 |   "id": "chatcmpl-i3gkjwthhw96whukek9tz",
149 |   "object": "chat.completion",
150 |   "created": 1731990317,
151 |   "model": "granite-3.0-2b-instruct",
152 |   "choices": [
153 |     {
154 |       "index": 0,
155 |       "logprobs": null,
156 |       "finish_reason": "stop",
157 |       "message": {
158 |         "role": "assistant",
159 |         "content": "Greetings, I'm a helpful AI, here to assist,\nIn providing answers, with no distress.\nI'll keep it short and sweet, in rhyme you'll find,\nA friendly companion, all day long you'll bind."
160 |       }
161 |     }
162 |   ],
163 |   "usage": {
164 |     "prompt_tokens": 24,
165 |     "completion_tokens": 53,
166 |     "total_tokens": 77
167 |   },
168 |   "stats": {
169 |     "tokens_per_second": 51.43709529007664,
170 |     "time_to_first_token": 0.111,
171 |     "generation_time": 0.954,
172 |     "stop_reason": "eosFound"
173 |   },
174 |   "model_info": {
175 |     "arch": "granite",
176 |     "quant": "Q4_K_M",
177 |     "format": "gguf",
178 |     "context_length": 4096
179 |   },
180 |   "runtime": {
181 |     "name": "llama.cpp-mac-arm64-apple-metal-advsimd",
182 |     "version": "1.3.0",
183 |     "supported_formats": ["gguf"]
184 |   }
185 | }
186 | ```
187 | 
188 | ---
189 | 
190 | ### `POST /api/v0/completions`
191 | 
192 | Text Completions API. You provide a prompt and receive a completion.
193 | 
194 | **Example request**
195 | 
196 | ```bash
197 | curl http://localhost:1234/api/v0/completions \
198 |   -H "Content-Type: application/json" \
199 |   -d '{
200 |     "model": "granite-3.0-2b-instruct",
201 |     "prompt": "the meaning of life is",
202 |     "temperature": 0.7,
203 |     "max_tokens": 10,
204 |     "stream": false,
205 |     "stop": "\n"
206 |   }'
207 | ```
208 | 
209 | **Response format**
210 | 
211 | ```json
212 | {
213 |   "id": "cmpl-p9rtxv6fky2v9k8jrd8cc",
214 |   "object": "text_completion",
215 |   "created": 1731990488,
216 |   "model": "granite-3.0-2b-instruct",
217 |   "choices": [
218 |     {
219 |       "index": 0,
220 |       "text": " to find your purpose, and once you have",
221 |       "logprobs": null,
222 |       "finish_reason": "length"
223 |     }
224 |   ],
225 |   "usage": {
226 |     "prompt_tokens": 5,
227 |     "completion_tokens": 9,
228 |     "total_tokens": 14
229 |   },
230 |   "stats": {
231 |     "tokens_per_second": 57.69230769230769,
232 |     "time_to_first_token": 0.299,
233 |     "generation_time": 0.156,
234 |     "stop_reason": "maxPredictedTokensReached"
235 |   },
236 |   "model_info": {
237 |     "arch": "granite",
238 |     "quant": "Q4_K_M",
239 |     "format": "gguf",
240 |     "context_length": 4096
241 |   },
242 |   "runtime": {
243 |     "name": "llama.cpp-mac-arm64-apple-metal-advsimd",
244 |     "version": "1.3.0",
245 |     "supported_formats": ["gguf"]
246 |   }
247 | }
248 | ```
249 | 
250 | ---
251 | 
252 | ### `POST /api/v0/embeddings`
253 | 
254 | Text Embeddings API. You provide a text and a representation of the text as an embedding vector is returned.
255 | 
256 | **Example request**
257 | 
258 | ```bash
259 | curl http://127.0.0.1:1234/api/v0/embeddings \
260 |   -H "Content-Type: application/json" \
261 |   -d '{
262 |     "model": "text-embedding-nomic-embed-text-v1.5",
263 |     "input": "Some text to embed"
264 |   }
265 | ```
266 | 
267 | **Example response**
268 | 
269 | ```json
270 | {
271 |   "object": "list",
272 |   "data": [
273 |     {
274 |       "object": "embedding",
275 |       "embedding": [
276 |         -0.016731496900320053,
277 |         0.028460891917347908,
278 |         -0.1407836228609085,
279 |         ... (truncated for brevity) ...,
280 |         0.02505224384367466,
281 |         -0.0037634256295859814,
282 |         -0.04341062530875206
283 |       ],
284 |       "index": 0
285 |     }
286 |   ],
287 |   "model": "text-embedding-nomic-embed-text-v1.5@q4_k_m",
288 |   "usage": {
289 |     "prompt_tokens": 0,
290 |     "total_tokens": 0
291 |   }
292 | }
293 | ```
294 | 
295 | ---
296 | 
297 | Please report bugs by opening an issue on [Github](https://github.com/lmstudio-ai/lmstudio-bug-tracker/issues).
```

0_app/2_plugins/mcp/deeplink.md
```
1 | ---
2 | title: "`Add to LM Studio` Button"
3 | description: Add MCP servers to LM Studio using a deeplink
4 | index: 2
5 | ---
6 | 
7 | You can install MCP servers in LM Studio with one click using a deeplink.
8 | 
9 | Starting with version 0.3.17 (10), LM Studio can act as an MCP host. Learn more about it [here](../mcp).
10 | 
11 | ---
12 | 
13 | # Generate your own MCP install link
14 | 
15 | Enter your MCP JSON entry to generate a deeplink for the `Add to LM Studio` button.
16 | 
17 | ```lms_mcp_deep_link_generator
18 | 
19 | ```
20 | 
21 | ## Try an example
22 | 
23 | Try to copy and paste the following into the link generator above.
24 | 
25 | ```json
26 | {
27 |   "hf-mcp-server": {
28 |     "url": "https://huggingface.co/mcp",
29 |     "headers": {
30 |       "Authorization": "Bearer <YOUR_HF_TOKEN>"
31 |     }
32 |   }
33 | }
34 | ```
35 | 
36 | <br>
37 | 
38 | ### Deeplink format
39 | 
40 | ```bash
41 | lmstudio://add_mcp?name=hf-mcp-server&config=eyJ1cmwiOiJodHRwczovL2h1Z2dpbmdmYWNlLmNvL21jcCIsImhlYWRlcnMiOnsiQXV0aG9yaXphdGlvbiI6IkJlYXJlciA8WU9VUl9IRl9UT0tFTj4ifX0%3D
42 | ```
43 | 
44 | #### Parameters
45 | 
46 | ```lms_params
47 | - name: "lmstudio://"
48 |   type: "protocol"
49 |   description: "The protocol scheme to open LM Studio"
50 | - name: "add_mcp"
51 |   type: "path"
52 |   description: "The action to install an MCP server"
53 | - name: "name"
54 |   type: "query parameter"
55 |   description: "The name of the MCP server to install"
56 | - name: "config"
57 |   type: "query parameter"
58 |   description: "Base64 encoded JSON configuration for the MCP server"
59 | ```
```

0_app/2_plugins/mcp/index.md
```
1 | ---
2 | title: Use MCP Servers
3 | description: Connect MCP servers to LM Studio
4 | index: 1
5 | ---
6 | 
7 | Starting LM Studio 0.3.17, LM Studio acts as an **Model Context Protocol (MCP) Host**. This means you can connect MCP servers to the app and make them available to your models.
8 | 
9 | ### Be cautious
10 | 
11 | Never install MCPs from untrusted sources.
12 | 
13 | ```lms_warning
14 | Some MCP servers can run arbitrary code, access your local files, and use your network connection. Always be cautious when installing and using MCP servers. If you don't trust the source, don't install it.
15 | ```
16 | 
17 | # Use MCP servers in LM Studio
18 | 
19 | Starting 0.3.17 (b10), LM Studio supports both local and remote MCP servers. You can add MCPs by editing the app's `mcp.json` file or via the ["Add to LM Studio" Button](mcp/deeplink), when available. LM Studio currently follows Cursor's `mcp.json` notation.
20 | 
21 | ## Install new servers: `mcp.json`
22 | 
23 | Switch to the "Program" tab in the right hand sidebar. Click `Install > Edit mcp.json`.
24 | 
25 | <img src="/assets/docs/install-mcp.png"  data-caption="" style="width: 80%;" className="" />
26 | 
27 | <br>
28 | 
29 | This will open the `mcp.json` file in the in-app editor. You can add MCP servers by editing this file.
30 | 
31 | <img src="/assets/docs/mcp-editor.png"  data-caption="Edit mcp.json using the in-app editor" style="width: 100%;" className="" />
32 | 
33 | ### Example MCP to try: Hugging Face MCP Server
34 | 
35 | This MCP server provides access to functions like model and dataset search.
36 | 
37 | <div className="w-fit">
38 |   <a style="background: rgb(255,255,255)" href="https://lmstudio.ai/install-mcp?name=hf-mcp-server&config=eyJ1cmwiOiJodHRwczovL2h1Z2dpbmdmYWNlLmNvL21jcCIsImhlYWRlcnMiOnsiQXV0aG9yaXphdGlvbiI6IkJlYXJlciA8WU9VUl9IRl9UT0tFTj4ifX0%3D">
39 |     <LightVariant>
40 |       <img src="https://files.lmstudio.ai/deeplink/mcp-install-light.svg" alt="Add MCP Server hf-mcp-server to LM Studio" />
41 |     </LightVariant>
42 |     <DarkVariant>
43 |       <img src="https://files.lmstudio.ai/deeplink/mcp-install-dark.svg" alt="Add MCP Server hf-mcp-server to LM Studio" />
44 |     </DarkVariant>
45 |   </a>
46 | </div>
47 | 
48 | ```json
49 | {
50 |   "mcpServers": {
51 |     "hf-mcp-server": {
52 |       "url": "https://huggingface.co/mcp",
53 |       "headers": {
54 |         "Authorization": "Bearer <YOUR_HF_TOKEN>"
55 |       }
56 |     }
57 |   }
58 | }
59 | ```
60 | 
61 | ###### You will need to replace `<YOUR_HF_TOKEN>` with your actual Hugging Face token. Learn more [here](https://huggingface.co/docs/hub/en/security-tokens).
62 | 
63 | Use the [deeplink button](mcp/deeplink), or copy the JSON snippet above and paste it into your `mcp.json` file.
64 | 
65 | ---
66 | 
67 | ## Gotchas and Troubleshooting
68 | 
69 | - Never install MCP servers from untrusted sources. Some MCPs can have far reaching access to your system.
70 | 
71 | - Some MCP servers were designed to be used with Claude, ChatGPT, Gemini and might use excessive amounts of tokens.
72 | 
73 |   - Watch out for this. It may quickly bog down your local model and trigger frequent context overflows.
74 | 
75 | - When adding MCP servers manually, copy only the content after `"mcpServers": {` and before the closing `}`.
```
