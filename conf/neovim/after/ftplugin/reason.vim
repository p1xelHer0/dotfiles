let g:neoformat_reason_refmt80 = {
\ 'exe': 'refmt',
\ 'args': ['--print-width 80'],
\ 'replace': 0,
\ 'stdin': 1,
\ 'no_append': 1
\ }

let g:neoformat_enabled_reason = ['refmt80']
let g:LanguageClient_serverCommands = {
\ 'reason': ['ocaml-language-server', '--stdio'],
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ }
