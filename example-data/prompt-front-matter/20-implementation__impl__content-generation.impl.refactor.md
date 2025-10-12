# Content Generation

## Metadata

- identifier: content-generation
- category: documentation
- category: marketing
- category: blog
- lifecycle-stage: implementation
- dependencies: [readme, changelog]
- provided-artifacts: [markdown-docs, frontmatter, section-headings]
- summary: Draft documentation, blog posts, or marketing copy aligned with codebase to achieve consistent, on-brand content.

## Inputs

- source-repo-readme
- recent-changelog-or-commits

## Canonical taxonomy (exact strings)

documentation
marketing
blog
implementation
generation
analysis
deployment

### Stage hints (for inference)

- implementation → steps involving proposal and generation after input reading
- generation → output creation from structure or outline
- analysis → reading inputs, parsing changes
- deployment → final delivery of artifacts

## Algorithm

1. Extract signals from $1  
   * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.

2. Determine the primary identifier  
   * Prefer explicit input; otherwise infer from main action + object.  
   * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
   * De-duplicate.

3. Determine categories  
   * Prefer explicit input; otherwise infer from verbs/headings vs $5.  
   * Validate, sort deterministically, and de-dupe (≤3).

4. Determine lifecycle/stage (optional)  
   * Prefer explicit input; otherwise map categories via $6.  
   * Omit if uncertain.

5. Determine dependencies (optional)  
   * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).

6. Determine provided artifacts (optional)  
   * Short list (≤3) of unlocked outputs.

7. Compose summary  
   * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”

8. Produce metadata in the requested format  
   * Default to a human-readable serialization; honor any requested alternative.

9. Reconcile if input already contains metadata  
   * Merge: explicit inputs > existing > inferred.  
   * Validate lists; move unknowns to an extension field if needed.  
   * Remove empty keys.

## Assumptions & Constraints

- Emit exactly one document: metadata, a single blank line, then $1.
- Limit distinct placeholders to ≤ 7.

## Validation

- Identifier matches a normalized id pattern.
- Categories non-empty and drawn from $5 (≤3).
- Stage, if present, is one of the allowed stages implied by $6.
- Dependencies, if present, are id-shaped (≤5).
- Summary ≤120 chars; punctuation coherent.
- Body text $1 is not altered.

## Output format examples

- identifier: content-generation  
- category: documentation  
- category: marketing  
- category: blog  
- lifecycle-stage: implementation  
- dependencies: [readme, changelog]  
- provided-artifacts: [markdown-docs, frontmatter, section-headings]  
- summary: Draft documentation, blog posts, or marketing copy aligned with codebase to achieve consistent, on-brand content.

---

# Content Generation

Trigger: /content-generation

Purpose: Draft docs, blog posts, or marketing copy aligned with the codebase.

## Steps

1. Read repo README and recent CHANGELOG or commits.
2. Propose outlines for docs and posts.
3. Generate content with code snippets and usage examples.

## Output format

- Markdown files with frontmatter and section headings.
