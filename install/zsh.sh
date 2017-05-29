# Install zsh
brew install zsh

# Install oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# Install zsh-syntax-highlighting to oh-my-zsh custom plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins

# Install base16-shell
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

# Set default shell to zsh
chsh -s $(which zsh)
