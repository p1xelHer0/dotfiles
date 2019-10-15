"""

" -- keymapping that uses functionality of plugins


" universal mappings {{{

let g:UltiSnipsExpandTrigger = '<C-j>'

" }}}


" normal mappings {{{

" ALE (mappings replaced with coc.nvim
" nmap [W <Plug>(ale_first)
" nmap [w <Plug>(ale_previous)
" nmap ]w <Plug>(ale_next)
" nmap ]W <Plug>(ale_last)


" fzf
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" EasyAlign
nnoremap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>

" LanugageClient (l for lang)
" nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<CR>
" nnoremap <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap <silent> <leader>lx :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> <leader>la :call LanguageClient#workspace_applyEdit()<CR>
" nnoremap <silent> <leader>lc :call LanguageClient#textDocument_completion()<CR>
" nnoremap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> <leader>lm :call LanguageClient_contextMenu()<CR>

" coc.nvim (replaces LanguageClient)
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lD <Plug>(coc-declaration)

nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lR <Plug>(coc-refactor)

nmap <silent> <leader>lf <Plug>(coc-format-selected)
vmap <silent> <leader>lf <Plug>(coc-format-selected)

nmap <silent> <leader>lt <Plug>(coc-type-definition)

nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> ]e <Plug>(coc-diagnostic-prev-error)

" nnoremap <silent> <leader>lx <Plug>(coc-)
" nnoremap <silent> <leader>la <Plug>(coc-)
" nnoremap <silent> <leader>lc <Plug>(coc-)
" nnoremap <silent> <leader>lh <Plug>(coc-)
" nnoremap <silent> <leader>ls <Plug>(coc-)
" nnoremap <silent> <leader>lm <Plug>(coc-)

" NERDTree
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTreeFind<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" Tagbar
nnoremap <buffer> <Leader>ct :TagbarToggle<CR>

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
