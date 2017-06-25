"""

" -- themes, colors and everything that affects the look of plugins


" ALE {{{

highlight ALEWarning cterm=underline ctermfg=3
highlight ALEError cterm=underline ctermfg=16

" }}}


" NERDTree {{{

let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

" arrows
let g:NERDTreeDirArrowExpandable='►'
let g:NERDTreeDirArrowCollapsible='▼'

" Git status icons
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "~",
\ "Staged"    : "▲",
\ "Untracked" : "▼",
\ "Renamed"   : "→",
\ "Unmerged"  : "=",
\ "Deleted"   : "-",
\ "Dirty"     : "~",
\ "Clean"     : "◆",
\ "Unknown"   : "?"
\ }

" colors
highlight NERDTreeGitStatusDirDirtytracked ctermfg=3
highlight NERDTreeGitStatusModified ctermfg=3
highlight link NERDTreeGitStatusDirClean DiffAdd
highlight link NERDTreeGitStatusStaged Special
highlight link NERDTreeGitStatusRenamed DiffLine
highlight link NERDTreeGitStatusUnmerged DiffLine
highlight link NERDTreeGitStatusUntracked DiffFile
highlight link NERDTreeGitStatusIgnored DiffFile

" }}}
