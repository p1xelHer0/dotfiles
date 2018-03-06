#!/bin/bash

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
  bs-platform
  create-react-app
  eslint
  neovim
  ocaml-language-server
  prettier
  prettier-eslint-cli
  tern
  instant-markdown-d
)

npm install -g "${packages[@]}"
