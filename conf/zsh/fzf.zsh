# fzf {{{

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
# --glob: Don't search git/node_modules
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'

# use the same command with <C-t>
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# preview contents of file
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
# see https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# use the same command with <A-c>
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# }}}


# Git + fzf {{{

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

# }}}
