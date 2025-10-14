```md
# PRD Generator
Trigger: /prd-generate
Purpose: Produce a complete `prd.txt` in the exact section order, headers, and tone of the inline example PRD using only the repository README and visible link texts.
Steps:

<<<<<<< Updated upstream
1. Read `README.md` at repo root; do not fetch external links.
2. Extract: product name, problem, target users, value, scope, constraints, features, flows, integrations, data, non-functional needs, risks.
3. If links exist, include their visible text or titles only as contextual hints.
4. Fill gaps with conservative assumptions to keep the PRD complete; collect assumptions for the Appendix.
5. Enforce strict structure identical to the example PRD’s top-level headers and order.
6. For each core feature, include What, Why, High-level How, and Acceptance criteria.
7. In Technical Architecture, document optional platform-specific features and required fallbacks; mirror related risks.
8. In Development Roadmap, group by phases (MVP and later); include acceptance criteria; exclude timelines.
9. In Logical Dependency Chain, order from foundations to visible value; keep items atomic.
10. Run an internal consistency check: features appear in roadmap; risks reflect platform and data concerns; all sections non-empty.
11. Output only the final `prd.txt` content starting with `# Overview` and ending with `# Appendix`.
Output format:

- Plain text PRD starting with `# Overview` and ending with `# Appendix`.
- No preamble, no postscript, no meta commentary.
Notes:
- Reject generation if `README.md` is missing.
- Do not browse external sources.
- Derived from example_prd.txt, extracted summaries only; secrets redacted.
=======
Output a plain-text file named `prd.txt` containing **only** these sections in this order (separated by one blank line):
# Overview
# Core Features
# User Experience
# Technical Architecture
# Development Roadmap
# Logical Dependency Chain
# Risks and Mitigations
# Appendix

**Output Format**

- `# Overview`: $3
- `# Core Features`: Each includes *What*, *Why*, *High-level How*, and BDD criteria:
  `Given ...`
  `When ...`
  `Then ...`
- `# User Experience`: Personas, key flows, UI/UX, accessibility
- `# Technical Architecture`: Components, data models, APIs/integrations, infrastructure, NFRs
- `# Development Roadmap`: MVP and Future Enhancements with acceptance criteria (no dates)
- `# Logical Dependency Chain`: Work ordering for foundations, earliest front end, extensible units
- `# Risks and Mitigations`: Each includes *Description*, *Likelihood*, *Impact*, *Mitigation*
- `# Appendix`:
  • Assumptions (bulleted)
  • Research findings from $1
  • Context notes (`- <visible text> — inferred topic`)
  • Technical specs

**Validation Checks**

- Headers present and ordered
- All BDD criteria included for features/fallbacks
- Risks include likelihood and impact
- No URLs/secrets; exactly one blank line between sections
- $1 contains **only** visible link text (no external browsing)
>>>>>>> Stashed changes
```
