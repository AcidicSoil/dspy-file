# rank-root-prompts dspy module implementation guide

// TODO

Output: Direct answer with a concrete path to make it work | Constraints: Use only the repo context you shared; no code snippets yet | Acceptance criteria: (1) Clear yes/no; (2) Why/where in code; (3) Single practical plan to enable “gather project context first, then rank prompts”

**Short answer:** No, not as-is. Supplying `rank-root-prompts.md` as the template won’t make your DSPy program gather the user’s codebase context before scanning a prompts directory.

**Why (grounded in your code):**

* The only place a prompt template is injected into the LM is **refactor mode** via `FileRefactorAnalyzer(..., template_text=...)`, whose signature accepts only `file_path` and `file_content` for a **single file**, not a project or a prompts directory. The template’s instructions are just LM guidance; they don’t trigger any filesystem work. (`refactor_analyzer.py`: `RefactorTemplateSignature`, `FileRefactorAnalyzer.forward`)

* The CLI wires templates only when `-m refactor` (or `--mode refactor`). In teach mode it never loads a template. (`analyze_file_cli.py`: `_resolve_prompt_text`, `AnalysisMode`, `main`)

* There is **no module/command** that:

    1. scans a project path for context,

    2. enumerates prompt files under a prompt path,

    3. reads each prompt file and computes a relevance score vs the user’s query.

In other words, your template describes a workflow, but your program doesn’t have the code paths (I/O + ranking) to execute that workflow.

---

Best-practice gap
=================

* Add a **PromptRanking module** and a **`rank-prompts` subcommand**:

  * Inputs: `{query, project_path, prompt_path, threshold}`.

  * Steps (programmatic, not left to the LM):

        1. **Project context**: reuse `collect_source_paths(...)` to gather representative files; summarize with a light pass (e.g., README, pyproject, top-N files by size/extension) and/or a short LM summary call.

        2. **Prompt scan**: glob `prompt_path` for `*.md|*.txt`, read contents.

        3. **Relevance**: compute a score per prompt (BM25/TF-IDF or small embedding cosine) using **(query + project summary)** as the query vector.

        4. **Output**: print the markdown table `filename | description | match_score` filtered by `threshold` (fallback line if none meet it).

* Keep the LM’s role **scoring/explaining**, not performing I/O. Use the LM to:

  * Produce each prompt’s **one-sentence description**.

  * Optionally refine scores with a small re-rank given the top-k from BM25.

* Extend tests:

  * Temp project + temp prompt dir → assert table sorted & threshold respected.

  * “No matches” path → assert single-line fallback.

* CLI integration:

  * New parser subcommand `rank-prompts` with flags: `--query`, `--project`, `--prompts`, `--threshold` (default 0.3).

  * Do **not** overload `refactor`/`teach`; keep ranking orthogonal.

This will make the “analyze codebase first, then scan/rank prompts” behavior deterministic and reliable—independent of how forceful the template wording is.

---

// TODO

### User-query

Should I consider any other additional functionality from the dspy framework before I begin this implementation?

---

Output: Concise design checklist | Constraints: Use official DSPy docs where possible; give ≤10 high-leverage suggestions; no code | Acceptance criteria: A single, prioritized list that answers “what to consider in DSPy before building,” with clear ties to DSPy features and citations

Here’s what I’d consider before you implement the “analyze project → rank prompts” flow:

1. Use a DSPy **Optimizer** to tune your ranking program
    Pick an optimizer (formerly “teleprompter”) to automatically improve the instructions/examples of your ranking module against a metric. Start simple with **BootstrapFewShot**; if you want joint optimization of instructions + few-shots, consider **MIPROv2**. [dspy.ai+2dspy.ai+2](https://dspy.ai/learn/optimization/optimizers/?utm_source=chatgpt.com)

2. Add a concrete **metric** and plug it into DSPy’s optimization loop
    Define a scoring function (e.g., nDCG@k, precision@1, or an LLM-as-judge) so the optimizer can actually improve your program. DSPy optimizers optimize your program “to maximize the metrics you specify.” [dspy.ai+1](https://dspy.ai/learn/optimization/optimizers/?utm_source=chatgpt.com)

3. Enforce output shape with **DSPy Assertions**
    Use Assertions to require: a 3-column markdown table; scores ∈ \[0,1\]; and the fallback line when nothing ≥ threshold. This turns schema/constraints into programmable checks, increasing reliability. [dspy.ai+2Arize AI+2](https://dspy.ai/learn/programming/7-assertions/?utm_source=chatgpt.com)

4. Treat project analysis as **RAG** and leverage DSPy’s retrieval utilities
    Summarize the repo with a retriever (e.g., ColBERTv2/Pinecone/AzureCognitiveSearch or a custom retriever) and feed those passages into your ranker. DSPy tutorials show how to set up a retriever and optimize a RAG module. [dspy.ai+1](https://dspy.ai/tutorials/rag/?utm_source=chatgpt.com)

5. Compose small **Signatures + Modules** instead of one giant prompt
    Use Signatures for (a) “ProjectContext” (inputs: file snippets), (b) “PromptSynopsis” (summarize each candidate prompt), and (c) “ReRank” (score top-k). Then wire them with `Predict`/`ChainOfThought`. This is idiomatic DSPy. [dspy.ai+1](https://dspy.ai/learn/programming/signatures/?utm_source=chatgpt.com)

6. Add a **two-stage ranker**: lexical/embedding pre-rank → LM re-rank
    First stage: BM25/embeddings to shortlist candidates; second stage: a DSPy module that scores with project context + query; let an optimizer refine that module. This mirrors DSPy’s pattern of “program + optimizer + metric.” [dspy.ai](https://dspy.ai/learn/optimization/optimizers/?utm_source=chatgpt.com)

7. **Bootstrap training data** for the optimizer
    Even a tiny set of (query, project blurb, best\_prompt) examples helps. BootstrapFewShot can generate/curate demos to seed the program and improve with rounds. [dspy.ai](https://dspy.ai/api/optimizers/BootstrapFewShot/?utm_source=chatgpt.com)

8. Plan for **saving/loading** and cost/latency monitoring
    DSPy tutorials cover saving/loading optimized programs and keeping an eye on cost—useful once your ranker stabilizes. [dspy.ai](https://dspy.ai/tutorials/rag/?utm_source=chatgpt.com)

9. Keep the mantra: **Programming, not prompting**
    Encode I/O (filesystem scans, globbing, thresholding) in Python; use the LM only for summarization/scoring. That’s the core DSPy philosophy. [dspy.ai](https://dspy.ai/?utm_source=chatgpt.com)

If you apply the items above, you’ll get a robust, testable pipeline where DSPy improves the **reasoning** parts (synopses, scoring, re-ranking) while your Python does the **work** (scan repo, collect prompts, threshold, table formatting).

---
