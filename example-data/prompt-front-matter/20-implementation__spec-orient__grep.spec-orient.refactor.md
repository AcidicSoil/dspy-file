# Recursive Text Search with ripgrep/grep Injection

## Inputs
- Input text to search for (e.g., `HttpClient`)
- Target directory (default: current project root)

## Canonical taxonomy (exact strings)
- search
- analysis
- insight
- debugging
- documentation
- configuration
- automation

### Stage hints (for inference)
- search → investigation or debugging
- analysis → analysis or insight generation
- insight → synthesis or reporting

## Algorithm
1. Extract signals from the prompt  
   *Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.*

2. Determine the primary identifier  
   *Prefer explicit input; otherwise infer from main action + object.*  
   Normalized to: `recursive-text-search`

3. Determine categories  
   *Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.*  
   Selected: search, analysis, insight

4. Determine lifecycle/stage (optional)  
   *Map via stage hints:* "search" → debugging; "analysis" → investigation; final inferred stage: debugging

5. Determine dependencies (optional)  
   *CLI tools required: ripgrep or grep, file system access.*  
   Identified: `rg`, `grep`

6. Determine provided artifacts (optional)  
   *Synthesized outputs from evidence:*  
   - Usage cluster in a code directory  
   - Note on inconsistent error handling

7. Compose summary  
   "Do recursive text search with ripgrep/grep injection to achieve insight into usage clusters and inconsistent error handling."

8. Produce metadata in the requested format  
   - Identifier: `recursive-text-search`  
   - Categories: `search`, `analysis`, `insight`  
   - Stage: `debugging`  
   - Dependencies: `rg`, `grep`  
   - Artifacts: `usage-cluster`, `error-handling-note`  
   - Summary: "Do recursive text search with ripgrep/grep injection to achieve insight into usage clusters and inconsistent error handling."

9. Reconcile if input already contains metadata  
   *No explicit metadata present; inferred values used.*

## Assumptions & Constraints
- Output must contain exactly one document: metadata block, blank line, then original body.
- Limit distinct placeholders to ≤7.
- Body text remains unaltered.

## Validation
- Identifier matches normalized pattern (kebab-case, lowercase).
- Categories are non-empty and drawn from canonical taxonomy (≤3).
- Stage (`debugging`) is implied by stage hints.
- Dependencies are id-shaped and relevant.
- Artifacts are concise and derived from output examples.
- Summary ≤120 chars; punctuation coherent.

## Output format examples
- Identifier: `recursive-text-search`
- Categories: `search`, `analysis`, `insight`
- Stage: `debugging`
- Dependencies: `rg`, `grep`
- Artifacts: `usage-cluster`, `error-handling-note`
- Summary: "Do recursive text search with ripgrep/grep injection to achieve insight into usage clusters and inconsistent error handling."
