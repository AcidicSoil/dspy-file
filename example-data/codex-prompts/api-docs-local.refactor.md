# API Docs Local

Trigger: $1

Purpose: $2

## Steps

$3

## Output format

$4

<!--
$1 = Trigger (e.g., "/api-docs-local")
$2 = Purpose (e.g., "Fetch API docs and store locally for offline, deterministic reference.")
$3 = Steps list (e.g., "1. Create `docs/apis/` directory.\n2. For each provided URL or package, write retrieval commands (curl or `npm view` docs links). Do not fetch automatically without confirmation.\n3. Add `DOCS.md` index linking local copies.")
$4 = Output format (e.g., "- Command list and file paths to place docs under `docs/apis/`.")
--> 

**API Docs Local**
