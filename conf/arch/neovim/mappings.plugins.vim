"""

" -- keymapping that uses functionality of plugins


" universal mappings {{{

let g:UltiSnipsExpandTrigger = "<C-j>"

" }}}


" normal mappings {{{

" ALE
nmap <silent><Up> <Plug>(ale_previous_wrap)
nmap <silent><Down> <Plug>(ale_next_wrap)


" EasyAlign
nmap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" Haskell
autocmd FileType haskell nnoremap <buffer> <silent>tt :GhcModType<CR>
autocmd FileType haskell nnoremap <buffer> <silent>tc :GhcModTypeClear<CR>
autocmd FileType haskell nnoremap <buffer> <silent>ti :GhcModTypeInsert<CR>
autocmd FileType haskell nnoremap <buffer> <silent>ts :GhcModSplitFunCase<CR>


" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" ReasonPrettyPrint
autocmd FileType reason nnoremap <buffer> <Leader><Leader>f :ReasonPrettyPrint<Cr>


" Tern
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>

" }}}


" insert mappings {{{

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" select the completion with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" }}}


" visual select mappings {{{

" }}}


" visual mappings {{{

" EasyAlign
xmap ga <Plug>(EasyAlign)

" }}}
