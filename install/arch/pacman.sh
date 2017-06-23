#!/bin/sh

# install pacman packages

# packages to install
packages=(
  fzf
  neovim
  python2-neovim
  python3-neovim
  ripgrep
  rxvt-unicode
)

sudo pacman -S "${packages[@]}"
