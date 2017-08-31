#!/bin/bash

# install Stack packages

# packages to install
apps=(
  hlint
  hindent
  ghc-mod
  stylish-haskell
)

# install the packages
if test "$(which stack)"
then
  echo "Installing Haskell packages..."
  stack --system-ghc install "${apps[@]}"
fi
