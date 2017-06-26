"""

" -- themes, colors and everything that affects the look of Neovim


" base16 {{{

" theme must be set before Neovim can use the fg and bg colors!
" see: :h cterm-colors: E419, E420
" https://github.com/chriskempson/base16-shell
" load theme from base16-shell
" we really just need to load on base16-theme here
" the colors will match since we are using base16-shell
let base16colorspace=256
if !exists('g:colors_name') || g:colors_name != 'base16-apathy'
  colorscheme base16-apathy
endif


" }}}


" default settings {{{

" syntax enable - default neovim

" split border
set fillchars+=vert: 
highlight VertSplit ctermbg=bg
highlight LineNr ctermbg=bg
highlight CursorLineNr ctermbg=bg ctermfg=3

" selection
highlight Visual cterm=reverse

" wildmenu
highlight WildMenu ctermfg=19
highlight StatusLine ctermfg=fg

" error
highlight Error ctermbg=16
highlight ErrorMsg ctermfg=16

" search
highlight Search ctermfg=bg

" NonText same color as bg, aka only shown at the current line
highlight NonText ctermfg=bg
highlight EndOfBuffer ctermfg=bg

" italic for this and XML (HTML) attributes
" highlight htmlArg cterm=italic
" highlight jsThis cterm=italic
" highlight xmlAttrib cterm=italic

" autoresize windows on terminal resize
autocmd VimResized * execute "normal! \<C-w>="

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

" disable paste mode on leaving INSERT mode.
autocmd InsertLeave * set nopaste

" only show the colorcolumn if the width surpasses 120 on that specific line
highlight OverLength ctermbg=3 ctermfg=0
match OverLength /\%121v/

" only show cursorline on focused window
autocmd BufEnter,FocusGained,VimEnter,WinEnter * setlocal cursorline
autocmd FocusLost,WinLeave * setlocal nocursorline

" }}}
