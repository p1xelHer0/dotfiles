# oh-my-zsh Bureau Theme
# modified
# removed [] from everything
# changed STAGED    symbol to  
# changed UNSTAGED  symbol to ~
# changed UNTRACKED symbol to +
# changed AHEAD     symbol to ▲
# changed BEHIND    symbol to ▼
# changed CLEAN     symbol to ◆


# nvm
ZSH_THEME_NVM_PROMPT_PREFIX=" %F{2}"
ZSH_THEME_NVM_PROMPT_SUFFIX="%{$reset_color%}"

# set Git colors addording to .gitconfig
_GIT_ADDED_COLOR=$(git config --list | grep added | grep -o -E "[0-8]")
_GIT_CHANGED_COLOR=$(git config --list | grep changed | grep -o -E "[0-8]")
_GIT_UNTRACKED_COLOR=$(git config --list | grep untracked | grep -o -E "[0-8]")

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{${_GIT_ADDED_COLOR}}◆%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{4}▲%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%F{5}▼%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%F{${_GIT_ADDED_COLOR}}×%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%F{${_GIT_CHANGED_COLOR}}~%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{${_GIT_UNTRACKED_COLOR}}+%{$reset_color%}"

bureau_git_branch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

bureau_node_status() {

  _STATUS=""

  # check status of files
  _INDEX=$(command git status --porcelain 2> /dev/null)
  if [[ -n "$_INDEX" ]]; then
    if $(echo "$_INDEX" | command grep -q '^[AMRD]. '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    else
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  echo $_STATUS
}

bureau_git_status() {
  _STATUS=""

  # check status of files
  _INDEX=$(command git status --porcelain 2> /dev/null)
  if [[ -n "$_INDEX" ]]; then
    if $(echo "$_INDEX" | command grep -q '^[AMRD]. '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    if $(echo "$_INDEX" | command grep -q '^.[MTD] '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
    fi
    if $(echo "$_INDEX" | command grep -q -E '^\?\? '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if $(echo "$_INDEX" | command grep -q '^UU '); then
      _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  else
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  # check status of local repository
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  if $(echo "$_INDEX" | command grep -q '^## .*ahead'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | command grep -q '^## .*behind'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | command grep -q '^## .*diverged'); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  if $(command git rev-parse --verify refs/stash &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $_STATUS
}

bureau_git_prompt () {
  local _branch=$(bureau_git_branch)
  local _status=$(bureau_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}


_PATH="%F{6}%~%{$reset_color%}"

if [[ $EUID -eq 0 ]]; then
  _USERNAME="%F{1}%n"
  _LIBERTY="%F{1}#"
# I want vi-mode here
elif [[ $EUID -ne 0 ]]; then
  _USERNAME="%F{6}%n"
  _LIBERTY="%F{2}$"
else
  _USERNAME="%F{6}%n"
  _LIBERTY="%F{2}$"
fi
_USERNAME="$_USERNAME%{$reset_color%}@%m"
_LIBERTY="$_LIBERTY%{$reset_color%}"

setopt prompt_subst
PROMPT='$_PATH$(bureau_git_prompt)$(nvm_prompt_info)
$_LIBERTY '
