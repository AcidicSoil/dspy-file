Project Structure:
├── README.md
├── development-extension-rfc.md
├── index.ts
├── package.json
├── src
│   ├── agent
│   │   ├── executor.ts
│   │   ├── task.test.ts
│   │   └── task.ts
│   ├── config
│   │   ├── config.ts
│   │   ├── extension.ts
│   │   └── settings.ts
│   ├── http
│   │   ├── app.test.ts
│   │   ├── app.ts
│   │   ├── endpoints.test.ts
│   │   ├── requestStorage.ts
│   │   └── server.ts
│   ├── index.ts
│   ├── persistence
│   │   ├── gcs.test.ts
│   │   └── gcs.ts
│   ├── types.ts
│   └── utils
│       ├── executor_utils.ts
│       ├── logger.ts
│       └── testing_utils.ts
├── tsconfig.json
└── vitest.config.ts


development-extension-rfc.md
```
1 | # RFC: Gemini CLI A2A Development-Tool Extension
2 | 
3 | ## 1. Introduction
4 | 
5 | ### 1.1 Overview
6 | 
7 | To standardize client integrations with the Gemini CLI agent, this document
8 | proposes the `development-tool` extension for the A2A protocol.
9 | 
10 | Rather than creating a new protocol, this specification builds upon the existing
11 | A2A protocol. As an open-source standard recently adopted by the Linux
12 | Foundation, A2A provides a robust foundation for core concepts like tasks,
13 | messages, and streaming events. This extension-based approach allows us to
14 | leverage A2A's proven architecture while defining the specific capabilities
15 | required for rich, interactive workflows with the Gemini CLI agent.
16 | 
17 | ### 1.2 Motivation
18 | 
19 | Recent work integrating Gemini CLI with clients like Zed and Gemini Code
20 | Assist’s agent mode has highlighted the need for a robust, standard
21 | communication protocol. Standardizing on A2A provides several key advantages:
22 | 
23 | - **Solid Foundation**: Provides a robust, open standard that ensures a stable,
24 |   predictable, and consistent integration experience across different IDEs and
25 |   client surfaces.
26 | - **Extensibility**: Creates a flexible foundation to support new tools and
27 |   workflows as they emerge.
28 | - **Ecosystem Alignment**: Aligns Gemini CLI with a growing industry standard,
29 |   fostering broader interoperability.
30 | 
31 | ## 2. Communication Flow
32 | 
33 | The interaction follows A2A’s task-based, streaming pattern. The client sends a
34 | `message/stream` request and the agent responds with a `contextId` / `taskId`
35 | and a stream of events. `TaskStatusUpdateEvent` events are used to convey the
36 | overall state of the task. The task is complete when the agent sends a final
37 | `TaskStatusUpdateEvent` with `final: true` and a terminal status like
38 | `completed` or `failed`.
39 | 
40 | ### 2.1 Asynchronous Responses and Notifications
41 | 
42 | Clients that may disconnect from the agent should supply a
43 | `PushNotificationConfig` to the agent with the initial `message/stream` method
44 | or subsequently with the `tasks/pushNotificationConfig/set` method so that the
45 | agent can call back when updates are ready.
46 | 
47 | ## 3. The `development-tool` extension
48 | 
49 | ### 3.1 Overview
50 | 
51 | The `development-tool` extension establishes a communication contract for
52 | workflows between a client and the Gemini CLI agent. It consists of a
53 | specialized set of schemas, embedded within core A2A data structures, that
54 | enable the agent to stream real-time updates on its state and thought process.
55 | These schemas also provide the mechanism for the agent to request user
56 | permission before executing tools.
57 | 
58 | **Sample Agent Card**
59 | 
60 | ```json
61 | {
62 |   "name": "Gemini CLI Agent",
63 |   "description": "An agent that generates code based on natural language instructions.",
64 |   "capabilities": {
65 |     "streaming": true,
66 |     "extensions": [
67 |       {
68 |         "uri": "https://github.com/google-gemini/gemini-cli/blob/main/docs/a2a/developer-profile/v0/spec.md",
69 |         "description": "An extension for interactive development tasks, enabling features like code generation, tool usage, and real-time status updates.",
70 |         "required": true
71 |       }
72 |     ]
73 |   }
74 | }
75 | ```
76 | 
77 | **Versioning**
78 | 
79 | The agent card `uri` field contains an embedded semantic version. The client
80 | must extract this version to determine compatibility with the agent extension
81 | using the compatibility logic defined in Semantic Versioning 2.0.0 spec.
82 | 
83 | ### 3.2 Schema Definitions
84 | 
85 | This section defines the schemas for the `development-tool` A2A extension,
86 | organized by their function within the communication flow. Note that all custom
87 | objects included in the `metadata` field (e.g. `Message.metadata`) must be keyed
88 | by the unique URI that points to that extension’s spec to prevent naming
89 | collisions with other extensions.
90 | 
91 | **Initialization & Configuration**
92 | 
93 | The first message in a session must contain an `AgentSettings` object in its
94 | metadata. This object provides the agent with the necessary configuration
95 | information for proper initialization. Additional configuration settings (ex.
96 | MCP servers, allowed tools, etc.) can be added to this message.
97 | 
98 | **Schema**
99 | 
100 | ```proto
101 | syntax = "proto3";
102 | 
103 | // Configuration settings for the Gemini CLI agent.
104 | message AgentSettings {
105 |   // The absolute path to the workspace directory where the agent will execute.
106 |   string workspace_path = 1;
107 | }
108 | ```
109 | 
110 | **Agent-to-Client Messages**
111 | 
112 | All real-time updates from the agent (including its thoughts, tool calls, and
113 | simple text replies) are streamed to the client as `TaskStatusUpdateEvents`.
114 | 
115 | Each Event contains a `Message` object, which holds the content in one of two
116 | formats:
117 | 
118 | - **TextPart**: Used for standard text messages. This part requires no custom
119 |   schema.
120 | - **DataPart**: Used for complex, structured objects. Tool Calls and Thoughts
121 |   are sent this way, each using their respective schemas defined below.
122 | 
123 | **Tool Calls**
124 | 
125 | The `ToolCall` schema is designed to provide a structured representation of a
126 | tool’s execution lifecycle. This protocol defines a clear state machine and
127 | provides detailed schemas for common development tasks (file edits, shell
128 | commands, MCP Tool), ensuring clients can build reliable UIs without being tied
129 | to a specific agent implementation.
130 | 
131 | The core principle is that the agent sends a `ToolCall` object on every update.
132 | This makes client-side logic stateless and simple.
133 | 
134 | **Tool Call Lifecycle**
135 | 
136 | 1.  **Creation**: The agent sends a `ToolCall` object with `status: PENDING`. If
137 |     user permission is required, the `confirmation_request` field will be
138 |     populated.
139 | 2.  **Confirmation**: If the client needs to confirm the message, the client
140 |     will send a `ToolCallConfirmation`. If the client responds with a
141 |     cancellation, execution will be skipped.
142 | 3.  **Execution**: Once approved (or if no approval is required), the agent
143 |     sends an update with `status: EXECUTING`. It can stream real-time progress
144 |     by updating the `live_content` field.
145 | 4.  **Completion**: The agent sends a final update with the status set to
146 |     `SUCCEEDED`, `FAILED`, or `CANCELLED` and populates the appropriate result
147 |     field.
148 | 
149 | **Schema**
150 | 
151 | ```proto
152 | syntax = "proto3";
153 | 
154 | import "google/protobuf/struct.proto";
155 | 
156 | // ToolCall is the central message represeting a tool's execution lifecycle.
157 | // The entire object is sent from the agent to client on every update.
158 | message ToolCall {
159 |   // A unique identifier, assigned by the agent
160 |   string tool_call_id = 1;
161 | 
162 |   // The current state of the tool call in its lifecycle
163 |   ToolCallStatus status = 2;
164 | 
165 |   // Name of the tool being called (e.g. 'Edit', 'ShellTool')
166 |   string tool_name = 3;
167 | 
168 |   // An optional description of the tool call's purpose to show the user
169 |   optional string description = 4;
170 | 
171 |   // The structured input params provided by the LLM for tool invocation.
172 |   google.protobuf.Struct input_parameters = 5;
173 | 
174 |   // String containing the real-time output from the tool as it executes (primarily designed for shell output).
175 |   // During streaming the entire string is replaced on each update
176 |   optional string live_content = 6;
177 | 
178 |   // The final result of the tool (used to replace live_content when applicable)
179 |   oneof result {
180 |     // The output on tool success
181 |     ToolOutput output = 7;
182 |     // The error details if the tool failed
183 |     ErrorDetails error = 8;
184 |   }
185 | 
186 |   // If the tool requires user confirmation, this field will be populated while status is PENDING
187 |   optional ConfirmationRequest confirmation_request = 9;
188 | }
189 | 
190 | // Possible execution status of a ToolCall
191 | enum ToolCallStatus {
192 |   STATUS_UNSPECIFIED = 0;
193 |   PENDING = 1;
194 |   EXECUTING = 2;
195 |   SUCCEEDED = 3;
196 |   FAILED = 4;
197 |   CANCELLED = 5;
198 | }
199 | 
200 | // ToolOuput represents the final, successful, output of a tool
201 | message ToolOutput {
202 |   oneof result {
203 |     string text = 1;
204 |     // For ToolCalls which resulted in a file modification
205 |     FileDiff diff = 2;
206 |     // A generic fallback for any other structured JSON data
207 |     google.protobuf.Struct structured_data = 3;
208 |   }
209 | }
210 | 
211 | // A structured representation of an error
212 | message ErrorDetails {
213 |   // User facing error message
214 |   string message = 1;
215 |   // Optional agent-specific error type or category (e.g. read_content_failure, grep_execution_error, mcp_tool_error)
216 |   optional string type = 2;
217 |   // Optional status code
218 |   optional int32 status_code = 3;
219 | }
220 | 
221 | // ConfirmationRequest is sent from the agent to client to request user permission for a ToolCall
222 | message ConfirmationRequest {
223 |   // A list of choices for the user to select from
224 |   repeated ConfirmationOption options = 1;
225 |   // Specific details of the action requiring user confirmation
226 |   oneof details {
227 |     ExecuteDetails execute_details = 2;
228 |     FileDiff file_edit_details = 3;
229 |     McpDetails mcp_details = 4;
230 |     GenericDetails generic_details = 5;
231 |   }
232 | }
233 | 
234 | // A single choice presented to the user during a confirmation request
235 | message ConfirmationOption {
236 |   // Unique ID for the choice (e.g. proceed_once, cancel)
237 |   string id = 1;
238 |   // Human-readable choice (e.g. Allow Once, Reject).
239 |   string name = 2;
240 |   // An optional longer description for a tooltip
241 |   optional string description = 3;
242 | }
243 | 
244 | // Details for a request to execute a shell command
245 | message ExecuteDetails {
246 |   // The shell command to be executed
247 |   string command = 1;
248 |   // An optional directory in which the command will be run
249 |   optional string working_directory = 2;
250 | }
251 | 
252 | 
253 | message FileDiff {
254 |   string file_name = 1;
255 |   // The absolute path to the file to modify
256 |   string file_path = 2;
257 |   // The original content, if the file exists
258 |   optional string old_content = 3;
259 |   string new_content = 4;
260 |   // Pre-formatted diff string for display
261 |   optional string formatted_diff = 5;
262 | }
263 | 
264 | // Details for an MCP (Model Context Protocol) tool confirmation
265 | message McpDetails {
266 |   // The name of the MCP server that provides the tool
267 |   string server_name = 1;
268 |   // THe name of the tool being called from the MCP Server
269 |   string tool_name = 2;
270 | }
271 | 
272 | // Generic catch-all for ToolCall requests that don't fit other types
273 | message GenericDetails {
274 |   // Description of the action requiring confirmation
275 |   string description = 1;
276 | }
277 | ```
278 | 
279 | **Agent Thoughts**
280 | 
281 | **Schema**
282 | 
283 | ```proto
284 | syntax = "proto3";
285 | 
286 | // Represents a thought with a subject and a detailed description.
287 | message AgentThought {
288 |   // A concise subject line or title for the thought.
289 |   string subject = 1;
290 | 
291 |   // The description or elaboration of the thought itself.
292 |   string description = 2;
293 | }
294 | ```
295 | 
296 | **Event Metadata**
297 | 
298 | The `metadata` object in `TaskStatusUpdateEvent` is used by the A2A client to
299 | deserialize the `TaskStatusUpdateEvents` into their appropriate objects.
300 | 
301 | **Schema**
302 | 
303 | ```proto
304 | syntax = "proto3";
305 | 
306 | // A DevelopmentToolEvent event.
307 | message DevelopmentToolEvent {
308 |   // Enum representing the specific type of development tool event.
309 |   enum DevelopmentToolEventKind {
310 |     // The default, unspecified value.
311 |     DEVELOPMENT_TOOL_EVENT_KIND_UNSPECIFIED = 0;
312 |     TOOL_CALL_CONFIRMATION = 1;
313 |     TOOL_CALL_UPDATE = 2;
314 |     TEXT_CONTENT = 3;
315 |     STATE_CHANGE = 4;
316 |     THOUGHT = 5;
317 |   }
318 | 
319 |   // The specific kind of event that occurred.
320 |   DevelopmentToolEventKind kind = 1;
321 | 
322 |   // The model used for this event.
323 |   string model = 2;
324 | 
325 |   // The tier of the user (optional).
326 |   string user_tier = 3;
327 | 
328 |   // An unexpected error occurred in the agent execution (optional).
329 |   string error = 4;
330 | }
331 | ```
332 | 
333 | **Client-to-Agent Messages**
334 | 
335 | When the agent sends a `TaskStatusUpdateEvent` with `status.state` set to
336 | `input-required` and its message contains a `ConfirmationRequest`, the client
337 | must respond by sending a new `message/stream` request.
338 | 
339 | This new request must include the `contextId` and the `taskId` from the ongoing
340 | task and contain a `ToolCallConfirmation` object. This object conveys the user's
341 | decision regarding the tool call that was awaiting approval.
342 | 
343 | **Schema**
344 | 
345 | ```proto
346 | syntax = "proto3";
347 | 
348 | // The client's response to a ConfirmationRequest.
349 | message ToolCallConfirmation {
350 |   // A unique identifier, assigned by the agent
351 |   string tool_call_id = 1;
352 |   // The 'id' of the ConfirmationOption chosen by the user.
353 |   string selected_option_id = 2;
354 |   // Included if the user modifies the proposed change.
355 |   // The type should correspond to the original ConfirmationRequest details.
356 |   oneof modified_details {
357 |     // Corresponds to a FileDiff confirmation
358 |     ModifiedFileDetails file_details = 3;
359 |   }
360 | }
361 | 
362 | message ModifiedFileDetails {
363 |   // The new content after user edits.
364 |   string new_content = 1;
365 | }
366 | ```
367 | 
368 | ### 3.3 Method Definitions
369 | 
370 | This section defines the new methods introduced by the `development-tool`
371 | extension.
372 | 
373 | **Method: `commands/get`**
374 | 
375 | This method allows the client to discover slash commands supported by Gemini
376 | CLI. The client should call this method during startup to dynamically populate
377 | its command list.
378 | 
379 | ```proto
380 | // Response message containing the list of all top-level slash commands.
381 | message GetAllSlashCommandsResponse {
382 |   // A list of the top-level slash commands.
383 |   repeated SlashCommand commands = 1;
384 | }
385 | 
386 | // Represents a single slash command, which can contain subcommands.
387 | message SlashCommand {
388 |   // The primary name of the command.
389 |   string name = 1;
390 |   // A detailed description of what the command does.
391 |   string description = 2;
392 |   // A list of arguments that the command accepts.
393 |   repeated SlashCommandArgument arguments = 3;
394 |   // A list of nested subcommands.
395 |   repeated SlashCommand sub_commands = 4;
396 | }
397 | 
398 | // Defines the structure for a single slash command argument.
399 | message SlashCommandArgument {
400 |   // The name of the argument.
401 |   string name = 1;
402 |   // A brief description of what the argument is for.
403 |   string description = 2;
404 |   // Whether the argument is required or optional.
405 |   bool is_required = 3;
406 | }
407 | ```
408 | 
409 | **Method: `command/execute`**
410 | 
411 | This method allows the client to execute a slash command. Following the initial
412 | `ExecuteSlashCommandResponse`, the agent will use the standard streaming
413 | mechanism to communicate the command's progress and output. All subsequent
414 | updates, including textual output, agent thoughts, and any required user
415 | confirmations for tool calls (like executing a shell command), will be sent as
416 | `TaskStatusUpdateEvent` messages, re-using the schemas defined above.
417 | 
418 | ```proto
419 | // Request to execute a specific slash command.
420 | message ExecuteSlashCommandRequest {
421 |   // The path to the command, e.g., ["memory", "add"] for /memory add
422 |   repeated string command_path = 1;
423 |   // The arguments for the command as a single string.
424 |   string args = 2;
425 | }
426 | 
427 | // Enum for the initial status of a command execution request.
428 | enum CommandExecutionStatus {
429 |   // Default unspecified status.
430 |   COMMAND_EXECUTION_STATUS_UNSPECIFIED = 0;
431 |   // The command was successfully received and its execution has started.
432 |   STARTED = 1;
433 |   // The command failed to start (e.g., command not found, invalid format).
434 |   FAILED_TO_START = 2;
435 |   // The command has been paused and is waiting for the user to confirm
436 |   // a set of shell commands.
437 |   AWAITING_SHELL_CONFIRMATION = 3;
438 |   // The command has been paused and is waiting for the user to confirm
439 |   // a specific action.
440 |   AWAITING_ACTION_CONFIRMATION = 4;
441 | }
442 | 
443 | // The immediate, async response after requesting a command execution.
444 | message ExecuteSlashCommandResponse {
445 |   // A unique taskID for this specific command execution.
446 |   string execution_id = 1;
447 |   // The initial status of the command execution.
448 |   CommandExecutionStatus status = 2;
449 |   // An optional message, particularly useful for explaining why a command
450 |   // failed to start.
451 |   string message = 3;
452 | }
453 | ```
454 | 
455 | ## 4. Separation of Concerns
456 | 
457 | We believe that all client-side context (ex., workspace state) and client-side
458 | tool execution (ex. read active buffers) should be routed through MCP.
459 | 
460 | This approach enforces a strict separation of concerns: the A2A
461 | `development-tool` extension standardizes communication to the agent, while MCP
462 | serves as the single, authoritative interface for client-side capabilities.
463 | 
464 | ## Appendix
465 | 
466 | ### A. Example Interaction Flow
467 | 
468 | 1.  **Client -> Server**: The client sends a `message/stream` request containing
469 |     the initial prompt and configuration in an `AgentSettings` object.
470 | 2.  **Server -> Client**: SSE stream begins.
471 |     - **Event 1**: The server sends a `Task` object with
472 |       `status.state: 'submitted'` and the new `taskId`.
473 |     - **Event 2**: The server sends a `TaskStatusUpdateEvent` with the metadata
474 |       `kind` set to `'STATE_CHANGE'` and `status.state` set to `'working'`.
475 | 3.  **Agent Logic**: The agent processes the prompt and decides to call the
476 |     `write_file` tool, which requires user confirmation.
477 | 4.  **Server -> Client**:
478 |     - **Event 3**: The server sends a `TaskStatusUpdateEvent`. The metadata
479 |       `kind` is `'TOOL_CALL_UPDATE'`, and the `DataPart` contains a `ToolCall`
480 |       object with its `status` as `'PENDING'` and a populated
481 |       `confirmation_request`.
482 |     - **Event 4**: The server sends a final `TaskStatusUpdateEvent` for this
483 |       exchange. The metadata `kind` is `'STATE_CHANGE'`, the `status.state` is
484 |       `'input-required'`, and `final` is `true`. The stream for this request
485 |       ends.
486 | 5.  **Client**: The client UI renders the confirmation prompt based on the
487 |     `ToolCall` object from Event 3. The user clicks "Approve."
488 | 6.  **Client -> Server**: The client sends a new `message/stream` request. It
489 |     includes the `taskId` from the ongoing task and a `DataPart` containing a
490 |     `ToolCallConfirmation` object (e.g.,
491 |     `{"tool_call_id": "...", "selected_option_id": "proceed_once"}`).
492 | 7.  **Server -> Client**: A new SSE stream begins for the second request.
493 |     - **Event 1**: The server sends a `TaskStatusUpdateEvent` with
494 |       `kind: 'TOOL_CALL_UPDATE'`, containing the `ToolCall` object with its
495 |       `status` now set to `'EXECUTING'`.
496 |     - **Event 2**: After the tool runs, the server sends another
497 |       `TaskStatusUpdateEvent` with `kind: 'TOOL_CALL_UPDATE'`, containing the
498 |       `ToolCall` with its `status` as `'SUCCEEDED'`.
499 | 8.  **Agent Logic**: The agent receives the successful tool result and generates
500 |     a final textual response.
501 | 9.  **Server -> Client**:
502 |     - **Event 3**: The server sends a `TaskStatusUpdateEvent` with
503 |       `kind: 'TEXT_CONTENT'` and a `TextPart` containing the agent's final
504 |       answer.
505 |     - **Event 4**: The server sends the final `TaskStatusUpdateEvent`. The
506 |       `kind` is `'STATE_CHANGE'`, the `status.state` is `'completed'`, and
507 |       `final` is `true`. The stream ends.
508 | 10. **Client**: The client displays the final answer. The task is now complete
509 |     but can be continued by sending another message with the same `taskId`.
```

index.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | export * from './src/index.js';
```

package.json
```
1 | {
2 |   "name": "@google/gemini-cli-a2a-server",
3 |   "version": "0.10.0-nightly.20251007.c195a9aa",
4 |   "private": true,
5 |   "description": "Gemini CLI A2A Server",
6 |   "repository": {
7 |     "type": "git",
8 |     "url": "git+https://github.com/google-gemini/gemini-cli.git",
9 |     "directory": "packages/a2a-server"
10 |   },
11 |   "type": "module",
12 |   "main": "dist/index.js",
13 |   "bin": {
14 |     "gemini-cli-a2a-server": "dist/a2a-server.mjs"
15 |   },
16 |   "scripts": {
17 |     "build": "node ../../scripts/build_package.js",
18 |     "start": "node dist/src/http/server.js",
19 |     "lint": "eslint . --ext .ts,.tsx",
20 |     "format": "prettier --write .",
21 |     "test": "vitest run",
22 |     "test:ci": "vitest run --coverage",
23 |     "typecheck": "tsc --noEmit"
24 |   },
25 |   "files": [
26 |     "dist"
27 |   ],
28 |   "dependencies": {
29 |     "@a2a-js/sdk": "^0.3.2",
30 |     "@google-cloud/storage": "^7.16.0",
31 |     "@google/gemini-cli-core": "file:../core",
32 |     "express": "^5.1.0",
33 |     "fs-extra": "^11.3.0",
34 |     "tar": "^7.4.3",
35 |     "uuid": "^11.1.0",
36 |     "winston": "^3.17.0"
37 |   },
38 |   "devDependencies": {
39 |     "@types/express": "^5.0.3",
40 |     "@types/fs-extra": "^11.0.4",
41 |     "@types/supertest": "^6.0.3",
42 |     "@types/tar": "^6.1.13",
43 |     "dotenv": "^16.4.5",
44 |     "supertest": "^7.1.4",
45 |     "typescript": "^5.3.3",
46 |     "vitest": "^3.1.1"
47 |   },
48 |   "engines": {
49 |     "node": ">=20"
50 |   }
51 | }
```

tsconfig.json
```
1 | {
2 |   "extends": "../../tsconfig.json",
3 |   "compilerOptions": {
4 |     "outDir": "dist",
5 |     "lib": ["DOM", "DOM.Iterable", "ES2023"],
6 |     "composite": true,
7 |     "types": ["node", "vitest/globals"]
8 |   },
9 |   "include": ["index.ts", "src/**/*.ts", "src/**/*.json"],
10 |   "exclude": ["node_modules", "dist"]
11 | }
```

vitest.config.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | /// <reference types="vitest" />
8 | import { defineConfig } from 'vitest/config';
9 | 
10 | export default defineConfig({
11 |   test: {
12 |     include: ['**/*.{test,spec}.?(c|m)[jt]s?(x)'],
13 |     exclude: ['**/node_modules/**', '**/dist/**'],
14 |     environment: 'jsdom',
15 |     globals: true,
16 |     reporters: ['default', 'junit'],
17 |     silent: true,
18 |     outputFile: {
19 |       junit: 'junit.xml',
20 |     },
21 |     coverage: {
22 |       enabled: true,
23 |       provider: 'v8',
24 |       reportsDirectory: './coverage',
25 |       include: ['src/**/*'],
26 |       reporter: [
27 |         ['text', { file: 'full-text-summary.txt' }],
28 |         'html',
29 |         'json',
30 |         'lcov',
31 |         'cobertura',
32 |         ['json-summary', { outputFile: 'coverage-summary.json' }],
33 |       ],
34 |     },
35 |     poolOptions: {
36 |       threads: {
37 |         minThreads: 8,
38 |         maxThreads: 16,
39 |       },
40 |     },
41 |     server: {
42 |       deps: {
43 |         inline: [/@google\/gemini-cli-core/],
44 |       },
45 |     },
46 |   },
47 | });
```

src/index.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | export * from './agent/executor.js';
8 | export * from './http/app.js';
9 | export * from './types.js';
```

src/types.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type {
8 |   MCPServerStatus,
9 |   ToolConfirmationOutcome,
10 | } from '@google/gemini-cli-core';
11 | import type { TaskState } from '@a2a-js/sdk';
12 | 
13 | // Interfaces and enums for the CoderAgent protocol.
14 | 
15 | export enum CoderAgentEvent {
16 |   /**
17 |    * An event requesting one or more tool call confirmations.
18 |    */
19 |   ToolCallConfirmationEvent = 'tool-call-confirmation',
20 |   /**
21 |    * An event updating on the status of one or more tool calls.
22 |    */
23 |   ToolCallUpdateEvent = 'tool-call-update',
24 |   /**
25 |    * An event providing text updates on the task.
26 |    */
27 |   TextContentEvent = 'text-content',
28 |   /**
29 |    * An event that indicates a change in the task's execution state.
30 |    */
31 |   StateChangeEvent = 'state-change',
32 |   /**
33 |    * An user-sent event to initiate the agent.
34 |    */
35 |   StateAgentSettingsEvent = 'agent-settings',
36 |   /**
37 |    * An event that contains a thought from the agent.
38 |    */
39 |   ThoughtEvent = 'thought',
40 | }
41 | 
42 | export interface AgentSettings {
43 |   kind: CoderAgentEvent.StateAgentSettingsEvent;
44 |   workspacePath: string;
45 | }
46 | 
47 | export interface ToolCallConfirmation {
48 |   kind: CoderAgentEvent.ToolCallConfirmationEvent;
49 | }
50 | 
51 | export interface ToolCallUpdate {
52 |   kind: CoderAgentEvent.ToolCallUpdateEvent;
53 | }
54 | 
55 | export interface TextContent {
56 |   kind: CoderAgentEvent.TextContentEvent;
57 | }
58 | 
59 | export interface StateChange {
60 |   kind: CoderAgentEvent.StateChangeEvent;
61 | }
62 | 
63 | export interface Thought {
64 |   kind: CoderAgentEvent.ThoughtEvent;
65 | }
66 | 
67 | export type ThoughtSummary = {
68 |   subject: string;
69 |   description: string;
70 | };
71 | 
72 | export interface ToolConfirmationResponse {
73 |   outcome: ToolConfirmationOutcome;
74 |   callId: string;
75 | }
76 | 
77 | export type CoderAgentMessage =
78 |   | AgentSettings
79 |   | ToolCallConfirmation
80 |   | ToolCallUpdate
81 |   | TextContent
82 |   | StateChange
83 |   | Thought;
84 | 
85 | export interface TaskMetadata {
86 |   id: string;
87 |   contextId: string;
88 |   taskState: TaskState;
89 |   model: string;
90 |   mcpServers: Array<{
91 |     name: string;
92 |     status: MCPServerStatus;
93 |     tools: Array<{
94 |       name: string;
95 |       description: string;
96 |       parameterSchema: unknown;
97 |     }>;
98 |   }>;
99 |   availableTools: Array<{
100 |     name: string;
101 |     description: string;
102 |     parameterSchema: unknown;
103 |   }>;
104 | }
105 | 
106 | export interface PersistedStateMetadata {
107 |   _agentSettings: AgentSettings;
108 |   _taskState: TaskState;
109 | }
110 | 
111 | export type PersistedTaskMetadata = { [k: string]: unknown };
112 | 
113 | export const METADATA_KEY = '__persistedState';
114 | 
115 | export function getPersistedState(
116 |   metadata: PersistedTaskMetadata,
117 | ): PersistedStateMetadata | undefined {
118 |   return metadata?.[METADATA_KEY] as PersistedStateMetadata | undefined;
119 | }
120 | 
121 | export function setPersistedState(
122 |   metadata: PersistedTaskMetadata,
123 |   state: PersistedStateMetadata,
124 | ): PersistedTaskMetadata {
125 |   return {
126 |     ...metadata,
127 |     [METADATA_KEY]: state,
128 |   };
129 | }
```

src/agent/executor.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type { Message, Task as SDKTask } from '@a2a-js/sdk';
8 | import type {
9 |   TaskStore,
10 |   AgentExecutor,
11 |   AgentExecutionEvent,
12 |   RequestContext,
13 |   ExecutionEventBus,
14 | } from '@a2a-js/sdk/server';
15 | import type {
16 |   ToolCallRequestInfo,
17 |   ServerGeminiToolCallRequestEvent,
18 |   Config,
19 | } from '@google/gemini-cli-core';
20 | import { GeminiEventType } from '@google/gemini-cli-core';
21 | import { v4 as uuidv4 } from 'uuid';
22 | 
23 | import { logger } from '../utils/logger.js';
24 | import type {
25 |   StateChange,
26 |   AgentSettings,
27 |   PersistedStateMetadata,
28 | } from '../types.js';
29 | import {
30 |   CoderAgentEvent,
31 |   getPersistedState,
32 |   setPersistedState,
33 | } from '../types.js';
34 | import { loadConfig, loadEnvironment, setTargetDir } from '../config/config.js';
35 | import { loadSettings } from '../config/settings.js';
36 | import { loadExtensions } from '../config/extension.js';
37 | import { Task } from './task.js';
38 | import { requestStorage } from '../http/requestStorage.js';
39 | import { pushTaskStateFailed } from '../utils/executor_utils.js';
40 | 
41 | /**
42 |  * Provides a wrapper for Task. Passes data from Task to SDKTask.
43 |  * The idea is to use this class inside CoderAgentExecutor to replace Task.
44 |  */
45 | class TaskWrapper {
46 |   task: Task;
47 |   agentSettings: AgentSettings;
48 | 
49 |   constructor(task: Task, agentSettings: AgentSettings) {
50 |     this.task = task;
51 |     this.agentSettings = agentSettings;
52 |   }
53 | 
54 |   get id() {
55 |     return this.task.id;
56 |   }
57 | 
58 |   toSDKTask(): SDKTask {
59 |     const persistedState: PersistedStateMetadata = {
60 |       _agentSettings: this.agentSettings,
61 |       _taskState: this.task.taskState,
62 |     };
63 | 
64 |     const sdkTask: SDKTask = {
65 |       id: this.task.id,
66 |       contextId: this.task.contextId,
67 |       kind: 'task',
68 |       status: {
69 |         state: this.task.taskState,
70 |         timestamp: new Date().toISOString(),
71 |       },
72 |       metadata: setPersistedState({}, persistedState),
73 |       history: [],
74 |       artifacts: [],
75 |     };
76 |     sdkTask.metadata!['_contextId'] = this.task.contextId;
77 |     return sdkTask;
78 |   }
79 | }
80 | 
81 | /**
82 |  * CoderAgentExecutor implements the agent's core logic for code generation.
83 |  */
84 | export class CoderAgentExecutor implements AgentExecutor {
85 |   private tasks: Map<string, TaskWrapper> = new Map();
86 |   // Track tasks with an active execution loop.
87 |   private executingTasks = new Set<string>();
88 | 
89 |   constructor(private taskStore?: TaskStore) {}
90 | 
91 |   private async getConfig(
92 |     agentSettings: AgentSettings,
93 |     taskId: string,
94 |   ): Promise<Config> {
95 |     const workspaceRoot = setTargetDir(agentSettings);
96 |     loadEnvironment(); // Will override any global env with workspace envs
97 |     const settings = loadSettings(workspaceRoot);
98 |     const extensions = loadExtensions(workspaceRoot);
99 |     return await loadConfig(settings, extensions, taskId);
100 |   }
101 | 
102 |   /**
103 |    * Reconstructs TaskWrapper from SDKTask.
104 |    */
105 |   async reconstruct(
106 |     sdkTask: SDKTask,
107 |     eventBus?: ExecutionEventBus,
108 |   ): Promise<TaskWrapper> {
109 |     const metadata = sdkTask.metadata || {};
110 |     const persistedState = getPersistedState(metadata);
111 | 
112 |     if (!persistedState) {
113 |       throw new Error(
114 |         `Cannot reconstruct task ${sdkTask.id}: missing persisted state in metadata.`,
115 |       );
116 |     }
117 | 
118 |     const agentSettings = persistedState._agentSettings;
119 |     const config = await this.getConfig(agentSettings, sdkTask.id);
120 |     const contextId: string =
121 |       (metadata['_contextId'] as string) || sdkTask.contextId;
122 |     const runtimeTask = await Task.create(
123 |       sdkTask.id,
124 |       contextId,
125 |       config,
126 |       eventBus,
127 |     );
128 |     runtimeTask.taskState = persistedState._taskState;
129 |     await runtimeTask.geminiClient.initialize();
130 | 
131 |     const wrapper = new TaskWrapper(runtimeTask, agentSettings);
132 |     this.tasks.set(sdkTask.id, wrapper);
133 |     logger.info(`Task ${sdkTask.id} reconstructed from store.`);
134 |     return wrapper;
135 |   }
136 | 
137 |   async createTask(
138 |     taskId: string,
139 |     contextId: string,
140 |     agentSettingsInput?: AgentSettings,
141 |     eventBus?: ExecutionEventBus,
142 |   ): Promise<TaskWrapper> {
143 |     const agentSettings = agentSettingsInput || ({} as AgentSettings);
144 |     const config = await this.getConfig(agentSettings, taskId);
145 |     const runtimeTask = await Task.create(taskId, contextId, config, eventBus);
146 |     await runtimeTask.geminiClient.initialize();
147 | 
148 |     const wrapper = new TaskWrapper(runtimeTask, agentSettings);
149 |     this.tasks.set(taskId, wrapper);
150 |     logger.info(`New task ${taskId} created.`);
151 |     return wrapper;
152 |   }
153 | 
154 |   getTask(taskId: string): TaskWrapper | undefined {
155 |     return this.tasks.get(taskId);
156 |   }
157 | 
158 |   getAllTasks(): TaskWrapper[] {
159 |     return Array.from(this.tasks.values());
160 |   }
161 | 
162 |   cancelTask = async (
163 |     taskId: string,
164 |     eventBus: ExecutionEventBus,
165 |   ): Promise<void> => {
166 |     logger.info(
167 |       `[CoderAgentExecutor] Received cancel request for task ${taskId}`,
168 |     );
169 |     const wrapper = this.tasks.get(taskId);
170 | 
171 |     if (!wrapper) {
172 |       logger.warn(
173 |         `[CoderAgentExecutor] Task ${taskId} not found for cancellation.`,
174 |       );
175 |       eventBus.publish({
176 |         kind: 'status-update',
177 |         taskId,
178 |         contextId: uuidv4(),
179 |         status: {
180 |           state: 'failed',
181 |           message: {
182 |             kind: 'message',
183 |             role: 'agent',
184 |             parts: [{ kind: 'text', text: `Task ${taskId} not found.` }],
185 |             messageId: uuidv4(),
186 |             taskId,
187 |           },
188 |         },
189 |         final: true,
190 |       });
191 |       return;
192 |     }
193 | 
194 |     const { task } = wrapper;
195 | 
196 |     if (task.taskState === 'canceled' || task.taskState === 'failed') {
197 |       logger.info(
198 |         `[CoderAgentExecutor] Task ${taskId} is already in a final state: ${task.taskState}. No action needed for cancellation.`,
199 |       );
200 |       eventBus.publish({
201 |         kind: 'status-update',
202 |         taskId,
203 |         contextId: task.contextId,
204 |         status: {
205 |           state: task.taskState,
206 |           message: {
207 |             kind: 'message',
208 |             role: 'agent',
209 |             parts: [
210 |               {
211 |                 kind: 'text',
212 |                 text: `Task ${taskId} is already ${task.taskState}.`,
213 |               },
214 |             ],
215 |             messageId: uuidv4(),
216 |             taskId,
217 |           },
218 |         },
219 |         final: true,
220 |       });
221 |       return;
222 |     }
223 | 
224 |     try {
225 |       logger.info(
226 |         `[CoderAgentExecutor] Initiating cancellation for task ${taskId}.`,
227 |       );
228 |       task.cancelPendingTools('Task canceled by user request.');
229 | 
230 |       const stateChange: StateChange = {
231 |         kind: CoderAgentEvent.StateChangeEvent,
232 |       };
233 |       task.setTaskStateAndPublishUpdate(
234 |         'canceled',
235 |         stateChange,
236 |         'Task canceled by user request.',
237 |         undefined,
238 |         true,
239 |       );
240 |       logger.info(
241 |         `[CoderAgentExecutor] Task ${taskId} cancellation processed. Saving state.`,
242 |       );
243 |       await this.taskStore?.save(wrapper.toSDKTask());
244 |       logger.info(`[CoderAgentExecutor] Task ${taskId} state CANCELED saved.`);
245 |     } catch (error) {
246 |       const errorMessage =
247 |         error instanceof Error ? error.message : 'Unknown error';
248 |       logger.error(
249 |         `[CoderAgentExecutor] Error during task cancellation for ${taskId}: ${errorMessage}`,
250 |         error,
251 |       );
252 |       eventBus.publish({
253 |         kind: 'status-update',
254 |         taskId,
255 |         contextId: task.contextId,
256 |         status: {
257 |           state: 'failed',
258 |           message: {
259 |             kind: 'message',
260 |             role: 'agent',
261 |             parts: [
262 |               {
263 |                 kind: 'text',
264 |                 text: `Failed to process cancellation for task ${taskId}: ${errorMessage}`,
265 |               },
266 |             ],
267 |             messageId: uuidv4(),
268 |             taskId,
269 |           },
270 |         },
271 |         final: true,
272 |       });
273 |     }
274 |   };
275 | 
276 |   async execute(
277 |     requestContext: RequestContext,
278 |     eventBus: ExecutionEventBus,
279 |   ): Promise<void> {
280 |     const userMessage = requestContext.userMessage as Message;
281 |     const sdkTask = requestContext.task as SDKTask | undefined;
282 | 
283 |     const taskId = sdkTask?.id || userMessage.taskId || uuidv4();
284 |     const contextId: string =
285 |       userMessage.contextId ||
286 |       sdkTask?.contextId ||
287 |       (sdkTask?.metadata?.['_contextId'] as string) ||
288 |       uuidv4();
289 | 
290 |     logger.info(
291 |       `[CoderAgentExecutor] Executing for taskId: ${taskId}, contextId: ${contextId}`,
292 |     );
293 |     logger.info(
294 |       `[CoderAgentExecutor] userMessage: ${JSON.stringify(userMessage)}`,
295 |     );
296 |     eventBus.on('event', (event: AgentExecutionEvent) =>
297 |       logger.info('[EventBus event]: ', event),
298 |     );
299 | 
300 |     const store = requestStorage.getStore();
301 |     if (!store) {
302 |       logger.error(
303 |         '[CoderAgentExecutor] Could not get request from async local storage. Cancellation on socket close will not be handled for this request.',
304 |       );
305 |     }
306 | 
307 |     const abortController = new AbortController();
308 |     const abortSignal = abortController.signal;
309 | 
310 |     if (store) {
311 |       // Grab the raw socket from the request object
312 |       const socket = store.req.socket;
313 |       const onClientEnd = () => {
314 |         logger.info(
315 |           `[CoderAgentExecutor] Client socket closed for task ${taskId}. Cancelling execution.`,
316 |         );
317 |         if (!abortController.signal.aborted) {
318 |           abortController.abort();
319 |         }
320 |         // Clean up the listener to prevent memory leaks
321 |         socket.removeListener('close', onClientEnd);
322 |       };
323 | 
324 |       // Listen on the socket's 'end' event (remote closed the connection)
325 |       socket.on('end', onClientEnd);
326 | 
327 |       // It's also good practice to remove the listener if the task completes successfully
328 |       abortSignal.addEventListener('abort', () => {
329 |         socket.removeListener('end', onClientEnd);
330 |       });
331 |       logger.info(
332 |         `[CoderAgentExecutor] Socket close handler set up for task ${taskId}.`,
333 |       );
334 |     }
335 | 
336 |     let wrapper: TaskWrapper | undefined = this.tasks.get(taskId);
337 | 
338 |     if (wrapper) {
339 |       wrapper.task.eventBus = eventBus;
340 |       logger.info(`[CoderAgentExecutor] Task ${taskId} found in memory cache.`);
341 |     } else if (sdkTask) {
342 |       logger.info(
343 |         `[CoderAgentExecutor] Task ${taskId} found in TaskStore. Reconstructing...`,
344 |       );
345 |       try {
346 |         wrapper = await this.reconstruct(sdkTask, eventBus);
347 |       } catch (e) {
348 |         logger.error(
349 |           `[CoderAgentExecutor] Failed to hydrate task ${taskId}:`,
350 |           e,
351 |         );
352 |         const stateChange: StateChange = {
353 |           kind: CoderAgentEvent.StateChangeEvent,
354 |         };
355 |         eventBus.publish({
356 |           kind: 'status-update',
357 |           taskId,
358 |           contextId: sdkTask.contextId,
359 |           status: {
360 |             state: 'failed',
361 |             message: {
362 |               kind: 'message',
363 |               role: 'agent',
364 |               parts: [
365 |                 {
366 |                   kind: 'text',
367 |                   text: 'Internal error: Task state lost or corrupted.',
368 |                 },
369 |               ],
370 |               messageId: uuidv4(),
371 |               taskId,
372 |               contextId: sdkTask.contextId,
373 |             } as Message,
374 |           },
375 |           final: true,
376 |           metadata: { coderAgent: stateChange },
377 |         });
378 |         return;
379 |       }
380 |     } else {
381 |       logger.info(`[CoderAgentExecutor] Creating new task ${taskId}.`);
382 |       const agentSettings = userMessage.metadata?.[
383 |         'coderAgent'
384 |       ] as AgentSettings;
385 |       try {
386 |         wrapper = await this.createTask(
387 |           taskId,
388 |           contextId,
389 |           agentSettings,
390 |           eventBus,
391 |         );
392 |       } catch (error) {
393 |         logger.error(
394 |           `[CoderAgentExecutor] Error creating task ${taskId}:`,
395 |           error,
396 |         );
397 |         pushTaskStateFailed(error, eventBus, taskId, contextId);
398 |         return;
399 |       }
400 |       const newTaskSDK = wrapper.toSDKTask();
401 |       eventBus.publish({
402 |         ...newTaskSDK,
403 |         kind: 'task',
404 |         status: { state: 'submitted', timestamp: new Date().toISOString() },
405 |         history: [userMessage],
406 |       });
407 |       try {
408 |         await this.taskStore?.save(newTaskSDK);
409 |         logger.info(`[CoderAgentExecutor] New task ${taskId} saved to store.`);
410 |       } catch (saveError) {
411 |         logger.error(
412 |           `[CoderAgentExecutor] Failed to save new task ${taskId} to store:`,
413 |           saveError,
414 |         );
415 |       }
416 |     }
417 | 
418 |     if (!wrapper) {
419 |       logger.error(
420 |         `[CoderAgentExecutor] Task ${taskId} is unexpectedly undefined after load/create.`,
421 |       );
422 |       return;
423 |     }
424 | 
425 |     const currentTask = wrapper.task;
426 | 
427 |     if (['canceled', 'failed', 'completed'].includes(currentTask.taskState)) {
428 |       logger.warn(
429 |         `[CoderAgentExecutor] Attempted to execute task ${taskId} which is already in state ${currentTask.taskState}. Ignoring.`,
430 |       );
431 |       return;
432 |     }
433 | 
434 |     if (this.executingTasks.has(taskId)) {
435 |       logger.info(
436 |         `[CoderAgentExecutor] Task ${taskId} has a pending execution. Processing message and yielding.`,
437 |       );
438 |       currentTask.eventBus = eventBus;
439 |       for await (const _ of currentTask.acceptUserMessage(
440 |         requestContext,
441 |         abortController.signal,
442 |       )) {
443 |         logger.info(
444 |           `[CoderAgentExecutor] Processing user message ${userMessage.messageId} in secondary execution loop for task ${taskId}.`,
445 |         );
446 |       }
447 |       // End this execution-- the original/source will be resumed.
448 |       return;
449 |     }
450 | 
451 |     logger.info(
452 |       `[CoderAgentExecutor] Starting main execution for message ${userMessage.messageId} for task ${taskId}.`,
453 |     );
454 |     this.executingTasks.add(taskId);
455 | 
456 |     try {
457 |       let agentTurnActive = true;
458 |       logger.info(`[CoderAgentExecutor] Task ${taskId}: Processing user turn.`);
459 |       let agentEvents = currentTask.acceptUserMessage(
460 |         requestContext,
461 |         abortSignal,
462 |       );
463 | 
464 |       while (agentTurnActive) {
465 |         logger.info(
466 |           `[CoderAgentExecutor] Task ${taskId}: Processing agent turn (LLM stream).`,
467 |         );
468 |         const toolCallRequests: ToolCallRequestInfo[] = [];
469 |         for await (const event of agentEvents) {
470 |           if (abortSignal.aborted) {
471 |             logger.warn(
472 |               `[CoderAgentExecutor] Task ${taskId}: Abort signal received during agent event processing.`,
473 |             );
474 |             throw new Error('Execution aborted');
475 |           }
476 |           if (event.type === GeminiEventType.ToolCallRequest) {
477 |             toolCallRequests.push(
478 |               (event as ServerGeminiToolCallRequestEvent).value,
479 |             );
480 |             continue;
481 |           }
482 |           await currentTask.acceptAgentMessage(event);
483 |         }
484 | 
485 |         if (abortSignal.aborted) throw new Error('Execution aborted');
486 | 
487 |         if (toolCallRequests.length > 0) {
488 |           logger.info(
489 |             `[CoderAgentExecutor] Task ${taskId}: Found ${toolCallRequests.length} tool call requests. Scheduling as a batch.`,
490 |           );
491 |           await currentTask.scheduleToolCalls(toolCallRequests, abortSignal);
492 |         }
493 | 
494 |         logger.info(
495 |           `[CoderAgentExecutor] Task ${taskId}: Waiting for pending tools if any.`,
496 |         );
497 |         await currentTask.waitForPendingTools();
498 |         logger.info(
499 |           `[CoderAgentExecutor] Task ${taskId}: All pending tools completed or none were pending.`,
500 |         );
501 | 
502 |         if (abortSignal.aborted) throw new Error('Execution aborted');
503 | 
504 |         const completedTools = currentTask.getAndClearCompletedTools();
505 | 
506 |         if (completedTools.length > 0) {
507 |           // If all completed tool calls were canceled, manually add them to history and set state to input-required, final:true
508 |           if (completedTools.every((tool) => tool.status === 'cancelled')) {
509 |             logger.info(
510 |               `[CoderAgentExecutor] Task ${taskId}: All tool calls were cancelled. Updating history and ending agent turn.`,
511 |             );
512 |             currentTask.addToolResponsesToHistory(completedTools);
513 |             agentTurnActive = false;
514 |             const stateChange: StateChange = {
515 |               kind: CoderAgentEvent.StateChangeEvent,
516 |             };
517 |             currentTask.setTaskStateAndPublishUpdate(
518 |               'input-required',
519 |               stateChange,
520 |               undefined,
521 |               undefined,
522 |               true,
523 |             );
524 |           } else {
525 |             logger.info(
526 |               `[CoderAgentExecutor] Task ${taskId}: Found ${completedTools.length} completed tool calls. Sending results back to LLM.`,
527 |             );
528 | 
529 |             agentEvents = currentTask.sendCompletedToolsToLlm(
530 |               completedTools,
531 |               abortSignal,
532 |             );
533 |             // Continue the loop to process the LLM response to the tool results.
534 |           }
535 |         } else {
536 |           logger.info(
537 |             `[CoderAgentExecutor] Task ${taskId}: No more tool calls to process. Ending agent turn.`,
538 |           );
539 |           agentTurnActive = false;
540 |         }
541 |       }
542 | 
543 |       logger.info(
544 |         `[CoderAgentExecutor] Task ${taskId}: Agent turn finished, setting to input-required.`,
545 |       );
546 |       const stateChange: StateChange = {
547 |         kind: CoderAgentEvent.StateChangeEvent,
548 |       };
549 |       currentTask.setTaskStateAndPublishUpdate(
550 |         'input-required',
551 |         stateChange,
552 |         undefined,
553 |         undefined,
554 |         true,
555 |       );
556 |     } catch (error) {
557 |       if (abortSignal.aborted) {
558 |         logger.warn(`[CoderAgentExecutor] Task ${taskId} execution aborted.`);
559 |         currentTask.cancelPendingTools('Execution aborted');
560 |         if (
561 |           currentTask.taskState !== 'canceled' &&
562 |           currentTask.taskState !== 'failed'
563 |         ) {
564 |           currentTask.setTaskStateAndPublishUpdate(
565 |             'input-required',
566 |             { kind: CoderAgentEvent.StateChangeEvent },
567 |             'Execution aborted by client.',
568 |             undefined,
569 |             true,
570 |           );
571 |         }
572 |       } else {
573 |         const errorMessage =
574 |           error instanceof Error ? error.message : 'Agent execution error';
575 |         logger.error(
576 |           `[CoderAgentExecutor] Error executing agent for task ${taskId}:`,
577 |           error,
578 |         );
579 |         currentTask.cancelPendingTools(errorMessage);
580 |         if (currentTask.taskState !== 'failed') {
581 |           const stateChange: StateChange = {
582 |             kind: CoderAgentEvent.StateChangeEvent,
583 |           };
584 |           currentTask.setTaskStateAndPublishUpdate(
585 |             'failed',
586 |             stateChange,
587 |             errorMessage,
588 |             undefined,
589 |             true,
590 |           );
591 |         }
592 |       }
593 |     } finally {
594 |       this.executingTasks.delete(taskId);
595 |       logger.info(
596 |         `[CoderAgentExecutor] Saving final state for task ${taskId}.`,
597 |       );
598 |       try {
599 |         await this.taskStore?.save(wrapper.toSDKTask());
600 |         logger.info(`[CoderAgentExecutor] Task ${taskId} state saved.`);
601 |       } catch (saveError) {
602 |         logger.error(
603 |           `[CoderAgentExecutor] Failed to save task ${taskId} state in finally block:`,
604 |           saveError,
605 |         );
606 |       }
607 |     }
608 |   }
609 | }
```

src/agent/task.test.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import { describe, it, expect, vi } from 'vitest';
8 | import { Task } from './task.js';
9 | import type { Config, ToolCallRequestInfo } from '@google/gemini-cli-core';
10 | import { createMockConfig } from '../utils/testing_utils.js';
11 | import type { ExecutionEventBus } from '@a2a-js/sdk/server';
12 | 
13 | describe('Task', () => {
14 |   it('scheduleToolCalls should not modify the input requests array', async () => {
15 |     const mockConfig = createMockConfig();
16 | 
17 |     const mockEventBus: ExecutionEventBus = {
18 |       publish: vi.fn(),
19 |       on: vi.fn(),
20 |       off: vi.fn(),
21 |       once: vi.fn(),
22 |       removeAllListeners: vi.fn(),
23 |       finished: vi.fn(),
24 |     };
25 | 
26 |     // The Task constructor is private. We'll bypass it for this unit test.
27 |     // @ts-expect-error - Calling private constructor for test purposes.
28 |     const task = new Task(
29 |       'task-id',
30 |       'context-id',
31 |       mockConfig as Config,
32 |       mockEventBus,
33 |     );
34 | 
35 |     task['setTaskStateAndPublishUpdate'] = vi.fn();
36 |     task['getProposedContent'] = vi.fn().mockResolvedValue('new content');
37 | 
38 |     const requests: ToolCallRequestInfo[] = [
39 |       {
40 |         callId: '1',
41 |         name: 'replace',
42 |         args: {
43 |           file_path: 'test.txt',
44 |           old_string: 'old',
45 |           new_string: 'new',
46 |         },
47 |         isClientInitiated: false,
48 |         prompt_id: 'prompt-id-1',
49 |       },
50 |     ];
51 | 
52 |     const originalRequests = JSON.parse(JSON.stringify(requests));
53 |     const abortController = new AbortController();
54 | 
55 |     await task.scheduleToolCalls(requests, abortController.signal);
56 | 
57 |     expect(requests).toEqual(originalRequests);
58 |   });
59 | });
```

