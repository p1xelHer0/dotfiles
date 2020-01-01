#!/bin/bash

# install Luarocks packages

# packages to install
apps=(
  luacheck
)

# install the packages
if test "$(which luarocks)"
then
  echo "Installing Luarocks packages..."
  sudo luaroccks install "${apps[@]}"
fi
