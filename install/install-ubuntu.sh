#!/usr/bin/env bash
set -euo pipefail

# Parse command line arguments
HEADLESS_BASIC_GUI=false
for arg in "$@"; do
    case $arg in
        --headless-basic-gui)
            HEADLESS_BASIC_GUI=true
            shift
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--headless-basic-gui]"
            exit 1
            ;;
    esac
done

# Save config for copy.sh to use
mkdir -p home/.config/rsh-shell-config/install
echo "HEADLESS_BASIC_GUI=$HEADLESS_BASIC_GUI" > home/.config/rsh-shell-config/install/install-mode

# Install core packages
PACKAGES=(
    curl
    python3-pip
    pipx
    git
    direnv
    tmux
    zsh
    sshfs
    shellcheck
)

# Add GUI packages if not in headless mode
if [ "$HEADLESS_BASIC_GUI" = false ]; then
    PACKAGES+=(
        gnome-tweaks
        gnome-shell-extensions
        brightnessctl
        waybar
        swaylock
        swayidle
        fonts-font-awesome
    )
fi

sudo apt install -y "${PACKAGES[@]}"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install keyd from PPA (skip in headless mode)
if [ "$HEADLESS_BASIC_GUI" = false ]; then
    sudo add-apt-repository ppa:keyd-team/ppa -y
    sudo apt update
    sudo apt install -y keyd
    sudo usermod -aG video "$USER"
    sudo usermod -aG input "$USER"
    sudo systemctl enable --now keyd
fi

pipx install epy-reader

brew install fzf

# not using apt because the brew version is more up-to-date, and makes VS Code integration easier
brew install neovim

chsh -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ "$HEADLESS_BASIC_GUI" = false ]; then
    echo "Note: xwayland-satellite needs to be built and placed in /usr/local/bin"
fi
