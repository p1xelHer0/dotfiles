#!/bin/bash

# install Stack and packages

# install Stack
wget -qO- https://get.haskellstack.org | sh

# packages to install
apps=(
  brittany
  cabal-install
  ghc-mod
  hindent
  hlint
  stylish-haskell
)

# install the packages
if test "$(which stack)"
then
  echo "Installing Haskell packages..."
  stack install "${apps[@]}"
fi

exec zsh

cabal update
