#!/bin/bash

## Install latest version of Python 2 and 3
## Set up virtualenvs for Neovim

python2="todo"
python3=$(pyenv install --list | grep -v - | grep -v b | tail -1)

# Install latest Python version
pyenv install $python3

# Restart for changes to take effect
exec zsh

# Set global Python
pyenv global $

# Setup pyenvs for neovim
pyenv virtualenv $python3 neovim3
pyenv activate neovim3
pip install neovim
# Upgrade with 'pip install --upgrade neovim'
# Set path to let g:python_host_prog in 'nvim/init.vim'
pyenv which python # Note the path

pyenv virtualenv $python2 neovim2
pyenv activate neovim2
pip install neovim
# Upgrade with 'pip install --upgrade neovim'
# Set path to let g:python3_host_prog in 'nvim/init.vim'
pyenv which python  # Note the path

# Update pip
pip install --upgrade pip