src/agent/task.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import {
8 |   CoreToolScheduler,
9 |   type GeminiClient,
10 |   GeminiEventType,
11 |   ToolConfirmationOutcome,
12 |   ApprovalMode,
13 |   getAllMCPServerStatuses,
14 |   MCPServerStatus,
15 |   isNodeError,
16 |   parseAndFormatApiError,
17 |   safeLiteralReplace,
18 |   type AnyDeclarativeTool,
19 |   type ToolCall,
20 |   type ToolConfirmationPayload,
21 |   type CompletedToolCall,
22 |   type ToolCallRequestInfo,
23 |   type ServerGeminiErrorEvent,
24 |   type ServerGeminiStreamEvent,
25 |   type ToolCallConfirmationDetails,
26 |   type Config,
27 |   type UserTierId,
28 |   type AnsiOutput,
29 | } from '@google/gemini-cli-core';
30 | import type { RequestContext } from '@a2a-js/sdk/server';
31 | import { type ExecutionEventBus } from '@a2a-js/sdk/server';
32 | import type {
33 |   TaskStatusUpdateEvent,
34 |   TaskArtifactUpdateEvent,
35 |   TaskState,
36 |   Message,
37 |   Part,
38 |   Artifact,
39 | } from '@a2a-js/sdk';
40 | import { v4 as uuidv4 } from 'uuid';
41 | import { logger } from '../utils/logger.js';
42 | import * as fs from 'node:fs';
43 | 
44 | import { CoderAgentEvent } from '../types.js';
45 | import type {
46 |   CoderAgentMessage,
47 |   StateChange,
48 |   ToolCallUpdate,
49 |   TextContent,
50 |   TaskMetadata,
51 |   Thought,
52 |   ThoughtSummary,
53 | } from '../types.js';
54 | import type { PartUnion, Part as genAiPart } from '@google/genai';
55 | 
56 | type UnionKeys<T> = T extends T ? keyof T : never;
57 | 
58 | export class Task {
59 |   id: string;
60 |   contextId: string;
61 |   scheduler: CoreToolScheduler;
62 |   config: Config;
63 |   geminiClient: GeminiClient;
64 |   pendingToolConfirmationDetails: Map<string, ToolCallConfirmationDetails>;
65 |   taskState: TaskState;
66 |   eventBus?: ExecutionEventBus;
67 |   completedToolCalls: CompletedToolCall[];
68 |   skipFinalTrueAfterInlineEdit = false;
69 | 
70 |   // For tool waiting logic
71 |   private pendingToolCalls: Map<string, string> = new Map(); //toolCallId --> status
72 |   private toolCompletionPromise?: Promise<void>;
73 |   private toolCompletionNotifier?: {
74 |     resolve: () => void;
75 |     reject: (reason?: Error) => void;
76 |   };
77 | 
78 |   private constructor(
79 |     id: string,
80 |     contextId: string,
81 |     config: Config,
82 |     eventBus?: ExecutionEventBus,
83 |   ) {
84 |     this.id = id;
85 |     this.contextId = contextId;
86 |     this.config = config;
87 |     this.scheduler = this.createScheduler();
88 |     this.geminiClient = this.config.getGeminiClient();
89 |     this.pendingToolConfirmationDetails = new Map();
90 |     this.taskState = 'submitted';
91 |     this.eventBus = eventBus;
92 |     this.completedToolCalls = [];
93 |     this._resetToolCompletionPromise();
94 |     this.config.setFallbackModelHandler(
95 |       // For a2a-server, we want to automatically switch to the fallback model
96 |       // for future requests without retrying the current one. The 'stop'
97 |       // intent achieves this.
98 |       async () => 'stop',
99 |     );
100 |   }
101 | 
102 |   static async create(
103 |     id: string,
104 |     contextId: string,
105 |     config: Config,
106 |     eventBus?: ExecutionEventBus,
107 |   ): Promise<Task> {
108 |     return new Task(id, contextId, config, eventBus);
109 |   }
110 | 
111 |   // Note: `getAllMCPServerStatuses` retrieves the status of all MCP servers for the entire
112 |   // process. This is not scoped to the individual task but reflects the global connection
113 |   // state managed within the @gemini-cli/core module.
114 |   async getMetadata(): Promise<TaskMetadata> {
115 |     const toolRegistry = await this.config.getToolRegistry();
116 |     const mcpServers = this.config.getMcpServers() || {};
117 |     const serverStatuses = getAllMCPServerStatuses();
118 |     const servers = Object.keys(mcpServers).map((serverName) => ({
119 |       name: serverName,
120 |       status: serverStatuses.get(serverName) || MCPServerStatus.DISCONNECTED,
121 |       tools: toolRegistry.getToolsByServer(serverName).map((tool) => ({
122 |         name: tool.name,
123 |         description: tool.description,
124 |         parameterSchema: tool.schema.parameters,
125 |       })),
126 |     }));
127 | 
128 |     const availableTools = toolRegistry.getAllTools().map((tool) => ({
129 |       name: tool.name,
130 |       description: tool.description,
131 |       parameterSchema: tool.schema.parameters,
132 |     }));
133 | 
134 |     const metadata: TaskMetadata = {
135 |       id: this.id,
136 |       contextId: this.contextId,
137 |       taskState: this.taskState,
138 |       model: this.config.getModel(),
139 |       mcpServers: servers,
140 |       availableTools,
141 |     };
142 |     return metadata;
143 |   }
144 | 
145 |   private _resetToolCompletionPromise(): void {
146 |     this.toolCompletionPromise = new Promise((resolve, reject) => {
147 |       this.toolCompletionNotifier = { resolve, reject };
148 |     });
149 |     // If there are no pending calls when reset, resolve immediately.
150 |     if (this.pendingToolCalls.size === 0 && this.toolCompletionNotifier) {
151 |       this.toolCompletionNotifier.resolve();
152 |     }
153 |   }
154 | 
155 |   private _registerToolCall(toolCallId: string, status: string): void {
156 |     const wasEmpty = this.pendingToolCalls.size === 0;
157 |     this.pendingToolCalls.set(toolCallId, status);
158 |     if (wasEmpty) {
159 |       this._resetToolCompletionPromise();
160 |     }
161 |     logger.info(
162 |       `[Task] Registered tool call: ${toolCallId}. Pending: ${this.pendingToolCalls.size}`,
163 |     );
164 |   }
165 | 
166 |   private _resolveToolCall(toolCallId: string): void {
167 |     if (this.pendingToolCalls.has(toolCallId)) {
168 |       this.pendingToolCalls.delete(toolCallId);
169 |       logger.info(
170 |         `[Task] Resolved tool call: ${toolCallId}. Pending: ${this.pendingToolCalls.size}`,
171 |       );
172 |       if (this.pendingToolCalls.size === 0 && this.toolCompletionNotifier) {
173 |         this.toolCompletionNotifier.resolve();
174 |       }
175 |     }
176 |   }
177 | 
178 |   async waitForPendingTools(): Promise<void> {
179 |     if (this.pendingToolCalls.size === 0) {
180 |       return Promise.resolve();
181 |     }
182 |     logger.info(
183 |       `[Task] Waiting for ${this.pendingToolCalls.size} pending tool(s)...`,
184 |     );
185 |     return this.toolCompletionPromise;
186 |   }
187 | 
188 |   cancelPendingTools(reason: string): void {
189 |     if (this.pendingToolCalls.size > 0) {
190 |       logger.info(
191 |         `[Task] Cancelling all ${this.pendingToolCalls.size} pending tool calls. Reason: ${reason}`,
192 |       );
193 |     }
194 |     if (this.toolCompletionNotifier) {
195 |       this.toolCompletionNotifier.reject(new Error(reason));
196 |     }
197 |     this.pendingToolCalls.clear();
198 |     // Reset the promise for any future operations, ensuring it's in a clean state.
199 |     this._resetToolCompletionPromise();
200 |   }
201 | 
202 |   private _createTextMessage(
203 |     text: string,
204 |     role: 'agent' | 'user' = 'agent',
205 |   ): Message {
206 |     return {
207 |       kind: 'message',
208 |       role,
209 |       parts: [{ kind: 'text', text }],
210 |       messageId: uuidv4(),
211 |       taskId: this.id,
212 |       contextId: this.contextId,
213 |     };
214 |   }
215 | 
216 |   private _createStatusUpdateEvent(
217 |     stateToReport: TaskState,
218 |     coderAgentMessage: CoderAgentMessage,
219 |     message?: Message,
220 |     final = false,
221 |     timestamp?: string,
222 |     metadataError?: string,
223 |   ): TaskStatusUpdateEvent {
224 |     const metadata: {
225 |       coderAgent: CoderAgentMessage;
226 |       model: string;
227 |       userTier?: UserTierId;
228 |       error?: string;
229 |     } = {
230 |       coderAgent: coderAgentMessage,
231 |       model: this.config.getModel(),
232 |       userTier: this.config.getUserTier(),
233 |     };
234 | 
235 |     if (metadataError) {
236 |       metadata.error = metadataError;
237 |     }
238 | 
239 |     return {
240 |       kind: 'status-update',
241 |       taskId: this.id,
242 |       contextId: this.contextId,
243 |       status: {
244 |         state: stateToReport,
245 |         message, // Shorthand property
246 |         timestamp: timestamp || new Date().toISOString(),
247 |       },
248 |       final,
249 |       metadata,
250 |     };
251 |   }
252 | 
253 |   setTaskStateAndPublishUpdate(
254 |     newState: TaskState,
255 |     coderAgentMessage: CoderAgentMessage,
256 |     messageText?: string,
257 |     messageParts?: Part[], // For more complex messages
258 |     final = false,
259 |     metadataError?: string,
260 |   ): void {
261 |     this.taskState = newState;
262 |     let message: Message | undefined;
263 | 
264 |     if (messageText) {
265 |       message = this._createTextMessage(messageText);
266 |     } else if (messageParts) {
267 |       message = {
268 |         kind: 'message',
269 |         role: 'agent',
270 |         parts: messageParts,
271 |         messageId: uuidv4(),
272 |         taskId: this.id,
273 |         contextId: this.contextId,
274 |       };
275 |     }
276 | 
277 |     const event = this._createStatusUpdateEvent(
278 |       this.taskState,
279 |       coderAgentMessage,
280 |       message,
281 |       final,
282 |       undefined,
283 |       metadataError,
284 |     );
285 |     this.eventBus?.publish(event);
286 |   }
287 | 
288 |   private _schedulerOutputUpdate(
289 |     toolCallId: string,
290 |     outputChunk: string | AnsiOutput,
291 |   ): void {
292 |     let outputAsText: string;
293 |     if (typeof outputChunk === 'string') {
294 |       outputAsText = outputChunk;
295 |     } else {
296 |       outputAsText = outputChunk
297 |         .map((line) => line.map((token) => token.text).join(''))
298 |         .join('\n');
299 |     }
300 | 
301 |     logger.info(
302 |       '[Task] Scheduler output update for tool call ' +
303 |         toolCallId +
304 |         ': ' +
305 |         outputAsText,
306 |     );
307 |     const artifact: Artifact = {
308 |       artifactId: `tool-${toolCallId}-output`,
309 |       parts: [
310 |         {
311 |           kind: 'text',
312 |           text: outputAsText,
313 |         } as Part,
314 |       ],
315 |     };
316 |     const artifactEvent: TaskArtifactUpdateEvent = {
317 |       kind: 'artifact-update',
318 |       taskId: this.id,
319 |       contextId: this.contextId,
320 |       artifact,
321 |       append: true,
322 |       lastChunk: false,
323 |     };
324 |     this.eventBus?.publish(artifactEvent);
325 |   }
326 | 
327 |   private async _schedulerAllToolCallsComplete(
328 |     completedToolCalls: CompletedToolCall[],
329 |   ): Promise<void> {
330 |     logger.info(
331 |       '[Task] All tool calls completed by scheduler (batch):',
332 |       completedToolCalls.map((tc) => tc.request.callId),
333 |     );
334 |     this.completedToolCalls.push(...completedToolCalls);
335 |     completedToolCalls.forEach((tc) => {
336 |       this._resolveToolCall(tc.request.callId);
337 |     });
338 |   }
339 | 
340 |   private _schedulerToolCallsUpdate(toolCalls: ToolCall[]): void {
341 |     logger.info(
342 |       '[Task] Scheduler tool calls updated:',
343 |       toolCalls.map((tc) => `${tc.request.callId} (${tc.status})`),
344 |     );
345 | 
346 |     // Update state and send continuous, non-final updates
347 |     toolCalls.forEach((tc) => {
348 |       const previousStatus = this.pendingToolCalls.get(tc.request.callId);
349 |       const hasChanged = previousStatus !== tc.status;
350 | 
351 |       // Resolve tool call if it has reached a terminal state
352 |       if (['success', 'error', 'cancelled'].includes(tc.status)) {
353 |         this._resolveToolCall(tc.request.callId);
354 |       } else {
355 |         // This will update the map
356 |         this._registerToolCall(tc.request.callId, tc.status);
357 |       }
358 | 
359 |       if (tc.status === 'awaiting_approval' && tc.confirmationDetails) {
360 |         this.pendingToolConfirmationDetails.set(
361 |           tc.request.callId,
362 |           tc.confirmationDetails,
363 |         );
364 |       }
365 | 
366 |       // Only send an update if the status has actually changed.
367 |       if (hasChanged) {
368 |         const message = this.toolStatusMessage(tc, this.id, this.contextId);
369 |         const coderAgentMessage: CoderAgentMessage =
370 |           tc.status === 'awaiting_approval'
371 |             ? { kind: CoderAgentEvent.ToolCallConfirmationEvent }
372 |             : { kind: CoderAgentEvent.ToolCallUpdateEvent };
373 | 
374 |         const event = this._createStatusUpdateEvent(
375 |           this.taskState,
376 |           coderAgentMessage,
377 |           message,
378 |           false, // Always false for these continuous updates
379 |         );
380 |         this.eventBus?.publish(event);
381 |       }
382 |     });
383 | 
384 |     if (this.config.getApprovalMode() === ApprovalMode.YOLO) {
385 |       logger.info('[Task] YOLO mode enabled. Auto-approving all tool calls.');
386 |       toolCalls.forEach((tc: ToolCall) => {
387 |         if (tc.status === 'awaiting_approval' && tc.confirmationDetails) {
388 |           tc.confirmationDetails.onConfirm(ToolConfirmationOutcome.ProceedOnce);
389 |           this.pendingToolConfirmationDetails.delete(tc.request.callId);
390 |         }
391 |       });
392 |       return;
393 |     }
394 | 
395 |     const allPendingStatuses = Array.from(this.pendingToolCalls.values());
396 |     const isAwaitingApproval = allPendingStatuses.some(
397 |       (status) => status === 'awaiting_approval',
398 |     );
399 |     const allPendingAreStable = allPendingStatuses.every(
400 |       (status) =>
401 |         status === 'awaiting_approval' ||
402 |         status === 'success' ||
403 |         status === 'error' ||
404 |         status === 'cancelled',
405 |     );
406 | 
407 |     // 1. Are any pending tool calls awaiting_approval
408 |     // 2. Are all pending tool calls in a stable state (i.e. not in validing or executing)
409 |     // 3. After an inline edit, the edited tool call will send awaiting_approval THEN scheduled. We wait for the next update in this case.
410 |     if (
411 |       isAwaitingApproval &&
412 |       allPendingAreStable &&
413 |       !this.skipFinalTrueAfterInlineEdit
414 |     ) {
415 |       this.skipFinalTrueAfterInlineEdit = false;
416 | 
417 |       // We don't need to send another message, just a final status update.
418 |       this.setTaskStateAndPublishUpdate(
419 |         'input-required',
420 |         { kind: CoderAgentEvent.StateChangeEvent },
421 |         undefined,
422 |         undefined,
423 |         /*final*/ true,
424 |       );
425 |     }
426 |   }
427 | 
428 |   private createScheduler(): CoreToolScheduler {
429 |     const scheduler = new CoreToolScheduler({
430 |       outputUpdateHandler: this._schedulerOutputUpdate.bind(this),
431 |       onAllToolCallsComplete: this._schedulerAllToolCallsComplete.bind(this),
432 |       onToolCallsUpdate: this._schedulerToolCallsUpdate.bind(this),
433 |       getPreferredEditor: () => 'vscode',
434 |       config: this.config,
435 |       onEditorClose: () => {},
436 |     });
437 |     return scheduler;
438 |   }
439 | 
440 |   private _pickFields<
441 |     T extends ToolCall | AnyDeclarativeTool,
442 |     K extends UnionKeys<T>,
443 |   >(from: T, ...fields: K[]): Partial<T> {
444 |     const ret = {} as Pick<T, K>;
445 |     for (const field of fields) {
446 |       if (field in from) {
447 |         ret[field] = from[field];
448 |       }
449 |     }
450 |     return ret as Partial<T>;
451 |   }
452 | 
453 |   private toolStatusMessage(
454 |     tc: ToolCall,
455 |     taskId: string,
456 |     contextId: string,
457 |   ): Message {
458 |     const messageParts: Part[] = [];
459 | 
460 |     // Create a serializable version of the ToolCall (pick necesssary
461 |     // properties/avoid methods causing circular reference errors)
462 |     const serializableToolCall: Partial<ToolCall> = this._pickFields(
463 |       tc,
464 |       'request',
465 |       'status',
466 |       'confirmationDetails',
467 |       'liveOutput',
468 |       'response',
469 |     );
470 | 
471 |     if (tc.tool) {
472 |       serializableToolCall.tool = this._pickFields(
473 |         tc.tool,
474 |         'name',
475 |         'displayName',
476 |         'description',
477 |         'kind',
478 |         'isOutputMarkdown',
479 |         'canUpdateOutput',
480 |         'schema',
481 |         'parameterSchema',
482 |       ) as AnyDeclarativeTool;
483 |     }
484 | 
485 |     messageParts.push({
486 |       kind: 'data',
487 |       data: serializableToolCall,
488 |     } as Part);
489 | 
490 |     return {
491 |       kind: 'message',
492 |       role: 'agent',
493 |       parts: messageParts,
494 |       messageId: uuidv4(),
495 |       taskId,
496 |       contextId,
497 |     };
498 |   }
499 | 
500 |   private async getProposedContent(
501 |     file_path: string,
502 |     old_string: string,
503 |     new_string: string,
504 |   ): Promise<string> {
505 |     try {
506 |       const currentContent = fs.readFileSync(file_path, 'utf8');
507 |       return this._applyReplacement(
508 |         currentContent,
509 |         old_string,
510 |         new_string,
511 |         old_string === '' && currentContent === '',
512 |       );
513 |     } catch (err) {
514 |       if (!isNodeError(err) || err.code !== 'ENOENT') throw err;
515 |       return '';
516 |     }
517 |   }
518 | 
519 |   private _applyReplacement(
520 |     currentContent: string | null,
521 |     oldString: string,
522 |     newString: string,
523 |     isNewFile: boolean,
524 |   ): string {
525 |     if (isNewFile) {
526 |       return newString;
527 |     }
528 |     if (currentContent === null) {
529 |       // Should not happen if not a new file, but defensively return empty or newString if oldString is also empty
530 |       return oldString === '' ? newString : '';
531 |     }
532 |     // If oldString is empty and it's not a new file, do not modify the content.
533 |     if (oldString === '' && !isNewFile) {
534 |       return currentContent;
535 |     }
536 | 
537 |     // Use intelligent replacement that handles $ sequences safely
538 |     return safeLiteralReplace(currentContent, oldString, newString);
539 |   }
540 | 
541 |   async scheduleToolCalls(
542 |     requests: ToolCallRequestInfo[],
543 |     abortSignal: AbortSignal,
544 |   ): Promise<void> {
545 |     if (requests.length === 0) {
546 |       return;
547 |     }
548 | 
549 |     const updatedRequests = await Promise.all(
550 |       requests.map(async (request) => {
551 |         if (
552 |           request.name === 'replace' &&
553 |           request.args &&
554 |           !request.args['newContent'] &&
555 |           request.args['file_path'] &&
556 |           request.args['old_string'] &&
557 |           request.args['new_string']
558 |         ) {
559 |           const newContent = await this.getProposedContent(
560 |             request.args['file_path'] as string,
561 |             request.args['old_string'] as string,
562 |             request.args['new_string'] as string,
563 |           );
564 |           return { ...request, args: { ...request.args, newContent } };
565 |         }
566 |         return request;
567 |       }),
568 |     );
569 | 
570 |     logger.info(
571 |       `[Task] Scheduling batch of ${updatedRequests.length} tool calls.`,
572 |     );
573 |     const stateChange: StateChange = {
574 |       kind: CoderAgentEvent.StateChangeEvent,
575 |     };
576 |     this.setTaskStateAndPublishUpdate('working', stateChange);
577 | 
578 |     await this.scheduler.schedule(updatedRequests, abortSignal);
579 |   }
580 | 
581 |   async acceptAgentMessage(event: ServerGeminiStreamEvent): Promise<void> {
582 |     const stateChange: StateChange = {
583 |       kind: CoderAgentEvent.StateChangeEvent,
584 |     };
585 |     switch (event.type) {
586 |       case GeminiEventType.Content:
587 |         logger.info('[Task] Sending agent message content...');
588 |         this._sendTextContent(event.value);
589 |         break;
590 |       case GeminiEventType.ToolCallRequest:
591 |         // This is now handled by the agent loop, which collects all requests
592 |         // and calls scheduleToolCalls once.
593 |         logger.warn(
594 |           '[Task] A single tool call request was passed to acceptAgentMessage. This should be handled in a batch by the agent. Ignoring.',
595 |         );
596 |         break;
597 |       case GeminiEventType.ToolCallResponse:
598 |         // This event type from ServerGeminiStreamEvent might be for when LLM *generates* a tool response part.
599 |         // The actual execution result comes via user message.
600 |         logger.info(
601 |           '[Task] Received tool call response from LLM (part of generation):',
602 |           event.value,
603 |         );
604 |         break;
605 |       case GeminiEventType.ToolCallConfirmation:
606 |         // This is when LLM requests confirmation, not when user provides it.
607 |         logger.info(
608 |           '[Task] Received tool call confirmation request from LLM:',
609 |           event.value.request.callId,
610 |         );
611 |         this.pendingToolConfirmationDetails.set(
612 |           event.value.request.callId,
613 |           event.value.details,
614 |         );
615 |         // This will be handled by the scheduler and _schedulerToolCallsUpdate will set InputRequired if needed.
616 |         // No direct state change here, scheduler drives it.
617 |         break;
618 |       case GeminiEventType.UserCancelled:
619 |         logger.info('[Task] Received user cancelled event from LLM stream.');
620 |         this.cancelPendingTools('User cancelled via LLM stream event');
621 |         this.setTaskStateAndPublishUpdate(
622 |           'input-required',
623 |           stateChange,
624 |           'Task cancelled by user',
625 |           undefined,
626 |           true,
627 |         );
628 |         break;
629 |       case GeminiEventType.Thought:
630 |         logger.info('[Task] Sending agent thought...');
631 |         this._sendThought(event.value);
632 |         break;
633 |       case GeminiEventType.ChatCompressed:
634 |         break;
635 |       case GeminiEventType.Finished:
636 |         logger.info(`[Task ${this.id}] Agent finished its turn.`);
637 |         break;
638 |       case GeminiEventType.Error:
639 |       default: {
640 |         // Block scope for lexical declaration
641 |         const errorEvent = event as ServerGeminiErrorEvent; // Type assertion
642 |         const errorMessage =
643 |           errorEvent.value?.error.message ?? 'Unknown error from LLM stream';
644 |         logger.error(
645 |           '[Task] Received error event from LLM stream:',
646 |           errorMessage,
647 |         );
648 | 
649 |         let errMessage = 'Unknown error from LLM stream';
650 |         if (errorEvent.value) {
651 |           errMessage = parseAndFormatApiError(errorEvent.value);
652 |         }
653 |         this.cancelPendingTools(`LLM stream error: ${errorMessage}`);
654 |         this.setTaskStateAndPublishUpdate(
655 |           this.taskState,
656 |           stateChange,
657 |           `Agent Error, unknown agent message: ${errorMessage}`,
658 |           undefined,
659 |           false,
660 |           errMessage,
661 |         );
662 |         break;
663 |       }
664 |     }
665 |   }
666 | 
667 |   private async _handleToolConfirmationPart(part: Part): Promise<boolean> {
668 |     if (
669 |       part.kind !== 'data' ||
670 |       !part.data ||
671 |       typeof part.data['callId'] !== 'string' ||
672 |       typeof part.data['outcome'] !== 'string'
673 |     ) {
674 |       return false;
675 |     }
676 | 
677 |     const callId = part.data['callId'] as string;
678 |     const outcomeString = part.data['outcome'] as string;
679 |     let confirmationOutcome: ToolConfirmationOutcome | undefined;
680 | 
681 |     if (outcomeString === 'proceed_once') {
682 |       confirmationOutcome = ToolConfirmationOutcome.ProceedOnce;
683 |     } else if (outcomeString === 'cancel') {
684 |       confirmationOutcome = ToolConfirmationOutcome.Cancel;
685 |     } else if (outcomeString === 'proceed_always') {
686 |       confirmationOutcome = ToolConfirmationOutcome.ProceedAlways;
687 |     } else if (outcomeString === 'proceed_always_server') {
688 |       confirmationOutcome = ToolConfirmationOutcome.ProceedAlwaysServer;
689 |     } else if (outcomeString === 'proceed_always_tool') {
690 |       confirmationOutcome = ToolConfirmationOutcome.ProceedAlwaysTool;
691 |     } else if (outcomeString === 'modify_with_editor') {
692 |       confirmationOutcome = ToolConfirmationOutcome.ModifyWithEditor;
693 |     } else {
694 |       logger.warn(
695 |         `[Task] Unknown tool confirmation outcome: "${outcomeString}" for callId: ${callId}`,
696 |       );
697 |       return false;
698 |     }
699 | 
700 |     const confirmationDetails = this.pendingToolConfirmationDetails.get(callId);
701 | 
702 |     if (!confirmationDetails) {
703 |       logger.warn(
704 |         `[Task] Received tool confirmation for unknown or already processed callId: ${callId}`,
705 |       );
706 |       return false;
707 |     }
708 | 
709 |     logger.info(
710 |       `[Task] Handling tool confirmation for callId: ${callId} with outcome: ${outcomeString}`,
711 |     );
712 |     try {
713 |       // Temporarily unset GCP environment variables so they do not leak into
714 |       // tool calls.
715 |       const gcpProject = process.env['GOOGLE_CLOUD_PROJECT'];
716 |       const gcpCreds = process.env['GOOGLE_APPLICATION_CREDENTIALS'];
717 |       try {
718 |         delete process.env['GOOGLE_CLOUD_PROJECT'];
719 |         delete process.env['GOOGLE_APPLICATION_CREDENTIALS'];
720 | 
721 |         // This will trigger the scheduler to continue or cancel the specific tool.
722 |         // The scheduler's onToolCallsUpdate will then reflect the new state (e.g., executing or cancelled).
723 | 
724 |         // If `edit` tool call, pass updated payload if presesent
725 |         if (confirmationDetails.type === 'edit') {
726 |           const payload = part.data['newContent']
727 |             ? ({
728 |                 newContent: part.data['newContent'] as string,
729 |               } as ToolConfirmationPayload)
730 |             : undefined;
731 |           this.skipFinalTrueAfterInlineEdit = !!payload;
732 |           await confirmationDetails.onConfirm(confirmationOutcome, payload);
733 |         } else {
734 |           await confirmationDetails.onConfirm(confirmationOutcome);
735 |         }
736 |       } finally {
737 |         if (gcpProject) {
738 |           process.env['GOOGLE_CLOUD_PROJECT'] = gcpProject;
739 |         }
740 |         if (gcpCreds) {
741 |           process.env['GOOGLE_APPLICATION_CREDENTIALS'] = gcpCreds;
742 |         }
743 |       }
744 | 
745 |       // Do not delete if modifying, a subsequent tool confirmation for the same
746 |       // callId will be passed with ProceedOnce/Cancel/etc
747 |       // Note !== ToolConfirmationOutcome.ModifyWithEditor does not work!
748 |       if (confirmationOutcome !== 'modify_with_editor') {
749 |         this.pendingToolConfirmationDetails.delete(callId);
750 |       }
751 | 
752 |       // If outcome is Cancel, scheduler should update status to 'cancelled', which then resolves the tool.
753 |       // If ProceedOnce, scheduler updates to 'executing', then eventually 'success'/'error', which resolves.
754 |       return true;
755 |     } catch (error) {
756 |       logger.error(
757 |         `[Task] Error during tool confirmation for callId ${callId}:`,
758 |         error,
759 |       );
760 |       // If confirming fails, we should probably mark this tool as failed
761 |       this._resolveToolCall(callId); // Resolve it as it won't proceed.
762 |       const errorMessageText =
763 |         error instanceof Error
764 |           ? error.message
765 |           : `Error processing tool confirmation for ${callId}`;
766 |       const message = this._createTextMessage(errorMessageText);
767 |       const toolCallUpdate: ToolCallUpdate = {
768 |         kind: CoderAgentEvent.ToolCallUpdateEvent,
769 |       };
770 |       const event = this._createStatusUpdateEvent(
771 |         this.taskState,
772 |         toolCallUpdate,
773 |         message,
774 |         false,
775 |       );
776 |       this.eventBus?.publish(event);
777 |       return false;
778 |     }
779 |   }
780 | 
781 |   getAndClearCompletedTools(): CompletedToolCall[] {
782 |     const tools = [...this.completedToolCalls];
783 |     this.completedToolCalls = [];
784 |     return tools;
785 |   }
786 | 
787 |   addToolResponsesToHistory(completedTools: CompletedToolCall[]): void {
788 |     logger.info(
789 |       `[Task] Adding ${completedTools.length} tool responses to history without generating a new response.`,
790 |     );
791 |     const responsesToAdd = completedTools.flatMap(
792 |       (toolCall) => toolCall.response.responseParts,
793 |     );
794 | 
795 |     for (const response of responsesToAdd) {
796 |       let parts: genAiPart[];
797 |       if (Array.isArray(response)) {
798 |         parts = response;
799 |       } else if (typeof response === 'string') {
800 |         parts = [{ text: response }];
801 |       } else {
802 |         parts = [response];
803 |       }
804 |       this.geminiClient.addHistory({
805 |         role: 'user',
806 |         parts,
807 |       });
808 |     }
809 |   }
810 | 
811 |   async *sendCompletedToolsToLlm(
812 |     completedToolCalls: CompletedToolCall[],
813 |     aborted: AbortSignal,
814 |   ): AsyncGenerator<ServerGeminiStreamEvent> {
815 |     if (completedToolCalls.length === 0) {
816 |       yield* (async function* () {})(); // Yield nothing
817 |       return;
818 |     }
819 | 
820 |     const llmParts: PartUnion[] = [];
821 |     logger.info(
822 |       `[Task] Feeding ${completedToolCalls.length} tool responses to LLM.`,
823 |     );
824 |     for (const completedToolCall of completedToolCalls) {
825 |       logger.info(
826 |         `[Task] Adding tool response for "${completedToolCall.request.name}" (callId: ${completedToolCall.request.callId}) to LLM input.`,
827 |       );
828 |       const responseParts = completedToolCall.response.responseParts;
829 |       if (Array.isArray(responseParts)) {
830 |         llmParts.push(...responseParts);
831 |       } else {
832 |         llmParts.push(responseParts);
833 |       }
834 |     }
835 | 
836 |     logger.info('[Task] Sending new parts to agent.');
837 |     const stateChange: StateChange = {
838 |       kind: CoderAgentEvent.StateChangeEvent,
839 |     };
840 |     // Set task state to working as we are about to call LLM
841 |     this.setTaskStateAndPublishUpdate('working', stateChange);
842 |     // TODO: Determine what it mean to have, then add a prompt ID.
843 |     yield* this.geminiClient.sendMessageStream(
844 |       llmParts,
845 |       aborted,
846 |       /*prompt_id*/ '',
847 |     );
848 |   }
849 | 
850 |   async *acceptUserMessage(
851 |     requestContext: RequestContext,
852 |     aborted: AbortSignal,
853 |   ): AsyncGenerator<ServerGeminiStreamEvent> {
854 |     const userMessage = requestContext.userMessage;
855 |     const llmParts: PartUnion[] = [];
856 |     let anyConfirmationHandled = false;
857 |     let hasContentForLlm = false;
858 | 
859 |     for (const part of userMessage.parts) {
860 |       const confirmationHandled = await this._handleToolConfirmationPart(part);
861 |       if (confirmationHandled) {
862 |         anyConfirmationHandled = true;
863 |         // If a confirmation was handled, the scheduler will now run the tool (or cancel it).
864 |         // We don't send anything to the LLM for this part.
865 |         // The subsequent tool execution will eventually lead to resolveToolCall.
866 |         continue;
867 |       }
868 | 
869 |       if (part.kind === 'text') {
870 |         llmParts.push({ text: part.text });
871 |         hasContentForLlm = true;
872 |       }
873 |     }
874 | 
875 |     if (hasContentForLlm) {
876 |       logger.info('[Task] Sending new parts to LLM.');
877 |       const stateChange: StateChange = {
878 |         kind: CoderAgentEvent.StateChangeEvent,
879 |       };
880 |       // Set task state to working as we are about to call LLM
881 |       this.setTaskStateAndPublishUpdate('working', stateChange);
882 |       // TODO: Determine what it mean to have, then add a prompt ID.
883 |       yield* this.geminiClient.sendMessageStream(
884 |         llmParts,
885 |         aborted,
886 |         /*prompt_id*/ '',
887 |       );
888 |     } else if (anyConfirmationHandled) {
889 |       logger.info(
890 |         '[Task] User message only contained tool confirmations. Scheduler is active. No new input for LLM this turn.',
891 |       );
892 |       // Ensure task state reflects that scheduler might be working due to confirmation.
893 |       // If scheduler is active, it will emit its own status updates.
894 |       // If all pending tools were just confirmed, waitForPendingTools will handle the wait.
895 |       // If some tools are still pending approval, scheduler would have set InputRequired.
896 |       // If not, and no new text, we are just waiting.
897 |       if (
898 |         this.pendingToolCalls.size > 0 &&
899 |         this.taskState !== 'input-required'
900 |       ) {
901 |         const stateChange: StateChange = {
902 |           kind: CoderAgentEvent.StateChangeEvent,
903 |         };
904 |         this.setTaskStateAndPublishUpdate('working', stateChange); // Reflect potential background activity
905 |       }
906 |       yield* (async function* () {})(); // Yield nothing
907 |     } else {
908 |       logger.info(
909 |         '[Task] No relevant parts in user message for LLM interaction or tool confirmation.',
910 |       );
911 |       // If there's no new text and no confirmations, and no pending tools,
912 |       // it implies we might need to signal input required if nothing else is happening.
913 |       // However, the agent.ts will make this determination after waitForPendingTools.
914 |       yield* (async function* () {})(); // Yield nothing
915 |     }
916 |   }
917 | 
918 |   _sendTextContent(content: string): void {
919 |     if (content === '') {
920 |       return;
921 |     }
922 |     logger.info('[Task] Sending text content to event bus.');
923 |     const message = this._createTextMessage(content);
924 |     const textContent: TextContent = {
925 |       kind: CoderAgentEvent.TextContentEvent,
926 |     };
927 |     this.eventBus?.publish(
928 |       this._createStatusUpdateEvent(
929 |         this.taskState,
930 |         textContent,
931 |         message,
932 |         false,
933 |       ),
934 |     );
935 |   }
936 | 
937 |   _sendThought(content: ThoughtSummary): void {
938 |     if (!content.subject && !content.description) {
939 |       return;
940 |     }
941 |     logger.info('[Task] Sending thought to event bus.');
942 |     const message: Message = {
943 |       kind: 'message',
944 |       role: 'agent',
945 |       parts: [
946 |         {
947 |           kind: 'data',
948 |           data: content,
949 |         } as Part,
950 |       ],
951 |       messageId: uuidv4(),
952 |       taskId: this.id,
953 |       contextId: this.contextId,
954 |     };
955 |     const thought: Thought = {
956 |       kind: CoderAgentEvent.ThoughtEvent,
957 |     };
958 |     this.eventBus?.publish(
959 |       this._createStatusUpdateEvent(this.taskState, thought, message, false),
960 |     );
961 |   }
962 | }
```

src/persistence/gcs.test.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import { Storage } from '@google-cloud/storage';
8 | import * as fse from 'fs-extra';
9 | import { promises as fsPromises, createReadStream } from 'node:fs';
10 | import * as tar from 'tar';
11 | import { gzipSync, gunzipSync } from 'node:zlib';
12 | import { v4 as uuidv4 } from 'uuid';
13 | import type { Task as SDKTask } from '@a2a-js/sdk';
14 | import type { TaskStore } from '@a2a-js/sdk/server';
15 | import type { Mocked, MockedClass, Mock } from 'vitest';
16 | import { describe, it, expect, beforeEach, vi } from 'vitest';
17 | 
18 | import { GCSTaskStore, NoOpTaskStore } from './gcs.js';
19 | import { logger } from '../utils/logger.js';
20 | import * as configModule from '../config/config.js';
21 | import { getPersistedState, METADATA_KEY } from '../types.js';
22 | 
23 | // Mock dependencies
24 | vi.mock('@google-cloud/storage');
25 | vi.mock('fs-extra', () => ({
26 |   pathExists: vi.fn(),
27 |   readdir: vi.fn(),
28 |   remove: vi.fn(),
29 |   ensureDir: vi.fn(),
30 | }));
31 | vi.mock('node:fs', async () => {
32 |   const actual = await vi.importActual<typeof import('node:fs')>('node:fs');
33 |   return {
34 |     ...actual,
35 |     promises: {
36 |       ...actual.promises,
37 |       readdir: vi.fn(),
38 |     },
39 |     createReadStream: vi.fn(),
40 |   };
41 | });
42 | vi.mock('tar');
43 | vi.mock('zlib');
44 | vi.mock('uuid');
45 | vi.mock('../utils/logger.js', () => ({
46 |   logger: {
47 |     info: vi.fn(),
48 |     warn: vi.fn(),
49 |     error: vi.fn(),
50 |     debug: vi.fn(),
51 |   },
52 | }));
53 | vi.mock('../config/config.js', () => ({
54 |   setTargetDir: vi.fn(),
55 | }));
56 | vi.mock('node:stream/promises', () => ({
57 |   pipeline: vi.fn(),
58 | }));
59 | vi.mock('../types.js', async (importOriginal) => {
60 |   const actual = await importOriginal<typeof import('../types.js')>();
61 |   return {
62 |     ...actual,
63 |     getPersistedState: vi.fn(),
64 |   };
65 | });
66 | 
67 | const mockStorage = Storage as MockedClass<typeof Storage>;
68 | const mockFse = fse as Mocked<typeof fse>;
69 | const mockCreateReadStream = createReadStream as Mock;
70 | const mockTar = tar as Mocked<typeof tar>;
71 | const mockGzipSync = gzipSync as Mock;
72 | const mockGunzipSync = gunzipSync as Mock;
73 | const mockUuidv4 = uuidv4 as Mock;
74 | const mockSetTargetDir = configModule.setTargetDir as Mock;
75 | const mockGetPersistedState = getPersistedState as Mock;
76 | const TEST_METADATA_KEY = METADATA_KEY || '__persistedState';
77 | 
78 | type MockWriteStream = {
79 |   on: Mock<
80 |     (event: string, cb: (error?: Error | null) => void) => MockWriteStream
81 |   >;
82 |   destroy: Mock<() => void>;
83 |   destroyed: boolean;
84 | };
85 | 
86 | type MockFile = {
87 |   save: Mock<(data: Buffer | string) => Promise<void>>;
88 |   download: Mock<() => Promise<[Buffer]>>;
89 |   exists: Mock<() => Promise<[boolean]>>;
90 |   createWriteStream: Mock<() => MockWriteStream>;
91 | };
92 | 
93 | type MockBucket = {
94 |   exists: Mock<() => Promise<[boolean]>>;
95 |   file: Mock<(path: string) => MockFile>;
96 |   name: string;
97 | };
98 | 
99 | type MockStorageInstance = {
100 |   bucket: Mock<(name: string) => MockBucket>;
101 |   getBuckets: Mock<() => Promise<[Array<{ name: string }>]>>;
102 |   createBucket: Mock<(name: string) => Promise<[MockBucket]>>;
103 | };
104 | 
105 | describe('GCSTaskStore', () => {
106 |   let bucketName: string;
107 |   let mockBucket: MockBucket;
108 |   let mockFile: MockFile;
109 |   let mockWriteStream: MockWriteStream;
110 |   let mockStorageInstance: MockStorageInstance;
111 | 
112 |   beforeEach(() => {
113 |     vi.clearAllMocks();
114 |     bucketName = 'test-bucket';
115 | 
116 |     mockWriteStream = {
117 |       on: vi.fn((event, cb) => {
118 |         if (event === 'finish') setTimeout(cb, 0); // Simulate async finish
119 |         return mockWriteStream;
120 |       }),
121 |       destroy: vi.fn(),
122 |       destroyed: false,
123 |     };
124 | 
125 |     mockFile = {
126 |       save: vi.fn().mockResolvedValue(undefined),
127 |       download: vi.fn().mockResolvedValue([Buffer.from('')]),
128 |       exists: vi.fn().mockResolvedValue([true]),
129 |       createWriteStream: vi.fn().mockReturnValue(mockWriteStream),
130 |     };
131 | 
132 |     mockBucket = {
133 |       exists: vi.fn().mockResolvedValue([true]),
134 |       file: vi.fn().mockReturnValue(mockFile),
135 |       name: bucketName,
136 |     };
137 | 
138 |     mockStorageInstance = {
139 |       bucket: vi.fn().mockReturnValue(mockBucket),
140 |       getBuckets: vi.fn().mockResolvedValue([[{ name: bucketName }]]),
141 |       createBucket: vi.fn().mockResolvedValue([mockBucket]),
142 |     };
143 |     mockStorage.mockReturnValue(mockStorageInstance as unknown as Storage);
144 | 
145 |     mockUuidv4.mockReturnValue('test-uuid');
146 |     mockSetTargetDir.mockReturnValue('/tmp/workdir');
147 |     mockGetPersistedState.mockReturnValue({
148 |       _agentSettings: {},
149 |       _taskState: 'submitted',
150 |     });
151 |     (fse.pathExists as Mock).mockResolvedValue(true);
152 |     (fsPromises.readdir as Mock).mockResolvedValue(['file1.txt']);
153 |     mockTar.c.mockResolvedValue(undefined);
154 |     mockTar.x.mockResolvedValue(undefined);
155 |     mockFse.remove.mockResolvedValue(undefined);
156 |     mockFse.ensureDir.mockResolvedValue(undefined);
157 |     mockGzipSync.mockReturnValue(Buffer.from('compressed'));
158 |     mockGunzipSync.mockReturnValue(Buffer.from('{}'));
159 |     mockCreateReadStream.mockReturnValue({ on: vi.fn(), pipe: vi.fn() });
160 |   });
161 | 
162 |   describe('Constructor & Initialization', () => {
163 |     it('should initialize and check bucket existence', async () => {
164 |       const store = new GCSTaskStore(bucketName);
165 |       await store['ensureBucketInitialized']();
166 |       expect(mockStorage).toHaveBeenCalledTimes(1);
167 |       expect(mockStorageInstance.getBuckets).toHaveBeenCalled();
168 |       expect(logger.info).toHaveBeenCalledWith(
169 |         expect.stringContaining('Bucket test-bucket exists'),
170 |       );
171 |     });
172 | 
173 |     it('should create bucket if it does not exist', async () => {
174 |       mockStorageInstance.getBuckets.mockResolvedValue([[]]);
175 |       const store = new GCSTaskStore(bucketName);
176 |       await store['ensureBucketInitialized']();
177 |       expect(mockStorageInstance.createBucket).toHaveBeenCalledWith(bucketName);
178 |       expect(logger.info).toHaveBeenCalledWith(
179 |         expect.stringContaining('Bucket test-bucket created successfully'),
180 |       );
181 |     });
182 | 
183 |     it('should throw if bucket creation fails', async () => {
184 |       mockStorageInstance.getBuckets.mockResolvedValue([[]]);
185 |       mockStorageInstance.createBucket.mockRejectedValue(
186 |         new Error('Create failed'),
187 |       );
188 |       const store = new GCSTaskStore(bucketName);
189 |       await expect(store['ensureBucketInitialized']()).rejects.toThrow(
190 |         'Failed to create GCS bucket test-bucket: Error: Create failed',
191 |       );
192 |     });
193 |   });
194 | 
195 |   describe('save', () => {
196 |     const mockTask: SDKTask = {
197 |       id: 'task1',
198 |       contextId: 'ctx1',
199 |       kind: 'task',
200 |       status: { state: 'working' },
201 |       metadata: {},
202 |     };
203 | 
204 |     it.skip('should save metadata and workspace', async () => {
205 |       const store = new GCSTaskStore(bucketName);
206 |       await store.save(mockTask);
207 | 
208 |       expect(mockFile.save).toHaveBeenCalledTimes(1);
209 |       expect(mockTar.c).toHaveBeenCalledTimes(1);
210 |       expect(mockCreateReadStream).toHaveBeenCalledTimes(1);
211 |       expect(mockFse.remove).toHaveBeenCalledTimes(1);
212 |       expect(logger.info).toHaveBeenCalledWith(
213 |         expect.stringContaining('metadata saved to GCS'),
214 |       );
215 |       expect(logger.info).toHaveBeenCalledWith(
216 |         expect.stringContaining('workspace saved to GCS'),
217 |       );
218 |     });
219 | 
220 |     it('should handle tar creation failure', async () => {
221 |       mockFse.pathExists.mockImplementation(
222 |         async (path) =>
223 |           !path.toString().includes('task-task1-workspace-test-uuid.tar.gz'),
224 |       );
225 |       const store = new GCSTaskStore(bucketName);
226 |       await expect(store.save(mockTask)).rejects.toThrow(
227 |         'tar.c command failed to create',
228 |       );
229 |     });
230 |   });
231 | 
232 |   describe('load', () => {
233 |     it('should load task metadata and workspace', async () => {
234 |       mockGunzipSync.mockReturnValue(
235 |         Buffer.from(
236 |           JSON.stringify({
237 |             [TEST_METADATA_KEY]: {
238 |               _agentSettings: {},
239 |               _taskState: 'submitted',
240 |             },
241 |             _contextId: 'ctx1',
242 |           }),
243 |         ),
244 |       );
245 |       mockFile.download.mockResolvedValue([Buffer.from('compressed metadata')]);
246 |       mockFile.download.mockResolvedValueOnce([
247 |         Buffer.from('compressed metadata'),
248 |       ]);
249 |       mockBucket.file = vi.fn((path) => {
250 |         const newMockFile = { ...mockFile };
251 |         if (path.includes('metadata')) {
252 |           newMockFile.download = vi
253 |             .fn()
254 |             .mockResolvedValue([Buffer.from('compressed metadata')]);
255 |           newMockFile.exists = vi.fn().mockResolvedValue([true]);
256 |         } else {
257 |           newMockFile.download = vi
258 |             .fn()
259 |             .mockResolvedValue([Buffer.from('compressed workspace')]);
260 |           newMockFile.exists = vi.fn().mockResolvedValue([true]);
261 |         }
262 |         return newMockFile;
263 |       });
264 | 
265 |       const store = new GCSTaskStore(bucketName);
266 |       const task = await store.load('task1');
267 | 
268 |       expect(task).toBeDefined();
269 |       expect(task?.id).toBe('task1');
270 |       expect(mockBucket.file).toHaveBeenCalledWith(
271 |         'tasks/task1/metadata.tar.gz',
272 |       );
273 |       expect(mockBucket.file).toHaveBeenCalledWith(
274 |         'tasks/task1/workspace.tar.gz',
275 |       );
276 |       expect(mockTar.x).toHaveBeenCalledTimes(1);
277 |       expect(mockFse.remove).toHaveBeenCalledTimes(1);
278 |     });
279 | 
280 |     it('should return undefined if metadata not found', async () => {
281 |       mockFile.exists.mockResolvedValue([false]);
282 |       const store = new GCSTaskStore(bucketName);
283 |       const task = await store.load('task1');
284 |       expect(task).toBeUndefined();
285 |       expect(mockBucket.file).toHaveBeenCalledWith(
286 |         'tasks/task1/metadata.tar.gz',
287 |       );
288 |     });
289 | 
290 |     it('should load metadata even if workspace not found', async () => {
291 |       mockGunzipSync.mockReturnValue(
292 |         Buffer.from(
293 |           JSON.stringify({
294 |             [TEST_METADATA_KEY]: {
295 |               _agentSettings: {},
296 |               _taskState: 'submitted',
297 |             },
298 |             _contextId: 'ctx1',
299 |           }),
300 |         ),
301 |       );
302 | 
303 |       mockBucket.file = vi.fn((path) => {
304 |         const newMockFile = { ...mockFile };
305 |         if (path.includes('workspace.tar.gz')) {
306 |           newMockFile.exists = vi.fn().mockResolvedValue([false]);
307 |         } else {
308 |           newMockFile.exists = vi.fn().mockResolvedValue([true]);
309 |           newMockFile.download = vi
310 |             .fn()
311 |             .mockResolvedValue([Buffer.from('compressed metadata')]);
312 |         }
313 |         return newMockFile;
314 |       });
315 | 
316 |       const store = new GCSTaskStore(bucketName);
317 |       const task = await store.load('task1');
318 | 
319 |       expect(task).toBeDefined();
320 |       expect(mockTar.x).not.toHaveBeenCalled();
321 |       expect(logger.info).toHaveBeenCalledWith(
322 |         expect.stringContaining('workspace archive not found'),
323 |       );
324 |     });
325 |   });
326 | });
327 | 
328 | describe('NoOpTaskStore', () => {
329 |   let realStore: TaskStore;
330 |   let noOpStore: NoOpTaskStore;
331 | 
332 |   beforeEach(() => {
333 |     // Create a mock of the real store to delegate to
334 |     realStore = {
335 |       save: vi.fn(),
336 |       load: vi.fn().mockResolvedValue({ id: 'task-123' } as SDKTask),
337 |     };
338 |     noOpStore = new NoOpTaskStore(realStore);
339 |   });
340 | 
341 |   it("should not call the real store's save method", async () => {
342 |     const mockTask: SDKTask = { id: 'test-task' } as SDKTask;
343 |     await noOpStore.save(mockTask);
344 |     expect(realStore.save).not.toHaveBeenCalled();
345 |   });
346 | 
347 |   it('should delegate the load method to the real store', async () => {
348 |     const taskId = 'task-123';
349 |     const result = await noOpStore.load(taskId);
350 |     expect(realStore.load).toHaveBeenCalledWith(taskId);
351 |     expect(result).toBeDefined();
352 |     expect(result?.id).toBe(taskId);
353 |   });
354 | });
```

