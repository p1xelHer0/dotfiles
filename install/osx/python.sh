#!/bin/bash

# install latest version of Python 2 and 3
# set up virtualenvs for Neovim

python2="todo"
python3=$(pyenv install --list | grep -v - | grep -v b | tail -1)

# install latest Python version
pyenv install $python3

# restart for changes to take effect
exec zsh

# set global Python
pyenv global $

# setup pyenvs for neovim
pyenv virtualenv $python3 neovim3
pyenv activate neovim3
pip install neovim
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python_host_prog in 'neovim/.vimrc'
pyenv which python # Note the path

pyenv virtualenv $python2 neovim2
pyenv activate neovim2
pip install neovim
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python3_host_prog in 'neovim/.vimrc'
pyenv which python  # Note the path

# update pip
pip install --upgrade pip
