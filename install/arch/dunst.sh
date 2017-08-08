#!/bin/bash

# create dunst folder and symlink config

# create folder
mkdir "$HOME/.config/dunst/"

# symlink
ln -fs "$HOME/dotfiles/conf/arch/dunst/dunstrc" "$HOME/.config/dunst/"
