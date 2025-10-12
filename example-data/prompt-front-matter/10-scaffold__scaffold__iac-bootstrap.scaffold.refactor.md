# IaC Bootstrap

## Metadata

- **Identifier**: iac-bootstrap
- **Categories**: 
  - IaC
  - CI/CD
  - Cloud Automation
- **Lifecycle Stage**: bootstrap
- **Dependencies**: none
- **Provided Artifacts**: 
  - stack diagram
  - file list
  - CI snippets
- **Summary**: Do create minimal Infrastructure-as-Code for chosen platform plus CI hooks to achieve rapid deployment readiness.

## Inputs

- Platform: aws | gcp | azure | fly | render
- IaC Tool: Terraform | Pulumi
- Environment Stages: preview, staging, prod
- Output Format: stack diagram, file list, CI snippets

## Canonical taxonomy (exact strings)

- IaC
- CI/CD
- Cloud Automation

### Stage hints (for inference)

- bootstrap → early setup/init phase
- create → initial configuration
- define → structural setup
- add → extend with hooks and policies

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
- No alteration of the original body text.

## Validation

- Identifier matches a normalized id pattern (kebab-case, lowercase).
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Identifier: iac-bootstrap  
- Categories: IaC, CI/CD, Cloud Automation  
- Lifecycle Stage: bootstrap  
- Dependencies: none  
- Artifacts: stack diagram, file list, CI snippets  
- Summary: Do create minimal Infrastructure-as-Code for chosen platform plus CI hooks to achieve rapid deployment readiness.

---

# IaC Bootstrap

Trigger: /iac-bootstrap <aws|gcp|azure|fly|render>

Purpose: Create minimal Infrastructure-as-Code for the chosen platform plus CI hooks.

**Steps:**

1. Select tool (Terraform, Pulumi). Initialize backend and state.
2. Define stacks for `preview`, `staging`, `prod`. Add outputs (URLs, connection strings).
3. Add CI jobs: plan on PR, apply on main with manual approval.
4. Document rollback and drift detection.

**Output format:** stack diagram, file list, CI snippets.

**Examples:** `/iac-bootstrap aws`.

**Notes:** Prefer least privilege IAM and remote state with locking.
