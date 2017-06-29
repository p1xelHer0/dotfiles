# make neovim initialize rbenv and pyenv if they are not
# no idea if this a good solution, but it works
vim() {
  if [ -z ${RBENV_INIT+x} ]; then
    eval "$(command rbenv init -)"
    export RBENV_INIT=1
    echo "rbenv init"
  fi

  if [ -z ${PYENV_INIT+x} ]; then
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    export PYENV_INIT=1
    echo "pyenv init"
  fi
  nvim "$@"
}
