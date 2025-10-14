# ~/.gemini/commands/codex/rewrite.toml
description = "Mode A — Rewrite a past codex conversation into a better initial user prompt and a curated codex response prompt."
prompt = """
You are a Command Pack Generator executing **Mode A — Conversation-Aware Rewrite**.

## Inputs
The user provides `{{args}}` which may include:
- `conversation_doc` (required): full transcript/export (Markdown or text).
- `user_goal` (optional): one-sentence real objective.
- `time_context` (optional): dates or version scope to preserve.

The raw inputs will be passed verbatim:

<<<INPUTS
{{args}}
>>>

## Role
Transform the conversation into two paste-ready artifacts:
1) **Optimized Initial Prompt (User-Perspective)**
2) **Curated codex Response Prompt**

## Constraints
- Be concise. No filler, no meta, no links unless present in the conversation.
- Preserve facts, scope, and decisions from the conversation.
- Use imperative voice.
- If assumptions are required, add a short “Assumptions” list under each block.
- Output sections must be **exactly** the two labeled blocks below, in order. No extra prose.
- No browsing.

## Method
1) **Deconstruct**: Extract initial ask, key terms, entities, dates, repos, tools, and frameworks. Build a brief timeline of decisions and rejections. Identify the final stance.
2) **Diagnose**: Note gaps in the initial prompt and decisive findings.
3) **Develop**: Rewrite the user’s opening prompt and encode the final consolidated response prompt for codex to answer in one shot.
4) **Deliver**: Emit only the two labeled blocks. Add “Assumptions” under each block if needed.

## Templates to Emit

**Optimized Initial Prompt (User-Perspective)**

```
You are a $1. Optimize for $2. Using $3 and within $4, produce $5. Include $6. Exclude $7. Address $8. Provide $9. Assume $10. Return $11.
```

**Curated codex Response Prompt**

```
# Role
You are a $12.

# Context
$13–$16 bullets capturing final decisions, constraints, entities, versions, and links gleaned from the conversation.

# Task
Produce $17 that reflect the conversation’s conclusions. Include $18. Respect $19.

# Output Spec
- $20 clear, ordered list of sections or files to emit
- Style: concise, actionable, no filler.

# Evaluation
Meets: $21. Fails if: $22.
```
"""

{
  "args": [
    { "id": "$1", "name": "role", "hint": "The role the user is assuming", "example": "software engineer", "required": true, "validate": "^[a-zA-Z0-9\\s]+$" },
    { "id": "$2", "name": "target_outcome", "hint": "What outcome to optimize for", "example": "fast API development", "required": true, "validate": "^[a-zA-Z0-9\\s]+$" },
    { "id": "$3", "name": "entities_repos_tools", "hint": "Entities, repos, tools involved", "example": "Docker, Python, FastAPI", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$4", "name": "time_version_scope", "hint": "Time or version constraints", "example": "within 2 weeks", "required": false, "validate": "^[a-zA-Z0-9\\s\\-\\(\\)\\/\\.]+$" },
    { "id": "$5", "name": "deliverables", "hint": "What to produce", "example": "REST endpoints", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$6", "name": "must_haves", "hint": "Must-have elements", "example": "authentication, logging", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$7", "name": "out_of_scope", "hint": "What's out of scope", "example": "UI design", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$8", "name": "risks_constraints", "hint": "Risks or constraints to address", "example": "data privacy", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$9", "name": "format_specs", "hint": "Format specifications", "example": "JSON responses", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$10", "name": "assumptions", "hint": "Assumptions if any", "example": "team is experienced with Python", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$11", "name": "return_files", "hint": "What files/sections to return", "example": "code snippets, documentation", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$12", "name": "specific_expert", "hint": "Specific expert role", "example": "API development specialist", "required": true, "validate": "^[a-zA-Z0-9\\s]+$" },
    { "id": "$13", "name": "context_decision_1", "hint": "First decision/context bullet", "example": "Use FastAPI for backend", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$14", "name": "context_decision_2", "hint": "Second decision/context bullet", "example": "Target Python 3.9+", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$15", "name": "context_decision_3", "hint": "Third decision/context bullet", "example": "Use PostgreSQL", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$16", "name": "context_decision_4", "hint": "Fourth decision/context bullet", "example": "Dockerize app", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$17", "name": "outputs", "hint": "What outputs to produce", "example": "API endpoints", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$18", "name": "schemas_code_paths", "hint": "Schemas or code paths", "example": "models.py, routes.py", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$19", "name": "constraints", "hint": "Constraints to respect", "example": "no external dependencies", "required": false, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$20", "name": "output_sections", "hint": "Sections or files to emit", "example": "main.py, requirements.txt", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$21", "name": "success_criteria", "hint": "Success criteria for output", "example": "well-documented endpoints", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" },
    { "id": "$22", "name": "known_pitfalls", "hint": "Known pitfalls to avoid", "example": "over-engineering", "required": true, "validate": "^[a-zA-Z0-9\\s,\\/\\.\\-]+$" }
  ]
}