src/persistence/gcs.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import { Storage } from '@google-cloud/storage';
8 | import { gzipSync, gunzipSync } from 'node:zlib';
9 | import * as tar from 'tar';
10 | import * as fse from 'fs-extra';
11 | import { promises as fsPromises, createReadStream } from 'node:fs';
12 | import { tmpdir } from 'node:os';
13 | import { join } from 'node:path';
14 | import type { Task as SDKTask } from '@a2a-js/sdk';
15 | import type { TaskStore } from '@a2a-js/sdk/server';
16 | import { logger } from '../utils/logger.js';
17 | import { setTargetDir } from '../config/config.js';
18 | import { getPersistedState, type PersistedTaskMetadata } from '../types.js';
19 | import { v4 as uuidv4 } from 'uuid';
20 | 
21 | type ObjectType = 'metadata' | 'workspace';
22 | 
23 | const getTmpArchiveFilename = (taskId: string): string =>
24 |   `task-${taskId}-workspace-${uuidv4()}.tar.gz`;
25 | 
26 | export class GCSTaskStore implements TaskStore {
27 |   private storage: Storage;
28 |   private bucketName: string;
29 |   private bucketInitialized: Promise<void>;
30 | 
31 |   constructor(bucketName: string) {
32 |     if (!bucketName) {
33 |       throw new Error('GCS bucket name is required.');
34 |     }
35 |     this.storage = new Storage();
36 |     this.bucketName = bucketName;
37 |     logger.info(`GCSTaskStore initializing with bucket: ${this.bucketName}`);
38 |     // Prerequisites: user account or service account must have storage admin IAM role
39 |     // and the bucket name must be unique.
40 |     this.bucketInitialized = this.initializeBucket();
41 |   }
42 | 
43 |   private async initializeBucket(): Promise<void> {
44 |     try {
45 |       const [buckets] = await this.storage.getBuckets();
46 |       const exists = buckets.some((bucket) => bucket.name === this.bucketName);
47 | 
48 |       if (!exists) {
49 |         logger.info(
50 |           `Bucket ${this.bucketName} does not exist in the list. Attempting to create...`,
51 |         );
52 |         try {
53 |           await this.storage.createBucket(this.bucketName);
54 |           logger.info(`Bucket ${this.bucketName} created successfully.`);
55 |         } catch (createError) {
56 |           logger.info(
57 |             `Failed to create bucket ${this.bucketName}: ${createError}`,
58 |           );
59 |           throw new Error(
60 |             `Failed to create GCS bucket ${this.bucketName}: ${createError}`,
61 |           );
62 |         }
63 |       } else {
64 |         logger.info(`Bucket ${this.bucketName} exists.`);
65 |       }
66 |     } catch (error) {
67 |       logger.info(
68 |         `Error during bucket initialization for ${this.bucketName}: ${error}`,
69 |       );
70 |       throw new Error(
71 |         `Failed to initialize GCS bucket ${this.bucketName}: ${error}`,
72 |       );
73 |     }
74 |   }
75 | 
76 |   private async ensureBucketInitialized(): Promise<void> {
77 |     await this.bucketInitialized;
78 |   }
79 | 
80 |   private getObjectPath(taskId: string, type: ObjectType): string {
81 |     return `tasks/${taskId}/${type}.tar.gz`;
82 |   }
83 | 
84 |   async save(task: SDKTask): Promise<void> {
85 |     await this.ensureBucketInitialized();
86 |     const taskId = task.id;
87 |     const persistedState = getPersistedState(
88 |       task.metadata as PersistedTaskMetadata,
89 |     );
90 | 
91 |     if (!persistedState) {
92 |       throw new Error(`Task ${taskId} is missing persisted state in metadata.`);
93 |     }
94 |     const workDir = process.cwd();
95 | 
96 |     const metadataObjectPath = this.getObjectPath(taskId, 'metadata');
97 |     const workspaceObjectPath = this.getObjectPath(taskId, 'workspace');
98 | 
99 |     const dataToStore = task.metadata;
100 | 
101 |     try {
102 |       const jsonString = JSON.stringify(dataToStore);
103 |       const compressedMetadata = gzipSync(Buffer.from(jsonString));
104 |       const metadataFile = this.storage
105 |         .bucket(this.bucketName)
106 |         .file(metadataObjectPath);
107 |       await metadataFile.save(compressedMetadata, {
108 |         contentType: 'application/gzip',
109 |       });
110 |       logger.info(
111 |         `Task ${taskId} metadata saved to GCS: gs://${this.bucketName}/${metadataObjectPath}`,
112 |       );
113 | 
114 |       if (await fse.pathExists(workDir)) {
115 |         const entries = await fsPromises.readdir(workDir);
116 |         if (entries.length > 0) {
117 |           const tmpArchiveFile = join(tmpdir(), getTmpArchiveFilename(taskId));
118 |           try {
119 |             await tar.c(
120 |               {
121 |                 gzip: true,
122 |                 file: tmpArchiveFile,
123 |                 cwd: workDir,
124 |                 portable: true,
125 |               },
126 |               entries,
127 |             );
128 | 
129 |             if (!(await fse.pathExists(tmpArchiveFile))) {
130 |               throw new Error(
131 |                 `tar.c command failed to create ${tmpArchiveFile}`,
132 |               );
133 |             }
134 | 
135 |             const workspaceFile = this.storage
136 |               .bucket(this.bucketName)
137 |               .file(workspaceObjectPath);
138 |             const sourceStream = createReadStream(tmpArchiveFile);
139 |             const destStream = workspaceFile.createWriteStream({
140 |               contentType: 'application/gzip',
141 |               resumable: true,
142 |             });
143 | 
144 |             await new Promise<void>((resolve, reject) => {
145 |               sourceStream.on('error', (err) => {
146 |                 logger.error(
147 |                   `Error in source stream for ${tmpArchiveFile}:`,
148 |                   err,
149 |                 );
150 |                 // Attempt to close destStream if source fails
151 |                 if (!destStream.destroyed) {
152 |                   destStream.destroy(err);
153 |                 }
154 |                 reject(err);
155 |               });
156 | 
157 |               destStream.on('error', (err) => {
158 |                 logger.error(
159 |                   `Error in GCS dest stream for ${workspaceObjectPath}:`,
160 |                   err,
161 |                 );
162 |                 reject(err);
163 |               });
164 | 
165 |               destStream.on('finish', () => {
166 |                 logger.info(
167 |                   `GCS destStream finished for ${workspaceObjectPath}`,
168 |                 );
169 |                 resolve();
170 |               });
171 | 
172 |               logger.info(
173 |                 `Piping ${tmpArchiveFile} to GCS object ${workspaceObjectPath}`,
174 |               );
175 |               sourceStream.pipe(destStream);
176 |             });
177 |             logger.info(
178 |               `Task ${taskId} workspace saved to GCS: gs://${this.bucketName}/${workspaceObjectPath}`,
179 |             );
180 |           } catch (error) {
181 |             logger.error(
182 |               `Error during workspace save process for ${taskId}:`,
183 |               error,
184 |             );
185 |             throw error;
186 |           } finally {
187 |             logger.info(`Cleaning up temporary file: ${tmpArchiveFile}`);
188 |             try {
189 |               if (await fse.pathExists(tmpArchiveFile)) {
190 |                 await fse.remove(tmpArchiveFile);
191 |                 logger.info(
192 |                   `Successfully removed temporary file: ${tmpArchiveFile}`,
193 |                 );
194 |               } else {
195 |                 logger.warn(
196 |                   `Temporary file not found for cleanup: ${tmpArchiveFile}`,
197 |                 );
198 |               }
199 |             } catch (removeError) {
200 |               logger.error(
201 |                 `Error removing temporary file ${tmpArchiveFile}:`,
202 |                 removeError,
203 |               );
204 |             }
205 |           }
206 |         } else {
207 |           logger.info(
208 |             `Workspace directory ${workDir} is empty, skipping workspace save for task ${taskId}.`,
209 |           );
210 |         }
211 |       } else {
212 |         logger.info(
213 |           `Workspace directory ${workDir} not found, skipping workspace save for task ${taskId}.`,
214 |         );
215 |       }
216 |     } catch (error) {
217 |       logger.error(`Failed to save task ${taskId} to GCS:`, error);
218 |       throw error;
219 |     }
220 |   }
221 | 
222 |   async load(taskId: string): Promise<SDKTask | undefined> {
223 |     await this.ensureBucketInitialized();
224 |     const metadataObjectPath = this.getObjectPath(taskId, 'metadata');
225 |     const workspaceObjectPath = this.getObjectPath(taskId, 'workspace');
226 | 
227 |     try {
228 |       const metadataFile = this.storage
229 |         .bucket(this.bucketName)
230 |         .file(metadataObjectPath);
231 |       const [metadataExists] = await metadataFile.exists();
232 |       if (!metadataExists) {
233 |         logger.info(`Task ${taskId} metadata not found in GCS.`);
234 |         return undefined;
235 |       }
236 |       const [compressedMetadata] = await metadataFile.download();
237 |       const jsonData = gunzipSync(compressedMetadata).toString();
238 |       const loadedMetadata = JSON.parse(jsonData);
239 |       logger.info(`Task ${taskId} metadata loaded from GCS.`);
240 | 
241 |       const persistedState = getPersistedState(loadedMetadata);
242 |       if (!persistedState) {
243 |         throw new Error(
244 |           `Loaded metadata for task ${taskId} is missing internal persisted state.`,
245 |         );
246 |       }
247 |       const agentSettings = persistedState._agentSettings;
248 | 
249 |       const workDir = setTargetDir(agentSettings);
250 |       await fse.ensureDir(workDir);
251 |       const workspaceFile = this.storage
252 |         .bucket(this.bucketName)
253 |         .file(workspaceObjectPath);
254 |       const [workspaceExists] = await workspaceFile.exists();
255 |       if (workspaceExists) {
256 |         const tmpArchiveFile = join(tmpdir(), getTmpArchiveFilename(taskId));
257 |         try {
258 |           await workspaceFile.download({ destination: tmpArchiveFile });
259 |           await tar.x({ file: tmpArchiveFile, cwd: workDir });
260 |           logger.info(
261 |             `Task ${taskId} workspace restored from GCS to ${workDir}`,
262 |           );
263 |         } finally {
264 |           if (await fse.pathExists(tmpArchiveFile)) {
265 |             await fse.remove(tmpArchiveFile);
266 |           }
267 |         }
268 |       } else {
269 |         logger.info(`Task ${taskId} workspace archive not found in GCS.`);
270 |       }
271 | 
272 |       return {
273 |         id: taskId,
274 |         contextId: loadedMetadata._contextId || uuidv4(),
275 |         kind: 'task',
276 |         status: {
277 |           state: persistedState._taskState,
278 |           timestamp: new Date().toISOString(),
279 |         },
280 |         metadata: loadedMetadata,
281 |         history: [],
282 |         artifacts: [],
283 |       };
284 |     } catch (error) {
285 |       logger.error(`Failed to load task ${taskId} from GCS:`, error);
286 |       throw error;
287 |     }
288 |   }
289 | }
290 | 
291 | export class NoOpTaskStore implements TaskStore {
292 |   constructor(private realStore: TaskStore) {}
293 | 
294 |   async save(task: SDKTask): Promise<void> {
295 |     logger.info(`[NoOpTaskStore] save called for task ${task.id} - IGNORED`);
296 |     return Promise.resolve();
297 |   }
298 | 
299 |   async load(taskId: string): Promise<SDKTask | undefined> {
300 |     logger.info(
301 |       `[NoOpTaskStore] load called for task ${taskId}, delegating to real store.`,
302 |     );
303 |     return this.realStore.load(taskId);
304 |   }
305 | }
```

src/http/app.test.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type { Config } from '@google/gemini-cli-core';
8 | import {
9 |   GeminiEventType,
10 |   ApprovalMode,
11 |   type ToolCallConfirmationDetails,
12 | } from '@google/gemini-cli-core';
13 | import type {
14 |   TaskStatusUpdateEvent,
15 |   SendStreamingMessageSuccessResponse,
16 | } from '@a2a-js/sdk';
17 | import type express from 'express';
18 | import type { Server } from 'node:http';
19 | import request from 'supertest';
20 | import {
21 |   afterAll,
22 |   afterEach,
23 |   beforeEach,
24 |   beforeAll,
25 |   describe,
26 |   expect,
27 |   it,
28 |   vi,
29 | } from 'vitest';
30 | import { createApp } from './app.js';
31 | import {
32 |   assertUniqueFinalEventIsLast,
33 |   assertTaskCreationAndWorkingStatus,
34 |   createStreamMessageRequest,
35 |   createMockConfig,
36 | } from '../utils/testing_utils.js';
37 | import { MockTool } from '@google/gemini-cli-core';
38 | 
39 | const mockToolConfirmationFn = async () =>
40 |   ({}) as unknown as ToolCallConfirmationDetails;
41 | 
42 | const streamToSSEEvents = (
43 |   stream: string,
44 | ): SendStreamingMessageSuccessResponse[] =>
45 |   stream
46 |     .split('\n\n')
47 |     .filter(Boolean) // Remove empty strings from trailing newlines
48 |     .map((chunk) => {
49 |       const dataLine = chunk
50 |         .split('\n')
51 |         .find((line) => line.startsWith('data: '));
52 |       if (!dataLine) {
53 |         throw new Error(`Invalid SSE chunk found: "${chunk}"`);
54 |       }
55 |       return JSON.parse(dataLine.substring(6));
56 |     });
57 | 
58 | // Mock the logger to avoid polluting test output
59 | // Comment out to debug tests
60 | vi.mock('../utils/logger.js', () => ({
61 |   logger: { info: vi.fn(), warn: vi.fn(), error: vi.fn() },
62 | }));
63 | 
64 | let config: Config;
65 | const getToolRegistrySpy = vi.fn().mockReturnValue(ApprovalMode.DEFAULT);
66 | const getApprovalModeSpy = vi.fn();
67 | const getShellExecutionConfigSpy = vi.fn();
68 | vi.mock('../config/config.js', async () => {
69 |   const actual = await vi.importActual('../config/config.js');
70 |   return {
71 |     ...actual,
72 |     loadConfig: vi.fn().mockImplementation(async () => {
73 |       const mockConfig = createMockConfig({
74 |         getToolRegistry: getToolRegistrySpy,
75 |         getApprovalMode: getApprovalModeSpy,
76 |         getShellExecutionConfig: getShellExecutionConfigSpy,
77 |       });
78 |       config = mockConfig as Config;
79 |       return config;
80 |     }),
81 |   };
82 | });
83 | 
84 | // Mock the GeminiClient to avoid actual API calls
85 | const sendMessageStreamSpy = vi.fn();
86 | vi.mock('@google/gemini-cli-core', async () => {
87 |   const actual = await vi.importActual('@google/gemini-cli-core');
88 |   return {
89 |     ...actual,
90 |     GeminiClient: vi.fn().mockImplementation(() => ({
91 |       sendMessageStream: sendMessageStreamSpy,
92 |       getUserTier: vi.fn().mockReturnValue('free'),
93 |       initialize: vi.fn(),
94 |     })),
95 |   };
96 | });
97 | 
98 | describe('E2E Tests', () => {
99 |   let app: express.Express;
100 |   let server: Server;
101 | 
102 |   beforeAll(async () => {
103 |     app = await createApp();
104 |     server = app.listen(0); // Listen on a random available port
105 |   });
106 | 
107 |   beforeEach(() => {
108 |     getApprovalModeSpy.mockReturnValue(ApprovalMode.DEFAULT);
109 |   });
110 | 
111 |   afterAll(
112 |     () =>
113 |       new Promise<void>((resolve) => {
114 |         server.close(() => {
115 |           resolve();
116 |         });
117 |       }),
118 |   );
119 | 
120 |   afterEach(() => {
121 |     vi.clearAllMocks();
122 |   });
123 | 
124 |   it('should create a new task and stream status updates (text-content) via POST /', async () => {
125 |     sendMessageStreamSpy.mockImplementation(async function* () {
126 |       yield* [{ type: 'content', value: 'Hello how are you?' }];
127 |     });
128 | 
129 |     const agent = request.agent(app);
130 |     const res = await agent
131 |       .post('/')
132 |       .send(createStreamMessageRequest('hello', 'a2a-test-message'))
133 |       .set('Content-Type', 'application/json')
134 |       .expect(200);
135 | 
136 |     const events = streamToSSEEvents(res.text);
137 | 
138 |     assertTaskCreationAndWorkingStatus(events);
139 | 
140 |     // Status update: text-content
141 |     const textContentEvent = events[2].result as TaskStatusUpdateEvent;
142 |     expect(textContentEvent.kind).toBe('status-update');
143 |     expect(textContentEvent.status.state).toBe('working');
144 |     expect(textContentEvent.metadata?.['coderAgent']).toMatchObject({
145 |       kind: 'text-content',
146 |     });
147 |     expect(textContentEvent.status.message?.parts).toMatchObject([
148 |       { kind: 'text', text: 'Hello how are you?' },
149 |     ]);
150 | 
151 |     // Status update: input-required (final)
152 |     const finalEvent = events[3].result as TaskStatusUpdateEvent;
153 |     expect(finalEvent.kind).toBe('status-update');
154 |     expect(finalEvent.status?.state).toBe('input-required');
155 |     expect(finalEvent.final).toBe(true);
156 | 
157 |     assertUniqueFinalEventIsLast(events);
158 |     expect(events.length).toBe(4);
159 |   });
160 | 
161 |   it('should create a new task, schedule a tool call, and wait for approval', async () => {
162 |     // First call yields the tool request
163 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
164 |       yield* [
165 |         {
166 |           type: GeminiEventType.ToolCallRequest,
167 |           value: {
168 |             callId: 'test-call-id',
169 |             name: 'test-tool',
170 |             args: {},
171 |           },
172 |         },
173 |       ];
174 |     });
175 |     // Subsequent calls yield nothing
176 |     sendMessageStreamSpy.mockImplementation(async function* () {
177 |       yield* [];
178 |     });
179 | 
180 |     const mockTool = new MockTool({
181 |       name: 'test-tool',
182 |       shouldConfirmExecute: vi.fn(mockToolConfirmationFn),
183 |     });
184 | 
185 |     getToolRegistrySpy.mockReturnValue({
186 |       getAllTools: vi.fn().mockReturnValue([mockTool]),
187 |       getToolsByServer: vi.fn().mockReturnValue([]),
188 |       getTool: vi.fn().mockReturnValue(mockTool),
189 |     });
190 | 
191 |     const agent = request.agent(app);
192 |     const res = await agent
193 |       .post('/')
194 |       .send(createStreamMessageRequest('run a tool', 'a2a-tool-test-message'))
195 |       .set('Content-Type', 'application/json')
196 |       .expect(200);
197 | 
198 |     const events = streamToSSEEvents(res.text);
199 |     assertTaskCreationAndWorkingStatus(events);
200 | 
201 |     // Status update: working
202 |     const workingEvent2 = events[2].result as TaskStatusUpdateEvent;
203 |     expect(workingEvent2.kind).toBe('status-update');
204 |     expect(workingEvent2.status.state).toBe('working');
205 |     expect(workingEvent2.metadata?.['coderAgent']).toMatchObject({
206 |       kind: 'state-change',
207 |     });
208 | 
209 |     // Status update: tool-call-update
210 |     const toolCallUpdateEvent = events[3].result as TaskStatusUpdateEvent;
211 |     expect(toolCallUpdateEvent.kind).toBe('status-update');
212 |     expect(toolCallUpdateEvent.status.state).toBe('working');
213 |     expect(toolCallUpdateEvent.metadata?.['coderAgent']).toMatchObject({
214 |       kind: 'tool-call-update',
215 |     });
216 |     expect(toolCallUpdateEvent.status.message?.parts).toMatchObject([
217 |       {
218 |         data: {
219 |           status: 'validating',
220 |           request: { callId: 'test-call-id' },
221 |         },
222 |       },
223 |     ]);
224 | 
225 |     // State update: awaiting_approval update
226 |     const toolCallConfirmationEvent = events[4].result as TaskStatusUpdateEvent;
227 |     expect(toolCallConfirmationEvent.kind).toBe('status-update');
228 |     expect(toolCallConfirmationEvent.metadata?.['coderAgent']).toMatchObject({
229 |       kind: 'tool-call-confirmation',
230 |     });
231 |     expect(toolCallConfirmationEvent.status.message?.parts).toMatchObject([
232 |       {
233 |         data: {
234 |           status: 'awaiting_approval',
235 |           request: { callId: 'test-call-id' },
236 |         },
237 |       },
238 |     ]);
239 |     expect(toolCallConfirmationEvent.status?.state).toBe('working');
240 | 
241 |     assertUniqueFinalEventIsLast(events);
242 |     expect(events.length).toBe(6);
243 |   });
244 | 
245 |   it('should handle multiple tool calls in a single turn', async () => {
246 |     // First call yields the tool request
247 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
248 |       yield* [
249 |         {
250 |           type: GeminiEventType.ToolCallRequest,
251 |           value: {
252 |             callId: 'test-call-id-1',
253 |             name: 'test-tool-1',
254 |             args: {},
255 |           },
256 |         },
257 |         {
258 |           type: GeminiEventType.ToolCallRequest,
259 |           value: {
260 |             callId: 'test-call-id-2',
261 |             name: 'test-tool-2',
262 |             args: {},
263 |           },
264 |         },
265 |       ];
266 |     });
267 |     // Subsequent calls yield nothing
268 |     sendMessageStreamSpy.mockImplementation(async function* () {
269 |       yield* [];
270 |     });
271 | 
272 |     const mockTool1 = new MockTool({
273 |       name: 'test-tool-1',
274 |       displayName: 'Test Tool 1',
275 |       shouldConfirmExecute: vi.fn(mockToolConfirmationFn),
276 |     });
277 |     const mockTool2 = new MockTool({
278 |       name: 'test-tool-2',
279 |       displayName: 'Test Tool 2',
280 |       shouldConfirmExecute: vi.fn(mockToolConfirmationFn),
281 |     });
282 | 
283 |     getToolRegistrySpy.mockReturnValue({
284 |       getAllTools: vi.fn().mockReturnValue([mockTool1, mockTool2]),
285 |       getToolsByServer: vi.fn().mockReturnValue([]),
286 |       getTool: vi.fn().mockImplementation((name: string) => {
287 |         if (name === 'test-tool-1') return mockTool1;
288 |         if (name === 'test-tool-2') return mockTool2;
289 |         return undefined;
290 |       }),
291 |     });
292 | 
293 |     const agent = request.agent(app);
294 |     const res = await agent
295 |       .post('/')
296 |       .send(
297 |         createStreamMessageRequest(
298 |           'run two tools',
299 |           'a2a-multi-tool-test-message',
300 |         ),
301 |       )
302 |       .set('Content-Type', 'application/json')
303 |       .expect(200);
304 | 
305 |     const events = streamToSSEEvents(res.text);
306 |     assertTaskCreationAndWorkingStatus(events);
307 | 
308 |     // Second working update
309 |     const workingEvent = events[2].result as TaskStatusUpdateEvent;
310 |     expect(workingEvent.kind).toBe('status-update');
311 |     expect(workingEvent.status.state).toBe('working');
312 | 
313 |     // State Update: Validate each tool call
314 |     const toolCallValidateEvent1 = events[3].result as TaskStatusUpdateEvent;
315 |     expect(toolCallValidateEvent1.metadata?.['coderAgent']).toMatchObject({
316 |       kind: 'tool-call-update',
317 |     });
318 |     expect(toolCallValidateEvent1.status.message?.parts).toMatchObject([
319 |       {
320 |         data: {
321 |           status: 'validating',
322 |           request: { callId: 'test-call-id-1' },
323 |         },
324 |       },
325 |     ]);
326 |     const toolCallValidateEvent2 = events[4].result as TaskStatusUpdateEvent;
327 |     expect(toolCallValidateEvent2.metadata?.['coderAgent']).toMatchObject({
328 |       kind: 'tool-call-update',
329 |     });
330 |     expect(toolCallValidateEvent2.status.message?.parts).toMatchObject([
331 |       {
332 |         data: {
333 |           status: 'validating',
334 |           request: { callId: 'test-call-id-2' },
335 |         },
336 |       },
337 |     ]);
338 | 
339 |     // State Update: Set each tool call to awaiting
340 |     const toolCallAwaitEvent1 = events[5].result as TaskStatusUpdateEvent;
341 |     expect(toolCallAwaitEvent1.metadata?.['coderAgent']).toMatchObject({
342 |       kind: 'tool-call-confirmation',
343 |     });
344 |     expect(toolCallAwaitEvent1.status.message?.parts).toMatchObject([
345 |       {
346 |         data: {
347 |           status: 'awaiting_approval',
348 |           request: { callId: 'test-call-id-1' },
349 |         },
350 |       },
351 |     ]);
352 |     const toolCallAwaitEvent2 = events[6].result as TaskStatusUpdateEvent;
353 |     expect(toolCallAwaitEvent2.metadata?.['coderAgent']).toMatchObject({
354 |       kind: 'tool-call-confirmation',
355 |     });
356 |     expect(toolCallAwaitEvent2.status.message?.parts).toMatchObject([
357 |       {
358 |         data: {
359 |           status: 'awaiting_approval',
360 |           request: { callId: 'test-call-id-2' },
361 |         },
362 |       },
363 |     ]);
364 | 
365 |     assertUniqueFinalEventIsLast(events);
366 |     expect(events.length).toBe(8);
367 |   });
368 | 
369 |   it('should handle tool calls that do not require approval', async () => {
370 |     // First call yields the tool request
371 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
372 |       yield* [
373 |         {
374 |           type: GeminiEventType.ToolCallRequest,
375 |           value: {
376 |             callId: 'test-call-id-no-approval',
377 |             name: 'test-tool-no-approval',
378 |             args: {},
379 |           },
380 |         },
381 |       ];
382 |     });
383 |     // Second call, after the tool runs, yields the final text
384 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
385 |       yield* [{ type: 'content', value: 'Tool executed successfully.' }];
386 |     });
387 | 
388 |     const mockTool = new MockTool({
389 |       name: 'test-tool-no-approval',
390 |       displayName: 'Test Tool No Approval',
391 |       execute: vi.fn().mockResolvedValue({
392 |         llmContent: 'Tool executed successfully.',
393 |         returnDisplay: 'Tool executed successfully.',
394 |       }),
395 |     });
396 | 
397 |     getToolRegistrySpy.mockReturnValue({
398 |       getAllTools: vi.fn().mockReturnValue([mockTool]),
399 |       getToolsByServer: vi.fn().mockReturnValue([]),
400 |       getTool: vi.fn().mockReturnValue(mockTool),
401 |     });
402 | 
403 |     const agent = request.agent(app);
404 |     const res = await agent
405 |       .post('/')
406 |       .send(
407 |         createStreamMessageRequest(
408 |           'run a tool without approval',
409 |           'a2a-no-approval-test-message',
410 |         ),
411 |       )
412 |       .set('Content-Type', 'application/json')
413 |       .expect(200);
414 | 
415 |     const events = streamToSSEEvents(res.text);
416 |     assertTaskCreationAndWorkingStatus(events);
417 | 
418 |     // Status update: working
419 |     const workingEvent2 = events[2].result as TaskStatusUpdateEvent;
420 |     expect(workingEvent2.kind).toBe('status-update');
421 |     expect(workingEvent2.status.state).toBe('working');
422 | 
423 |     // Status update: tool-call-update (validating)
424 |     const validatingEvent = events[3].result as TaskStatusUpdateEvent;
425 |     expect(validatingEvent.metadata?.['coderAgent']).toMatchObject({
426 |       kind: 'tool-call-update',
427 |     });
428 |     expect(validatingEvent.status.message?.parts).toMatchObject([
429 |       {
430 |         data: {
431 |           status: 'validating',
432 |           request: { callId: 'test-call-id-no-approval' },
433 |         },
434 |       },
435 |     ]);
436 | 
437 |     // Status update: tool-call-update (scheduled)
438 |     const scheduledEvent = events[4].result as TaskStatusUpdateEvent;
439 |     expect(scheduledEvent.metadata?.['coderAgent']).toMatchObject({
440 |       kind: 'tool-call-update',
441 |     });
442 |     expect(scheduledEvent.status.message?.parts).toMatchObject([
443 |       {
444 |         data: {
445 |           status: 'scheduled',
446 |           request: { callId: 'test-call-id-no-approval' },
447 |         },
448 |       },
449 |     ]);
450 | 
451 |     // Status update: tool-call-update (executing)
452 |     const executingEvent = events[5].result as TaskStatusUpdateEvent;
453 |     expect(executingEvent.metadata?.['coderAgent']).toMatchObject({
454 |       kind: 'tool-call-update',
455 |     });
456 |     expect(executingEvent.status.message?.parts).toMatchObject([
457 |       {
458 |         data: {
459 |           status: 'executing',
460 |           request: { callId: 'test-call-id-no-approval' },
461 |         },
462 |       },
463 |     ]);
464 | 
465 |     // Status update: tool-call-update (success)
466 |     const successEvent = events[6].result as TaskStatusUpdateEvent;
467 |     expect(successEvent.metadata?.['coderAgent']).toMatchObject({
468 |       kind: 'tool-call-update',
469 |     });
470 |     expect(successEvent.status.message?.parts).toMatchObject([
471 |       {
472 |         data: {
473 |           status: 'success',
474 |           request: { callId: 'test-call-id-no-approval' },
475 |         },
476 |       },
477 |     ]);
478 | 
479 |     // Status update: working (before sending tool result to LLM)
480 |     const workingEvent3 = events[7].result as TaskStatusUpdateEvent;
481 |     expect(workingEvent3.kind).toBe('status-update');
482 |     expect(workingEvent3.status.state).toBe('working');
483 | 
484 |     // Status update: text-content (final LLM response)
485 |     const textContentEvent = events[8].result as TaskStatusUpdateEvent;
486 |     expect(textContentEvent.metadata?.['coderAgent']).toMatchObject({
487 |       kind: 'text-content',
488 |     });
489 |     expect(textContentEvent.status.message?.parts).toMatchObject([
490 |       { text: 'Tool executed successfully.' },
491 |     ]);
492 | 
493 |     assertUniqueFinalEventIsLast(events);
494 |     expect(events.length).toBe(10);
495 |   });
496 | 
497 |   it('should bypass tool approval in YOLO mode', async () => {
498 |     // First call yields the tool request
499 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
500 |       yield* [
501 |         {
502 |           type: GeminiEventType.ToolCallRequest,
503 |           value: {
504 |             callId: 'test-call-id-yolo',
505 |             name: 'test-tool-yolo',
506 |             args: {},
507 |           },
508 |         },
509 |       ];
510 |     });
511 |     // Second call, after the tool runs, yields the final text
512 |     sendMessageStreamSpy.mockImplementationOnce(async function* () {
513 |       yield* [{ type: 'content', value: 'Tool executed successfully.' }];
514 |     });
515 | 
516 |     // Set approval mode to yolo
517 |     getApprovalModeSpy.mockReturnValue(ApprovalMode.YOLO);
518 | 
519 |     const mockTool = new MockTool({
520 |       name: 'test-tool-yolo',
521 |       displayName: 'Test Tool YOLO',
522 |       execute: vi.fn().mockResolvedValue({
523 |         llmContent: 'Tool executed successfully.',
524 |         returnDisplay: 'Tool executed successfully.',
525 |       }),
526 |     });
527 | 
528 |     getToolRegistrySpy.mockReturnValue({
529 |       getAllTools: vi.fn().mockReturnValue([mockTool]),
530 |       getToolsByServer: vi.fn().mockReturnValue([]),
531 |       getTool: vi.fn().mockReturnValue(mockTool),
532 |     });
533 | 
534 |     const agent = request.agent(app);
535 |     const res = await agent
536 |       .post('/')
537 |       .send(
538 |         createStreamMessageRequest(
539 |           'run a tool in yolo mode',
540 |           'a2a-yolo-mode-test-message',
541 |         ),
542 |       )
543 |       .set('Content-Type', 'application/json')
544 |       .expect(200);
545 | 
546 |     const events = streamToSSEEvents(res.text);
547 |     assertTaskCreationAndWorkingStatus(events);
548 | 
549 |     // Status update: working
550 |     const workingEvent2 = events[2].result as TaskStatusUpdateEvent;
551 |     expect(workingEvent2.kind).toBe('status-update');
552 |     expect(workingEvent2.status.state).toBe('working');
553 | 
554 |     // Status update: tool-call-update (validating)
555 |     const validatingEvent = events[3].result as TaskStatusUpdateEvent;
556 |     expect(validatingEvent.metadata?.['coderAgent']).toMatchObject({
557 |       kind: 'tool-call-update',
558 |     });
559 |     expect(validatingEvent.status.message?.parts).toMatchObject([
560 |       {
561 |         data: {
562 |           status: 'validating',
563 |           request: { callId: 'test-call-id-yolo' },
564 |         },
565 |       },
566 |     ]);
567 | 
568 |     // Status update: tool-call-update (scheduled)
569 |     const awaitingEvent = events[4].result as TaskStatusUpdateEvent;
570 |     expect(awaitingEvent.metadata?.['coderAgent']).toMatchObject({
571 |       kind: 'tool-call-update',
572 |     });
573 |     expect(awaitingEvent.status.message?.parts).toMatchObject([
574 |       {
575 |         data: {
576 |           status: 'scheduled',
577 |           request: { callId: 'test-call-id-yolo' },
578 |         },
579 |       },
580 |     ]);
581 | 
582 |     // Status update: tool-call-update (executing)
583 |     const executingEvent = events[5].result as TaskStatusUpdateEvent;
584 |     expect(executingEvent.metadata?.['coderAgent']).toMatchObject({
585 |       kind: 'tool-call-update',
586 |     });
587 |     expect(executingEvent.status.message?.parts).toMatchObject([
588 |       {
589 |         data: {
590 |           status: 'executing',
591 |           request: { callId: 'test-call-id-yolo' },
592 |         },
593 |       },
594 |     ]);
595 | 
596 |     // Status update: tool-call-update (success)
597 |     const successEvent = events[6].result as TaskStatusUpdateEvent;
598 |     expect(successEvent.metadata?.['coderAgent']).toMatchObject({
599 |       kind: 'tool-call-update',
600 |     });
601 |     expect(successEvent.status.message?.parts).toMatchObject([
602 |       {
603 |         data: {
604 |           status: 'success',
605 |           request: { callId: 'test-call-id-yolo' },
606 |         },
607 |       },
608 |     ]);
609 | 
610 |     // Status update: working (before sending tool result to LLM)
611 |     const workingEvent3 = events[7].result as TaskStatusUpdateEvent;
612 |     expect(workingEvent3.kind).toBe('status-update');
613 |     expect(workingEvent3.status.state).toBe('working');
614 | 
615 |     // Status update: text-content (final LLM response)
616 |     const textContentEvent = events[8].result as TaskStatusUpdateEvent;
617 |     expect(textContentEvent.metadata?.['coderAgent']).toMatchObject({
618 |       kind: 'text-content',
619 |     });
620 |     expect(textContentEvent.status.message?.parts).toMatchObject([
621 |       { text: 'Tool executed successfully.' },
622 |     ]);
623 | 
624 |     assertUniqueFinalEventIsLast(events);
625 |     expect(events.length).toBe(10);
626 |   });
627 | });
```

