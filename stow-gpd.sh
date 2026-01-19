#!/usr/bin/env bash
set -euo pipefail

stow -d stow -t ~ gpd
sudo stow -d stow/gpd -t /etc etc
echo "Stowed: gpd (niri output + keyd)"
