#!/bin/bash

# install nvm, latest version of node and npm packages

# install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# restart for changes to take effect
exec zsh

if test ! "$(which nvm)"
then
  echo "Installing a stable version of nodejs..."

  # install the latest version of nodejs
  nvm install node

  # switch to the installed version
  nvm alias default node
fi

# globally install with npm
packages=(
  create-react-app
  eslint
  flow-bin
  js-beautify
  preact-cli
  prettier
  prettier-eslint-cli
  react-native-cli
  reason-cli
  serve
  stylefmt
  stylelint
  tern
  webpack
)

npm install -g "${packages[@]}"
