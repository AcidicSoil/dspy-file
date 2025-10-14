```md
# Reset Strategy

## Metadata

- **identifier**: {{identifier}}  
- **category**: {{category}}  
- **stage**: {{stage}}  
- **dependencies**: {{dependencies}}  
- **provided_artifacts**: ["{{artifact_1}}", "{{artifact_2}}"]  
- **summary**: {{summary}}  

---

# Reset Strategy

Trigger: /reset-strategy

Purpose: {{purpose}}

## Steps

1. Run: `git status -sb` and `git diff --stat` to assess churn.
2. If many unrelated edits or failing builds, propose: `git reset --hard HEAD` to discard working tree.
3. Save any valuable snippets to `scratch/` before reset.
4. Re-implement the minimal correct fix from a clean state.

## Output format

- A short decision note and exact commands. Never execute resets automatically.

## Examples

- {{example}}

## Notes

- {{note}}

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
