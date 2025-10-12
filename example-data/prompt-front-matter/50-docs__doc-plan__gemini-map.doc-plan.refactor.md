# Gemini→Codex Mapper

Task: Given a TOML configuration for a Gemini CLI command, produce a structured Codex prompt file with metadata and example usage. The output must be ready to run via bash.

## Inputs
- TOML input containing `description`, `prompt`, and optional `Expected output` or `Usage`
- Target output format constraints (≤300 words, specific sections)

## Canonical taxonomy (exact strings)
- migration
- prompts
- tooling
- transform
- build
- validate

### Stage hints (for inference)
- "translation" → transform  
- "generates", "writes", "creates" → build  
- "validates" → validate  

## Algorithm
1. Extract signals from TOML:
   - Description and prompt define intent.
   - Expected output defines structure of result.

2. Determine the primary identifier:
   - Prefer explicit input; otherwise infer from main action + object.
   - Normalize to lowercase, kebab-case, length-capped (≤32), starts with letter.
   - Result: `gemini-map`

3. Determine categories:
   - Prefer explicit tags: migration, prompts, tooling
   - Validate and de-dupe → [migration, prompts, tooling]

4. Determine lifecycle/stage:
   - Map from "translation" to "transform"
   - Stage: transform

5. Determine dependencies:
   - No prerequisites mentioned.
   - Dependencies: []

6. Determine provided artifacts:
   - Codex prompt file (structured with role, steps, output, example)
   - Bash snippet for writing the file to `~/.codex/prompts/<filename>.md`

7. Compose summary:
   - "Do translate a Gemini CLI TOML command into a Codex prompt file to achieve structured, reusable prompt generation."

8. Produce metadata in human-readable format:
   - identifier: gemini-map
   - categories: migration, prompts, tooling
   - stage: transform
   - dependencies: []
   - artifacts: codex-prompt-file, bash-write-snippet
   - summary: Do translate a Gemini CLI TOML command into a Codex prompt file to achieve structured, reusable prompt generation.

9. Reconcile if input already contains metadata:
   - No existing metadata; all derived from explicit or inferable signals.

## Assumptions & Constraints
- Output must include metadata block followed by blank line and original body unchanged.
- All identifiers normalized and within constraints.
- Categories strictly from canonical taxonomy.
- Stage inferred via stage hints only if not explicit.
- Artifacts are short-listed (≤3).
- Summary ≤120 characters.

## Validation
- Identifier: `gemini-map` → valid kebab-case, lowercase.
- Categories: [migration, prompts, tooling] → all in taxonomy, non-empty, de-duplicated.
- Stage: transform → valid and implied by translation workflow.
- Dependencies: empty list → valid.
- Artifacts: codex-prompt-file, bash-write-snippet → both valid and ≤3.
- Summary: 108 characters; coherent and punctuated correctly.

## Output format examples
```markdown
# Gemini→Codex Mapper

identifier: gemini-map  
categories: migration, prompts, tooling  
stage: transform  
dependencies: []  
artifacts: codex-prompt-file, bash-write-snippet  
summary: Do translate a Gemini CLI TOML command into a Codex prompt file to achieve structured, reusable prompt generation.

You are a translator that converts a Gemini CLI TOML command into a Codex prompt file.

Steps:

1) Read TOML with `description` and `prompt`.
2) Extract the task, inputs, and outputs implied by the TOML.
3) Write a Codex prompt file ≤ 300 words:

    - Role line `You are ...`
    - Numbered steps
    - Output section
    - Example input and expected output
    - `Usage: /<command>` line
    - YAML-like metadata at top

4) Choose a short, hyphenated filename ≤ 32 chars.
5) Emit a ready-to-run bash snippet:
`cat > ~/.codex/prompts/<filename>.md << 'EOF'` … `EOF`.
6) Do not include destructive commands or secrets.

Example input:

```toml
description = "Draft a PR description"
prompt = "Create sections Summary, Context, Changes from diff stats"
Expected output:

A pr-desc.md file with the structure above and a bash cat > block.

Usage: /gemini-map
```
```
