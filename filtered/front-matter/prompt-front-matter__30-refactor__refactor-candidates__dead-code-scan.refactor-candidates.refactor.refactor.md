```md
# Dead Code Scan

## Metadata

1. **identifier**: dead-code-scan
2. **categories**: 
   - code analysis
   - static scanning
   - dead code detection
3. **lifecycle stage**: pre-analysis
4. **dependencies**: 
   - rg (ripgrep)
5. **provided artifacts**: 
   - structured report
   - list of candidate files and exports
6. **summary**: Do scan for dead code to identify unused files and exports via static signals.

## Inputs

7. Command: `/dead-code-scan`
8. No explicit input required; runs without arguments.
9. Context: file reference graph via `rg` search.

## Canonical taxonomy (exact strings)

10. - code analysis
    - static scanning
    - dead code detection

### Stage hints (for inference)

11. - pre-analysis → scan, inspect, gather evidence
    - inspection → analyze codebase for patterns
    - post-analysis → review and recommend removals

## Algorithm

12. 1. Extract signals from $1  
      * Titles/headings, imperative verbs, intent sentences, explicit tags, and dependency phrasing.*

13. 2. Determine the primary identifier  
      * Prefer explicit input; otherwise infer from main action + object.  
      * Normalize (lowercase, kebab-case, length-capped, starts with a letter).  
      * De-duplicate.*

14. 3. Determine categories  
      * Prefer explicit input; otherwise infer from verbs/headings vs canonical taxonomy.  
      * Validate, sort deterministically, and de-dupe (≤3).*

15. 4. Determine lifecycle/stage (optional)  
      * Prefer explicit input; otherwise map categories via stage hints.  
      * Omit if uncertain.*

16. 5. Determine dependencies (optional)  
      * Parse phrases implying order or prerequisites; keep id-shaped items (≤5).*

17. 6. Determine provided artifacts (optional)  
      * Short list (≤3) of unlocked outputs.*

18. 7. Compose summary  
      * One sentence (≤120 chars): “Do <verb> <object> to achieve <outcome>.”*

19. 8. Produce metadata in the requested format  
      * Default to a human-readable serialization; honor any requested alternative.*

20. 9. Reconcile if input already contains metadata  
      * Merge: explicit inputs > existing > inferred.  
      * Validate lists; move unknowns to an extension field if needed.  
      * Remove empty keys.*

## Assumptions & Constraints

21. - Emit exactly one document: metadata, a single blank line, then $1.
22. - Limit distinct placeholders to ≤7.

## Validation

23. - Identifier matches a normalized id pattern (kebab-case, lowercase).
24. - Categories non-empty and drawn from canonical taxonomy (≤3).
25. - Stage, if present, is one of the allowed stages implied by stage hints.
26. - Dependencies, if present, are id-shaped (≤5).
27. - Summary ≤120 chars; punctuation coherent.
28. - Body text $1 is not altered.

## Output format examples

29. - Example Input:  
    (none – command runs without arguments)

30. - Expected Output:  
    - Structured report following the specified sections.
```
