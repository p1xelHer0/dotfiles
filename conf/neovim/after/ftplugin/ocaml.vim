nnoremap <buffer> <Leader>d :MerlinLocate<CR>
nnoremap <buffer> <Leader>dt :MerlinTypeOf<CR>

let g:LanguageClient_serverCommands = {
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ }
