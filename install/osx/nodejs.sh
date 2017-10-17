#!/bin/bash

# install nvm, latest version of node and npm packages

# install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# restart for changes to take effect
exec zsh

if test ! "$(which nvm)"
then
  echo "installing latest Node.js"

  # install the latest version of nodejs
  nvm install node

  # switch to the installed version
  nvm alias default node
fi

# globally install with yarn
packages=(
  bower
  create-react-app
  eslint
  instant-markdown-d
  prettier
  prettier-eslint-cli
  pulp
  react-native-cli
  tern
)

# install reason with npm for now
reasonPackages=(
  https://github.com/reasonml/reason-cli/archive/beta-v-1.13.7-bin-darwin.tar.gz
  bs-platform
)

yarn global add "${packages[@]}"
npm i -g "${reasonPackages[@]}"
