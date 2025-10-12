# Research Workflow

## Metadata

- **Identifier**: research-item
- **Categories**: 
  - Research Workflow
  - Query Generation
  - Evidence Collection
- **Lifecycle Stage**: Process
- **Dependencies**: objective text, context (optional)
- **Provided Artifacts**:
  - Query Set
  - Evidence Log
  - Synthesis
  - Contradictions
  - Gaps & Next
  - Decision Hook
  - Conversation State Update
- **Summary**: Run research on a single objective to generate queries, evidence, synthesis, and decision insights.

## Inputs

- Objective text (required)
- Starting context (optional)

## Canonical taxonomy (exact strings)

- Research Workflow
- Query Generation
- Evidence Collection
- Synthesis
- Decision Support
- Conversation State Management
- Gap Analysis

### Stage hints (for inference)

- Process: discrete, end-to-end workflow with input-output structure
- Discovery: exploratory search phase
- Evaluation: evidence review and synthesis
- Decision: final recommendation or hook

## Algorithm

1. Extract signals from $1  
   *Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.*

2. Determine the primary identifier  
   *Prefer explicit input; otherwise infer from main action + object.*  
   *Normalize (lowercase, kebab-case, length-capped, starts with a letter).*  
   *De-duplicate.*

3. Determine categories  
   *Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.*  
   *Validate, sort deterministically, and de-dupe (≤3).*

4. Determine lifecycle/stage (optional)  
   *Prefer explicit input; otherwise map categories via stage hints.*  
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
- Limit distinct placeholders to ≤7.
- Do not alter the body text after metadata.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from canonical taxonomy (≤3).
- Stage, if present, is one of the allowed stages implied by stage hints.
- Dependencies, if present, are id-shaped (≤5).
- Provided artifacts are within expected output list.
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

```
## Item 1: {short title}

### Goal
{1 sentence}

### Assumptions
- {only if needed}

### Query Set
- {Q1}
- {Q2}
- {Q3}
- {Q4–Q8}

### Evidence Log
| SourceID | Title | Publisher | URL | PubDate | Accessed | Quote (≤25w) | Finding | Rel | Conf |
|---|---|---|---|---|---|---|---|---|---|

### Synthesis
- {claim with [S1,S3]}
- {finding with [S2]}
- {risk/edge with [S4]}

### Contradictions
- {S2 vs S5 → rationale}

### Gaps & Next
- {follow-up or test}

### Decision Hook
{one line}

### Conversation State Update
- New facts: {bullets}
- Constraints learned: {bullets}
- Entities normalized: {canonical forms}
```

- Input: `/research-item Compare OpenAPI 3.1 tooling for Python clients in 2024; budget $0; prefer official docs.`  
- Output: As per format with SourceIDs and dates.

Notes:
- Safety: No personal data. Do not fabricate sources.
- Provenance: Cite reputable sources; record n/a for missing PubDate.
