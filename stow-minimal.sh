#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "--dry-run" ]]; then
    echo "=== DRY RUN MODE ==="
    stow -n -d stow -t ~ nvim tmux
else
    stow -d stow -t ~ nvim tmux
    echo "Stowed: nvim, tmux"
fi
