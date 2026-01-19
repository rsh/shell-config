#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--dry-run" ]]; then
    echo "=== DRY RUN MODE ==="
    stow -n -d stow -t ~ editor tmux
else
    stow -d stow -t ~ editor tmux
    echo "Stowed: editor, tmux"
fi
