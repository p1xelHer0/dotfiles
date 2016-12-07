# Install zsh
brew install zsh

# Install oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# Install zsh-syntax-highlighting to oh-my-zsh custom plugins
cd $HOME/.oh-my-zsh/custom/plugins && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# Install base16-shell
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

# Change default shell
chsh -s $(which zsh)
