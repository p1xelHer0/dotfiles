#!/bin/bash

# install latest version of Ruby and gems with rbenv
# install Neovim dependency

if test $(which rbenv)
then
  echo "Installing a stable version of Ruby..."

  # get latest Ruby version
  rubyv=$(rbenv install -l | grep -v - | tail -1)

  # install Ruby
  rbenv install $rubyv

  # switch to the installed version
  rbenv global $rubyv

  # ruby dependency for Neovim
  gem install neovim

  # bundler and Cocoapods for react-native
  # gem install bundler cocoapods
 fi
