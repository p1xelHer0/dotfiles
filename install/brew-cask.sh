#!/bin/bash

# Install Caskroom

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages

apps=(
  android-studio                                # android
  atom                                          # utils
  discord                                       # utils
  dropbox                                       # utils
  firefox                                       # utils
  firefoxnightly                                # utils
  flux                                          # utils
  gitkraken                                     # utils
  google-chrome                                 # utils
  google-chrome-canary                          # utils
  intel-haxm                                    # android (emulator perf)
  iterm2-nightly                                # utils
  java                                          # android
  opera                                         # utils
  react-native-debugger                         # js
  slack                                         # utils
  spotify                                       # utils
  vlc                                           # utils
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
