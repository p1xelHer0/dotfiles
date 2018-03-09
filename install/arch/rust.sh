#!/bin/bash

# install Rust with Rustup
# https://www.rustup.rs/

# install rustup
curl https://sh.rustup.rs -sSs | sh

rustup default stable

# install RLS
packages=(
  rls-preview
  rust-analysis
  rust-src
  rustfmt-preview
)

rustup component add "${packages[@]}"

# install Rusti
rustup install nightly-2016-08-01
rustup run nightly-2016-08-01 cargo install --git https://github.com/murarth/rusti
