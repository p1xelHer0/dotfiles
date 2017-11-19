"""

" -- keymapping that uses functionality of plugins

scriptencoding utf-8
set encoding=utf-8


" universal mappings {{{

let g:UltiSnipsExpandTrigger = '<C-j>'

" }}}


" normal mappings {{{

" ALE
nnoremap <silent> [W <Plug>(ale_first)
nnoremap <silent> [w <Plug>(ale_previous)
nnoremap <silent> ]w <Plug>(ale_next)
nnoremap <silent> ]W <Plug>(ale_last)


" fzf
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>t :Tags<CR>

" EasyAlign
nnoremap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" Tagbar
nmap <buffer><silent> ct :TagbarToggle<CR>

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
