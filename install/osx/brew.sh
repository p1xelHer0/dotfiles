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
  diff-so-fancy                                 # better git-diffs
  dfu-util                                      # used to install whitefox configs
  evince                                        # utils - document viewer, pdf
  fasd                                          # utils - navigate directories fast, like autojump, z
  fswatch                                       # utils - file watcher used for watching files in dune projects
  # fzf                                         # utils - terminal fuzzy finder, install with vim atm
  git                                           # utils
  git-flow                                      # utils - git branching model
  gpatch                                        # utils - needed for opam
  koekeishiya/formulae                          # utils - skhd and yabai
  ranger                                        # utils - file manager
  neovim/neovim/neovim                          # editor
  opam                                          # ocaml - package manager
  pyenv                                         # python - used in neovim
  pyenv-virtualenv                              # python - used in neovim
  tree                                          # utils
  ranger                                        # terminal - file manager
  rbevn                                         # ruby - used in neovim, and osx cocoapods
  reattach-to-user-namespace                    # tmux - copy-paste fix
  ripgrep                                       # utils - search fast
  shellcheck                                    # shell linter
  universal-ctags --HEAD
  wget                                          # utils
  wifi-password                                 # utils - show the wifi-password in terminal
  yabai
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

brew tap homebrew/services

brew tap universal-ctags/universal-ctags
brew tap koekeishiya/formulae

# make sure we’re using the latest Homebrew
brew update

# install packages
brew install "${apps[@]}"

# remove outdated versions from the cellar
brew cleanup

# start chunkwm and khd by default
brew services start koekeishiya/formulae/skhd
