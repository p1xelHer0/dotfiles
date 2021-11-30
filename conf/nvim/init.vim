color ttwnty

lua require("init")

augroup insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

" enable jsx/tsx
augroup jsx_and_tsx
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
augroup vim_enter
  autocmd!
  autocmd VimEnter * autocmd vim_enter WinEnter * let w:created = 1
augroup END

" autoresize windows on terminal resize
augroup vim_resize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup END

" only show the colorcolumn if the width surpasses 80 on that specific line
highlight OverLength ctermfg=0 ctermbg=3
match OverLength /\%82v/


" -----------------------------------------------------------------------------
" vim-active-numbers
" -----------------------------------------------------------------------------
let g:actnum_exclude = ['nerdtree', 'unite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m', '']

" -----------------------------------------------------------------------------
" vim-litecorrect
" -----------------------------------------------------------------------------
augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
augroup END

" -----------------------------------------------------------------------------
" vim-lexical
" -----------------------------------------------------------------------------
let g:lexical#thesaurus = ['$HOME/dotfiles/thesaurus/moby.txt',]

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
augroup END

" -----------------------------------------------------------------------------
" vim-signify
" -----------------------------------------------------------------------------
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'


" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Show syntax highlighting groups for word under cursor
nmap <F2> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
