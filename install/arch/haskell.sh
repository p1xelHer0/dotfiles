#!/bin/bash

# install Stack packages

# packages to install
apps=(
  --resolver nightly-2016-10-17 hindent
  hlint
  ghc-mod
  stylish-haskell
)

# install the packages
if test "$(which stack)"
then
  echo "Installing Haskell packages..."
  stack install --system-ghc "${apps[@]}"
fi
