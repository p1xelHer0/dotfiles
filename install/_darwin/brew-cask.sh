#!/bin/bash

# installs brew cask which is used to install applications

brew tap caskroom/cask
brew install brew-cask

brew tap homebrew/cask-drivers
brew tap caskroom/versions

base=(
  firefox                                       # browser
  google-chrome                                 # browser
  slack                                         # communication
  spotify                                       # utils
)

# packages to install
apps=(
  alfred                                        # utils
  discord                                       # communication
  firefox-developer-edition                     # browser
  google-chrome-canary                          # browser
  michaeleisel/zld/zld                          # rust, faster linker
  mullvadvpn                                    # privacy
  postman                                       # dev
  qmk-toolbox                                   # keyboard
  signal                                        # communication
  telegram                                      # communication
  vlc                                           # utils
  zulip                                         # communication
)

# quick look plugins
# see: https://github.com/sindresorhus/quick-look-plugins
quicklookplugins=(
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlprettypatch
  quicklook-csv
  betterzipql
  qlimagesize
  webpquicklook
  suspicious-package
)

brew cask install "${base[@]}"

brew cask install "${quicklookplugins[@]}"
