#!/bin/bash

# install Homebrew and some of the common dependencies needed/desired for software development

# ask for the administrator password upfront
sudo -v

# check for Homebrew and install it if missing
if test ! "$(which brew)"
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# upgrade any already-installed formulae
brew upgrade --all

# packages to install
apps=(
  coreutils                                     # utils
  curl                                          # utils
  dfu-util                                      # used to install whitefox configs
  fasd                                          # utils - navigate directories fast, like autojump, z
  # fzf                                         # utils - terminal fuzzy finder, install with vim atm
  git                                           # utils
  git-flow                                      # utils - git branching model
  koekeishiya/formulae/skhd                     # utils - hotkey daemon
  chunkwm                                       # utils - window manager
  ranger                                        # utils - file manager
  neovim/neovim/neovim                          # editor
  pyenv                                         # python - used in neovim
  pyenv-virtualenv                              # python - used in neovim
  ranger                                        # terminal - file manager
  rbevn                                         # ruby - used in neovim, and osx cocoapods
  reattach-to-user-namespace                    # tmux - copy-paste fix
  ripgrep                                       # utils - search fast
  shellcheck                                    # shell linter
  universal-ctags --HEAD
  wget                                          # utils
  wifi-password                                 # utils - show the wifi-password in terminal
  yarn --ignore-dependencies                    # js - package manager
  zsh                                           # shell
)

reactnative=(
  android-sdk                                   # android/java
  ant                                           # java - build tool
  gradle                                        # java - build tool
  jenv                                          # java - verion manager
  maven                                         # java - package manager
  watchman                                      # js - react-native dependency
)

haskell=(
  haskell-stack                                 # haskell
)

fun=(
  ffmpeg                                        # utils - make videos
  gifsicle                                      # utils - make gifs
  htop                                          # utils - monitor processes
  neofetch                                      # utils - print system information
)

brew tap homebrew/versions
brew tap homebrew/dupes
brew tap homebrew/services

brew tap universal-ctags/universal-ctags
brew tap crisidev/homebrew-chunkwm

# make sure we’re using the latest Homebrew
brew update

# install packages
brew install "${apps[@]}"

# remove outdated versions from the cellar
brew cleanup

# start chunkwm and khd by default
brew services start koekeishiya/formulae/skhd
brew services restart crisidev/chunkwm/chunkwm
