#!/bin/bash

# install version of Python 2 and 3
# set up virtualenvs for Neovim

# python3v=$(pyenv install -l | grep -v - | grep -v b | tail -1)

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

# install latest Python version
sudo pyenv install 3.7.4

# restart for changes to take effect
exec zsh

# set global Python
pyenv global 3.7.4

# setup pyenvs for neovim
pyenv virtualenv 3.7.4 neovim3
pyenv activate neovim3
pip install neovim
pip install --upgrade pip
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python_host_prog in 'neovim/.vimrc'
# pyenv which python # Note the path

pyenv virtualenv 2.7.15 neovim2
pyenv activate neovim2
pip install neovim
pip install --upgrade pip
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python3v in 'neovim/.vimrc'
pyenv which python  # Note the path

pyenv deactivate
pip install vim-vint

# update pip
pip install --upgrade pip

# install pywal
pip install pywal
