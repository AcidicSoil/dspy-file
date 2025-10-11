<!-- $1=Process name (e.g., "plan-delta") -->
<!-- $2=Delta input text -->
<!-- $3=Selection mode (Continue/Hybrid/Full) -->
<!-- $4=New objectives (list) -->
<!-- $5=Constraints (list) -->
<!-- $6=Artifact path template (e.g., "./artifacts/delta-YYYYMMDD-HHMMSS.md") -->
<!-- $7=Evidence log entry structure (source,date,summary,link) -->

**Process Template**

Trigger: $1

Purpose: Orchestrate mid-project planning deltas on an existing task graph with history preservation, lineage, and readiness recalculation.

Steps:

1. Discover repository context: detect tasks file path and latest plan doc.
2. Snapshot: create artifact directory and copy current tasks file to $6.
3. Input collection: read $2 and parse $3 mode.
4. Delta Doc generation: create $6 containing sections: Objectives ($4), Constraints ($5), Impacts, Decisions, Evidence.
5. Task graph update: never alter historical states; add `superseded_by` for replaced tasks; include new `source_doc` and `lineage`.
6. Graph maintenance: recompute dependencies and flag contradictions.
7. Readiness and selection: implement `ready/next()` to select tasks.
8. Outputs: write updated tasks file, persist Delta Doc, emit decision hooks.
9. Termination: stop when all deltas merged or prerequisite unresolved.

Required Artifacts:
- Updated tasks file (JSON)
- Delta document ($6)
- Readiness report (plain text)

Evidence Requirements:
- Each evidence entry must include $7 fields.

Output format:
- Produce three artifacts as specified above.
- Print decision hooks starting with `HOOK: <id> enables <capability>`.
