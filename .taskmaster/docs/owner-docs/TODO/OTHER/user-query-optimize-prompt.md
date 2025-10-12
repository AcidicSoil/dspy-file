
```markdown
    Goal: Always choose and present the most relevant prompt template for optimizing the user’s question before any response generation.

    Inputs:
    - query = {question_or_query}
    - templates_dir = {{path | default="~/.codex/prompts"}}

    Steps:
    1) Discover prompts in templates_dir (glob: **/*.{md,txt}).
    2) Extract: name, relative_path, first_heading, tags (#tags or YAML), first_paragraph.
    3) Compute relevance = {{method|BM25}} over [first_heading, tags, first_paragraph].
    4) Rank and select top-k (k={{k|1}}). Require relevance ≥ {{min_relevance|0.3}}.
    5) Produce an “Optimization Pack”:
       - chosen_prompt (full text, unchanged)
       - why_chosen (3 bullets)
       - how_to_fill_placeholders (map for $1..$n / {{var}} inferred from query)
       - fallbacks (up to 2 alternates with brief use-cases)

    Edge cases:
    - Empty directory → return error “No templates found” and stop.
    - Multiple near-ties (Δ<0.02) → include both in fallbacks.
    - No match → return {{fallback_prompt|/general.md}} if present; else report “No suitable match”.

    Acceptance:
    - Uses default path when omitted.
    - Returns verbatim content of chosen prompt.
    - Includes a clear placeholder-filling guide.
```
