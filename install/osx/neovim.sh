## Install vim-plug and symlinks Neovim files

# Instll vim-plug
mkdir -p $HOME/.config/nvim/autoload
wget -O $HOME/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Symlink
ln -fs $HOME/dotfiles/conf/osx/neovim/.vimrc $HOME/.config/nvim/init.vim
ln -fs $HOME/dotfiles/conf/osx/neovim/colors.vim $HOME/.config/nvim/autoload/
ln -fs $HOME/dotfiles/conf/osx/neovim/UltiSnips $HOME/.config/nvim/
