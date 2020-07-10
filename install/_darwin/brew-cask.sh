#!/bin/bash

# installs brew cask which is used to install applications

# install cask
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
  dropbox                                       # utils
  firefox-developer-edition                     # browser
  google-chrome-canary                          # browser
  mactex                                        # utils
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

# install packages
brew cask install "${base[@]}"

# install quick look plugins
brew cask install "${quicklookplugins[@]}"
