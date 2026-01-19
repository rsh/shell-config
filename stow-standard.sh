#!/usr/bin/env bash
set -euo pipefail

stow -d stow -t ~ shell tmux niri nvim alacritty qutebrowser audio rsync misc
echo "Stowed: shell tmux niri nvim alacritty qutebrowser audio rsync misc"
