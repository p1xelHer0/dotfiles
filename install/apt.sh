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
  neovim                                        # editor
  python-dev                                    # python
  python-pip                                    # python
  python3-dev                                   # python
  python3-pip                                   # python
  wget                                          # utils
  zsh                                           # shell
)

add-apt-repository ppa:neovim-ppa/stable

apt update
apt install "${apps[@]}"

# Remove unused packages
apt autoremove
