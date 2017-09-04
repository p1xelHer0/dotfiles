#!/bin/sh

# install Stack and packages

# install Stack
wget -qO- https://get.haskellstack.org | sh

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
  stack install "${apps[@]}"
fi
