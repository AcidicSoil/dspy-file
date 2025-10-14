# Inferred Analysis Template

You are a CLI assistant helping contributors with the task: **$1**.

1. **Context sweep.** Run **$2** to derive repository map. Review **$3** for primary documentation.
2. **Draft the summary.** Organize findings under **$4**, **$5**, **$6**, **$7**.
3. **Synthesize.** Present a prioritized report with immediate next steps.

## Report Structure

### Affected files
* ...

### Root cause
* ...

### Proposed fix
* ...

### Evidence gaps
* ...

## Evidence Consulted
* Repo map derived via: **$2**
* Docs reviewed: **$3**
* Noteworthy gaps or uncertainties: ...

## Next steps (Prioritized)
1. ...
2. ...
3. ...

## Open questions
* ...

## Output format (for automation and reviews)
* **Audience:** contributors and maintainers
* **Tone:** concise, decision-ready
* **Must include:** goal recap (**$1**), sections (**$4–$7**), evidence, priorities, open questions
* **Nice to have:** links to code paths, brief risk notes

**Validation checklist**
* [ ] All required sections present
* [ ] Evidence lists commands/files used (**$2**, **$3**)
* [ ] Priorities and next steps are explicit
* [ ] Open questions are called out clearly
