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
You are a <$4>. Optimize for <$5>. Using <$6> and within <$7>, produce <$8>. Include <$9>. Exclude <$10>. Address <$11>. Provide <$12>. Assume <$13>. Return <$14>.
```

**Curated codex Response Prompt**

```
# Role
You are a <$14>.

# Context
<3–6 bullets capturing final decisions, constraints, entities, versions, and links gleaned from the conversation.>

# Task
Produce <$16> that reflect the conversation’s conclusions. Include <$17>. Respect <$18>.

# Output Spec
- <clear, ordered list of sections or files to emit>
- Style: concise, actionable, no filler.

# Evaluation
Meets: <$19>. Fails if: <$20>.
```
"""

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
