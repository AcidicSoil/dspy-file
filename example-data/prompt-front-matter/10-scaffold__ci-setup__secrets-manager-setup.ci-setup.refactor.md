# Secrets Manager Setup

## Inputs
- Trigger: `/secrets-manager-setup <provider>`
- Purpose: Provision a secrets store and map application variables to it.

## Canonical taxonomy (exact strings)
provision, configuration, security

### Stage hints (for inference)
setup → configuration  
configuration → setup  
security → audit  

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
- Artifacts, if present, are short (≤3) and relevant.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples
- identifier: secrets-manager-setup  
- categories: [provision, configuration]  
- stage: setup  
- dependencies: []  
- provided_artifacts: ["mapping table (ENV_VAR → provider path)", "bootstrap steps"]  
- summary: "Provision a secrets store and map environment variables to achieve secure access."

# Secrets Manager Setup

Trigger: /secrets-manager-setup <provider>

Purpose: Provision a secrets store and map application variables to it.

**Steps:**

1. Choose provider: 1Password, Doppler, AWS Secrets Manager, GCP Secret Manager, Vault.
2. Define secret names and scopes. Generate read paths for web and api.
3. Add dev bootstrap instructions and CI access policy docs.

**Output format:** mapping table `ENV_VAR → provider path` and bootstrap steps.

**Examples:** `/secrets-manager-setup doppler`.

**Notes:** Never echo secret values. Include rotation policy.
