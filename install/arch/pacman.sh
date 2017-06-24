#!/bin/sh

# install pacman packages

# packages to install
packages=(
  acpid          # monitor - battery
  htop           # monitor - processes

  neovim         # neovim
  python-neovim  # neovim
  python2-neovim # neovim

  pulseadio      # sound
  pulseadio-alsa # sound
  alsa-utils     # sound

  rxvt-unicode   # terminal
  xterm          # terminal
  tmux           # terminal
  bc             # terminal - used by base16 color

  openntpd       # time

  fzf            # utils
  ripgrep        # utils
  wget           # utils

  xorg           # x
  xorg-server    # x
  xorg-twm       # x
  xorg-utils     # x
  xorg-xclock    # x
  xorg-xinit     # x

  avahi
  cronie
  dbus
  linux-header
)

sudo pacman -S "${packages[@]}"

systemctl enable acpid
systemctl enable avahi
systemctl enable dbus
systemctl enable openntpd
