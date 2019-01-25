let g:LanguageClient_serverCommands = {
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ }

" run the following line in vim to index the documentation:
" :execute "helptags " . substitute(system('opam config var share'),'\n$','','''') .  "/merlin/vim/doc"
