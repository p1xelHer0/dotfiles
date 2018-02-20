#!/bin/bash

# install pacman packages

# packages to install
packages=(
  htop           # monitor - processes

  neovim         # neovim
  python-neovim  # neovim
  python2-neovim # neovim

  # shellcheck     # shell linter

  alsa-utils     # sound
  pulseadio      # sound
  pulseadio-alsa # sound

  zsh            # shell
  rxvt-unicode   # terminal
  tmux           # terminal
  ranger         # terminal - file manager

  thunar         # file manager

  dunst          # notifications

  imagemagick    # wal

  fzf            # utils
  ripgrep        # utils
  wget           # utils
  xsel           # utils - clipboard
  bc             # utils - used by base16 color
  maim           # utils - screenshots
  wmctrl         # utils - used by lemonbar, "interact with X"
  p7zip          # utils - 7zip
  zip            # utils - zipping
  unzip          # utils - uinzipping

  xorg           # x
  xorg-xinit     # x
  xorg-xmodmap   # x - keymappings

  xcape          # keymappings

  rofi           # program launcher
  feh            # wallpaper

  ttf-dejavu     # fonts
  xorg-fonts     # x - fonts
  xorg-xfontsel  # x - find X fonts

  openntpd       # time

  ghc-static     # haskell

  python         # python3
  python-pip     # python3

  lua            # lua 5.3
  luarocks       # package management
  love           # love2d

  tiled          # tilemap editor

  linux-headers
  avahi
  dbus
)

vmboxpackages=(
  virtualbox-guest-dkms
  virtualbox-guest-utils
)

sudo pacman -S "${packages[@]}"

# remove orphaned packages: pacman -Rns $(pacman -Qtdq)
