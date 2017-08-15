#!/bin/bash

# symlink alacritty config

# symlink
mkdir "$HOME/.config/alacritty"
ln -fs "$HOME/dotfiles/conf/osx/alacritty/alacritty.yml" "$HOME/.config/alacritty/"
