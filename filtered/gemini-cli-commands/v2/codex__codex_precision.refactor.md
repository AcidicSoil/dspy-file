# ~/.gemini/commands/codex/precision.toml
description = "Mode B — Convert a vague prompt into a one-paragraph precision researcher instruction."
prompt = """
You are a Command Pack Generator executing **Mode B — Precision Search Prompt Generator**.

## Inputs
The user provides `{{args}}` which may include:
- `prompt` (vague ask or topic; required if no conversation is present)
- `time_context` (optional)
- Any minimal context text

The raw inputs will be passed verbatim:

<<<INPUTS
$1
>>>

## Constraints
- Output **exactly one paragraph**.
- Imperative voice. No filler. No links unless present in inputs.
- Include context and scope; recast the vague ask into a concrete research instruction.
- No browsing.

## Template to Emit

**Researcher Instruction Paragraph**

```
Find $2 by searching $3; prioritize $4; extract $5; compare $6; note $7; deliver a concise summary with $8, citing the most authoritative sources.
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
{
  "args": [
    {
      "id": "$1",
      "name": "args",
      "hint": "User-provided inputs including prompt, time_context, and minimal context text",
      "example": "{ \"prompt\": \"market trends\", \"time_context\": \"last 5 years\" }",
      "required": true,
      "validate": "json"
    },
    {
      "id": "$2",
      "name": "target_info",
      "hint": "Specific information to find in the research",
      "example": "market trends",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$3",
      "name": "sources_scope_timeframe",
      "hint": "Sources, scope, or timeframe for the search",
      "example": "industry reports and academic journals",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$4",
      "name": "entities_versions_locations",
      "hint": "Entities, versions, or locations to prioritize",
      "example": "key companies and their versions",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$5",
      "name": "specific_data_points",
      "hint": "Specific data points to extract from sources",
      "example": "revenue figures and growth rates",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$6",
      "name": "alternatives_criteria",
      "hint": "Alternatives or criteria for comparison",
      "example": "market share vs. competitive analysis",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$7",
      "name": "risks_limitations",
      "hint": "Risks or limitations to note in findings",
      "example": "data accuracy concerns and outdated reports",
      "required": true,
      "validate": "string"
    },
    {
      "id": "$8",
      "name": "required_artifacts_tables",
      "hint": "Required artifacts or tables to deliver",
      "example": "comparative charts and summary tables",
      "required": true,
      "validate": "string"
    }
  ]
}
