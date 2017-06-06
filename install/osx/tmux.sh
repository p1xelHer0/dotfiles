#!/bin/bash

## Install tpm to handle tmux plugins
## Symlink .tmux.conf

# Install tpm
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Symlink
ln -fs $HOME/dotfiles/conf/osx/tmux/.tmux.conf $HOME/
