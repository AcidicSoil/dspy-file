```md
#1
[Directive]
Goal: Convert a concrete Markdown doc into a reusable prompt template that preserves structure and replaces instance-specific content with numbered placeholders.

Inputs
- $1 = full source Markdown content (paste file text)
- $2 = command name to target (e.g., problem-analyzer) [optional]
- $3 = max placeholders to allocate (1–9; default 7) [optional]
- $4 = fallback skeleton ("problem-analyzer" | "planner" | "summary" | "auto") [optional; default "auto"]

Instructions
1) Parse $1. Keep section hierarchy (headings, lists, code-block fences, callouts). Do NOT copy any concrete facts, sentences, or values from $1.
2) Identify variable fields (titles, summaries, reasons, paths, code blocks, parameters, dates, IDs, lists of items, acceptance criteria). Collapse each into a placeholder token.
3) Allocate ≤$3 placeholders named by purpose in a header comment map, then use the literal tokens $1..$N inside the body to mark where user input will go. Combine fine-grained fields if >$3 are needed.
4) If $1 lacks clear sections, infer intent and produce a minimal skeleton. If still ambiguous, use the fallback skeleton in $4.
5) Output only the template. No narration.

Format
- Begin with an HTML comment mapping: `<!-- $1=..., $2=..., ... -->`
- Optional H1: `# {$2 or inferred command}`
- Body: original structure with leaf content replaced by $1..$N.
- End with a sentinel line: `DON'T CODE YET.` if analysis/plan oriented.

Acceptance
- ≤ one screen of header comments.
- Uses literal `$1..$N` tokens (verbatim).
- Zero leakage of concrete content from the source.

Produce the template now.
```

```md
#2
[Spec]
Objective: Templatize a user’s Markdown into a reusable Codex CLI prompt with numbered placeholders.

Inputs
- $1: Source Markdown text.
- $2: Desired prompt/command name (string) [optional].
- $3: Cap on placeholders (1–9, default 7) [optional].

Process
A) Structure detection
- Preserve headings and list scaffolding exactly; drop filled content.
- Treat code fences as variable blocks unless they are instructions (keep language tag, replace body with a placeholder).
- Detect common sections (Problem, Context, Tasks, Output format, Constraints, Acceptance criteria).

B) Placeholder planning
- Build a concise map at top: `<!-- $1=problem, $2=context, $3=tasks, ... -->`
- Reuse placeholders across repeated slots if semantically identical (e.g., same “problem” repeated).
- If more than $3 fields, coalesce into list-style placeholders: one for “items”, one for “steps”, one for “evidence”.

C) Output rules
- Emit only the template Markdown.
- Use literal `$1..$N` in the body; never curly braces or named variables.
- If the source suggests an analysis workflow but lacks “Output format,” synthesize a sane default block with placeholders:
  - Affected files → $X
  - Root cause → $Y
  - Proposed fix → $Z
  - Tests → $W
  - Documentation gaps → $V
  - Open questions → $U
- Append `DON'T CODE YET.` if the genre is planning/analysis.

Deliverable
A single Markdown template suitable for saving to `~/.codex/prompts/{$2 or inferred}.md`.
```

```md
#3
[QA-Ready]
Task: From the given Markdown ($1), output a reusable prompt template that:
- Mirrors the section/layout structure.
- Replaces every instance-specific span with numbered placeholders `$1..$N` (verbatim).
- Includes a top comment mapping of placeholder semantics.
- Introduces missing, commonly expected sections when context implies them (e.g., analysis → Affected files, Root cause, Proposed fix, Tests, Docs gaps, Open questions).
- Contains no copied facts from $1.

Inputs
- $1 = source Markdown text
- $2 = template name to embed (optional; defaults to inferred genre)
- $3 = maximum placeholders (1–9; default 7)

Algorithm
1) Classify genre (analysis/planning/summary/how-to/other) from headings + verbs.
2) Extract candidate fields (title, summary, bullets, code, paths, IDs, dates, metrics). Rank by importance; cap to $3.
3) Emit:
   <!-- $1=..., $2=..., ... -->
   # {$2 or Inferred Name}
   (preserved headings/lists with leaves replaced by $1..$N)
   Optional “Output format” block if genre=analysis or planning.
4) Validation pass: ensure ≤$3 placeholders, no verbatim sentences from input, and literal `$` tokens remain.

Output only the final template Markdown.
```
