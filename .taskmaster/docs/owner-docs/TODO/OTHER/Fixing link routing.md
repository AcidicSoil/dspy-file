# Fixing link routing

```md
Use an absolute URL—PyPI doesn’t resolve relative repo paths.
In your README, replace the relative link with a full GitHub link to that folder.

**Change this**

    [[example-data after running a few passes](example-data/)]

**to this (adjust owner/repo/branch if needed)**

    [example-data after running a few passes](https://github.com/AcidicSoil/dspy-file/tree/main/example-data)

Tip: for images/files, use `https://raw.githubusercontent.com/<owner>/<repo>/<branch>/<path>`; and you can also add a “Examples” entry under `project_urls` in `pyproject.toml` so it shows up in the PyPI sidebar.
```

---

## Original Users Query

how can i setup a way that if a user is using an older version, they will be prompted for an option to upgrade? Or is that done automatically?

---

## Agents response

Short answer: Python packages don’t auto-update. If you want users to be prompted, you need to add that logic (ideally in your CLI, not at import time).

Here’s a clean, low-friction pattern I recommend:

* Check the latest version on PyPI (via the JSON API).

* Compare with the installed version using `packaging.version`.

* Only prompt when running interactively (CLI) and at most once per day (simple cache file).

* Offer to run `pip install -U dspyteach` for them; otherwise print the command.

* Allow users/orgs to disable with an env var (e.g., `DSPYTEACH_NO_UPDATE_CHECK=1`).

### path: dspyteach/upgrade_check.py

```python
    from **future** import annotations

    import json
    import os
    import sys
    import time
    import subprocess
    import urllib.request
    from importlib import metadata
    from pathlib import Path
    from typing import Optional

    from packaging.version import Version, InvalidVersion

    PACKAGE = "dspyteach"
    ENV_DISABLE = "DSPYTEACH_NO_UPDATE_CHECK"
    CACHE_TTL_SECONDS = 24 *60* 60  # once per day
    CACHE_FILE = Path(os.path.expanduser("~")) / ".cache" / PACKAGE / "latest.json"
    PYPI_JSON = f"<https://pypi.org/pypi/{PACKAGE}/json>"

    def _current_version() -> Optional[Version]:
        try:
            return Version(metadata.version(PACKAGE))
        except metadata.PackageNotFoundError:
            return None
        except InvalidVersion:
            return None

    def _cached_latest() -> Optional[Version]:
        try:
            if not CACHE_FILE.exists():
                return None
            if time.time() - CACHE_FILE.stat().st_mtime > CACHE_TTL_SECONDS:
                return None
            data = json.loads(CACHE_FILE.read_text())
            return Version(data.get("latest", ""))
        except Exception:
            return None

    def _fetch_latest(timeout: float = 1.5) -> Optional[Version]:
        try:
            with urllib.request.urlopen(PYPI_JSON, timeout=timeout) as r:
                info = json.load[r]("info")
            latest = info["version"]
            # write cache
            CACHE_FILE.parent.mkdir(parents=True, exist_ok=True)
            CACHE_FILE.write_text(json.dumps({"latest": latest}))
            return Version(latest)
        except Exception:
            return None

    def _get_latest_version() -> Optional[Version]:
        return_cached_latest() or_fetch_latest()

    def maybe_prompt_upgrade(auto: bool = False) -> None:
        """
        Call this from your CLI entrypoint before running the command.
        - Respects ENV_DISABLE
        - Prompts only if interactive (stdin is a TTY)
        - If auto=True and running non-interactively, just print a notice (no prompt)
        """
        if os.getenv(ENV_DISABLE):
            return

        cur = _current_version()
        if cur is None:
            return

        latest = _get_latest_version()
        if latest is None:
            return

        if latest <= cur:
            return  # already up-to-date

        msg = (
            f"A newer {PACKAGE} is available: {cur} → {latest}.\n"
            f"Upgrade with: {sys.executable} -m pip install -U {PACKAGE}\n"
        )

        # Non-interactive: just inform (if auto=True), no prompt.
        if not sys.stdin.isatty():
            if auto:
                print(msg, file=sys.stderr)
            return

        # Interactive prompt
        reply = input(
            f"{msg}Would you like me to run the upgrade now? [Y/n] "
        ).strip().lower()

        if reply in ("", "y", "yes"):
            try:
                subprocess.check_call(
                    [sys.executable, "-m", "pip", "install", "-U", PACKAGE]
                )
                print("Upgrade complete.", file=sys.stderr)
            except subprocess.CalledProcessError:
                print("Upgrade failed. You can run the command manually.", file=sys.stderr)
```

## Hook it into your CLI

### path: dspyteach/cli.py

```python
    from __future__ import annotations
    import argparse
    from .upgrade_check import maybe_prompt_upgrade

    def main() -> None:
        parser = argparse.ArgumentParser("dspyteach")
        parser.add_argument("--no-update-check", action="store_true",
                            help="Skip checking for a newer version.")
        args = parser.parse_args()

        if not args.no_update_check:
            maybe_prompt_upgrade(auto=True)  # prints notice if non-interactive

        # ...rest of your CLI
```

Expose the CLI via `pyproject.toml`:

### path: pyproject.toml

```toml
[project.scripts]
dspyteach = "dspyteach.cli:main"
```

Notes:

* Don’t perform network calls at import time inside the library—keep checks in the CLI or an explicit `--check-upgrade` command to avoid surprising users and slowing notebooks.

* Provide an opt-out (`DSPYTEACH_NO_UPDATE_CHECK=1` and `--no-update-check`).

* This does not “auto-update”; it prompts or prints instructions. That’s the norm for Python tools and keeps environments reproducible.

---
