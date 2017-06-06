#!/bin/bash

## Installs brew cask which is used to install applications

# Install cask
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Packages to install
apps=(
  alfred                                        # utils
  brave                                         # browser
  discord                                       # communication
  dropbox                                       # utils
  firefox                                       # browser
  firefoxnightly                                # browser
  flux                                          # utils
  gitkraken                                     # utils
  google-chrome                                 # browser
  google-chrome-canary                          # browser
  iterm2-nightly                                # terminal
  opera                                         # browser
  postman                                       # dev
  skype                                         # communication
  slack                                         # communication
  spotify                                       # utils
  ubersicht                                     # utils
  vlc                                           # utils
  xquartz                                       # utils (kwm)
)

reactnative=(
  android-studio                                # android
  java                                          # android
  intel-haxm                                    # android (emulator perf)
  react-native-debugger                         # js
)

# Install packages
brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
