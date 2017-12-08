"""

" -- keymapping that uses functionality of plugins


" universal mappings {{{

let g:UltiSnipsExpandTrigger = '<C-j>'

" }}}


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
nnoremap <silent> <Leader>f :F<CR>

" EasyAlign
nnoremap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTreeFind<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" Tagbar
nmap <buffer> <Leader>ct :TagbarToggle<CR>

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
