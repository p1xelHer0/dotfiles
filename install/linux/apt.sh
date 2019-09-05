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
  fasd                                          # utils - navigate directories fast, like autojump, z
  git                                           # utils
  git-flow                                      # utils - git branching model
  ranger                                        # utils - file manager
  neovim                                        # editor
  tree                                          # utils
  ranger                                        # terminal - file manager
  rbevn                                         # ruby - used in neovim, and osx cocoapods
  ripgrep                                       # utils - search fast
  shellcheck                                    # shell linter
  wget                                          # utils
  zsh                                           # shell


)

python=(
  build-essential
  checkinstall
  python-dev
  python-setuptools
  python-pip
  python-smbus
  libncursesw5-dev
  libgdbm-dev
  libc6-dev
  zlib1g-dev
  libsqlite3-dev
  tk-dev
  libssl-dev
  openssl
  libffi-dev
)

apt update
apt install "${apps[@]}"
apt install "${python[@]}"

# Remove unused packages
apt autoremove
