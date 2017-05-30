#!/bin/bash

# Installs apt dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Upgrade any already-installed packages
apt upgrade

# Install packages
apps=(
  coreutils                                     # utils
  curl                                          # utils
  fasd                                          # utils (navigate directories fast, like autojump, z)
  git                                           # utils
  wget                                          # utils
)

apt update
apt install "${apps[@]}"

# Remove unused packages
apt autoremove
