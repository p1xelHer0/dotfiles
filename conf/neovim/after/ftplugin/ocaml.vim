nnoremap <buffer> <Leader>dd :MerlinLocate<CR>
nnoremap <buffer> <Leader>tt :MerlinTypeOf<CR>
let g:LanguageClient_serverCommands = {
\ 'reason': ['ocaml-language-server', '--stdio'],
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ }
