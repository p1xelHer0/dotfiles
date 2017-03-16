#!/bin/bash

# TODO automize everything... someday...
exit

# dotfiles directory
dir = $HOME/dotfiles

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

# Package managers, packages and applications
. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/brew-cask.sh"-
. "$DOTFILES_DIR/install/zsh.sh"
. "$DOTFILES_DIR/install/nvm.sh"
. "$DOTFILES_DIR/install/npm.sh"
. "$DOTFILES_DIR/install/vim.sh"
. "$DOTFILES_DIR/install/haskell.sh"
. "$DOTFILES_DIR/install/python.sh"
. "$DOTFILES_DIR/install/rbenv.sh"
. "$DOTFILES_DIR/install/jenv.sh"
. "$DOTFILES_DIR/install/android.sh"


# Symlinks for zsh, oh-my-zsh, atom, vim, xcode
# WARNING, THIS OVERRIDES YOUR FILES WITHOUT CONSENT, BE CAREFUL (-f means force)

# zsh + oh-my-zsh
ln -fs $HOME/dotfiles/zsh/themes/p1xelHer0.zsh-theme $HOME/.oh-my-zsh/themes/
ln -fs $HOME/dotfiles/zsh/.zshrc $HOME/

# atom
ln -fs $HOME/dotfiles/atom/config.cson $HOME/.atom/
ln -fs $HOME/dotfiles/atom/keymap.cson $HOME/.atom/
ln -fs $HOME/dotfiles/atom/snippets.cson $HOME/.atom/
# link my own base16 scheme to the base16 package
# need to add p1xelher0 to the lib/base16-settings.coffee list to be able to select it!
ln -fs $HOME/dotfiles/atom/p1xelher0.less $HOME/.atom/packages/base16-syntax/styles/schemes
# ln -fs $HOME/dotfiles/atom/styles.less $HOME/.atom/
# points to my stylesheet repository instead
ln -fs $HOME/dev/repo/private/p1xelher0-stylesheet/styles.less $HOME/.atom/

# nvim
ln -fs $HOME/dotfiles/nvim/init.vim $HOME/.config/nvim/
ln -fs $HOME/dotfiles/nvim/autoload $HOME/.config/nvim/
ln -fs $HOME/dotfiles/nvim/UltiSnips $HOME/.config/nvim/

# xcode themes
ln -fs $HOME/dotfiles/xcode/FontAndColorThemes $HOME/Library/Developer/Xcode/UserData/


# Terminal & iTerm 2 & Hyper

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# hyper
ln -fs $HOME/dotfiles/hyper/.hyper.js $HOME/
# points to my theme repository
ln -fs $HOME/dev/repo/private/hyper-p1xelHer0 $HOME/.hyper_plugins/local/

# iterm
# enable italics by adding terminfo
tic $HOME/dotfiles/iterm/tmux.terminfo
tic $HOME/dotfiles/iterm/xterm-256color.terminfo
tic $HOME/dotfiles/iterm/tmux-256color.terminfo


# tmux
ln -fs $HOME/dotfiles/tmux/.tmux.conf $HOME/

# kwm + khd
ln -fs $HOME/dotfiles/wm/kwm/kwmrc $HOME/.kwm/
ln -fs $HOME/dotfiles/wm/khd/.khdrc $HOME/

# ubersicht
ln -fs $HOME/dotfiles/ubersicht/WidgetSettings.json $HOME/Library/Application\ Support/tracesOf.Uebersicht/

# Atom

# Copy over Atom configs
# cp -r atom/packages.list $HOME/.atom

# Install community packages
# apm list --installed --bare - get a list of installed packages
# apm install --packages-file $HOME/.atom/packages.list


# Reload zsh settings
source $HOME/.zshrc
