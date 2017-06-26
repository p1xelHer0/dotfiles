#!/bin/bash

# installs brew cask which is used to install applications

# install cask
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# packages to install
apps=(
  alfred                                        # utils
  brave                                         # browser
  discord                                       # communication
  dropbox                                       # utils
  firefox                                       # browser
  firefoxnightly                                # browser
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

# install packages
brew cask install "${apps[@]}"

# quick look plugins
# see: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
