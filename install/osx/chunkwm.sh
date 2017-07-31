#!/bin/bash

# symlink chunkwm config

# symlink
ln -fs "/usr/local/opt/chunkwm/share/chunkwm_plugins" "$HOME/chunkwm_plugins"
# ln -fs "$HOME/dotfiles/conf/osx/chunkwm/.chunkwmrc" "$HOME/"
# chunkwm does not support symlinks, yet, it seems
cp "/usr/local/opt/chunkwm/share/examples/chunkwmrc" "$HOME/.chunkwmrc"

chmod +x "$HOME/.chunkwmrc"
