let g:LanguageClient_serverCommands = {
\ 'rust': ['rustup', 'run', 'nightly', 'rls']
\ }

let g:ale_linters = {
\ 'rust': ['cargo', 'rustfmt'],
\}
