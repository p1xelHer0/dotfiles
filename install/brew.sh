#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/versions
brew tap homebrew/dupes
brew tap homebrew/services

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install packages
apps=(
  android-sdk                                   # android/java
  ant                                           # android/java
  coreutils                                     # utils
  curl                                          # utils
  fasd                                          # utils (navigate directories fast, like autojump, z)
  fzf                                           # utils (terminal fuzzy finder)
  git                                           # utils
  gradle                                        # android/java
  haskell-stack                                 # haskell
  jenv                                          # java
  koekeishiya/formulae/khd                      # utils
  koekeishiya/formulae/kwm                      # utils
  maven                                         # android/java
  neovim/neovim/neovim                          # editor
  neofetch                                      # utils
  pyenv                                         # python
  pyenv-virtualenv                              # python
  rbevn                                         # ruby
  reattach-to-user-namespace                    # tmux copy-paste fix
  ripgrep                                       # utils
  watchman                                      # js (react-native dependency)
  wget                                          # utils
  wifi-password                                 # utils
  yarn                                          # js
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup

# Start kwm by default
brew services start kwm
brew services start khd
