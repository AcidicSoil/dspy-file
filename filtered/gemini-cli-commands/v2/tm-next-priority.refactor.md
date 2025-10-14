# Command: /pm:prioritize-tasks

# Usage: /pm:prioritize-tasks "Back-office revamp; Migrate billing, clean data, deploy SSO; API auth depends on IdP; PCI compliance by Q2; High ARR impact, medium risk; Weighted scoring (impact 50%, effort 30%, risk 20%); Team of 4 for 6 weeks"

# Args:

# - {{goals}}: project goals & scope

# - {{backlog}}: candidate tasks under consideration

# - {{dependencies}}: known blocking/blocked-by relationships

# - {{constraints}}: deadlines, policies, tech limits

# - {{priority_signals}}: impact, risk, obligations

# - {{decision_criteria}}: tie-break rules or scoring model

# - {{capacity}}: available capacity & timeframe

prompt = """
You are given structured inputs to prioritize a project backlog. Use them to produce a clear, dependency-aware plan.

Inputs

* Goals & scope: $1
* Backlog (tasks): $2
* Dependencies: $3
* Constraints: $4
* Priority signals: $5
* Decision criteria: $6
* Capacity & timeframe: $7

Do the following, in order:

1. Build a dependency-aware ordering of the backlog (respect "blocked-by" and "unlocks").
2. Score each task against the provided decision criteria and priority signals; map to Impact (H/M/L) and Effort (S/M/L).
3. Identify blockers, coupling risks, and quick wins; prefer tasks that unlock multiple others and align with constraints.
4. Respect capacity & timeframe when selecting immediate work.

Acceptance:

* Return exactly the four sections below, in this order and format.
* Section 1 is a Markdown table with the headers and column order shown.
* Populate at least the top 3 ranked tasks (more if provided and unambiguous).
* Keep rationale concise (≤120 chars per row).
* No extra sections, notes, or commentary outside the four required sections.

Output sections (exact):

1. **Ranked Task Table**

   | Rank | Task | Blocked By | Unlocks | Impact (H/M/L) | Effort (S/M/L) | Rationale |
   | ---- | ---- | ---------- | ------- | -------------- | -------------- | --------- |
   | 1    | …    | …          | …       | …              | …              | …         |
   | 2    | …    | …          | …       | …              | …              | …         |
   | 3    | …    | …          | …       | …              | …              | …         |

2. **Recommendation**

   * **Do now:** *one task*
   * **Why:** *2–4 bullets*
   * **Next:** *2–3 tasks*

3. **Risks & Mitigations** — *bulleted list*

4. **Open Questions** — *bulleted list*
   """

{
  "args": [
    {
      "id": "$1",
      "name": "goals",
      "hint": "project goals & scope",
      "example": "Back-office revamp",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$2",
      "name": "backlog",
      "hint": "candidate tasks under consideration",
      "example": "Migrate billing, clean data, deploy SSO",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$3",
      "name": "dependencies",
      "hint": "known blocking/blocked-by relationships",
      "example": "API auth depends on IdP",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$4",
      "name": "constraints",
      "hint": "deadlines, policies, tech limits",
      "example": "PCI compliance by Q2",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$5",
      "name": "priority_signals",
      "hint": "impact, risk, obligations",
      "example": "High ARR impact, medium risk",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$6",
      "name": "decision_criteria",
      "hint": "tie-break rules or scoring model",
      "example": "Weighted scoring (impact 50%, effort 30%, risk 20%)",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$7",
      "name": "capacity",
      "hint": "available capacity & timeframe",
      "example": "Team of 4 for 6 weeks",
      "required": true,
      "validate": "string"
    }
  ]
}
