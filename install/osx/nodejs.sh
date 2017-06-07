#!/bin/sh

## Install nvm, latest version of node and npm packages

# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# Restart for changes to take effect
exec zsh

if test ! $(which nvm)
then
  echo "Installing a stable version of nodejs..."

  # Install the latest version of nodejs
  nvm install node

  # Switch to the installed version
  nvm alias default node
fi

# Globally install with npm
packages=(
  create-react-app
  eslint
  flow-bin
  js-beautify
  preact-cli
  prettier
  react-native-cli
  serve
  stylefmt
  stylelint
  tern
  webpack
)

npm install -g "${packages[@]}"
