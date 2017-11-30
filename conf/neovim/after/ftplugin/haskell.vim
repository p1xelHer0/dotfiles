let g:neoformat_enabled_haskell = ['hindent', 'stylish-haskell']

" neco-ghc
let g:haskellmode_completion_ghc = 1
let g:necoghc_enable_detailed_browse = 1

" ghc-vim
autocmd FileType haskell nnomap <buffer> tt :GhcModType<CR>
autocmd FileType haskell nnomap <buffer> tc :GhcModTypeClear<CR>
autocmd FileType haskell nnomap <buffer> ti :GhcModTypeInsert<CR>
autocmd FileType haskell nnomap <buffer> ts :GhcModSplitFunCase<CR>

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_case = 2             " two spaces for indentation
