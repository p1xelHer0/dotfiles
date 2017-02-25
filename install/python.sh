# this installs the latest version of python, not sure if this is good but, w/e
pyenv install $(pyenv install --list | grep -v - | grep -v b | tail -1)
pyenv global $(pyenv install --list | grep -v - | grep -v b | tail -1)
exec $SHELL

# setup pyenvs for neovim
pyenv virtualenv $(pyenv install --list | grep -v - | grep -v b | tail -1) neovim3
pyenv activate neovim3
pip install neovim
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python_host_prog in 'nvim/init.vim'
pyenv which python


pyenv virtualenv <python2v> neovim2
pyenv activate neovim2
pip install neovim
# upgrade with 'pip install --upgrade neovim'
# set path to let g:python3_host_prog in 'nvim/init.vim'
pyenv which python  # Note the path

# update pip
pip install --upgrade pip

# in nvim
:UpdateRemotePlugins