src/http/app.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import express from 'express';
8 | 
9 | import type { AgentCard } from '@a2a-js/sdk';
10 | import type { TaskStore } from '@a2a-js/sdk/server';
11 | import { DefaultRequestHandler, InMemoryTaskStore } from '@a2a-js/sdk/server';
12 | import { A2AExpressApp } from '@a2a-js/sdk/server/express'; // Import server components
13 | import { v4 as uuidv4 } from 'uuid';
14 | import { logger } from '../utils/logger.js';
15 | import type { AgentSettings } from '../types.js';
16 | import { GCSTaskStore, NoOpTaskStore } from '../persistence/gcs.js';
17 | import { CoderAgentExecutor } from '../agent/executor.js';
18 | import { requestStorage } from './requestStorage.js';
19 | 
20 | const coderAgentCard: AgentCard = {
21 |   name: 'Gemini SDLC Agent',
22 |   description:
23 |     'An agent that generates code based on natural language instructions and streams file outputs.',
24 |   url: 'http://localhost:41242/',
25 |   provider: {
26 |     organization: 'Google',
27 |     url: 'https://google.com',
28 |   },
29 |   protocolVersion: '0.3.0',
30 |   version: '0.0.2', // Incremented version
31 |   capabilities: {
32 |     streaming: true,
33 |     pushNotifications: false,
34 |     stateTransitionHistory: true,
35 |   },
36 |   securitySchemes: undefined,
37 |   security: undefined,
38 |   defaultInputModes: ['text'],
39 |   defaultOutputModes: ['text'],
40 |   skills: [
41 |     {
42 |       id: 'code_generation',
43 |       name: 'Code Generation',
44 |       description:
45 |         'Generates code snippets or complete files based on user requests, streaming the results.',
46 |       tags: ['code', 'development', 'programming'],
47 |       examples: [
48 |         'Write a python function to calculate fibonacci numbers.',
49 |         'Create an HTML file with a basic button that alerts "Hello!" when clicked.',
50 |       ],
51 |       inputModes: ['text'],
52 |       outputModes: ['text'],
53 |     },
54 |   ],
55 |   supportsAuthenticatedExtendedCard: false,
56 | };
57 | 
58 | export function updateCoderAgentCardUrl(port: number) {
59 |   coderAgentCard.url = `http://localhost:${port}/`;
60 | }
61 | 
62 | export async function createApp() {
63 |   try {
64 |     // loadEnvironment() is called within getConfig now
65 |     const bucketName = process.env['GCS_BUCKET_NAME'];
66 |     let taskStoreForExecutor: TaskStore;
67 |     let taskStoreForHandler: TaskStore;
68 | 
69 |     if (bucketName) {
70 |       logger.info(`Using GCSTaskStore with bucket: ${bucketName}`);
71 |       const gcsTaskStore = new GCSTaskStore(bucketName);
72 |       taskStoreForExecutor = gcsTaskStore;
73 |       taskStoreForHandler = new NoOpTaskStore(gcsTaskStore);
74 |     } else {
75 |       logger.info('Using InMemoryTaskStore');
76 |       const inMemoryTaskStore = new InMemoryTaskStore();
77 |       taskStoreForExecutor = inMemoryTaskStore;
78 |       taskStoreForHandler = inMemoryTaskStore;
79 |     }
80 | 
81 |     const agentExecutor = new CoderAgentExecutor(taskStoreForExecutor);
82 | 
83 |     const requestHandler = new DefaultRequestHandler(
84 |       coderAgentCard,
85 |       taskStoreForHandler,
86 |       agentExecutor,
87 |     );
88 | 
89 |     let expressApp = express();
90 |     expressApp.use((req, res, next) => {
91 |       requestStorage.run({ req }, next);
92 |     });
93 | 
94 |     const appBuilder = new A2AExpressApp(requestHandler);
95 |     expressApp = appBuilder.setupRoutes(expressApp, '');
96 |     expressApp.use(express.json());
97 | 
98 |     expressApp.post('/tasks', async (req, res) => {
99 |       try {
100 |         const taskId = uuidv4();
101 |         const agentSettings = req.body.agentSettings as
102 |           | AgentSettings
103 |           | undefined;
104 |         const contextId = req.body.contextId || uuidv4();
105 |         const wrapper = await agentExecutor.createTask(
106 |           taskId,
107 |           contextId,
108 |           agentSettings,
109 |         );
110 |         await taskStoreForExecutor.save(wrapper.toSDKTask());
111 |         res.status(201).json(wrapper.id);
112 |       } catch (error) {
113 |         logger.error('[CoreAgent] Error creating task:', error);
114 |         const errorMessage =
115 |           error instanceof Error
116 |             ? error.message
117 |             : 'Unknown error creating task';
118 |         res.status(500).send({ error: errorMessage });
119 |       }
120 |     });
121 | 
122 |     expressApp.get('/tasks/metadata', async (req, res) => {
123 |       // This endpoint is only meaningful if the task store is in-memory.
124 |       if (!(taskStoreForExecutor instanceof InMemoryTaskStore)) {
125 |         res.status(501).send({
126 |           error:
127 |             'Listing all task metadata is only supported when using InMemoryTaskStore.',
128 |         });
129 |       }
130 |       try {
131 |         const wrappers = agentExecutor.getAllTasks();
132 |         if (wrappers && wrappers.length > 0) {
133 |           const tasksMetadata = await Promise.all(
134 |             wrappers.map((wrapper) => wrapper.task.getMetadata()),
135 |           );
136 |           res.status(200).json(tasksMetadata);
137 |         } else {
138 |           res.status(204).send();
139 |         }
140 |       } catch (error) {
141 |         logger.error('[CoreAgent] Error getting all task metadata:', error);
142 |         const errorMessage =
143 |           error instanceof Error
144 |             ? error.message
145 |             : 'Unknown error getting task metadata';
146 |         res.status(500).send({ error: errorMessage });
147 |       }
148 |     });
149 | 
150 |     expressApp.get('/tasks/:taskId/metadata', async (req, res) => {
151 |       const taskId = req.params.taskId;
152 |       let wrapper = agentExecutor.getTask(taskId);
153 |       if (!wrapper) {
154 |         const sdkTask = await taskStoreForExecutor.load(taskId);
155 |         if (sdkTask) {
156 |           wrapper = await agentExecutor.reconstruct(sdkTask);
157 |         }
158 |       }
159 |       if (!wrapper) {
160 |         res.status(404).send({ error: 'Task not found' });
161 |         return;
162 |       }
163 |       res.json({ metadata: await wrapper.task.getMetadata() });
164 |     });
165 |     return expressApp;
166 |   } catch (error) {
167 |     logger.error('[CoreAgent] Error during startup:', error);
168 |     process.exit(1);
169 |   }
170 | }
171 | 
172 | export async function main() {
173 |   try {
174 |     const expressApp = await createApp();
175 |     const port = process.env['CODER_AGENT_PORT'] || 0;
176 | 
177 |     const server = expressApp.listen(port, () => {
178 |       const address = server.address();
179 |       let actualPort;
180 |       if (process.env['CODER_AGENT_PORT']) {
181 |         actualPort = process.env['CODER_AGENT_PORT'];
182 |       } else if (address && typeof address !== 'string') {
183 |         actualPort = address.port;
184 |       } else {
185 |         throw new Error('[Core Agent] Could not find port number.');
186 |       }
187 |       updateCoderAgentCardUrl(Number(actualPort));
188 |       logger.info(
189 |         `[CoreAgent] Agent Server started on http://localhost:${actualPort}`,
190 |       );
191 |       logger.info(
192 |         `[CoreAgent] Agent Card: http://localhost:${actualPort}/.well-known/agent-card.json`,
193 |       );
194 |       logger.info('[CoreAgent] Press Ctrl+C to stop the server');
195 |     });
196 |   } catch (error) {
197 |     logger.error('[CoreAgent] Error during startup:', error);
198 |     process.exit(1);
199 |   }
200 | }
```

src/http/endpoints.test.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import { describe, it, expect, beforeAll, afterAll, vi } from 'vitest';
8 | import request from 'supertest';
9 | import type express from 'express';
10 | import * as fs from 'node:fs';
11 | import * as path from 'node:path';
12 | import * as os from 'node:os';
13 | import type { Server } from 'node:http';
14 | import type { AddressInfo } from 'node:net';
15 | 
16 | import { createApp, updateCoderAgentCardUrl } from './app.js';
17 | import type { TaskMetadata } from '../types.js';
18 | import { createMockConfig } from '../utils/testing_utils.js';
19 | import type { Config } from '@google/gemini-cli-core';
20 | 
21 | // Mock the logger to avoid polluting test output
22 | // Comment out to help debug
23 | vi.mock('../utils/logger.js', () => ({
24 |   logger: { info: vi.fn(), warn: vi.fn(), error: vi.fn() },
25 | }));
26 | 
27 | // Mock Task.create to avoid its complex setup
28 | vi.mock('../agent/task.js', () => {
29 |   class MockTask {
30 |     id: string;
31 |     contextId: string;
32 |     taskState = 'submitted';
33 |     config = {
34 |       getContentGeneratorConfig: vi
35 |         .fn()
36 |         .mockReturnValue({ model: 'gemini-pro' }),
37 |     };
38 |     geminiClient = {
39 |       initialize: vi.fn().mockResolvedValue(undefined),
40 |     };
41 |     constructor(id: string, contextId: string) {
42 |       this.id = id;
43 |       this.contextId = contextId;
44 |     }
45 |     static create = vi
46 |       .fn()
47 |       .mockImplementation((id, contextId) =>
48 |         Promise.resolve(new MockTask(id, contextId)),
49 |       );
50 |     getMetadata = vi.fn().mockImplementation(async () => ({
51 |       id: this.id,
52 |       contextId: this.contextId,
53 |       taskState: this.taskState,
54 |       model: 'gemini-pro',
55 |       mcpServers: [],
56 |       availableTools: [],
57 |     }));
58 |   }
59 |   return { Task: MockTask };
60 | });
61 | 
62 | vi.mock('../config/config.js', async () => {
63 |   const actual = await vi.importActual('../config/config.js');
64 |   return {
65 |     ...actual,
66 |     loadConfig: vi
67 |       .fn()
68 |       .mockImplementation(async () => createMockConfig({}) as Config),
69 |   };
70 | });
71 | 
72 | describe('Agent Server Endpoints', () => {
73 |   let app: express.Express;
74 |   let server: Server;
75 |   let testWorkspace: string;
76 | 
77 |   const createTask = (contextId: string) =>
78 |     request(app)
79 |       .post('/tasks')
80 |       .send({
81 |         contextId,
82 |         agentSettings: {
83 |           kind: 'agent-settings',
84 |           workspacePath: testWorkspace,
85 |         },
86 |       })
87 |       .set('Content-Type', 'application/json');
88 | 
89 |   beforeAll(async () => {
90 |     // Create a unique temporary directory for the workspace to avoid conflicts
91 |     testWorkspace = fs.mkdtempSync(
92 |       path.join(os.tmpdir(), 'gemini-agent-test-'),
93 |     );
94 |     app = await createApp();
95 |     await new Promise<void>((resolve) => {
96 |       server = app.listen(0, () => {
97 |         const port = (server.address() as AddressInfo).port;
98 |         updateCoderAgentCardUrl(port);
99 |         resolve();
100 |       });
101 |     });
102 |   });
103 | 
104 |   afterAll(async () => {
105 |     if (server) {
106 |       await new Promise<void>((resolve, reject) => {
107 |         server.close((err) => {
108 |           if (err) return reject(err);
109 |           resolve();
110 |         });
111 |       });
112 |     }
113 | 
114 |     if (testWorkspace) {
115 |       try {
116 |         fs.rmSync(testWorkspace, { recursive: true, force: true });
117 |       } catch (e) {
118 |         console.warn(`Could not remove temp dir '${testWorkspace}':`, e);
119 |       }
120 |     }
121 |   });
122 | 
123 |   it('should create a new task via POST /tasks', async () => {
124 |     const response = await createTask('test-context');
125 |     expect(response.status).toBe(201);
126 |     expect(response.body).toBeTypeOf('string'); // Should return the task ID
127 |   }, 7000);
128 | 
129 |   it('should get metadata for a specific task via GET /tasks/:taskId/metadata', async () => {
130 |     const createResponse = await createTask('test-context-2');
131 |     const taskId = createResponse.body;
132 |     const response = await request(app).get(`/tasks/${taskId}/metadata`);
133 |     expect(response.status).toBe(200);
134 |     expect(response.body.metadata.id).toBe(taskId);
135 |   }, 6000);
136 | 
137 |   it('should get metadata for all tasks via GET /tasks/metadata', async () => {
138 |     const createResponse = await createTask('test-context-3');
139 |     const taskId = createResponse.body;
140 |     const response = await request(app).get('/tasks/metadata');
141 |     expect(response.status).toBe(200);
142 |     expect(Array.isArray(response.body)).toBe(true);
143 |     expect(response.body.length).toBeGreaterThan(0);
144 |     const taskMetadata = response.body.find(
145 |       (m: TaskMetadata) => m.id === taskId,
146 |     );
147 |     expect(taskMetadata).toBeDefined();
148 |   });
149 | 
150 |   it('should return 404 for a non-existent task', async () => {
151 |     const response = await request(app).get('/tasks/fake-task/metadata');
152 |     expect(response.status).toBe(404);
153 |   });
154 | 
155 |   it('should return agent metadata via GET /.well-known/agent-card.json', async () => {
156 |     const response = await request(app).get('/.well-known/agent-card.json');
157 |     const port = (server.address() as AddressInfo).port;
158 |     expect(response.status).toBe(200);
159 |     expect(response.body.name).toBe('Gemini SDLC Agent');
160 |     expect(response.body.url).toBe(`http://localhost:${port}/`);
161 |   });
162 | });
```

src/http/requestStorage.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type express from 'express';
8 | import { AsyncLocalStorage } from 'node:async_hooks';
9 | 
10 | export const requestStorage = new AsyncLocalStorage<{ req: express.Request }>();
```

