#!/bin/bash

# installs brew cask which is used to install applications

# install cask
brew tap caskroom/cask
brew install brew-cask

brew tap homebrew/cask-drivers
brew tap caskroom/versions
brew tap caskroom/fonts

# packages to install
apps=(
  alacritty                                     # terminal
  alfred                                        # utils
  brave                                         # browser
  discord                                       # communication
  dropbox                                       # utils
  firefox                                       # browser
  firefoxnightly                                # browser
  firefox-developer-edition                     # browser
  font-iosevka                                  # font
  gitkraken                                     # utils
  google-chrome                                 # browser
  google-chrome-canary                          # browser
  iterm2-nightly                                # terminal
  keybase                                       # utils
  mactex                                        # utils
  mullvadvpn                                    # privacy
  opera                                         # browser
  postman                                       # dev
  qmk-toolbox                                   # keyboard
  signal                                        # communication
  skype                                         # communication
  slack                                         # communication
  spotify                                       # utils
  telegram                                      # communication
  twitch                                        # utils
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

gamedev=(
  mono-mdk                                      # mono (unity, c#)
)

# install packages
brew cask install "${apps[@]}"

# quick look plugins
# see: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
