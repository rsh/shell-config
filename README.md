# RSH Shell Config

This repo contains the configuration I usually set up on a new machine.

It assumes:
- OS: Ubuntu
- Window manager: niri
- Shell: zsh


# Ubuntu

## Set up shell

Run the installation script: `./install-ubuntu.sh`

After installation completes: `./copy.sh`

## Per-application settings

Done by hand, for now.

###  Firefox
In `about:config`, set `apz.gtk.kinetic_scroll.enabled` to `false`.

#### Change reader font to EB Garamond

1. Download [EB Garamond](https://fonts.google.com/specimen/EB+Garamond)
1. `mkdir -p /home/rayhan/snap/firefox/common/.fonts`
1. Copy the TTF files to that directory
1. `cd ~/snap/firefox/common/.mozilla/firefox/*.default`
1. `mkdir -p chrome && cd chrome && echo "@-moz-document url-prefix('about:reader') {\n    body.serif {\n        font-family: 'EB Garamond' \!important;\n    }\n}\n" >> userContent.css`

via: https://superuser.com/a/1323420 and https://bugzilla.mozilla.org/show_bug.cgi?id=1760996#c2

### Set up fingerprint reader for auth

Run `sudo pam-auth-update` and enable the fingerprint reader by hitting spacebar.

## Vim/Neovim Keybindings

Leader key: `<Space>`

- `<Space>t` - Toggle NERDTree
- `<Space>R` - Reload vimrc
- `<Space>c` - Insert checkbox `- [ ] ` at beginning of line
- `<Space>d` - Toggle checkbox state `[ ]` ↔ `[x]` (markdown files only)
- `<Space>x` - Remove checkbox entirely (neovim, markdown files only)
- `jk` - Exit insert mode (alternative to Esc)


# MacOS

If you find yourself needing to use this on macOS, after installing Homebrew and Oh My ZSH:
`brew install alacritty`
`brew install tmux`
`brew tap homebrew/cask-fonts`
`brew install --cask font-victor-mono`


# TODO

# Firefox

Look into switching to tree-style tabs and disable native toolbar at the top. Then maximize will use the Gnome Unite extension on maximize

https://superuser.com/questions/1424478/can-i-hide-native-tabs-at-the-top-of-firefox
