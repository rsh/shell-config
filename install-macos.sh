#!/usr/bin/env bash
set -euo pipefail

echo "WARNING: This script is untested."
read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install core packages via Homebrew
brew install \
    curl \
    python3 \
    git \
    direnv \
    tmux \
    zsh \
    sshfs-mac \
    shellcheck \
    fzf \
    neovim \
    font-fontawesome

# Install pipx via pip3
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Install epy-reader via pipx
pipx install epy-reader

# Change default shell to zsh (macOS uses zsh by default on newer versions, but ensuring it's set)
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation complete! Please restart your terminal for all changes to take effect."
