#!/bin/bash

## Install latest version of Ruby and gems with rbenv
## install Neovim dependency

if test $(which rbenv)
then
  echo "Installing a stable version of Ruby..."

  # Get latest Ruby version
  rubyv=$(egrep "^\s+2\.3\.\d+$" <(rbenv install -l) | tail -1)

  # Install Ruby
  rbenv install $rubyv

  # Switch to the installed version
  rbenv global $rubyv

 # Ruby dependency for Neovim
  gem install neovim

  # Bundler and Cocoapods for react-native
  # gem install bundler cocoapods
 fi
