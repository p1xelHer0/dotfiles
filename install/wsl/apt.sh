#!/bin/bash

# install apt dependencies needed/desired for software development

# ask for the administrator password upfront
sudo -v

# upgrade any already-installed packages
apt upgrade

# install packages
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

add-apt-repository ppa:x4121/ripgrep
add-apt-repository ppa:neovim-ppa/stable

apt update
apt install "${apps[@]}"

# Remove unused packages
apt autoremove
