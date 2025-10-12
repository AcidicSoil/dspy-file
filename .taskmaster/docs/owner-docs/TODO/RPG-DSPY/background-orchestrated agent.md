
[QA-Ready]
Create a technical design doc that specifies a background-orchestrated agent using DSPy for control and an RPG for planning.

Requirements:

1) Inputs: {repo_context}, {code_host_api}, {issue_tracker}, {embeddings_store}.
2) RPG Model: define node/edge types, status, priority, owner, evidence links; CRUD & versioning; example graph for {sample_repo}.
3) DSPy Programs: list signatures for planner, retriever, tool-caller, summarizer; include optimization/evaluation strategy; caching and failure-recovery policy.
4) Execution Flow: event triggers → plan update → program compile/run → artifact write-back → telemetry.
5) Observability: traces, metrics, cost; minimal dashboard spec.
6) Interfaces: CLI commands, REST endpoints, webhooks; auth model.
7) Test Plan: unit tests for RPG ops; golden tasks for DSPy programs; E2E scenario; load test; rollback plan.
8) Acceptance Criteria: {acceptance_criteria} (e.g., ≥{x}% plan correctness on {n} tasks; P50 latency ≤{y} min; reproducible traces).
9) Out-of-Scope: {non_goals}.
Deliverables: diagram(s), JSON schema, example configs, sample prompts, seed datasets. Limit to 4–6 pages.
