# vim: set foldmethod=marker foldlevel=0 nomodeline:

if [[ $(uname) == "Darwin" ]]; then
  DARWIN=true
fi

# =============================================================================
# settings {{{
# =============================================================================

# theme
ZSH_THEME=puck

# use the maximum amount of file descriptors
ulimit -n 24576

export LC_ALL=en_US.UTF-8
export EDITOR='nvim'

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd.mm.yyyy"


# }}}
# =============================================================================
# oh-my-zsh {{{
# =============================================================================

export ZSH=$HOME/.oh-my-zsh

# plugins
plugins=(vi-mode zsh-syntax-highlighting)


# }}}
# =============================================================================
# $PATH {{{
# =============================================================================

# dotfile scripts
export DOT_SCRIPTS=$HOME/dotfiles/bin

# Yarn
export YARN_BIN=$HOME/.yarn/bin


# set $PATH
export PATH=$DOT_SCRIPTS:$PATH

export PATH=$YARN_BIN:$PATH


# -----------------------------------------------------------------------------
# macOS $PATH
# -----------------------------------------------------------------------------

if [[ -n "$DARWIN" ]]; then
  # macOS dotfile scripts
  export MACOS_DOT_SCRIPTS=$HOME/dotfiles/bin/_darwin

  # set $PATH
  export PATH=$MACOS_DOT_SCRIPTS:$PATH

  export PATH="/usr/local/sbin:$PATH"

# -----------------------------------------------------------------------------
# Linux $PATH
# -----------------------------------------------------------------------------
else
  # Linux dotfile scripts
  export LINUX_DOT_SCRIPTS=$HOME/dotfiles/bin/linux

  # set $PATH
  export PATH=$LINUX_DOT_SCRIPTS:$PATH
fi


# }}}
# =============================================================================
# source and eval {{{
# =============================================================================

# aliases
source $HOME/dotfiles/conf/alias/.alias

if [[ -n "$DARWIN" ]]; then
  source $HOME/dotfiles/conf/_darwin/alias/.alias
else
  source $HOME/dotfiles/conf/_arch/alias/.alias
fi

# fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi

# fnm
eval "$(fnm env --multi)"

# npm tab completion
. <(npm completion)

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# lorri direnv niv
eval "$(direnv hook zsh)"


# }}}
# =============================================================================
# fzf {{{
# =============================================================================

# default options
# colors
# fullscreen
export FZF_DEFAULT_OPTS='
  --color fg:7,bg:0,hl:3,fg+:4,bg+:0,hl+:3,info:2
  --color prompt:6,spinner:4,pointer:3,marker:3,header:2
  --no-height --no-reverse
'

# make fzf use ripgrep
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow 2> /dev/null'

# use the same command with <C-t>
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# preview contents of file
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
# see https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# use the same command with <A-c>
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Git + fzf
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-git-wrapper() {
  fzf --no-height --no-reverse "$@"
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-git-wrapper -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-git-wrapper --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-git-wrapper --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-git-wrapper --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-git-wrapper --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper f b t r h
unset -f bind-git-helper

[ -f $HOME/.nix-profile/share/fzf/key-bindings.zsh ] && source $HOME/.nix-profile/share/fzf/key-bindings.zsh


# }}}

# =============================================================================
# nix {{{
# =============================================================================

# added by Nix installer
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi


# }}}
