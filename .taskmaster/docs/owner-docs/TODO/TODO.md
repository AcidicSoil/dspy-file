# TODO

## **TUI TO-DO'S**

* (todo)TUI for easy prompt selection picker etc... and many other useful functions

  * -v | verbose: output config specs that model loaded with

  * Iterate on templates of choice that were previously generated for mass iteratation variations
// TODO *(todo) see below for description

"""
Here’s what I want to build:

* **Unify your DSPy tools behind one CLI using Typer.** Keep typed options, map your `Provider` / `AnalysisMode` enums directly, and use env-var fallbacks for flags so existing `DSPYTEACH_*` config still works. Typer is a CLI framework (powered by Click) that supports this pattern cleanly. ([typer.tiangolo.com][1])
* **Expose subcommands:** `analyze` (current), plus future enhancements like `rank-prompts`, `sequence` (later), and a new `ui` command that launches the terminal interface.
* **Replace ad-hoc `input()` prompts** with Typer options/prompts while keeping pretty output via Rich. (Rich handles styled text, tables, progress, markdown.) ([rich.readthedocs.io][2])
* **Add a full-screen TUI with Textual** (launched from `ui`) that matches Codex/Gemini CLI flow:

  * Big banner/header + tips panel; centered prompt line with history.
  * Footer/status bar showing provider/model/API base and live updates.
  * Keybindings/help (`?`), a command palette for actions like `/model` and `/status`.
  * Progress indicators and toast-style notifications for long tasks.
    Textual is a Python TUI framework (built by Textualize, integrates with Rich) suited for this layout. ([Textual Documentation][3])
* **Preserve your provider setup** (Ollama / LM Studio / OpenAI) and current env handling under both the CLI and TUI.

[1]: https://typer.tiangolo.com/?utm_source=chatgpt.com "Typer"
[2]: https://rich.readthedocs.io/en/latest/introduction.html?utm_source=chatgpt.com "Introduction — Rich 14.1.0 documentation"
[3]: https://textual.textualize.io/?utm_source=chatgpt.com "Textual"
"""

// TODO * (tui-ui)Option for users to inject /nothink for qwen3 models

// TODO * (tui-ui)Add a percentage of progress during inferences so users can see how much longer is left on the job.

---

### TODOS

// TODO * (todo)Gather llm provider model options from their respective docs to further fine-tune the jobs by tweaking model parameters.

// TODO * (feature)Analyze and research bug fixes for errors (using web searching functionality from top rated sites docs etc...)

// TODO * (improved idea)Setup analysis signatures for codefetch files and increment inferences on each in by code fences, so file by file.

// TODO * (feature)Setup codex-5 bridge to use as provider i.e., have gpt-5-codex as an option for users similiar to how task-master-ai has the options for gpt-5-codex, gemini-cli, and others

---

// TODO * (todo) have checks for user workspace to detect if on WSL trying to call lm-studio on windows host, then prompts users with warning to enable toggle and configures BASE_URL to correct address. This can be optional, just in case users have custom workspaces where this might not be viable with a simple replacement of the ip address retrieved in a scan tool. y/n | if no , then do nothing else scan local ip and change base url accordingly.

---

// TODO *(todo) turn the fullstackCrawl repo into a tutorial variant of describing/teaching/guidance for fullstack app requests of all kinds. Mimic the approach of the systematic approach of building. Example., (instead of using the tech stack mentioned): Use the target tech stack and replace all parts until it fits the target tech stack. If user wants a refactor or gemini-cli folder structure like variant then it would create the same fullstack course contents but curated into the users requested, which would be a mimic of the gemini-cli repo style. It would replace all parts until it was a teaching guide to complete the users request. This user could view this from a web-browser in the same layout via its course contents, giving the user and ai/agents instructions on their task/goals etc... until app/goal completion.

---

// TODO *(todo) Read "./.taskmaster/docs/owner-docs/TODO/TODO-rank-root-prompt-module" for TODO instructions.

// TODO *(todo) turn the ~/.codex/prompts/*.md (just the prompt) into a dataset then use dspy features to integrate into dspyteach cleanly

---
