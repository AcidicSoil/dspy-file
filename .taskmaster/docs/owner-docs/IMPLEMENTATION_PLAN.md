Implementation Plan
===================
1. Inspect current CLI and helper modules to identify integration points for mode handling.
2. Create a new refactor analyzer module that loads the refactor prompt template and exposes a DSPy module for template generation.
3. Update the CLI and helper utilities to accept a --mode flag, select the appropriate analyzer, render predictions, and adjust output naming.
4. Export the new analyzer, ensure the template ships with the package, and refresh documentation/tests where possible.
5. Validate with available tests or dry runs and prepare a summary of the changes.
