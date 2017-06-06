#!/bin/sh

## Installs Stack packages

# Packages to install
apps=(
  hlint
  ghc-mod
  stylish-haskell
)

# Install the packages
if test $(which stack)
then
  echo "Haskell packages..."
  stack install "${apps[@]}"
fi
