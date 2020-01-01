#!/bin/bash

# install oh-my-zsh, zsh-syntax-highlighting, base16-shell
# set zsh to default shell

# install oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install zsh-syntax-highlighting to oh-my-zsh custom plugins
# https://github.com/zsh-users/zsh-syntax-highlighting.git
mkdir -p "$HOME/.oh-my-zsh/custom/plugins/"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# install zsh-autosuggestions to oh-my-zsh custom plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"


# set default shell to zsh
chsh -s "$(which zsh)"

