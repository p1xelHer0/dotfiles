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
  bs-platform
  eslint
  esy
  instant-markdown-d
  javascript-typescript-langserver
  neovim
  ocaml-language-server
  prettier
  reason-cli
)

yarn global add "${packages[@]}"
