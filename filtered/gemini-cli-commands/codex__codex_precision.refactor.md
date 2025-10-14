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
{{args}}
>>>

## Constraints
- Output **exactly one paragraph**.
- Imperative voice. No filler. No links unless present in inputs.
- Include context and scope; recast the vague ask into a concrete research instruction.
- No browsing.

## Template to Emit

**Researcher Instruction Paragraph**

```
Find $1 by searching $2; prioritize $3; extract $4; compare $5; note $6; deliver a concise summary with $7, citing the most authoritative sources.
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "prompt",
      "hint": "A vague ask or topic to be converted into a concrete research instruction.",
      "example": "the impact of AI on global employment",
      "required": true,
      "validate": ".*"
    },
    {
      "id": "$2",
      "name": "time_context",
      "hint": "Optional time frame or context for the search.",
      "example": "last decade",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$3",
      "name": "prioritized_entities",
      "hint": "Entities, versions, or locations to prioritize during the search.",
      "example": "leading tech companies and academic institutions",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$4",
      "name": "extracted_data_points",
      "hint": "Specific data points to extract from sources.",
      "example": "employment statistics, policy changes",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$5",
      "name": "alternatives_criteria",
      "hint": "Alternatives or criteria to compare in the analysis.",
      "example": "different AI implementation models",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$6",
      "name": "risks_limitations",
      "hint": "Risks or limitations to note during research.",
      "example": "data bias, regulatory constraints",
      "required": false,
      "validate": ".*"
    },
    {
      "id": "$7",
      "name": "required_artifacts_tables",
      "hint": "Required artifacts or tables for the summary.",
      "example": "comparative charts and data tables",
      "required": false,
      "validate": ".*"
    }
  ]
}
