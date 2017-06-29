#!/bin/bash

# install tpm to handle tmux plugins
# symlink .tmux.conf

# install tpm
mkdir -p "$HOME/.tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# symlink
ln -fs "$HOME/dotfiles/conf/osx/tmux/.tmux.conf" "$HOME/"
