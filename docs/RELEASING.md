---
title: "Releasing dspyteach"
description: "Checklist for packaging, verifying, and publishing new dspyteach builds to PyPI and TestPyPI."
---

# Releasing dspyteach

This guide captures the maintainer workflow for packaging and publishing new versions of `dspyteach`.

## Package & Publish

```bash
# (optional) bump the version before you publish
uv version --bump patch

# build the source distribution and wheel; artifacts land in dist/
uv build --no-sources

# publish to PyPI (or TestPyPI) once you have an API token
UV_PUBLISH_TOKEN=... uv publish
```

Expected result: `dist/` contains both a wheel and sdist stamped with the new version, and `uv publish` completes without error.

To install the package from a freshly built artifact:

```bash
pip install dist/dspyteach-<version>-py3-none-any.whl
```

Once the project is on PyPI, users can install it directly:

```bash
pip install dspyteach
```

The `dspyteach` console script (plus the legacy `dspy-file-teaching` alias) will be available after installation.

<Check>Importing `dspyteach` and running `dspyteach --help` should show the CLI version you just published.</Check>

## CI Publishing

GitHub Actions workflows can automate publishing to TestPyPI. The repo ships with `.github/workflows/publish-testpypi.yml`, which:

1. Checks out the repository (ensuring `pyproject.toml` is present as required by `uv publish`).
2. Installs `uv` with Python 3.12.
3. Runs `uv build --no-sources` from the repository root.
4. Publishes with `uv publish --index testpypi dist/*` using the `TEST_PYPI_TOKEN` secret.

Review the [uv publishing guide](https://docs.astral.sh/uv/guides/package/#publishing-your-package) for official details about required files and authentication.
