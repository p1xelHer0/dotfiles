let g:neoformat_enabled_haskell = ['hindent', 'stylish-haskell']

" neco-ghc
setlocal omnifunc=necoghc#omnifunc
let g:haskellmode_completion_ghc = 1
let g:necoghc_enable_detailed_browse = 1

" ghc-vim
" nnoremap <buffer> <Leader>tt :GhcModType<CR>
" nnoremap <buffer> <Leader>tc :GhcModTypeClear<CR>
" nnoremap <buffer> <Leader>ti :GhcModTypeInsert<CR>
" nnoremap <buffer> <Leader>ts :GhcModSplitFunCase<CR>

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_case = 2             " two spaces for indentation

" intero-neovim
augroup autosave
  autocmd!
  autocmd BufWritePost *.hs InteroReload
augroup END

" Background process and window management
nnoremap <silent> <leader>is :InteroStart<CR>
nnoremap <silent> <leader>ik :InteroKill<CR>

" Open intero/GHCi split horizontally
nnoremap <silent> <leader>io :InteroOpen<CR>
nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
nnoremap <silent> <leader>ih :InteroHide<CR>

" Load individual modules
nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

" Type-related information
" Heads up! These next two differ from the rest.
map <silent> <leader>tg <Plug>InteroGenericType
map <silent> <leader>tt <Plug>InteroType
nnoremap <silent> <leader>ti :InteroTypeInsert<CR>

" Navigation
nnoremap <silent> <leader>dd :InteroGoToDef<CR>

" Managing targets
" Prompts you to enter targets (no silent):
nnoremap <leader>ist :InteroSetTargets<SPACE>
