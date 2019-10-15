let g:Default_reasonServer = {
\ 'reason': ['$HOME/reason-language-server']
\ }

let g:LanguageClient_serverCommands = g:Default_reasonServer

" enable Merlin related plugins
function! ReasonNative()
  call plug#load('vim-reasonml')
  execute 'LanguageClientStop'

  let g:LanguageClient_serverCommands = {
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ }

  " override LanguageClient type command with Merlins, its better
  nnoremap <silent> <Leader>lt :MerlinTypeOf<CR>
  nnoremap <silent> <Leader>mg :MerlinGrowEnclosing<CR>
  nnoremap <silent> <Leader>ms :MerlinShrinkEnclosing<CR>
  nnoremap <silent> <Leader>mc :MerlinClearEnclosing<CR>

  execute 'LanguageClientStart'
endfunction

" go back to reason-language-server
function! ReasonWeb()
  execute 'LanguageClientStop'

  let g:LanguageClient_serverCommands = g:Default_reasonServer

  nnoremap <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>

  execute 'LanguageClientStart'
endfunction

nnoremap <Leader>2r :!refmt --parse=ml --print=re % > %.re<CR>
nnoremap <Leader>2o :!refmt --parse=re --print=ml % > %.ml<CR>
