# p1xelHer0 ZSH Theme

PROMPT='$fg[green]%#$fg[magenta] @ $fg[cyan]$(get_pwd) $(git_prompt_info)
$fg[cyan]🤔  > %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="$fg[magenta]· $fg[blue]"
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY=" 💩 "
ZSH_THEME_GIT_PROMPT_CLEAN=" 👌 "

function get_pwd() {
  echo "${PWD/$HOME/~}"
}
