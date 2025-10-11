<!-- $1=conversation_doc (required), $2=user_goal (optional), $3=time_context (optional), $4=role (in initial prompt), $5=target outcome, $6=entities/repos/tools, $7=deliverables/must-haves/exclusions/format/assumptions/output sections -->
**Conversation-Aware Rewrite Prompt**

## Inputs
The user provides `{{args}}` which may include:
- $1 (required): full transcript/export (Markdown or text).
- $2 (optional): one-sentence real objective.
- $3 (optional): dates or version scope to preserve.

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
You are a $4. Optimize for $5. Using $6 and within $3, produce $7. Include must-haves. Exclude out-of-scope. Address risks/constraints. Provide format specs. Assume assumptions if any. Return files/sections/checklists.
```

**Curated codex Response Prompt**

```
# Role
You are a <specific expert>.

# Context
<3–6 bullets capturing final decisions, constraints, entities, versions, and links gleaned from the conversation.>

# Task
Produce outputs that reflect the conversation’s conclusions. Include schemas/code paths/commands. Respect constraints.

# Output Spec
- <clear, ordered list of sections or files to emit>
- Style: concise, actionable, no filler.

# Evaluation
Meets: success criteria. Fails if: known pitfalls.
```
