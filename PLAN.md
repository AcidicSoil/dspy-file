Goal
----
Deliver a robust DSPy file analyzer CLI that works seamlessly with LM Studio by
clarifying provider selection, insulating against API quirks, and validating
the request/response flow end-to-end.

User Story
----------
As a practitioner running `dspyteach`, I want to analyze files with LM Studio
without encountering provider mapping surprises or HTTP 4xx errors so that I
can generate teaching and refactor reports reliably.

Milestones
----------
1. Provider interaction hardened.
2. LM Studio request pipeline validated.
3. Regression coverage expanded.

Tasks
-----
- [ ] [@codex|3h] Rework provider prompts to cache the choice per session,
      ensuring no repeated blocking (`dspy_file/analyze_file_cli.py`).
- [ ] [@codex|4h] Implement LM Studio-specific request adapter that enforces
      `application/json` headers and logs 4xx bodies (`dspy_file/analyze_file_cli.py`,
      `dspy_file/file_helpers.py`).
- [ ] [@codex|2h] Add smoke tests covering LM Studio success and failure cases
      using stubbed responses (`tests/smoke_test.py`).
- [ ] [@codex|1h] Document LM Studio setup and troubleshooting in README
      (`README.md`).

Won't do
--------
- Auto-detecting LM Studio based on API base heuristics.
- Adding support for additional providers outside Ollama/OpenAI/LM Studio.

Ideas for later
---------------
- Persist provider + suffix preferences in a config file for reuse.
- Integrate structured logging for analyzer runs.

Validation
----------
- Run `pytest tests/smoke_test.py -q`.
- Manually invoke `dspyteach` against a local LM Studio instance to confirm
  JSON header handling and prompt flow.

Risks
-----
- LM Studio API surface may change without notice; adapter must degrade
  gracefully.
- Increased prompting could annoy non-interactive users if caching fails.

