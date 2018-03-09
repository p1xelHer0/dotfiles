let g:LanguageClient_serverCommands = {
\ 'rust': ['rustup', 'run', 'stable', 'rls']
\ }

let g:ale_linters = {
\ 'rust': ['rustc', 'cargo', 'rls', 'rustfmt'],
\}
