"""

" -- everything that affects the non-color look of Neovim


colorscheme pxl19

" split border
set fillchars+=vert: 

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

" only show the colorcolumn if the width surpasses 80 on that specific line
highlight OverLength ctermfg=0 ctermbg=3
match OverLength /\%81v/
