# DSPy file analyzer CLI - command line entry point for DSPy file analysis

This tool analyzes a file using DSPy and generates a report or refactor template based on the selected mode.

To use this tool, provide the following parameters:

- $1: Path to the file to analyze
- $2: Provider (OLLAMA, LMSTUDIO, OPENAI)
- $3: Model name
- $4: API base URL
- $5: API key
- $6: Analysis mode (TEACH or REFACTOR)
- $7: Output directory

Example usage:
python analyze_file_cli.py $1 --provider $2 --model $3 --api-base $4 --api-key $5 --mode $6 --output-dir $7
