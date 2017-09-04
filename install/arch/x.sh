#!/bin/bash

# symlink x-related items

# symlink .xinitrc
ln -fs "$HOME/dotfiles/conf/arch/x/.xinitrc" "$HOME/"

# symlink .Xresources
ln -fs "$HOME/dotfiles/conf/arch/x/.Xresources" "$HOME"

# symlink .Xmodmap
ln -fs "$HOME/dotfiles/conf/arch/x/.Xmodmap" "$HOME"
