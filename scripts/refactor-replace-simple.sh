#!/usr/bin/env bash
set -euo pipefail

# 1) cd to the directory that has the *.refactor.md files
#    (example) cd ~/some/source/dir

# 2) set your target directory (where the real *.md live)
TARGET="$HOME/.codex/prompts"

shopt -s nullglob
for src in *.refactor.md; do
  dest="$TARGET/${src%.refactor.md}.md"

  if [ -f "$dest" ]; then
    # optional backup before overwrite:
    # cp -p -- "$dest" "$dest.bak"

    # overwrite target contents but keep its name
    cp -fp -- "$src" "$dest"
    echo "replaced: $dest"
  else
    echo "skip (no match at target): $dest"
  fi
done
