#!/bin/bash

# Change version here if needed
rbenv install 2.3.1
rbenv global 2.3.1

exec $SHELL
gem update --system

# We'll be using bundler for Cocoapods for react-native
gem install bundler cocoapods

# Ruby dependency for Neovim
gem install neovim
