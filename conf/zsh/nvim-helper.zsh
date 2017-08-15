# make neovim initialize rbenv and pyenv if they are not
# no idea if this a good solution, but it works
vim() {
  if [ -z ${RBENV_INIT+x} ]; then
    printf "\e[38;5;1mrbenv init... "
    eval "$(command rbenv init -)"
    export RBENV_INIT=1
    printf "done\e[0m\n";
  fi
  if [ -z ${PYENV_INIT+x} ]; then
    printf "\e[38;5;2mpyenv init... "
    eval "$(command pyenv init -)"
    printf "done";
    printf "\e[38;5;4m pyenv virtualenv init... "
    eval "$(command pyenv virtualenv-init -)"
    export PYENV_INIT=1
    printf "done\e[0m\n";
  fi
  nvim "$@"
}
