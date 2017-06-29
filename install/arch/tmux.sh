#!/bin/bash

# create folder to store plugins
# symlink .tmux.conf

# create plugins folder
mkdir -p "$HOME/.tmux/plugins"

# symlink
ln -fs "$HOME/dotfiles/conf/tmux/.tmux.conf" "$HOME/"
