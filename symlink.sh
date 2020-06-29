#!/bin/bash

# alacritty
mkdir -p "$HOME/.config/alacritty"
# my alacritty config is a wal template
ln -fs "$HOME/dotfiles/conf/alacritty/alacritty.yml" "$HOME/.config/wal/templates/"
ln -fs "$HOME/.cache/wal/alacritty.yml" "$HOME/.config/alacritty/"

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
