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
  Schniz/tap/fnm                                # node version manager, fast
  # coreutils                                     # utils
  # curl                                          # utils
  # dfu-util                                      # used to install whitefox configs
  # diff-so-fancy                                 # better git-diffs
  # entr                                          # utils - file watcher
  # evince                                        # utils - document viewer, pdf
  # exa                                           # utils - ls "replacement"
  # fasd                                          # utils - navigate directories fast, like autojump, z
  # ffmpeg                                        # utils - make videos
  # fswatch                                       # utils - file watcher used for watching files in dune projects
  # fzf                                           # utils - terminal fuzzy finder
  # gifsicle                                      # utils - make gifs
  # git                                           # utils
  # git-flow                                      # utils - git branching model
  gpatch                                        # utils - needed for opam
  # gpg                                           # security
  haskell-stack                                 # haskell
  # htop                                          # utils - monitor processes
  luarocks                                      # lua package manager
  # neofetch                                      # utils - print system information
  # neovim/neovim/neovim                          # editor
  # opam                                          # ocaml
  pidof                                         # utils - needed for pywal
  # pinentry-mac                                  # securiy
  # ranger                                        # utils - file manager
  # reattach-to-user-namespace                    # tmux - copy-paste fix
  # ripgrep                                       # utils - search fast
  # shellcheck                                    # shell linter
  # tree                                          # utils
  # wget                                          # utils
  # wifi-password                                 # utils - show the wifi-password in terminal
  yabai                                         # window manager
  yarn                                          # js - package manager
  # zsh                                           # shell
)

reactnative=(
  android-sdk                                   # android/java
  # ant                                           # java - build tool
  # gradle                                        # java - build tool
  # jenv                                          # java - verion manager
  # maven                                         # java - package manager
  # watchman                                      # js - react-native dependency
)

brew tap homebrew/services
brew tap koekeishiya/formulae

# make sure we’re using the latest Homebrew
brew update

# install packages
brew install "${apps[@]}"

# remove outdated versions from the cellar
brew cleanup

# start chunkwm and khd by default
brew services start koekeishiya/formulae/skhd
