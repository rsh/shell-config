#!/usr/bin/env bash

sudo apt install curl

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo apt install python3-pip
sudo apt install pipx

sudo apt install git
sudo apt install direnv
sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions
sudo apt install tmux
sudo apt install zsh
sudo apt install sshfs

pipx install epy-reader

brew install fzf

# not using apt because the brew version is more up-to-date, and makes VS Code integration easier
brew install neovim

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

