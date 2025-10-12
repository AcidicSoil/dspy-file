# API Docs Local

## Metadata

- **identifier**: api-docs-local
- **categories**: [documentation, retrieval, storage]
- **lifecycle_stage**: configuration
- **dependencies**: []
- **provided_artifacts**: ["docs/apis/ directory", "DOCS.md index file"]
- **summary**: Do fetch API docs and store locally to achieve offline, deterministic reference.

## Inputs

- URLs or package names to retrieve documentation from.

## Canonical taxonomy (exact strings)

- documentation
- retrieval
- storage
- configuration
- generation
- deployment
- validation

### Stage hints (for inference)

- configuration → setup of environment or initial state
- retrieval → fetching data from external sources
- storage → saving content locally
- deployment → making system available to users

## Algorithm

1. Extract signals from $1  
   *Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.*

2. Determine the primary identifier  
   *Prefer explicit input; otherwise infer from main action + object.*  
   *Normalize (lowercase, kebab-case, length-capped, starts with a letter).*  
   *De-duplicate.*

3. Determine categories  
   *Prefer explicit input; otherwise infer from verbs/headings vs $5.*  
   *Validate, sort deterministically, and de-dupe (≤3).*

4. Determine lifecycle/stage (optional)  
   *Prefer explicit input; otherwise map categories via $6.*  
   *Omit if uncertain.*

5. Determine dependencies (optional)  
   *Parse phrases implying order or prerequisites; keep id-shaped items (≤5).*

6. Determine provided artifacts (optional)  
   *Short list (≤3) of unlocked outputs.*

7. Compose summary  
   *One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”*

8. Produce metadata in the requested format  
   *Default to a human-readable serialization; honor any requested alternative.*

9. Reconcile if input already contains metadata  
   *Merge: explicit inputs > existing > inferred.*  
   *Validate lists; move unknowns to an extension field if needed.*  
   *Remove empty keys.*

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- Command list and file paths to place docs under `docs/apis/`.
- Example: curl -o docs/apis/github.com/api.json https://api.github.com/docs
- Example: npm view express docs --json > docs/apis/express/README.md

# API Docs Local

Trigger: /api-docs-local

Purpose: Fetch API docs and store locally for offline, deterministic reference.

## Steps

1. Create `docs/apis/` directory.
2. For each provided URL or package, write retrieval commands (curl or `npm view` docs links). Do not fetch automatically without confirmation.
3. Add `DOCS.md` index linking local copies.

## Output format

- Command list and file paths to place docs under `docs/apis/`.
