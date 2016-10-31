#!/bin/bash

# Change version here if needed
rbenv install 2.3.1
rbenv global 2.3.1

# New instance
exec bash

gem update --system

# We'll be using bundler for Cocoapods for react-native
gem install bundler cocoapods
