# Env Setup

Task: Given the following content, produce a structured metadata block and then emit the original body unchanged. The metadata must expose identifiers, categories, optional lifecycle/stage, optional dependencies, optional provided artifacts, and a concise summary. Output = metadata, blank line, then the original text.

## Inputs
- Source file path: C:\Users\user\projects\prompts\temp-prompts\10-scaffold\ci-setup\env-setup.ci-setup.md
- Raw content: # Env Setup\n\nTrigger: /env-setup\n\nPurpose: Create .env.example, runtime schema validation, and per-env overrides.\n\n**Steps:**\n1. Scan repo for `process.env` usage and collected keys.\n2. Emit `.env.example` with comments and safe defaults.\n3. Add runtime validation via `zod` or `envsafe` in `packages/config`.\n4. Document `development`, `staging`, `production` precedence and loading order.\n\n**Output format:** `.env.example` content block and `config/env.ts` snippet.\n\n**Examples:** `/env-setup`.\n\n**Notes:** Do not include real credentials. Enforce `STRICT_ENV=true` in CI.

## Canonical taxonomy (exact strings)
- environment
- configuration
- infrastructure

### Stage hints (for inference)
- setup → init
- configure → config
- validate → validate

## Algorithm
1. Extract signals from the content  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via stage hints.  
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
- Emit exactly one document: metadata, a single blank line, then the original body.
- Limit distinct placeholders to ≤ 7.

## Validation
- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text is not altered.

## Output format examples
- Identifier: env-setup  
- Categories: ["environment", "configuration", "infrastructure"]  
- Stage: init  
- Dependencies: []  
- Artifacts: [".env.example content block", "config/env.ts snippet"]  
- Summary: "Do setup environment to achieve secure configuration with schema validation."
