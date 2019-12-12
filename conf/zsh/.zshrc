###

# -- here be turtles


export TERM=xterm-256color


if [[ $(uname) == "Darwin" ]]; then
  IS_MACOS=true
fi


# theme
ZSH_THEME=p1xelHer0

# import colorscheme from 'wal'
# if [[ -n "$IS_MACOS" ]]; then
# else
#   cat /home/pxl/.cache/wal/sequences
# fi


autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# use the maximum amount of file descriptors
ulimit -n 24576


# settings {{{

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd.mm.yyyy"

# }}}


# oh-my-zsh {{{

export ZSH=$HOME/.oh-my-zsh

# zsh-autosuggestions
plugins=(vi-mode zsh-syntax-highlighting)

# add osx plugin on macOS
if [[ -n "$IS_MACOS" ]]; then
  plugins+=(osx)
fi

# }}}


# $PATH {{{

# dotfile scripts
export DOT_SCRIPTS=$HOME/dotfiles/bin

# Yarn
export YARN_BIN=$HOME/.yarn/bin

# Haskell
export STACK_PACKAGES=$HOME/.local/bin
export HASKELL_IDE_ENGINE=$HOME/hie-bin/*

# Python
export PYENV_ROOT=$HOME/.pyenv

# Rust
export CARGO_HOME=$HOME/.cargo


# set $PATH
export PATH=$DOT_SCRIPTS:$PATH

export PATH=$YARN_BIN:$PATH

export PATH=$STACK_PACKAGES:$PATH

export PATH=$PYENV_ROOT/bin:$PATH

export PATH=$HASKELL_IDE_ENGINE:$PATH

export PATH=$CARGO_HOME:$PATH

# }}}


# macOS $PATH {{{

if [[ -n "$IS_MACOS" ]]; then
  # macOS dotfile scripts
  export MACOS_DOT_SCRIPTS=$HOME/dotfiles/bin/osx

  # clang
  # export CLANG=/usr/local/opt/llvm/bin

  # React Native
  export REACT_NATIVE=$HOME/.nvm/versions/node/$NODE_VERSION/bin/react-native
  export REACT_DEBUGGER="unset ELECTRON_RUN_AS_NODE && open -g 'rndebugger://set-debugger-loc?port=19001' ||" yarn start

  # xcode simctl is needed for react-native emulator
  export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer/

  # Mono
  export MONO_ROOT=/Library/Frameworks/Mono.framework/Versions/Current/bin

  # Java
  export JENV=$HOME/.jenv/bin

  # Android
  export ANT_HOME=/usr/local/opt/ant
  export MAVEN_HOME=/usr/local/opt/maven
  export GRADLE_HOME=/usr/local/opt/gradle
  export ANDROID_HOME=/usr/local/opt/android-sdk
  export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

# }}}


# Linux $PATH {{
else
  # Linux dotfile scripts
  export LINUX_DOT_SCRIPTS=$HOME/dotfiles/bin/linux
fi

# }}}


# set macOS $PATH
if [[ -n "$IS_MACOS" ]]; then
  export PATH=$MACOS_DOT_SCRIPTS:$PATH

  export PATH="/usr/local/sbin:$PATH"

  export PATH=$CLANG:$PATH

  export PATH=$STACK_PACKAGES:$PATH

  export PATH=$REACT_NATIVE_HOME:$PATH

  export PATH=$MONO_ROOT:$PATH

  export PATH=$JENV:$PATH

  export PATH=$ANT_HOME/bin:$PATH
  export PATH=$MAVEN_HOME/bin:$PATH
  export PATH=$GRADLE_HOME/bin:$PATH

  export PATH=$ANDROID_HOME/tools:$PATH
  export PATH=$ANDROID_HOME/tools/bin:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH
  export PATH=$ANDROID_HOME/build-tools/23.0.1:$PATH

# }}}


# set Linux $PATH {{{
else
  export PATH=$LINUX_DOT_SCRIPTS:$PATH
fi

# }}}


# NA > EU confirmed?
export LC_ALL=en_US.UTF-8


# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# use vi mode
# bindkey -v
# export KEYTIMEOUT=1

# only load custom ranger config
export RANGER_LOAD_DEFAULT_RC=false


# ssh
# export SSH_KEY_PATH="$HOME/.ssh/dsa_id"


# Source and init all helpers {{{

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh


# load aliases
if [[ -n "$IS_MACOS" ]]; then
  source $HOME/dotfiles/conf/osx/alias/.alias
else
  source $HOME/dotfiles/conf/linux/alias/.alias
fi


# load fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi


# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# load fnm
eval "$(fnm env --multi)"


# load rustup
source $CARGO_HOME/env

# setup function to only load stuff when we need them
# see: https://kev.inburke.com/kevin/profiling-zsh-startup-time

# load jenv
# jenv() {
#   eval "$(command jenv init -)"
#   jenv "$@"
# }


# load pyenv
pyenv() {
  printf "\e[38;5;2mpyenv init... "
  eval "$(command pyenv init -)"
  printf "done";
  printf "\e[38;5;4m pyenv virtualenv init... "
  eval "$(command pyenv virtualenv-init -)"
  export PYENV_INIT=1
  printf "done\e[0m\n";
  pyenv "$@"
}


# load stack
if which stack > /dev/null; then
  eval "$(command stack --bash-completion-script stack)"
fi


# load rbenv
rbenv() {
  printf "\e[38;5;1mrbenv init... "
  eval "$(command rbenv init -)"
  export RBENV_INIT=1
  printf "done\e[0m\n";
  rbenv "$@"
}


# npm tab completion
. <(npm completion)


# load all configs
for config ($HOME/dotfiles/conf/zsh/*.zsh) source $config

# }}}

