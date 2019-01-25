#!/bin/bash

# install opam packages
packages=(
  dune
  merlin
  ocamlformat
  ocp-indent
  utop
)

opam install "${packages[@]}"
