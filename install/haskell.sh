# Install packages
apps=(
  hlint
  ghc-mod
  stylish-haskell
)

stack install "${apps[@]}"
