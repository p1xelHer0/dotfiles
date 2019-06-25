#!/bin/bash

# symlink yabai config

# symlink
ln -fs "$HOME/dotfiles/conf/osx/yabai/.yabairc" "$HOME/"

chmod +x "$HOME/.yabairc"
