"""

" -- keymapping that uses functionality of plugins


" universal mappings {{{

let g:UltiSnipsExpandTrigger = '<C-j>'

" }}}


" normal mappings {{{

" ALE
nmap <silent> <Up> <Plug>(ale_previous_wrap)
nmap <silent> <Down> <Plug>(ale_next_wrap)


" EasyAlign
nmap ga <Plug>(EasyAlign)


" goyo.vim
nnoremap <Leader>gv :Goyo<CR>


" Haskell

augroup filetype_haskell
  autocmd!
  autocmd FileType haskell nnoremap <buffer><silent> tt :GhcModType<CR>
  autocmd FileType haskell nnoremap <buffer><silent> tc :GhcModTypeClear<CR>
  autocmd FileType haskell nnoremap <buffer><silent> ti :GhcModTypeInsert<CR>
  autocmd FileType haskell nnoremap <buffer><silent> ts :GhcModSplitFunCase<CR>
augroup END


" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>


" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>


" ReasonPrettyPrint
augroup filetype_reason
  autocmd!
  autocmd FileType reason nnoremap <buffer> <Leader><Leader>f :ReasonPrettyPrint<Cr>
augroup END


" Tern
augroup filetype_javascript
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <Leader>d :TernDef<CR>
augroup END

" }}}


" insert mappings {{{

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}


" visual select mappings {{{

" }}}


" visual mappings {{{

" EasyAlign
xmap ga <Plug>(EasyAlign)

" }}}
