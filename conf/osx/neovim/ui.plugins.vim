" ## Plugin settings {{

" # ALE {
highlight ALEWarning cterm=underline ctermfg=3
highlight ALEError cterm=underline ctermfg=16
" } ALE #


" # NERDTree {
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

" Open NERDTree when opening a directory or just starting Neovim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" NERDTree Git status icons
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

" NERDTree colors
highlight NERDTreeGitStatusDirDirtytracked ctermfg=3
highlight NERDTreeGitStatusModified ctermfg=3
highlight link NERDTreeGitStatusDirClean DiffAdd
highlight link NERDTreeGitStatusStaged Special
highlight link NERDTreeGitStatusRenamed DiffLine
highlight link NERDTreeGitStatusUnmerged DiffLine
highlight link NERDTreeGitStatusUntracked DiffFile
highlight link NERDTreeGitStatusIgnored DiffFile
" } NERDTree #

" }} Plugin settings ##
