"""

" -- plugin settings, everything that affects how a plugin works

scriptencoding utf-8
set encoding=utf-8


" Deoplete {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources = {}

augroup pumvisible
  autocmd!
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

set completeopt-=preview

" }}}


" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1


" UltiSnips
let g:UltiSnipsSnippetsDir = $HOME . '/.config/nvim/'
let g:UltiSnipsEditSplit = 'vertical'


" goyo.vim {{{

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux set pane-border-status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set nocursorline
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set nocursorline
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}


" Neoformat {{{

" use formatprg if possible
let g:neoformat_try_formatprg = 1
" let g:neoformat_verbose = 1

" }}}


" NERDTree {{{

" path to bookmarks
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")

" Open NERDTree when opening a directory or just starting Neovim
augroup NERDTree_open
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END

" }}}


" SuperTab {{{

let g:SuperTabCrMapping=1

" }}}
