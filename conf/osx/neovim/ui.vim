" ## Base16 {

" Theme must be set before Neovim can use the fg and bg colors!
" See: :h cterm-colors: E419, E420
" https://github.com/chriskempson/base16-shell
" Load theme from base16-shell
if filereadable(expand("$HOME/.vimrc_background"))
  let base16colorspace=256
  source $HOME/.vimrc_background
endif

" } Base16 ##


" ## Default settings {{

" syntax enable - default neovim

" Split border
set fillchars+=vert: 
highlight VertSplit ctermfg=18 ctermbg=18
highlight LineNr ctermbg=18
highlight CursorLineNr cterm=bold ctermfg=3

" Wildmenu
highlight WildMenu ctermfg=19
highlight StatusLine ctermfg=fg

" Error
highlight Error ctermbg=16
highlight ErrorMsg ctermfg=16

" Search
highlight Search ctermfg=bg

" NonText same color as bg, aka only shown at the current line
highlight NonText ctermfg=bg
highlight EndOfBuffer ctermfg=bg

" Italic for this and XML (HTML) attributes
highlight htmlArg cterm=italic
highlight jsThis cterm=italic
highlight xmlAttrib cterm=italic

" Autoresize windows on terminal resize
autocmd VimResized * execute "normal! \<C-w>="

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

" Disable paste mode on leaving INSERT mode.
autocmd InsertLeave * set nopaste

" Only show the colorcolumn if the width surpasses 120 on that specific line
highlight OverLength ctermbg=3 ctermfg=0
match OverLength /\%121v/

" Only show cursorline on focused window
autocmd BufEnter,FocusGained,VimEnter,WinEnter * setlocal cursorline
autocmd FocusLost,WinLeave * setlocal nocursorline

" }} Default settings ##
