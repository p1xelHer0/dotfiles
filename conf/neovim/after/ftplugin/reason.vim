" use this for revery
let g:LanguageClient_serverCommands = {
\ 'reason': ['ocaml-language-server', '--stdio'],
\ }

" use this for ReasonReact
" let g:LanguageClient_serverCommands = {
" \ 'reason': ['$HOME/reason-language-server.exe']
" \ }

nnoremap <Leader>2r :!refmt --parse=ml --print=re % > %.re<CR>
nnoremap <Leader>2o :!refmt --parse=re --print=ml % > %.ml<CR>
