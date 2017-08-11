#!/bin/bash

# symlink chunkwm config

# symlink
ln -fs "$HOME/dotfiles/conf/osx/chunkwm/.chunkwmrc" "$HOME/"

chmod +x "$HOME/.chunkwmrc"
