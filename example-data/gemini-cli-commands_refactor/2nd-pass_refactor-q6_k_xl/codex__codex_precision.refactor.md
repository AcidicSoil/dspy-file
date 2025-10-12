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
Find $1 by searching $2; prioritize $3; extract $4; compare $5; note risks/limitations; deliver a concise summary with $6, citing the most authoritative sources.
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "target_info",
      "hint": "The specific information or entity to be researched (e.g., 'the market share of Tesla in 2023').",
      "example": "market share of electric vehicles in Europe",
      "required": true,
      "validate": "^(.+)$"
    },
    {
      "id": "$2",
      "name": "sources_scope_timeframe",
      "hint": "The sources, scope, and timeframe for the search (e.g., 'official reports from 2020–2023').",
      "example": "official government reports from 2020 to 2023",
      "required": true,
      "validate": "^(.+)$"
    },
    {
      "id": "$3",
      "name": "entities_to_prioritize",
      "hint": "Key entities, versions, or locations to focus on (e.g., 'versions of the 2023 model').",
      "example": "versions of the 2023 Tesla Model S",
      "required": true,
      "validate": "^(.+)$"
    },
    {
      "id": "$4",
      "name": "data_to_extract",
      "hint": "Specific data points to extract from sources (e.g., 'sales figures, pricing, battery capacity').",
      "example": "sales figures, pricing, and battery capacity",
      "required": true,
      "validate": "^(.+)$"
    },
    {
      "id": "$5",
      "name": "alternatives_criteria",
      "hint": "How to compare alternatives or criteria (e.g., 'by performance, cost, and reliability').",
      "example": "by performance, cost, and reliability",
      "required": true,
      "validate": "^(.+)$"
    },
    {
      "id": "$6",
      "name": "output_artifacts",
      "hint": "Required deliverables or outputs (e.g., 'a table of key metrics, a summary paragraph').",
      "example": "a table of key metrics and a summary paragraph",
      "required": true,
      "validate": "^(.+)$"
    }
  ]
}
