#!/bin/bash

if test ! "$(which fnm)"
then
  echo "installing latest Node.js"

  # install the latest version of nodejs
  fnm install node

  # switch to the installed version
  fnm alias default node
fi

# globally install with yarn
packages=(
  create-react-app
  eslint
  gatsby
  instant-markdown-d
  javascript-typescript-langserver
  neovim
  prettier
  prettier-eslint-cli
)

# install reason with npm
reasonPackages=(
  bs-platform
  ocaml-language-server
  reason-cli
)

yarn global add "${packages[@]}"
yarn global add "${reasonPackages[@]}"
