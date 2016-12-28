#!/bin/sh

if test ! $(which nvm)
then
  echo "Installing a stable version of Node..."

  # Install the latest version of node.
  nvm install node

  # Switch to the installed version
  nvm use node
fi

# All `npm install <pkg>`` commands will pin to the version that was available at the time you run the command
npm config set save-exact = true

# Globally install with npm
packages=(
  babel-cli
  eslint
  grunt
  gulp
  mocha
  npm-check
  react-native-cli
  serve
  standard
  tern
  webpack
)

npm install -g "${packages[@]}"
