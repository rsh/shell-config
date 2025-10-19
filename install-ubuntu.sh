#!/usr/bin/env bash
set -euo pipefail

# Install core packages
sudo apt install -y \
    curl \
    python3-pip \
    pipx \
    git \
    direnv \
    gnome-tweaks \
    gnome-shell-extensions \
    tmux \
    zsh \
    sshfs \
    brightnessctl \
    shellcheck \
    waybar \
    fonts-font-awesome

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install keyd from PPA
sudo add-apt-repository ppa:keyd-team/ppa -y
sudo apt update
sudo apt install -y keyd
sudo usermod -aG video "$USER"
sudo usermod -aG input "$USER"
sudo systemctl enable --now keyd

pipx install epy-reader

brew install fzf

# not using apt because the brew version is more up-to-date, and makes VS Code integration easier
brew install neovim

chsh -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Note: xwayland-satellite needs to be built and placed in /usr/local/bin"
