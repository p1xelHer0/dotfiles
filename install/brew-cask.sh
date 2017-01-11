#!/bin/bash

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages

apps=(
  alfred                                        # utils
  android-studio                                # android
  atom                                          # utils
  brave                                         # browser
  discord                                       # communication
  dropbox                                       # utils
  firefox                                       # browser
  firefoxnightly                                # browser
  flux                                          # utils
  gitkraken                                     # utils
  gitter                                        # communication
  google-chrome                                 # browser
  google-chrome-canary                          # browser
  hyper                                         # terminal
  intel-haxm                                    # android (emulator perf)
  iterm2-nightly                                # terminal
  java                                          # android
  mamp                                          # utils
  opera                                         # browser
  react-native-debugger                         # js
  skype                                         # communication
  slack                                         # communication
  spectacle                                     # utils
  spotify                                       # utils
  vlc                                           # utils
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
