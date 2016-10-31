#!/bin/bash

# TODO automize everything... someday...
exit
# dotfiles directory
dir = ~/dotfiles

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

# Package managers, packages and applications
. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/zsh.sh"
. "$DOTFILES_DIR/install/nvm.sh"
. "$DOTFILES_DIR/install/npm.sh"
. "$DOTFILES_DIR/install/brew-cask.sh"


# Symlinks for zsh, oh-my-zsh, atom, vim, xcode

# zsh + oh-my-zsh
ln -fs ~/dotfiles/oh-my-zsh/themes/p1xelHer0.zsh-theme $HOME/.oh-my-zsh/themes
ln -fs ~/dotfiles/shell/.zshrc $HOME

# atom
ln -fs ~/dotfiles/atom/config.cson $HOME/.atom
ln -fs ~/dotfiles/atom/keymap.cson $HOME/.atom
ln -fs ~/dotfiles/atom/snippets.cson $HOME/.atom
ln -fs ~/dotfiles/atom/styles.less $HOME/.atom

# vim
ln -fs ~/dotfiles/vim/.vim $HOME
ln -fs ~/dotfiles/vim/.vimrc $HOME

# vim
ln -fs ~/dotfiles/vim/.vim $HOME
ln -fs ~/dotfiles/vim/.vimrc $HOME

# xcode themes
ln -fs ~/dotfiles/xcode/FontAndColorThemes $HOME/Library/Developer/Xcode/UserData


# Terminal & iTerm 2

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Install iTerm theme
open "${HOME}/dotfiles/iterm/themes/p1xelher0.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false


# Atom

# Copy over Atom configs
#cp -r atom/packages.list $HOME/.atom

# Install community packages
#apm list --installed --bare - get a list of installed packages
#apm install --packages-file $HOME/.atom/packages.list


# Reload zsh settings
source ~/.zshrc
