```md
# Feature Flags

## Metadata

- **Identifier**: {{identifier}}  
- **Categories**: {{categories}}  
- **Stage**: {{stage}}  
- **Dependencies**: {{dependencies}}  
- **Provided Artifacts**: {{artifacts}}  
- **Summary**: {{summary}}

---

**Steps:**

1. Select provider (LaunchDarkly, Unleash, Flagsmith, custom).
2. Add SDK init in web/api with bootstrap values and offline mode for dev.
3. Define flag naming and ownership. Add kill‑switch pattern and monitoring.

**Output format:** {{output_format}}

**Examples:** `/feature-flags {{example_provider}}`.

**Notes:** Ensure flags are typed and expire with tickets.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
