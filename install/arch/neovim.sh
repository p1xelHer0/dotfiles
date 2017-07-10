#!/bin/bash

# symlink Neovim files

# symlink
ln -fs "$HOME/dotfiles/conf/neovim/.vimrc" "$HOME/.config/nvim/init.vim"
ln -fs "$HOME/dotfiles/conf/neovim/UltiSnips" "$HOME/.config/nvim/"
