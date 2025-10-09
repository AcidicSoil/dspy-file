@interactive_generate_llms_py_dynamic_names_owner_repo_dirs.py  @docs/
Use the model config like the one shown in @interactive_generate_llms_py_dynamic_names_owner_repo_dirs.py
look at my personal dspy config in tutorials and then read through the tutorials and other relevant files to accomplish the following:

```
[Spec]
Create a DSPy task template named “{task_name}”.

Goal
- Apply {operation} to files.

Parameters
- Paths: {repo_root}, {destination}
- Patterns: {file_globs[]}, {exclude_globs[]}
- Behavior: {dry_run}, {backup}, {concurrency:int}, {max_files:int}, {retry:int}, {allow_network:bool}
- Contract: input {mime_types|schema}, output {schema}, invariants {invariants}

Algorithm
A) Enumerate matching files with locale-stable sort.
B) Validate each input against {schema}.
C) Transform using {operation}.
D) Write atomically (temp file then rename).
E) On error, record {error_code, message, file} and continue.

Reporting
- Emit {run_report.json} and {ndjson_log} with ISO-8601 timestamps and checksums.

Non-goals
- Interactive prompts. No network I/O unless {allow_network}=true.

Edge cases
- Empty matches, unreadable files, malformed content, size > {size_limit_mb}, binary vs text detection.

Done when
- Outputs exist, checksums recorded, and {acceptance_criteria} pass.

Deliverable
- Reusable DSPy template with parameterized entrypoint {format?} and examples for {inputs}->{outputs}.

```
