#!/bin/bash

# install base16-shell and Symlink base16-theme

# install base16-shell
# see: https://github.com/chriskempson/base16-shell
git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"

# base16 settings file
touch "$HOME/dotfiles/conf/osx/base16/.base16"

# symlink
ln -fs "$HOME/dotfiles/conf/osx/base16/base16-p1xelHer0.sh" "$HOME/.config/base16-shell/scripts"