src/http/server.ts
```
1 | #!/usr/bin/env node
2 | 
3 | /**
4 |  * @license
5 |  * Copyright 2025 Google LLC
6 |  * SPDX-License-Identifier: Apache-2.0
7 |  */
8 | 
9 | import * as url from 'node:url';
10 | import * as path from 'node:path';
11 | 
12 | import { logger } from '../utils/logger.js';
13 | import { main } from './app.js';
14 | 
15 | // Check if the module is the main script being run
16 | const isMainModule =
17 |   path.basename(process.argv[1]) ===
18 |   path.basename(url.fileURLToPath(import.meta.url));
19 | 
20 | if (
21 |   import.meta.url.startsWith('file:') &&
22 |   isMainModule &&
23 |   process.env['NODE_ENV'] !== 'test'
24 | ) {
25 |   process.on('uncaughtException', (error) => {
26 |     logger.error('Unhandled exception:', error);
27 |     process.exit(1);
28 |   });
29 | 
30 |   main().catch((error) => {
31 |     logger.error('[CoreAgent] Unhandled error in main:', error);
32 |     process.exit(1);
33 |   });
34 | }
```

src/config/config.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import * as fs from 'node:fs';
8 | import * as path from 'node:path';
9 | import { homedir } from 'node:os';
10 | import * as dotenv from 'dotenv';
11 | 
12 | import type { TelemetryTarget } from '@google/gemini-cli-core';
13 | import {
14 |   AuthType,
15 |   Config,
16 |   type ConfigParameters,
17 |   FileDiscoveryService,
18 |   ApprovalMode,
19 |   loadServerHierarchicalMemory,
20 |   GEMINI_CONFIG_DIR,
21 |   DEFAULT_GEMINI_EMBEDDING_MODEL,
22 |   DEFAULT_GEMINI_MODEL,
23 |   type GeminiCLIExtension,
24 | } from '@google/gemini-cli-core';
25 | 
26 | import { logger } from '../utils/logger.js';
27 | import type { Settings } from './settings.js';
28 | import { type AgentSettings, CoderAgentEvent } from '../types.js';
29 | 
30 | export async function loadConfig(
31 |   settings: Settings,
32 |   extensions: GeminiCLIExtension[],
33 |   taskId: string,
34 | ): Promise<Config> {
35 |   const mcpServers = mergeMcpServers(settings, extensions);
36 |   const workspaceDir = process.cwd();
37 |   const adcFilePath = process.env['GOOGLE_APPLICATION_CREDENTIALS'];
38 | 
39 |   const configParams: ConfigParameters = {
40 |     sessionId: taskId,
41 |     model: DEFAULT_GEMINI_MODEL,
42 |     embeddingModel: DEFAULT_GEMINI_EMBEDDING_MODEL,
43 |     sandbox: undefined, // Sandbox might not be relevant for a server-side agent
44 |     targetDir: workspaceDir, // Or a specific directory the agent operates on
45 |     debugMode: process.env['DEBUG'] === 'true' || false,
46 |     question: '', // Not used in server mode directly like CLI
47 |     fullContext: false, // Server might have different context needs
48 |     coreTools: settings.coreTools || undefined,
49 |     excludeTools: settings.excludeTools || undefined,
50 |     showMemoryUsage: settings.showMemoryUsage || false,
51 |     approvalMode:
52 |       process.env['GEMINI_YOLO_MODE'] === 'true'
53 |         ? ApprovalMode.YOLO
54 |         : ApprovalMode.DEFAULT,
55 |     mcpServers,
56 |     cwd: workspaceDir,
57 |     telemetry: {
58 |       enabled: settings.telemetry?.enabled,
59 |       target: settings.telemetry?.target as TelemetryTarget,
60 |       otlpEndpoint:
61 |         process.env['OTEL_EXPORTER_OTLP_ENDPOINT'] ??
62 |         settings.telemetry?.otlpEndpoint,
63 |       logPrompts: settings.telemetry?.logPrompts,
64 |     },
65 |     // Git-aware file filtering settings
66 |     fileFiltering: {
67 |       respectGitIgnore: settings.fileFiltering?.respectGitIgnore,
68 |       enableRecursiveFileSearch:
69 |         settings.fileFiltering?.enableRecursiveFileSearch,
70 |     },
71 |     ideMode: false,
72 |     folderTrust: settings.folderTrust === true,
73 |   };
74 | 
75 |   const fileService = new FileDiscoveryService(workspaceDir);
76 |   const extensionContextFilePaths = extensions.flatMap((e) => e.contextFiles);
77 |   const { memoryContent, fileCount } = await loadServerHierarchicalMemory(
78 |     workspaceDir,
79 |     [workspaceDir],
80 |     false,
81 |     fileService,
82 |     extensionContextFilePaths,
83 |     settings.folderTrust === true,
84 |   );
85 |   configParams.userMemory = memoryContent;
86 |   configParams.geminiMdFileCount = fileCount;
87 |   const config = new Config({
88 |     ...configParams,
89 |   });
90 |   // Needed to initialize ToolRegistry, and git checkpointing if enabled
91 |   await config.initialize();
92 | 
93 |   if (process.env['USE_CCPA']) {
94 |     logger.info('[Config] Using CCPA Auth:');
95 |     try {
96 |       if (adcFilePath) {
97 |         path.resolve(adcFilePath);
98 |       }
99 |     } catch (e) {
100 |       logger.error(
101 |         `[Config] USE_CCPA env var is true but unable to resolve GOOGLE_APPLICATION_CREDENTIALS file path ${adcFilePath}. Error ${e}`,
102 |       );
103 |     }
104 |     await config.refreshAuth(AuthType.LOGIN_WITH_GOOGLE);
105 |     logger.info(
106 |       `[Config] GOOGLE_CLOUD_PROJECT: ${process.env['GOOGLE_CLOUD_PROJECT']}`,
107 |     );
108 |   } else if (process.env['GEMINI_API_KEY']) {
109 |     logger.info('[Config] Using Gemini API Key');
110 |     await config.refreshAuth(AuthType.USE_GEMINI);
111 |   } else {
112 |     const errorMessage =
113 |       '[Config] Unable to set GeneratorConfig. Please provide a GEMINI_API_KEY or set USE_CCPA.';
114 |     logger.error(errorMessage);
115 |     throw new Error(errorMessage);
116 |   }
117 | 
118 |   return config;
119 | }
120 | 
121 | export function mergeMcpServers(
122 |   settings: Settings,
123 |   extensions: GeminiCLIExtension[],
124 | ) {
125 |   const mcpServers = { ...(settings.mcpServers || {}) };
126 |   for (const extension of extensions) {
127 |     Object.entries(extension.mcpServers || {}).forEach(([key, server]) => {
128 |       if (mcpServers[key]) {
129 |         console.warn(
130 |           `Skipping extension MCP config for server with key "${key}" as it already exists.`,
131 |         );
132 |         return;
133 |       }
134 |       mcpServers[key] = server;
135 |     });
136 |   }
137 |   return mcpServers;
138 | }
139 | 
140 | export function setTargetDir(agentSettings: AgentSettings | undefined): string {
141 |   const originalCWD = process.cwd();
142 |   const targetDir =
143 |     process.env['CODER_AGENT_WORKSPACE_PATH'] ??
144 |     (agentSettings?.kind === CoderAgentEvent.StateAgentSettingsEvent
145 |       ? agentSettings.workspacePath
146 |       : undefined);
147 | 
148 |   if (!targetDir) {
149 |     return originalCWD;
150 |   }
151 | 
152 |   logger.info(
153 |     `[CoderAgentExecutor] Overriding workspace path to: ${targetDir}`,
154 |   );
155 | 
156 |   try {
157 |     const resolvedPath = path.resolve(targetDir);
158 |     process.chdir(resolvedPath);
159 |     return resolvedPath;
160 |   } catch (e) {
161 |     logger.error(
162 |       `[CoderAgentExecutor] Error resolving workspace path: ${e}, returning original os.cwd()`,
163 |     );
164 |     return originalCWD;
165 |   }
166 | }
167 | 
168 | export function loadEnvironment(): void {
169 |   const envFilePath = findEnvFile(process.cwd());
170 |   if (envFilePath) {
171 |     dotenv.config({ path: envFilePath, override: true });
172 |   }
173 | }
174 | 
175 | function findEnvFile(startDir: string): string | null {
176 |   let currentDir = path.resolve(startDir);
177 |   while (true) {
178 |     // prefer gemini-specific .env under GEMINI_DIR
179 |     const geminiEnvPath = path.join(currentDir, GEMINI_CONFIG_DIR, '.env');
180 |     if (fs.existsSync(geminiEnvPath)) {
181 |       return geminiEnvPath;
182 |     }
183 |     const envPath = path.join(currentDir, '.env');
184 |     if (fs.existsSync(envPath)) {
185 |       return envPath;
186 |     }
187 |     const parentDir = path.dirname(currentDir);
188 |     if (parentDir === currentDir || !parentDir) {
189 |       // check .env under home as fallback, again preferring gemini-specific .env
190 |       const homeGeminiEnvPath = path.join(
191 |         process.cwd(),
192 |         GEMINI_CONFIG_DIR,
193 |         '.env',
194 |       );
195 |       if (fs.existsSync(homeGeminiEnvPath)) {
196 |         return homeGeminiEnvPath;
197 |       }
198 |       const homeEnvPath = path.join(homedir(), '.env');
199 |       if (fs.existsSync(homeEnvPath)) {
200 |         return homeEnvPath;
201 |       }
202 |       return null;
203 |     }
204 |     currentDir = parentDir;
205 |   }
206 | }
```

src/config/extension.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | // Copied exactly from packages/cli/src/config/extension.ts, last PR #1026
8 | 
9 | import type {
10 |   MCPServerConfig,
11 |   ExtensionInstallMetadata,
12 |   GeminiCLIExtension,
13 | } from '@google/gemini-cli-core';
14 | import * as fs from 'node:fs';
15 | import * as path from 'node:path';
16 | import * as os from 'node:os';
17 | import { logger } from '../utils/logger.js';
18 | 
19 | export const EXTENSIONS_DIRECTORY_NAME = path.join('.gemini', 'extensions');
20 | export const EXTENSIONS_CONFIG_FILENAME = 'gemini-extension.json';
21 | export const INSTALL_METADATA_FILENAME = '.gemini-extension-install.json';
22 | 
23 | /**
24 |  * Extension definition as written to disk in gemini-extension.json files.
25 |  * This should *not* be referenced outside of the logic for reading files.
26 |  * If information is required for manipulating extensions (load, unload, update)
27 |  * outside of the loading process that data needs to be stored on the
28 |  * GeminiCLIExtension class defined in Core.
29 |  */
30 | interface ExtensionConfig {
31 |   name: string;
32 |   version: string;
33 |   mcpServers?: Record<string, MCPServerConfig>;
34 |   contextFileName?: string | string[];
35 |   excludeTools?: string[];
36 | }
37 | 
38 | export function loadExtensions(workspaceDir: string): GeminiCLIExtension[] {
39 |   const allExtensions = [
40 |     ...loadExtensionsFromDir(workspaceDir),
41 |     ...loadExtensionsFromDir(os.homedir()),
42 |   ];
43 | 
44 |   const uniqueExtensions: GeminiCLIExtension[] = [];
45 |   const seenNames = new Set<string>();
46 |   for (const extension of allExtensions) {
47 |     if (!seenNames.has(extension.name)) {
48 |       logger.info(
49 |         `Loading extension: ${extension.name} (version: ${extension.version})`,
50 |       );
51 |       uniqueExtensions.push(extension);
52 |       seenNames.add(extension.name);
53 |     }
54 |   }
55 | 
56 |   return uniqueExtensions;
57 | }
58 | 
59 | function loadExtensionsFromDir(dir: string): GeminiCLIExtension[] {
60 |   const extensionsDir = path.join(dir, EXTENSIONS_DIRECTORY_NAME);
61 |   if (!fs.existsSync(extensionsDir)) {
62 |     return [];
63 |   }
64 | 
65 |   const extensions: GeminiCLIExtension[] = [];
66 |   for (const subdir of fs.readdirSync(extensionsDir)) {
67 |     const extensionDir = path.join(extensionsDir, subdir);
68 | 
69 |     const extension = loadExtension(extensionDir);
70 |     if (extension != null) {
71 |       extensions.push(extension);
72 |     }
73 |   }
74 |   return extensions;
75 | }
76 | 
77 | function loadExtension(extensionDir: string): GeminiCLIExtension | null {
78 |   if (!fs.statSync(extensionDir).isDirectory()) {
79 |     logger.error(
80 |       `Warning: unexpected file ${extensionDir} in extensions directory.`,
81 |     );
82 |     return null;
83 |   }
84 | 
85 |   const configFilePath = path.join(extensionDir, EXTENSIONS_CONFIG_FILENAME);
86 |   if (!fs.existsSync(configFilePath)) {
87 |     logger.error(
88 |       `Warning: extension directory ${extensionDir} does not contain a config file ${configFilePath}.`,
89 |     );
90 |     return null;
91 |   }
92 | 
93 |   try {
94 |     const configContent = fs.readFileSync(configFilePath, 'utf-8');
95 |     const config = JSON.parse(configContent) as ExtensionConfig;
96 |     if (!config.name || !config.version) {
97 |       logger.error(
98 |         `Invalid extension config in ${configFilePath}: missing name or version.`,
99 |       );
100 |       return null;
101 |     }
102 | 
103 |     const installMetadata = loadInstallMetadata(extensionDir);
104 | 
105 |     const contextFiles = getContextFileNames(config)
106 |       .map((contextFileName) => path.join(extensionDir, contextFileName))
107 |       .filter((contextFilePath) => fs.existsSync(contextFilePath));
108 | 
109 |     return {
110 |       name: config.name,
111 |       version: config.version,
112 |       path: extensionDir,
113 |       contextFiles,
114 |       installMetadata,
115 |       mcpServers: config.mcpServers,
116 |       excludeTools: config.excludeTools,
117 |       isActive: true, // Barring any other signals extensions should be considered Active.
118 |     } as GeminiCLIExtension;
119 |   } catch (e) {
120 |     logger.error(
121 |       `Warning: error parsing extension config in ${configFilePath}: ${e}`,
122 |     );
123 |     return null;
124 |   }
125 | }
126 | 
127 | function getContextFileNames(config: ExtensionConfig): string[] {
128 |   if (!config.contextFileName) {
129 |     return ['GEMINI.md'];
130 |   } else if (!Array.isArray(config.contextFileName)) {
131 |     return [config.contextFileName];
132 |   }
133 |   return config.contextFileName;
134 | }
135 | 
136 | export function loadInstallMetadata(
137 |   extensionDir: string,
138 | ): ExtensionInstallMetadata | undefined {
139 |   const metadataFilePath = path.join(extensionDir, INSTALL_METADATA_FILENAME);
140 |   try {
141 |     const configContent = fs.readFileSync(metadataFilePath, 'utf-8');
142 |     const metadata = JSON.parse(configContent) as ExtensionInstallMetadata;
143 |     return metadata;
144 |   } catch (e) {
145 |     logger.warn(
146 |       `Failed to load or parse extension install metadata at ${metadataFilePath}: ${e}`,
147 |     );
148 |     return undefined;
149 |   }
150 | }
```

