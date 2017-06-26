###

# -- here be turtles

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in $HOME/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME=p1xelHer0

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(osx zsh-syntax-highlighting)


# base16-shell {{{

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
source $HOME/dotfiles/conf/osx/base16/.colors

# }}}


# nvm {{{

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

NODE_VERSION=$(node --version | grep -v -)

# }}}


# $PATH {{{

# chunkc + chunkwm
export CHUNKWM=$HOME/chunkwm/bin
export CHUNKC=$HOME/chunkwm/src/chunkc/bin

# React Native
export REACT_NATIVE=$HOME/.nvm/versions/node/$NODE_VERSION/bin/react-native

# xcode simctl is needed for react-native emulator
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer/


# Rust
export CARGO_HOME=$HOME/.cargo/bin


# Haskell
export STACK_PACKAGES=$HOME/.local/bin


# Java
export JENV=$HOME/.jenv/bin


# Python
export PYENV_ROOT=$HOME/.pyenv


# Android
export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk


# set $PATH
export PATH=$CHUNKWM:$PATH
export PATH=$CHUNKC:$PATH
export PATH=$REACT_NATIVE_HOME:$PATH
export PATH=$CARGO_HOME:$PATH
export PATH=$STACK_PACKAGES:$PATH
export PATH=$JENV:$PATH
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/23.0.1:$PATH

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
source $HOME/dotfiles/conf/osx/alias/.alias


# load fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi


# load fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh


# setup function to only load stuff when we need them
# see: https://kev.inburke.com/kevin/profiling-zsh-startup-time

# load jenv
# jenv() {
#   eval "$(command jenv init -)"
#   jenv "$@"
# }


# load pyenv
pyenv() {
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}


# load stack
if which stack > /dev/null; then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
  eval "$(command stack --bash-completion-script stack)"
fi


# load rbenv
rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}


# npm tab completion
. <(npm completion)


# load all configs
for config ($HOME/dotfiles/conf/osx/zsh/*.zsh) source $config

# }}}
