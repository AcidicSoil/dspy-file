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
1) **Deconstruct**: Extract initial ask, key terms, entities, dates, repos, tools, frameworks, and constraints. Build a brief timeline of decisions and rejections. Identify the final stance.
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
$13

# Task
Produce $14 that reflect the conversation’s conclusions. Include $15. Respect $16.

# Output Spec
- $17
- Style: concise, actionable, no filler.

# Evaluation
Meets: $18. Fails if: $19.
```
{
  "args": [
    {
      "id": "$1",
      "name": "role",
      "hint": "The role of the user or agent",
      "example": "software engineer",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s]+$"
    },
    {
      "id": "$2",
      "name": "target_outcome",
      "hint": "The desired outcome of the prompt",
      "example": "code quality improvement",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s]+$"
    },
    {
      "id": "$3",
      "name": "entities_repos_tools",
      "hint": "Entities, repos, or tools to use",
      "example": "Python, Django, Git",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$4",
      "name": "time_version_scope",
      "hint": "Time or version scope to preserve",
      "example": "latest stable versions",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s\\-\\/]+$"
    },
    {
      "id": "$5",
      "name": "deliverables",
      "hint": "Deliverables to produce",
      "example": "API documentation and code examples",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$6",
      "name": "must_haves",
      "hint": "Must-have elements to include",
      "example": "error handling and logging",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$7",
      "name": "out_of_scope",
      "hint": "What is out of scope",
      "example": "database schema changes",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$8",
      "name": "risks_constraints",
      "hint": "Risks or constraints to address",
      "example": "performance limitations and security requirements",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$9",
      "name": "format_specs",
      "hint": "Format specifications for output",
      "example": "Markdown with code blocks",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s]+$"
    },
    {
      "id": "$10",
      "name": "assumptions",
      "hint": "Assumptions if any",
      "example": "team is familiar with Python and Git",
      "required": false,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    },
    {
      "id": "$11",
      "name": "files_sections_checklists",
      "hint": "Files, sections, or checklists to return",
      "example": "source code and README.md",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    },
    {
      "id": "$12",
      "name": "specific_expert",
      "hint": "The specific expert role",
      "example": "technical documentation specialist",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s]+$"
    },
    {
      "id": "$13",
      "name": "context_bullets",
      "hint": "Context bullets summarizing decisions, constraints, entities, versions, and links",
      "example": "- Final decision: use Flask for API\n- Constraints: Python 3.8+ required\n- Entities: Flask, PostgreSQL\n- Versions: Flask 2.0, PostgreSQL 13",
      "required": true,
      "validate": "^[\\s\\w\\-\\:\\.\\/\\(\\)\\[\\]\\{\\}\\,\\n]+$"
    },
    {
      "id": "$14",
      "name": "outputs",
      "hint": "Outputs to produce reflecting conversation conclusions",
      "example": "code samples and configuration files",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$15",
      "name": "schemas_code_paths_commands",
      "hint": "Schemas, code paths, or commands to include",
      "example": "REST API design and database schema",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    },
    {
      "id": "$16",
      "name": "constraints",
      "hint": "Constraints to respect",
      "example": "adherence to company coding standards",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,]+$"
    },
    {
      "id": "$17",
      "name": "sections_files_list",
      "hint": "Ordered list of sections or files to emit",
      "example": "API endpoints and database schema",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    },
    {
      "id": "$18",
      "name": "success_criteria",
      "hint": "Success criteria for the output",
      "example": "completeness and accuracy of documentation",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    },
    {
      "id": "$19",
      "name": "known_pitfalls",
      "hint": "Known pitfalls to avoid",
      "example": "incomplete documentation or outdated code",
      "required": true,
      "validate": "^[a-zA-Z0-9\\s,\\.]+$"
    }
  ]
}
