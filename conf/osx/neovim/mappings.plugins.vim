"""

" -- keymapping that uses functionality of plugins


" Universal mappings {{{

let g:UltiSnipsExpandTrigger = "<C-j>"

" }}}


" Normal mappings {{{

" ALE
nmap <silent><Up> <Plug>(ale_previous_wrap)
nmap <silent><Down> <Plug>(ale_next_wrap)


" EasyAlign
nmap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" ReasonPrettyPrint
autocmd FileType reason nnoremap <buffer> <Leader><Leader>f :ReasonPrettyPrint<Cr>


" Tern
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>

" }}}


" Insert mappings {{{

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enter closes options if present and inserts linebreak
" Apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" }}}


" Visual select mappings {{{

" }}}


" Visual mappings {{{

" EasyAlign
xmap ga <Plug>(EasyAlign)

" }}} Visual mappings
