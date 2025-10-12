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
Find $3 by searching $4; prioritize $5; extract specific data points; compare alternatives/criteria; note risks/limitations; deliver a concise summary with required artifacts/tables, citing the most authoritative sources.
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.

{
  "args": [
    {
      "id": "$1",
      "name": "prompt",
      "hint": "The vague ask or topic to convert into a research instruction",
      "example": "What are the key trends in renewable energy adoption in Europe?",
      "required": true,
      "validate": "^.*$"
    },
    {
      "id": "$2",
      "name": "time_context",
      "hint": "Optional temporal scope (e.g., 'last 5 years', 'post-2020')",
      "example": "last 5 years",
      "required": false,
      "validate": "^.*$"
    },
    {
      "id": "$3",
      "name": "target_info",
      "hint": "What specific information needs to be found (e.g., trends, figures, policies)",
      "example": "key trends in renewable energy adoption",
      "required": true,
      "validate": "^.*$"
    },
    {
      "id": "$4",
      "name": "sources_or_scope",
      "hint": "Where or when to search (e.g., government reports, peer-reviewed journals)",
      "example": "government reports and peer-reviewed journals",
      "required": true,
      "validate": "^.*$"
    },
    {
      "id": "$5",
      "name": "entities_or_versions",
      "hint": "What specific entities, versions, or locations to prioritize (e.g., EU policies, 2023 data)",
      "example": "EU policies from 2023",
      "required": true,
      "validate": "^.*$"
    }
  ]
}
