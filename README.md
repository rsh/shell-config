# RSH Shell Config

This repo contains the configuration I usually set up on a new Linux-based machine.


# Copy dotfiles

From the root directory of his repo: `cp -r ./home/. ~`



# MacOS

After installing Homebrew and Oh My ZSH:
`brew install alacritty`
`brew install tmux`
`brew tap homebrew/cask-fonts`
`brew install --cask font-victor-mono`


# Ubuntu

## Set up shell


```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo apt install python3-pip
sudo apt install pipx

sudo apt install git
sudo apt-get install gnome-tweaks
sudo apt install neovim
sudo apt install tmux
sudo apt install zsh
sudo apt install sshfs

pipx install epy-reader

brew install fzf

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -r ./home/. ~
```

## Remap caps-lock to ctrl

1. Open "Tweaks"
1. "Keyboard" => "Additional Layout Options"
1. "Caps Lock Behavior" => "Make Caps Lock and additional Ctrl"

## Per-application settings

Done by hand, for now.

###  Firefox
In `about:config`, set `apz.gtk.kinetic_scroll.enabled` to `false`.

### 1Password Quick Access

Gnome/Wayland doesn't allow global shortcuts, so [this workaround](https://1password.community/discussion/comment/686578/#Comment_686578) tells Gnome to execute the Quick Access command via hotkey.

1. In Gnome Settings, go to Keyboard => View and Customize Shortcuts => Custom Shortcuts => Add shortcut
1. Add a shortcut with the command `1password --quick-access`
1. Set the keyboard shortcut to ctrl+shift+space (which is the default that comes with 1Password)

### Set up fingerprint reader for auth

Run `sudo pam-auth-update` and enable the fingerprint reader by hitting spacebar.