src/config/settings.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import * as fs from 'node:fs';
8 | import * as path from 'node:path';
9 | import { homedir } from 'node:os';
10 | 
11 | import type { MCPServerConfig } from '@google/gemini-cli-core';
12 | import {
13 |   getErrorMessage,
14 |   type TelemetrySettings,
15 | } from '@google/gemini-cli-core';
16 | import stripJsonComments from 'strip-json-comments';
17 | 
18 | export const SETTINGS_DIRECTORY_NAME = '.gemini';
19 | export const USER_SETTINGS_DIR = path.join(homedir(), SETTINGS_DIRECTORY_NAME);
20 | export const USER_SETTINGS_PATH = path.join(USER_SETTINGS_DIR, 'settings.json');
21 | 
22 | // Reconcile with https://github.com/google-gemini/gemini-cli/blob/b09bc6656080d4d12e1d06734aae2ec33af5c1ed/packages/cli/src/config/settings.ts#L53
23 | export interface Settings {
24 |   mcpServers?: Record<string, MCPServerConfig>;
25 |   coreTools?: string[];
26 |   excludeTools?: string[];
27 |   telemetry?: TelemetrySettings;
28 |   showMemoryUsage?: boolean;
29 |   checkpointing?: CheckpointingSettings;
30 |   folderTrust?: boolean;
31 | 
32 |   // Git-aware file filtering settings
33 |   fileFiltering?: {
34 |     respectGitIgnore?: boolean;
35 |     enableRecursiveFileSearch?: boolean;
36 |   };
37 | }
38 | 
39 | export interface SettingsError {
40 |   message: string;
41 |   path: string;
42 | }
43 | 
44 | export interface CheckpointingSettings {
45 |   enabled?: boolean;
46 | }
47 | 
48 | /**
49 |  * Loads settings from user and workspace directories.
50 |  * Project settings override user settings.
51 |  *
52 |  * How is it different to gemini-cli/cli: Returns already merged settings rather
53 |  * than `LoadedSettings` (unnecessary since we are not modifying users
54 |  * settings.json).
55 |  */
56 | export function loadSettings(workspaceDir: string): Settings {
57 |   let userSettings: Settings = {};
58 |   let workspaceSettings: Settings = {};
59 |   const settingsErrors: SettingsError[] = [];
60 | 
61 |   // Load user settings
62 |   try {
63 |     if (fs.existsSync(USER_SETTINGS_PATH)) {
64 |       const userContent = fs.readFileSync(USER_SETTINGS_PATH, 'utf-8');
65 |       const parsedUserSettings = JSON.parse(
66 |         stripJsonComments(userContent),
67 |       ) as Settings;
68 |       userSettings = resolveEnvVarsInObject(parsedUserSettings);
69 |     }
70 |   } catch (error: unknown) {
71 |     settingsErrors.push({
72 |       message: getErrorMessage(error),
73 |       path: USER_SETTINGS_PATH,
74 |     });
75 |   }
76 | 
77 |   const workspaceSettingsPath = path.join(
78 |     workspaceDir,
79 |     SETTINGS_DIRECTORY_NAME,
80 |     'settings.json',
81 |   );
82 | 
83 |   // Load workspace settings
84 |   try {
85 |     if (fs.existsSync(workspaceSettingsPath)) {
86 |       const projectContent = fs.readFileSync(workspaceSettingsPath, 'utf-8');
87 |       const parsedWorkspaceSettings = JSON.parse(
88 |         stripJsonComments(projectContent),
89 |       ) as Settings;
90 |       workspaceSettings = resolveEnvVarsInObject(parsedWorkspaceSettings);
91 |     }
92 |   } catch (error: unknown) {
93 |     settingsErrors.push({
94 |       message: getErrorMessage(error),
95 |       path: workspaceSettingsPath,
96 |     });
97 |   }
98 | 
99 |   if (settingsErrors.length > 0) {
100 |     console.error('Errors loading settings:');
101 |     for (const error of settingsErrors) {
102 |       console.error(`  Path: ${error.path}`);
103 |       console.error(`  Message: ${error.message}`);
104 |     }
105 |   }
106 | 
107 |   // If there are overlapping keys, the values of workspaceSettings will
108 |   // override values from userSettings
109 |   return {
110 |     ...userSettings,
111 |     ...workspaceSettings,
112 |   };
113 | }
114 | 
115 | function resolveEnvVarsInString(value: string): string {
116 |   const envVarRegex = /\$(?:(\w+)|{([^}]+)})/g; // Find $VAR_NAME or ${VAR_NAME}
117 |   return value.replace(envVarRegex, (match, varName1, varName2) => {
118 |     const varName = varName1 || varName2;
119 |     if (process && process.env && typeof process.env[varName] === 'string') {
120 |       return process.env[varName]!;
121 |     }
122 |     return match;
123 |   });
124 | }
125 | 
126 | function resolveEnvVarsInObject<T>(obj: T): T {
127 |   if (
128 |     obj === null ||
129 |     obj === undefined ||
130 |     typeof obj === 'boolean' ||
131 |     typeof obj === 'number'
132 |   ) {
133 |     return obj;
134 |   }
135 | 
136 |   if (typeof obj === 'string') {
137 |     return resolveEnvVarsInString(obj) as unknown as T;
138 |   }
139 | 
140 |   if (Array.isArray(obj)) {
141 |     return obj.map((item) => resolveEnvVarsInObject(item)) as unknown as T;
142 |   }
143 | 
144 |   if (typeof obj === 'object') {
145 |     const newObj = { ...obj } as T;
146 |     for (const key in newObj) {
147 |       if (Object.prototype.hasOwnProperty.call(newObj, key)) {
148 |         newObj[key] = resolveEnvVarsInObject(newObj[key]);
149 |       }
150 |     }
151 |     return newObj;
152 |   }
153 | 
154 |   return obj;
155 | }
```

src/utils/executor_utils.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type { Message } from '@a2a-js/sdk';
8 | import type { ExecutionEventBus } from '@a2a-js/sdk/server';
9 | import { v4 as uuidv4 } from 'uuid';
10 | 
11 | import { CoderAgentEvent } from '../types.js';
12 | import type { StateChange } from '../types.js';
13 | 
14 | export async function pushTaskStateFailed(
15 |   error: unknown,
16 |   eventBus: ExecutionEventBus,
17 |   taskId: string,
18 |   contextId: string,
19 | ) {
20 |   const errorMessage =
21 |     error instanceof Error ? error.message : 'Agent execution error';
22 |   const stateChange: StateChange = {
23 |     kind: CoderAgentEvent.StateChangeEvent,
24 |   };
25 |   eventBus.publish({
26 |     kind: 'status-update',
27 |     taskId,
28 |     contextId,
29 |     status: {
30 |       state: 'failed',
31 |       message: {
32 |         kind: 'message',
33 |         role: 'agent',
34 |         parts: [
35 |           {
36 |             kind: 'text',
37 |             text: errorMessage,
38 |           },
39 |         ],
40 |         messageId: uuidv4(),
41 |         taskId,
42 |         contextId,
43 |       } as Message,
44 |     },
45 |     final: true,
46 |     metadata: {
47 |       coderAgent: stateChange,
48 |       model: 'unknown',
49 |       error: errorMessage,
50 |     },
51 |   });
52 | }
```

