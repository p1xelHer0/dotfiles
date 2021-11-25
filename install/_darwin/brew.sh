#!/bin/bash

# install Homebrew and some software

sudo -v

if test ! "$(which brew)"
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew upgrade --all

apps=(
  # superfly/tap/flyctl
)

brew update

brew install "${apps[@]}"

brew cleanup
