"""

" -- themes, colors and everything that affects the look of Neovim


" wal {{{

colorscheme wal

" }}}


" base16 {{{

" theme must be set before Neovim can use the fg and bg colors!
" see: :h cterm-colors: E419, E420
" https://github.com/chriskempson/base16-shell
" load theme from base16-shell
" let g:base16colorspace=256
" if IsMacOS()
  " if filereadable(expand('$HOME/.vimrc_background'))
    " source $HOME/.vimrc_background
  " endif
" else
  " if !exists('g:colors_name') || g:colors_name !=? 'base16-apathy'
    " colorscheme base16-apathy
  " endif
" endif

" }}}


" default settings {{{

" syntax enable - default neovim

" split border
set fillchars+=vert: 
highlight VertSplit ctermfg=0 ctermbg=0
highlight LineNr ctermbg=0
highlight CursorLineNr cterm=bold ctermfg=3 ctermbg=0

" selection
highlight CursorLine cterm=NONE
highlight Visual ctermbg=0 cterm=reverse

" fold
" highlight Folded
highlight Folded ctermfg=8
highlight FoldColumn ctermfg=8

" wildmenu
highlight WildMenu ctermfg=0

" error
" highlight Error ctermbg=16
" highlight ErrorMsg ctermfg=16

" search
highlight Search ctermfg=0

" NonText same color as bg, aka only shown at the current line
highlight NonText ctermfg=0
highlight EndOfBuffer ctermfg=0

" highlight DiffAdd cterm=reverse
" highlight DiffChange cterm=reverse
" highlight DiffDelete cterm=reverse
" highlight DiffText cterm=reverse

" italic for this and XML (HTML) attributes
" highlight htmlArg cterm=italic
" highlight jsThis cterm=italic
" highlight xmlAttrib cterm=italic

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
augroup vim_enter
  autocmd!
  autocmd VimEnter * autocmd vim_enter WinEnter * let w:created=1
augroup END

" autoresize windows on terminal resize
augroup vim_resize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup END

" disable paste mode on leaving INSERT mode
augroup insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

" only show the colorcolumn if the width surpasses 120 on that specific line
highlight OverLength ctermbg=3 ctermfg=0
match OverLength /\%121v/

" only show cursorline on focused window
autocmd BufEnter,FocusGained,VimEnter,WinEnter * setlocal cursorline
autocmd FocusLost,WinLeave * setlocal nocursorline

" }}}