src/utils/logger.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import winston from 'winston';
8 | 
9 | const logger = winston.createLogger({
10 |   level: 'info',
11 |   format: winston.format.combine(
12 |     // First, add a timestamp to the log info object
13 |     winston.format.timestamp({
14 |       format: 'YYYY-MM-DD HH:mm:ss.SSS A', // Custom timestamp format
15 |     }),
16 |     // Here we define the custom output format
17 |     winston.format.printf((info) => {
18 |       const { level, timestamp, message, ...rest } = info;
19 |       return (
20 |         `[${level.toUpperCase()}] ${timestamp} -- ${message}` +
21 |         `${Object.keys(rest).length > 0 ? `\n${JSON.stringify(rest, null, 2)}` : ''}`
22 |       ); // Only print ...rest if present
23 |     }),
24 |   ),
25 |   transports: [new winston.transports.Console()],
26 | });
27 | 
28 | export { logger };
```

src/utils/testing_utils.ts
```
1 | /**
2 |  * @license
3 |  * Copyright 2025 Google LLC
4 |  * SPDX-License-Identifier: Apache-2.0
5 |  */
6 | 
7 | import type {
8 |   Task as SDKTask,
9 |   TaskStatusUpdateEvent,
10 |   SendStreamingMessageSuccessResponse,
11 | } from '@a2a-js/sdk';
12 | import {
13 |   ApprovalMode,
14 |   DEFAULT_TRUNCATE_TOOL_OUTPUT_LINES,
15 |   DEFAULT_TRUNCATE_TOOL_OUTPUT_THRESHOLD,
16 |   GeminiClient,
17 | } from '@google/gemini-cli-core';
18 | import type { Config, Storage } from '@google/gemini-cli-core';
19 | import { expect, vi } from 'vitest';
20 | 
21 | export function createMockConfig(
22 |   overrides: Partial<Config> = {},
23 | ): Partial<Config> {
24 |   const mockConfig = {
25 |     getToolRegistry: vi.fn().mockReturnValue({
26 |       getTool: vi.fn(),
27 |       getAllToolNames: vi.fn().mockReturnValue([]),
28 |     }),
29 |     getApprovalMode: vi.fn().mockReturnValue(ApprovalMode.DEFAULT),
30 |     getIdeMode: vi.fn().mockReturnValue(false),
31 |     getAllowedTools: vi.fn().mockReturnValue([]),
32 |     getWorkspaceContext: vi.fn().mockReturnValue({
33 |       isPathWithinWorkspace: () => true,
34 |     }),
35 |     getTargetDir: () => '/test',
36 |     storage: {
37 |       getProjectTempDir: () => '/tmp',
38 |     } as Storage,
39 |     getTruncateToolOutputThreshold: () =>
40 |       DEFAULT_TRUNCATE_TOOL_OUTPUT_THRESHOLD,
41 |     getTruncateToolOutputLines: () => DEFAULT_TRUNCATE_TOOL_OUTPUT_LINES,
42 |     getDebugMode: vi.fn().mockReturnValue(false),
43 |     getContentGeneratorConfig: vi.fn().mockReturnValue({ model: 'gemini-pro' }),
44 |     getModel: vi.fn().mockReturnValue('gemini-pro'),
45 |     getUsageStatisticsEnabled: vi.fn().mockReturnValue(false),
46 |     setFallbackModelHandler: vi.fn(),
47 |     initialize: vi.fn().mockResolvedValue(undefined),
48 |     getProxy: vi.fn().mockReturnValue(undefined),
49 |     getHistory: vi.fn().mockReturnValue([]),
50 |     getEmbeddingModel: vi.fn().mockReturnValue('text-embedding-004'),
51 |     getSessionId: vi.fn().mockReturnValue('test-session-id'),
52 |     getUserTier: vi.fn(),
53 |     ...overrides,
54 |   } as unknown as Config;
55 | 
56 |   mockConfig.getGeminiClient = vi
57 |     .fn()
58 |     .mockReturnValue(new GeminiClient(mockConfig));
59 |   return mockConfig;
60 | }
61 | 
62 | export function createStreamMessageRequest(
63 |   text: string,
64 |   messageId: string,
65 |   taskId?: string,
66 | ) {
67 |   const request: {
68 |     jsonrpc: string;
69 |     id: string;
70 |     method: string;
71 |     params: {
72 |       message: {
73 |         kind: string;
74 |         role: string;
75 |         parts: [{ kind: string; text: string }];
76 |         messageId: string;
77 |       };
78 |       metadata: {
79 |         coderAgent: {
80 |           kind: string;
81 |           workspacePath: string;
82 |         };
83 |       };
84 |       taskId?: string;
85 |     };
86 |   } = {
87 |     jsonrpc: '2.0',
88 |     id: '1',
89 |     method: 'message/stream',
90 |     params: {
91 |       message: {
92 |         kind: 'message',
93 |         role: 'user',
94 |         parts: [{ kind: 'text', text }],
95 |         messageId,
96 |       },
97 |       metadata: {
98 |         coderAgent: {
99 |           kind: 'agent-settings',
100 |           workspacePath: '/tmp',
101 |         },
102 |       },
103 |     },
104 |   };
105 | 
106 |   if (taskId) {
107 |     request.params.taskId = taskId;
108 |   }
109 | 
110 |   return request;
111 | }
112 | 
113 | export function assertUniqueFinalEventIsLast(
114 |   events: SendStreamingMessageSuccessResponse[],
115 | ) {
116 |   // Final event is input-required & final
117 |   const finalEvent = events[events.length - 1].result as TaskStatusUpdateEvent;
118 |   expect(finalEvent.metadata?.['coderAgent']).toMatchObject({
119 |     kind: 'state-change',
120 |   });
121 |   expect(finalEvent.status?.state).toBe('input-required');
122 |   expect(finalEvent.final).toBe(true);
123 | 
124 |   // There is only one event with final and its the last
125 |   expect(
126 |     events.filter((e) => (e.result as TaskStatusUpdateEvent).final).length,
127 |   ).toBe(1);
128 |   expect(
129 |     events.findIndex((e) => (e.result as TaskStatusUpdateEvent).final),
130 |   ).toBe(events.length - 1);
131 | }
132 | 
133 | export function assertTaskCreationAndWorkingStatus(
134 |   events: SendStreamingMessageSuccessResponse[],
135 | ) {
136 |   // Initial task creation event
137 |   const taskEvent = events[0].result as SDKTask;
138 |   expect(taskEvent.kind).toBe('task');
139 |   expect(taskEvent.status.state).toBe('submitted');
140 | 
141 |   // Status update: working
142 |   const workingEvent = events[1].result as TaskStatusUpdateEvent;
143 |   expect(workingEvent.kind).toBe('status-update');
144 |   expect(workingEvent.status.state).toBe('working');
145 | }
```
