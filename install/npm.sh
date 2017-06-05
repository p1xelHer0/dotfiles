#!/bin/sh

if test ! $(which nvm)
then
  echo "Installing a stable version of Node..."

  # Install the latest version of node.
  nvm install node

  # Switch to the installed version
  nvm alias default node
fi

# Globally install with npm
packages=(
  create-react-app
  eslint
  preact-cli
  react-native-cli
  serve
  standard
  stylelint
  tern
  webpack
)

npm install -g "${packages[@]}"
