#!/bin/bash

#  symlink Neovim files

# symlink
ln -fs "$HOME/dotfiles/conf/neovim/.vimrc" "$HOME/.config/nvim/init.vim"
ln -fs "$HOME/dotfiles/conf/neovim/UltiSnips" "$HOME/.config/nvim/"
ln -fs "$HOME/dotfiles/conf/neovim/after" "$HOME/.config/nvim/"
ln -fs "$HOME/dotfiles/conf/neovim/colors" "$HOME/.config/nvim/"

ln -fs "$HOME/dotfiles/conf/neovim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
