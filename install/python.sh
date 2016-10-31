# this installs the latest version of python, not sure if this is good but, w/e
pyenv install $(pyenv install --list | grep -v - | grep -v b | tail -1)
pyenv global $(pyenv install --list | grep -v - | grep -v b | tail -1)
exec $SHELL
pip install jupyter
