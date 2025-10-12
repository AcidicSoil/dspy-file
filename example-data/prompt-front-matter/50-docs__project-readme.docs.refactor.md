# Codex Prompts — Vibe Coding Additions

Task: Given $1, produce a structured **metadata block** and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then $1.

## Inputs

- Source file path: `C:\Users\user\projects\prompts\temp-prompts\50-docs\project-readme.docs.md`
- Maximum placeholders allowed: 7
- Input parameters block:
  - Identifier: codex-prompts-vibe-coding
  - Categories: Planning & Scope, App Scaffold & Contracts, Data & Auth, Frontend UX, Quality Gates & Tests, CI/CD & Env, Release & Ops, Post-release Hardening, Model Tactics
  - Lifecycle stage: P0–P9 (phased development lifecycle)
  - Dependencies:
    - `npm install`
    - `validate:metadata` before `build:catalog`
    - Task completion via `advance_state` or CLI commands
    - Prior prompts in sequence (e.g., `/planning-process` → `/scope-control`)
  - Provided artifacts:
    - `catalog.json`
    - `.mcp/state.json`
    - Ready task list
    - Dependency graph (DOT/JSON)
    - PR descriptions, commit messages, test scripts
  - Summary: "Do staged planning and execution to achieve a consistent, auditable, and automated software development lifecycle."

## Canonical taxonomy (exact strings)

- Planning & Scope  
- App Scaffold & Contracts  
- Data & Auth  
- Frontend UX  
- Quality Gates & Tests  
- CI/CD & Env  
- Release & Ops  
- Post-release Hardening  
- Model Tactics  

### Stage hints (for inference)

- P0: Preflight Docs → requires DocFetchReport to be "OK"  
- P1: Plan & Scope → passes Scope Gate  
- P2: App Scaffold & Contracts → clear Test Gate lite  
- P3: Data & Auth → migrations must dry-run cleanly  
- P4: Frontend UX → queue accessibility checks  
- P5: Quality Gates & Tests → meet the Test Gate  
- P6: CI/CD & Env → satisfy the Review Gate  
- P7: Release & Ops → clear the Release Gate  
- P8: Post-release Hardening → resolve Sev-1 issues  
- P9: Model Tactics → document uplift before switching defaults  

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.  

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs $5.  
   * Validate, sort deterministically, and de-dupe (≤3).  

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via $6.  
   * Omit if uncertain.

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts are concise and relevant (≤3).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

```yaml
---
identifier: codex-prompts-vibe-coding
categories:
  - Planning & Scope
  - App Scaffold & Contracts
  - Data & Auth
  - Frontend UX
  - Quality Gates & Tests
  - CI/CD & Env
  - Release & Ops
  - Post-release Hardening
  - Model Tactics
lifecycle_stage: P0-P9 (phased development lifecycle)
dependencies:
  - npm install
  - validate:metadata before build:catalog
  - prior prompts in sequence (e.g., planning → scope)
provided_artifacts:
  - catalog.json
  - .mcp/state.json
  - ready task list
  - dependency graph (DOT/JSON)
summary: "Do staged planning and execution to achieve a consistent, auditable, and automated software development lifecycle."
---
```
