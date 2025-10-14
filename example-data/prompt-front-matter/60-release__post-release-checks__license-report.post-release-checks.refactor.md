# Post-Release License Check

## Metadata

- **identifier**: summarize-third-party-licenses  
- **categories**: 
  - license-analysis  
  - risk-assessment  
  - output-formatting  
- **lifecycle_stage**: post-release  
- **dependencies**: 
  - license-checker  
  - package-json  
- **provided_artifacts**: 
  - license-inventory  
  - risk-flag-summary  
- **summary**: Summarize third-party licenses and risk flags to achieve clear visibility into legal exposure and mitigation paths.

## Inputs

- CLI tool: `npx --yes license-checker`
- Target file: `package.json`

## Canonical taxonomy (exact strings)

- license-analysis
- risk-assessment
- output-formatting
- compliance-reporting
- dependency-scanning
- security-auditing
- post-release-checks

### Stage hints (for inference)

- pre-release → early development, dependency setup  
- post-release → validation, legal review, risk mitigation  
- production → ongoing monitoring  

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
- Provided artifacts, if present, are short and relevant (≤3).  
- Summary ≤120 chars; punctuation coherent.  
- Body text $1 is not altered.

## Output format examples

- identifier: analyze-deps  
- categories: dependency-scanning, risk-assessment  
- lifecycle_stage: pre-release  
- dependencies: npm-check-updates, package-json  
- provided_artifacts: dependency-graph, vulnerability-list  
- summary: Analyze dependencies to achieve visibility into outdated and vulnerable packages.

- identifier: generate-compliance-report  
- categories: compliance-reporting, legal-review  
- lifecycle_stage: post-release  
- dependencies: policy-docs, audit-log  
- provided_artifacts: report-summary, flag-table  
- summary: Generate a compliance report to ensure adherence to organizational licensing policies.
