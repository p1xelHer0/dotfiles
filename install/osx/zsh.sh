#!/bin/bash

# install oh-my-zsh, zsh-syntax-highlighting, base16-shell
# set zsh to default shell
# symlink zsh-theme and .zshrc

# install oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# install zsh-syntax-highlighting to oh-my-zsh custom plugins
# https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


# set default shell to zsh
chsh -s $(which zsh)

# symlink
ln -fs $HOME/dotfiles/conf/osx/zsh/themes/p1xelHer0.zsh-theme $HOME/.oh-my-zsh/themes/
ln -fs $HOME/dotfiles/conf/osx/zsh/.zshrc $HOME/

# restart for changes to take effect
exec zsh
