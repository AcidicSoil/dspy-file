# DSPy Repo Specialist

## Overview

Analyzes any software repository and produces a structured technical brief. Uses DSPy programs with retrieval, verification, and evaluation. Runs from a CLI or an HTTP service.

## Goals

* Fast, repeatable repository understanding.
* Deterministic structure and stable ordering.
* Low-variance outputs with field-level validation.
* Track quality, latency, and cost per run.

## Non-Goals

* Full static analysis or compilation.
* Internet crawling beyond the supplied repo.
* Vendor lock to a single model backend.

## Core Capabilities

* Ingest a repo at a specific commit.
* Select target files by strategy.
* Build compact context windows.
* Run teleprompted DSPy modules for analysis.
* Verify and repair field outputs.
* Render a human brief and a machine JSON.
* Log metrics and artifacts for evaluation.
* Cache intermediates by repo and commit.
* Serve via CLI and HTTP.

## Architecture

1. **Repo ingestion**
   Clone with auth. Collect file tree, README, and package metadata. Enforce size caps and ordering.

2. **Target selection**
   Strategies: ByGlob, ByRecentGitChanges, ByHeuristic, ExplicitList. Resolve to an ordered path list. Log final targets.

3. **Retrieval and context**
   Parse, chunk, filter by suffix, rank. Build top-K snippets per task within token limits. Deduplicate by content hash.

4. **DSPy program orchestration**
   Modules: AnalyzeRepository, AnalyzeCodeStructure, GenerateUsageExamples. Optional LM routing by field type and difficulty.

5. **Verifier and repair**
   Validate schema, types, URLs, and non-empty lists. Selectively regenerate failed fields only.

6. **Rendering**
   Produce Markdown for humans and JSON for systems. Keep section order deterministic.

7. **Evaluation and tracking**
   Per-field metrics, latency, and token accounting. Store runs and artifacts for comparison.

8. **Caching and cost control**
   Read-through cache keyed by repo and commit. TTL and eviction policy. Budget caps per phase.

9. **Serving and ops**
   CLI for local runs. HTTP endpoint for automation. Observability, rate limits, and clear errors.

10. **Security**
    Least-privilege tokens. Secrets isolation. Bounded I/O. Safe logging with redaction.

## Data Flow

Input repo → Ingest → Select targets → Retrieve snippets → DSPy modules → Verifier → Render → Metrics + Cache → Outputs.

## Inputs

* Repository URL or local path.
* Commit or branch.
* Selection strategy with args.
* Auth token for the host.

## Outputs

* Markdown technical brief.
* JSON payload with validated fields.
* Run record with metrics and artifacts.

## Configuration

* Repository source and auth.
* Strategy and arguments.
* Model routing policy and budgets.
* Cache location and TTL.
* Evaluation thresholds.
* Service host and rate limits.

## Performance Levers

* Reduce selected files and chunk size.
* Tighten max tokens per module.
* Enable cache on stable commits.
* Route simple fields to cheaper models.
* Batch repos when feasible.

## Quality Controls

* Deterministic sorting and seeds.
* Field validators with targeted retries.
* Golden sets for regression checks.
* Run-over-run drift monitoring.

## Extensibility Points

* New selection strategies.
* Custom chunkers and rankers.
* Additional DSPy modules per domain.
* Field-specific validators.
* Alternate renderers and exporters.

## Operations

* Health checks and readiness probes.
* Structured logs with correlation IDs.
* Rate limiting per caller.
* Usage dashboards for latency and cost.

## Risks and Mitigations

* **Large repos**: enforce caps and sampling.
* **Noisy outputs**: verification and selective repair.
* **Token blowups**: strict budgets and caching.
* **Auth failures**: clear errors and fallback to local path.

## Roadmap

* Embedding-based rerank optional add-on.
* Multi-repo synthesis for mono-repos.
* Active learning from accepted runs.
* Pluggable domain taxonomies.

## Acceptance Criteria

* Deterministic outputs for the same commit and config.
* All required fields present and validated.
* Logged metrics for every run.
* Cache hits on repeat runs of the same commit.
* Clean failure modes with actionable messages.

## Mind Map

[Architecture mind map (PNG)](sandbox:/mnt/data/dspy_arch_mindmap.png)

## License

Choose a permissive license suitable for internal and partner use.

## Contributing

Open an issue for proposed changes. Keep additions modular and behind a flag. Include evaluation notes and impact on latency and cost.
