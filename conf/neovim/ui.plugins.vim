"""

" -- themes, colors and everything that affects the look of plugins


" ALE {{{

let g:ale_sign_column_always = 1

highlight ALEWarning term=reverse cterm=reverse ctermfg=3
highlight link ALEWarningSign ALEWarning

highlight ALEError term=reverse cterm=reverse ctermfg=16
highlight link ALEErrorSign ALEError


" }}}


" GitGutter {{{

" Git status icons
highlight GitGutterAdd ctermbg=0
let g:gitgutter_sign_added = '+'

highlight GitGutterChange ctermbg=0
let g:gitgutter_sign_modified = '~'

highlight GitGutterDelete ctermbg=0
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'

highlight GitGutterChangeDelete ctermbg=0
let g:gitgutter_sign_modified_removed = '_'

" }}}


" NERDTree {{{

let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowFiles=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0

" arrows
if !IsMacOS()
  let g:NERDTreeDirArrowExpandable='▶'
  let g:NERDTreeDirArrowCollapsible='▼'
endif

" Git status icons
let g:NERDTreeIndicatorMapCustom = {
\ 'Modified'  : '~',
\ 'Staged'    : '▲',
\ 'Untracked' : '▼',
\ 'Renamed'   : '→',
\ 'Unmerged'  : '=',
\ 'Deleted'   : '-',
\ 'Dirty'     : '~',
\ 'Clean'     : '◆',
\ 'Unknown'   : '?'
\ }

" colors
highlight NERDTreeBookmarksLeader ctermfg=4 ctermbg=0
highlight NERDTreeGitStatusDirDirtytracked ctermfg=3
highlight NERDTreeGitStatusModified ctermfg=3
highlight link NERDTreeGitStatusDirClean DiffAdd
highlight link NERDTreeGitStatusStaged Special
highlight link NERDTreeGitStatusRenamed DiffLine
highlight link NERDTreeGitStatusUnmerged DiffLine
highlight link NERDTreeGitStatusUntracked DiffFile
highlight link NERDTreeGitStatusIgnored DiffFile

" }}}
