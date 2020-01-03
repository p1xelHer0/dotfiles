#!/bin/bash

# alacritty
mkdir -p "$HOME/.config/alacritty"
ln -fs "$HOME/dotfiles/conf/_darwin/alacritty/alacritty.yml" "$HOME/.config/alacritty/"

# base16
touch "$HOME/dotfiles/conf/base16/.base16"
ln -fs "$HOME/dotfiles/conf/base16/base16-p1xelHer0.sh" "$HOME/.config/base16-shell/scripts"

# git
ln -fs "$HOME/dotfiles/conf/git/.gitconfig" "$HOME/"

# karabiner elements
ln -fs "$HOME/dotfiles/conf/_darwin/karabiner-elements/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# neofetch
ln -fs "$HOME/dotfiles/conf/neofetch/config" "$HOME/.config/neofetch/config"

# nvim
ln -fs "$HOME/dotfiles/conf/nvim/.vimrc" "$HOME/.config/nvim/init.vim"
ln -fs "$HOME/dotfiles/conf/nvim/UltiSnips" "$HOME/.config/nvim/"
ln -fs "$HOME/dotfiles/conf/nvim/after" "$HOME/.config/nvim/"
ln -fs "$HOME/dotfiles/conf/nvim/colors" "$HOME/.config/nvim/"
ln -fs "$HOME/dotfiles/conf/nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

# ranger
ranger --copy-config=all
ln -fs "$HOME/dotfiles/conf/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

# skhd
ln -fs "$HOME/dotfiles/conf/_darwin/skhd/.skhdrc" "$HOME/"

# tmux
mkdir -p "$HOME/.tmux/plugins"
ln -fs "$HOME/dotfiles/conf/tmux/.tmux.conf" "$HOME/"

# ubersicht
touch "$HOME/dotfiles/conf/_darwin/ubersicht/widgets/nerdbar.widget/scripts/network.out"
ln -fs "$HOME/dotfiles/conf/_darwin/ubersicht/WidgetSettings.json" "$HOME/Library/Application\\ Support/tracesOf.Uebersicht/"

# yabai
ln -fs "$HOME/dotfiles/conf/_darwin/yabai/.yabairc" "$HOME/"
chmod +x "$HOME/.yabairc"

# zsh
ln -fs "$HOME/dotfiles/conf/zsh/themes/p1xelHer0.zsh-theme" "$HOME/.oh-my-zsh/themes/"
ln -fs "$HOME/dotfiles/conf/zsh/.zshrc" "$HOME/"
