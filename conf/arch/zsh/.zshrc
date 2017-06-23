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

plugins=(zsh-syntax-highlighting)


# base16-shell {{{

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
source $HOME/dotfiles/conf/arch/base16/.colors

# }}}


# nvm {{{

export NVM_DIR=$HOME/.nvm
[ -s "/usr/share/nvm/nvm.sh" ] && . "/usr/share/nvm/nvm.sh"

NODE_VERSION=$(node --version | grep -v -)

# }}}


# $PATH {{{


# Rust
# export CARGO_HOME=$HOME/.cargo/bin


# Haskell
# export STACK_PACKAGES=$HOME/.local/bin


# set $PATH
# export PATH=$CARGO_HOME:$PATH
# export PATH=$STACK_PACKAGES:$PATH

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
source $HOME/dotfiles/conf/arch/alias/.alias


# load fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi


# load fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh


# load stack
if which stack > /dev/null; then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
  eval "$(command stack --bash-completion-script stack)"
fi


# npm tab completion
. <(npm completion)


# load all configs
for config ($HOME/dotfiles/conf/arch/zsh/*.zsh) source $config

# }}}
