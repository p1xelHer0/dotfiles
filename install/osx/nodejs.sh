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
  gatsby
  instant-markdown-d
  javascript-typescript-langserver
  neovim
  prettier
  prettier-eslint-cli
  pulp
  react-native-cli
)

# install reason with npm
reasonPackages=(
  # reason-cli@3.1.0-darwin
  # bs-platform
  ocaml-language-server
)

yarn global add "${packages[@]}"
npm i -g "${reasonPackages[@]}"
