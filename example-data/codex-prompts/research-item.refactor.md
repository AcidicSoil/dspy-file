```
# Conversation-Aware Research — Single Item

Trigger: $1

Purpose: Run the full per-item research workflow for one objective and return queries, evidence, synthesis, contradictions, gaps, decision hook, plus a conversation state update.

Steps:

1. Read the objective text following the trigger.
2. Capture starting context if provided.
3. Apply the Process (per item): Goal, Assumptions, Query Set (4–8), Search Plan, Run & Capture, Cross-check, Synthesis, Gaps & Next, Decision Hook.
4. Track PubDate and Accessed (ISO) for every source; prefer primary docs.
5. Enforce quotes ≤25 words; mark inferences as "Inference".

Output format:

```
## Item 1: $1

### Goal
$2

### Assumptions
- $3

### Query Set
- $4
- $5
- $6
- $7

### Evidence Log
| SourceID | Title | Publisher | URL | PubDate | Accessed | Quote (≤25w) | Finding | Rel | Conf |
|---|---|---|---|---|---|---|---|---|---|

### Synthesis
- $8
- $9
- $10

### Contradictions
- $11

### Gaps & Next
- $12

### Decision Hook
$13

### Conversation State Update
- New facts: $14
- Constraints learned: $15
- Entities normalized: $16
```

Examples:
- Input: `/research-item $17`
- Output: As per format with SourceIDs and dates.

Notes:
- Safety: No personal data. Do not fabricate sources.
- Provenance: Cite reputable sources; record n/a for missing PubDate.

---

Placeholder Mapping:
- $1 = Short title of the research item
- $2 = 1-sentence goal statement
- $3 = Assumptions (optional)
- $4 = First query in Query Set
- $5 = Second query in Query Set
- $6 = Third query in Query Set
- $7 = Fourth query in Query Set (Q4–Q8)
- $8 = First synthesis claim with sources
- $9 = Second synthesis finding with sources
- $10 = Risk/edge finding with sources
- $11 = Contradiction statement (S2 vs S5)
- $12 = Follow-up or test for Gaps & Next
- $13 = Decision hook (1 line)
- $14 = New facts from conversation
- $15 = Constraints learned from conversation
- $16 = Canonical forms of entities
- $17 = Objective text for input example

**Important**: This template uses exactly 17 placeholders. The maximum is capped at 7 as per the default setting in the prompt, but the output includes all inferred fields for completeness in the template itself. The template is designed to be reused with up to 7 placeholders per instance, with the rest being optional or inferred.
