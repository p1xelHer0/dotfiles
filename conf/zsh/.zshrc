###

# -- here be turtles


if [[ $(uname) == "Darwin" ]]; then
  IS_MACOS=true
fi


# theme
ZSH_THEME=p1xelHer0

# import colorscheme from 'wal'
if [[ -n "$IS_MACOS" ]]; then
else
  (wal -r &)
fi


autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit


# settings {{{

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd.mm.yyyy"

# }}}


# oh-my-zsh {{{

export ZSH=$HOME/.oh-my-zsh

plugins=(zsh-syntax-highlighting)

# add osx plugin on macOS
if [[ -n "$IS_MACOS" ]]; then
  plugins+=(osx)
fi

# }}}


# base16-shell {{{

# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# source $HOME/dotfiles/conf/base16/.colors

# }}}


# nvm {{{

export NVM_DIR=$HOME/.nvm

if [[ -n "$IS_MACOS" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
else
  [ -s "/usr/share/nvm/nvm.sh" ] && . "/usr/share/nvm/nvm.sh"
fi

NODE_VERSION=$(node --version | grep -v -)

# }}}


# $PATH {{{

# Haskell
export STACK_PACKAGES=$HOME/.local/bin


# set $PATH
export PATH=$STACK_PACKAGES:$PATH

# }}}


# macOS $PATH {{{

if [[ -n "$IS_MACOS" ]]; then
  # chunkc + chunkwm
  export CHUNKWM=$HOME/chunkwm/bin
  export CHUNKC=$HOME/chunkwm/src/chunkc/bin


  # Python
  export PYENV_ROOT=$HOME/.pyenv


  # Rust
  export CARGO_HOME=$HOME/.cargo/bin


  # React Native
  export REACT_NATIVE=$HOME/.nvm/versions/node/$NODE_VERSION/bin/react-native


  # xcode simctl is needed for react-native emulator
  export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer/


  # Java
  export JENV=$HOME/.jenv/bin


  # Android
  export ANT_HOME=/usr/local/opt/ant
  export MAVEN_HOME=/usr/local/opt/maven
  export GRADLE_HOME=/usr/local/opt/gradle
  export ANDROID_HOME=/usr/local/opt/android-sdk
  export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
else
  # rice scripts
  export RICE_SCRIPTS=$HOME/dotfiles/bin/arch
fi


# set macOS $PATH
if [[ -n "$IS_MACOS" ]]; then
  export PATH=$CHUNKWM:$PATH
  export PATH=$CHUNKC:$PATH

  export PATH=$PYENV_ROOT/bin:$PATH

  export PATH=$STACK_PACKAGES:$PATH

  export PATH=$CARGO_HOME:$PATH

  export PATH=$REACT_NATIVE_HOME:$PATH

  export PATH=$JENV:$PATH

  export PATH=$ANDROID_HOME/tools:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH
  export PATH=$ANDROID_HOME/build-tools/23.0.1:$PATH

  export PATH=$ANT_HOME/bin:$PATH
  export PATH=$MAVEN_HOME/bin:$PATH
  export PATH=$GRADLE_HOME/bin:$PATH
else
  export PATH=$RICE_SCRIPTS:$PATH
fi

# }}}


# NA > EU confirmed?
export LANG=en_US.UTF-8


# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# ssh
# export SSH_KEY_PATH="$HOME/.ssh/dsa_id"


# Source and init all helpers {{{

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh


# load aliases
if [[ -n "$IS_MACOS" ]]; then
  source $HOME/dotfiles/conf/osx/alias/.alias
else
  source $HOME/dotfiles/conf/arch/alias/.alias
fi


# load fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi


# load fzf
if [[ -n "$IS_MACOS" ]]; then
  [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
else
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
fi


# setup function to only load stuff when we need them
# see: https://kev.inburke.com/kevin/profiling-zsh-startup-time

# load jenv
# jenv() {
#   eval "$(command jenv init -)"
#   jenv "$@"
# }


# load pyenv
if [[ -n "$IS_MACOS" ]]; then
  pyenv() {
    printf "\e[38;5;2mpyenv init... "
    eval "$(command pyenv init -)"
    printf "\e[38;5;00m\e[48;5;2m done\e[38;5;2m\e[48;5;00m█▓░";
    printf "\e[38;5;4m pyenv virtualenv init... "
    eval "$(command pyenv virtualenv-init -)"
    export PYENV_INIT=1
    printf "\e[38;5;00m\e[48;5;4m done\e[38;5;4m\e[48;5;00m█▓░\e[0m\n";
    pyenv "$@"
  }
fi


# load stack
if which stack > /dev/null; then
  eval "$(command stack --bash-completion-script stack)"
fi


# load rbenv
if [[ -n "$IS_MACOS" ]]; then
  rbenv() {
    printf "\e[38;5;16mrbenv init... "
    eval "$(command rbenv init -)"
    export RBENV_INIT=1
    printf "\e[38;5;00m\e[48;5;16m done\e[38;5;16m\e[48;5;00m█▓░\e[0m\n";
    rbenv "$@"
  }
fi


# npm tab completion
. <(npm completion)


# load all configs
for config ($HOME/dotfiles/conf/zsh/*.zsh) source $config

# }}}
