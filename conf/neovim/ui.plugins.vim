"""

" -- themes, colors and everything that affects the look of plugins

scriptencoding utf-8
set encoding=utf-8


" ALE {{{

let g:ale_sign_column_always = 1

highlight ALEWarning cterm=underline
highlight link ALEWarningSign ALEWarning

highlight ALEError cterm=underline
highlight link ALEErrorSign ALEError


" }}}


" fzf {{{

let $FZF_DEFAULT_OPTS .= ' --inline-info'

" }}}


" GitGutter {{{

" Git status icons
execute 'highlight GitGutterAdd ctermbg=0 ctermfg=' . g:GitAddColor
execute 'highlight GitGutterChange ctermbg=0 ctermfg=' . g:GitChangeColor
execute 'highlight GitGutterDelete ctermbg=0 ctermfg=' . g:GitUntrackedColor
execute 'highlight GitGutterChangeDelete ctermbg=0 ctermfg=' . g:GitUntrackedColor

" }}}


" NERDTree {{{

let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowFiles=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0

" Git status icons
let g:NERDTreeIndicatorMapCustom = {
\ 'Modified'  : '~',
\ 'Staged'    : '▲',
\ 'Untracked' : '▼',
\ 'Renamed'   : '→',
\ 'Unmerged'  : '=',
\ 'Deleted'   : '_',
\ 'Dirty'     : '~',
\ 'Clean'     : '◆',
\ 'Unknown'   : '?'
\ }

" colors
highlight link NERDTreeBookmarksLeader NERDTreeDirSlash
execute 'highlight NERDTreeGitStatusStaged ctermfg=' . g:GitChangeColor
execute 'highlight NERDTreeGitStatusModified ctermfg=' . g:GitChangeColor
execute 'highlight NERDTreeGitStatusUntracked ctermfg=' . g:GitUntrackedColor
execute 'highlight NERDTreeGitStatusRenamed ctermfg=' . g:GitUntrackedColor
execute 'highlight NERDTreeGitStatusUnmerged ctermfg=' . g:GitUntrackedColor
execute 'highlight NERDTreeGitStatusIgnored ctermfg=' . g:GitUntrackedColor

" }}}
