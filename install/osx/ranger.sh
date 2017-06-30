#!/bin/bash

# setup basic ranger config and symlink config

# setup basic config
ranger --copy-config=all

# symlink
ln -fs "$HOME/dotfiles/conf/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
