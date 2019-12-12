"""

" -- keymapping that uses functionality of plugins


" normal mappings {{{

" ALE
nmap [W <Plug>(ale_first)
nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)
nmap ]W <Plug>(ale_last)


" fzf
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>f :Rg<CR>


" EasyAlign
nnoremap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" coc.nvim {{{

  " gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD <Plug>(coc-declaration)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gt <Plug>(coc-type-definition)

  " change text
  nmap <silent> <leader>lr <Plug>(coc-rename)
  nmap <silent> <leader>lR <Plug>(coc-refactor)
  nmap <silent> <leader>lq <Plug>(coc-fix-current)
  nmap <silent> <leader>la <Plug>(coc-codeaction)
  nmap <silent> <leader>lf <Plug>(coc-format-selected)
  vmap <silent> <leader>lf <Plug>(coc-format-selected)

  " diagnostics
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

" }}}

" NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTreeFind<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>

" }}}


" insert mappings {{{

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}


" visual mappings {{{

" EasyAlign
xmap ga <Plug>(EasyAlign)

" }}}
