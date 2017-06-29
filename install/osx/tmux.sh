#!/bin/bash

# install tpm to handle tmux plugins
# symlink .tmux.conf

# install tpm
mkdir -p "$HOME/.tmux/plugins"
# git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tmux-battery "$HOME/.tmux/plugins"
git clone https://github.com/robhurring/tmux-spotify "$HOME/.tmux/plugins"

# symlink
ln -fs "$HOME/dotfiles/conf/tmux/.tmux.conf" "$HOME/"
