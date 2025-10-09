# Teaching Brief: `analyze_file_cli.py` - Code Analysis with DSPy

## Context & Purpose

This command-line tool (`/home/user/projects/archive/dspy-file/dspy_file/analyze_file_cli.py`) enables educators and developers to generate human-readable teaching materials from source code using DSPy's language model framework. Designed specifically for pedagogical use cases, it transforms technical code into structured learning content while prioritizing user safety through interactive confirmation steps - a critical pattern when analyzing sensitive or production systems.

## Overview

The script implements a clean separation of concerns: input handling via `argparse`, path resolution with recursive scanning capabilities, model integration using local Ollama servers, and output management for de-duplicated Markdown reports. Its workflow begins by resolving file paths through helper functions like `collect_source_paths`, then passes each target to the `FileTeachingAnalyzer` class which generates structured teaching content via DSPy's language modeling pipeline. Crucially, it includes an interactive confirmation step (`_confirm_analyze`) before processing any files - a safeguard against accidental analysis of confidential codebases or large repositories.

## Key Concepts

- **Pedagogical Code Analysis**: The script transforms code structure into teachable concepts using DSPy's framework for generating human-understandable explanations from technical artifacts.
- **Local Model Integration**: Ollama provides lightweight, secure model inference without cloud dependencies - ideal for classroom environments with restricted internet access.
- **Path Safety Patterns**: Special character handling in filenames prevents output corruption through systematic sanitization (e.g., converting slashes to underscores).
- **User-Centric Design**: Mandatory confirmation prompts respect ethical boundaries when analyzing potentially sensitive code, aligning with responsible AI practices.

## Practical Workflows

1. Analyze a single Python file: `python analyze_file_cli.py path/to/file.py`
2. Process recursive files while excluding subdirectories: `--non-recursive` flag
3. Target specific file types using glob patterns (e.g., `--glob '*.py'`)
4. Generate raw model outputs for debugging with the `--raw` option
5. Customize output storage via `--output-dir /custom/path`
6. Enable interactive confirmation for each file through `--interactive`

## Critical Pitfalls to Avoid

- **Ollama dependency failures**: Always verify Ollama server is running at `http://localhost:11434` before execution
- **Path corruption risks**: Special characters in paths (e.g., spaces, slashes) can break de-duplication logic - use sanitization functions
- **Resource leaks**: Forgetting to stop the Ollama model after analysis wastes server resources and may cause connection errors
- **Overly broad patterns**: Glob expressions like `*` should be restricted to specific file types (e.g., `.py`) to prevent unintended processing

## Integration Requirements

This tool requires:

1. A running Ollama server at default port 11434
2. Python environment with DSPy installed (`pip install dspy`)
3. Write permissions in the specified output directory
4. Proper model configuration through DSPy's `configure` method pointing to local Ollama

## Testing Focus Areas

Instructors should validate:

- Ollama connection stability before analysis begins
- Filename sanitization for edge cases (e.g., paths with `/`, spaces)
- Confirmation prompts working correctly across different input responses
- Error handling during file access, encoding issues, and permission failures
- Model cleanup procedures even when exceptions occur

## References

1. [DSPy Documentation](https://dspy.readthedocs.io/en/latest/)
2. [Ollama Installation Guide](https://ollama.com/download)
3. DSPy File Analysis Examples: [GitHub Repository](https://github.com/dspylab/dspy/blob/main/examples/file_analyzer.py)

---

This teaching brief provides instructors with actionable knowledge to safely implement code analysis tools while emphasizing ethical AI practices and system reliability - critical considerations for modern programming education.
