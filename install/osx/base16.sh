#!/bin/bash

## Install base16-shell and Symlink base16-theme

# Install base16-shell
# https://github.com/chriskempson/base16-shell
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

# Symlink
ln -fs $HOME/dotfiles/conf/osx/base16/base16-p1xelHer0.sh $HOME/.config/base16-shell/scripts
