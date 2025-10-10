# Original-Users-query

```txt
Generate an instruction template for an AGENTS.md that will take the user's question and/or query and run it through the template as an optimizing step before considering anything else. The template will direct the agent to a {{path}} that, by default, will be "~/.codex/prompts" if omitted. The agent will then provide a relevant prompt from that directory based on the relevance of the user's question/query.
```

---

```md
    #1
    [Directive]
    Objective: Before any other action, optimize the user’s question/query by passing it through a selected prompt template.

    Inputs:
    - User input: {question_or_query}
    - Templates path: {{path}} (default: ~/.codex/prompts if omitted)

    Process:
    1) Resolve path → use {{path}} if provided; else ~/.codex/prompts.
    2) Load all prompt files in the path (extensions: .md, .txt).
    3) For each prompt, derive metadata (filename, title line, any front-matter tags) and compute relevance to {question_or_query} using {{scoring_method|cosine|BM25}}.
    4) Rank prompts descending by score; break ties by shortest prompt title, then most recent modified time.
    5) Select top {{selection_count|1}} prompt(s) with score ≥ {{min_score|0.35}}.
    6) Output the chosen prompt(s) verbatim plus a brief rationale and the filled placeholders (if any).
    7) If no prompt meets threshold, return {{fallback_prompt|the most general helper prompt in the directory}} and state “No strong match”.

    Output format (strict):
    - selected_prompt_path(s)
    - prompt_content(s)
    - rationale (≤120 words)
    - filled_placeholders: {…}

    Non-goals:
    - Do not execute the selected prompt; only return it and the optimization rationale.
    - Do not browse external sources.

    Acceptance criteria:
    - Defaults applied when {{path}} missing.
    - Deterministic ranking with ties handled.
    - Clear fallback when no match.
```

```md
    #2
    [Spec]
    Purpose: Route every user input through a best-fit template before any tool use or answering.

    Required behavior:
    - Default template directory: ~/.codex/prompts unless {{path}} is provided.
    - Consider files: *.md, *.txt. Ignore hidden files.

    Algorithm:
    1) Normalize input: trim, lowercase for matching, keep original for output.
    2) Build an index of {title, tags, first 200 chars, file path}.
    3) Score relevance using: title*3 + tags*2 + body*1 with {{similarity_fn|cosine}} over {{embedding_model|local}}.
    4) Pick the single highest-scoring prompt if score ≥ {{threshold|0.4}}; otherwise return “no suitable template” with the top 3 candidates as suggestions.
    5) Substitute detected placeholders in the chosen prompt: $1..$9 or {{placeholders}} using best-effort mapping from the input; leave placeholders intact if mapping is unclear.

    Return (machine-readable):
    ```json
    {
      "path_used": "{{resolved_path}}",
      "selected": [{"path": "...", "score": 0.00}],
      "alternatives": [{"path":"...", "score":0.00}],
      "optimized_input_preview": "…"
    }
    ```

Quality gates:

*   Stable sort; tie-break by file name A→Z.

*   Time limit per run: {{time\_budget\_ms|250}}.

*   Deterministic results given same corpus and input.
```

```markdown
    #3
    [QA-Ready]
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
