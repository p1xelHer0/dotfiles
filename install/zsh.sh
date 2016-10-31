# Install zsh
brew install zsh

# Install oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# Install zsh-syntax-highlighting to oh-my-zsh custom plugins
cd ~/.oh-my-zsh/custom/plugins && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# Change default shell
chsh -s $(which zsh)
