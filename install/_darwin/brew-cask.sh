#!/bin/bash

# installs brew cask which is used to install applications

# install cask
brew tap caskroom/cask
brew install brew-cask

brew tap homebrew/cask-drivers
brew tap caskroom/versions
brew tap caskroom/fonts

base=(
  alacritty                                     # terminal
  firefox                                       # browser
  google-chrome                                 # browser
  slack                                         # communication
  spotify                                       # utils
  tidal
)

# packages to install
apps=(
  alfred                                        # utils
  brave                                         # browser
  discord                                       # communication
  dropbox                                       # utils
  firefox-developer-edition                     # browser
  firefoxnightly                                # browser
  google-chrome-canary                          # browser
  keybase                                       # utils
  mactex                                        # utils
  mullvadvpn                                    # privacy
  postman                                       # dev
  qmk-toolbox                                   # keyboard
  signal                                        # communication
  telegram                                      # communication
  vlc                                           # utils
  zulip                                         # communication
)

# install packages
brew cask install "${base[@]}"

# quick look plugins
# see: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
