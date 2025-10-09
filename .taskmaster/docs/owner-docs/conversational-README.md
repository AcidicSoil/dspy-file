# Conversational DSPy Agent

A modular DSPy agent that adapts its dialogue path and capabilities to a user’s evolving goal.

## Objectives

* Infer intent each turn and route to the right submodule with justification.
* Maintain short- and long-term memory to personalize responses and persist decisions.
* Support dynamic tool use based on user requests and inferred needs.

## Architecture Overview

**Components**

* Intent Classification
* State Summarization
* Router Policy
* Tool Selection
* Answer Generation
* Safety and Guardrails
* Memory Store: short-term and long-term
* Tool Adapters
* Retrieval Layer over `{knowledge_base}`
* Model Provider over `{models}`
* I/O: CLI and minimal web endpoint

**Data Flow**

1. Ingest user turn and `{context}`.
2. Update short-term state. Read long-term memory when needed.
3. Classify intent. Summarize state.
4. Score candidate paths. Pick a route. Resolve ties and fallbacks.
5. Select tools from `{tools}` if required. Execute with schemas.
6. Generate answer with rationale. Optionally stream.
7. Write back memories and decisions.

**Control Flow**

* Turn loop with deterministic checkpoints: classify → summarize → route → act → answer → persist.
* All state passed via context objects. No globals.

## DSPy Signatures and Modules

Define typed Signatures and Modules for:

* **Intent Classification**: map turn + context to intent label and confidence.
* **State Summarization**: compress dialogue and decisions into a bounded summary.
* **Tool Selection**: propose tools, arguments, and preconditions.
* **Answer Generation**: produce final reply and justification.
* **Safety and Guardrails**: refusal, redaction, and policy notes.

## Router Policy

* Score candidates: {QA, task, summarization, coding help, clarify}.
* Features: intent confidence, recency, tool readiness, safety risk, cost.
* Tie-break rules: prefer safer, cheaper, faster in that order.
* Fallbacks: clarify question, safe summarization, minimal answer without tools.

## Memory Model

* **Short-term**: turn buffer and rolling summary.
* **Long-term**: profile, preferences, tool outcomes, decisions.
* Read and write via explicit interfaces. Include TTL and size caps.

## Tools

* Register at startup from `{tools}` with JSON schemas.
* Selection requires precheck, dry run spec, and error handling policy.
* At least three tools exercised in examples and tests.

## Inputs

* `{context}`: domain description and known user personas.
* `{tools}`: callable tools with schemas.
* `{knowledge_base}`: retrieval source or stub.
* `{models}`: LM endpoints and settings.

## Constraints

* Pure Python. Typed. Small functions. Clear interfaces.
* No global state. Use context objects for all data.
* Streaming optional behind a flag.

## Deliverables

1. Architecture overview for components, data flow, and control flow.
2. DSPy Signatures and Modules for core tasks above.
3. Router policy with scoring, ties, and fallbacks.
4. Working code with CLI and minimal web endpoint. Config-driven model selection.
5. Example conversations with branching paths and corrections.
6. Tests and an evaluation harness with acceptance criteria.

## Configuration

* Single config file for `{models}`, `{tools}`, `{knowledge_base}`, routing thresholds, memory caps, and streaming.
* Environment variables for secrets only.

## CLI

* Flags for model, streaming, memory store path, tool whitelist, and logging level.
* Reads `{context}` and tool registry at start.

## Web Endpoint

* Minimal HTTP interface for a single session and a multi-turn session.
* Request schema includes user turn, session id, and optional tool hints.

## Evaluation

**Unit Tests**

* Routing: correct module selection on varied intents and confidences.
* Memory: survives across turns and sessions with TTL rules.
* Tool I/O: schema validation, retries, and error paths.

**Golden Conversations**

* 10+ scripted dialogues with branching and corrections.
* Track task success and safety events.
* Target success rate: ≥ `{target_success_rate}%`.

**Metrics**

* Route accuracy
* Tool success rate
* Turn latency
* Token cost
* Safety refusals and overrides

## Acceptance Criteria

* Correct path switches on mid-conversation goal changes.
* Memory survives across turns and sessions.
* At least 3 tools can be selected and used correctly.
* Passes unit tests for routing, memory, and tool I/O.
* 10+ golden conversations achieve ≥ `{target_success_rate}%` task success.

## Project Layout

* `agent/` core modules
* `tools/` adapters and schemas
* `memory/` stores and policies
* `routing/` policy and features
* `eval/` tests, golden sets, and harness
* `cli/` entry points
* `web/` minimal endpoint
* `config/` defaults and examples
* `docs/` examples and diagrams

## Security and Safety

* Guardrails in front of tool execution and final answer.
* Redaction and refusal rules applied before output.
* Least-privilege tool configs and audit logs.

## Roadmap

* Add multi-agent handoff.
* Add per-persona router variants.
* Add active learning from evaluation traces.

## License

Choose and add a license file.
