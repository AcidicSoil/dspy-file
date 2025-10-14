<!-- $1 = user-provided inputs (e.g., prompt, time_context) 
$2 = generated researcher instruction paragraph 
$3 = target information to find 
$4 = sources or scope and timeframe for search 
$5 = entities, versions, or locations to prioritize 
$6 = specific data points to extract 
$7 = alternatives or criteria to compare 
$8 = risks, limitations, or caveats to note 
$9 = required artifacts or tables to deliver -->

**$2**

```
Find $3 by searching $4; prioritize $5; extract $6; compare $7; note $8; deliver a concise summary with $9, citing the most authoritative sources.
```

## Output format
- Exactly one paragraph
- Imperative voice. No filler. No links unless present in inputs.
- Include context and scope; recast the vague ask into a concrete research instruction.
- No browsing.
