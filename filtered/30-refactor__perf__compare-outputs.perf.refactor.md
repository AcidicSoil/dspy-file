```md
# Compare Outputs

Trigger: /compare-outputs

Purpose: Run multiple models or tools on the same prompt and summarize best output.

## Steps

1. Define evaluation prompts and expected properties.
2. Record outputs from each model/tool with metadata.
3. Score using a rubric: correctness, compile/run success, edits required.
4. Recommend a winner and suggested settings.

## Output format

- Matrix comparison and a one-paragraph decision.

## Template Placeholders

### [1] Evaluation Prompts
- Prompt 1: {{prompt_1}}
- Prompt 2: {{prompt_2}}
- Prompt 3: {{prompt_3}}

### [2] Expected Properties
- Property 1: {{property_1}}
- Property 2: {{property_2}}
- Property 3: {{property_3}}

### [3] Model/Tool Metadata
- Tool 1: {{tool_1}}
- Tool 2: {{tool_2}}
- Tool 3: {{tool_3}}

### [4] Scoring Rubric
- Correctness Score: {{correctness_score}}
- Compile/Run Success: {{compile_run_success}}
- Edits Required: {{edits_required}}

### [5] Winner Recommendation
- Recommended Tool: {{recommended_tool}}
- Suggested Settings: {{suggested_settings}}

### [6] Matrix Comparison
{{matrix_comparison}}

### [7] Decision Summary
{{decision_summary}}
```
