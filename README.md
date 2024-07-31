# RSH Shell Config

This repo contains the configuration I usually set up on a new machine.


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
sudo apt install direnv
sudo apt install gnome-tweaks
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

#### Change reader font to EB Garamond

1. Download [EB Garamond](https://fonts.google.com/specimen/EB+Garamond)
1. `mkir -p /home/rayhan/snap/firefox/common/.fonts`
1. Copy the TTF files to that directory
1. `cd ~/snap/firefox/common/.mozilla/firefox/*.default`
1. `mkdir -p chrome && cd chrome && echo "@-moz-document url-prefix('about:reader') {\n    body.serif {\n        font-family: 'EB Garamond' \!important;\n    }\n}\n" >> userContent.css`

via: https://superuser.com/a/1323420 and https://bugzilla.mozilla.org/show_bug.cgi?id=1760996#c2
### 1Password Quick Access

Gnome/Wayland doesn't allow global shortcuts, so [this workaround](https://1password.community/discussion/comment/686578/#Comment_686578) tells Gnome to execute the Quick Access command via hotkey.

1. In Gnome Settings, go to Keyboard => View and Customize Shortcuts => Custom Shortcuts => Add shortcut
1. Add a shortcut with the command `1password --quick-access`
1. Set the keyboard shortcut to ctrl+shift+space (which is the default that comes with 1Password)

### Set up fingerprint reader for auth

Run `sudo pam-auth-update` and enable the fingerprint reader by hitting spacebar.


# TODO

# Firefox

Look into switching to tree-style tabs and disable native toolbar at the top. Then maximize will use the Gnome Unite extension on maximize

https://superuser.com/questions/1424478/can-i-hide-native-tabs-at-the-top-of-firefox
