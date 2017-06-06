#!/bin/bash

## Install oh-my-zsh, zsh-syntax-highlighting, base16-shell
## Set zsh to default shell
## Symlink zsh-theme and .zshrc

# Install oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# Install zsh-syntax-highlighting to oh-my-zsh custom plugins
# https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


# Set default shell to zsh
chsh -s $(which zsh)

# Symlink
ln -fs $HOME/dotfiles/conf/osx/zsh/themes/p1xelHer0.zsh-theme $HOME/.oh-my-zsh/themes/
ln -fs $HOME/dotfiles/conf/osx/zsh/.zshrc $HOME/

# Restart for changes to take effect
exec zsh
