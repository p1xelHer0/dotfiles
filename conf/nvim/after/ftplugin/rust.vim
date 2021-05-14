autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

nnoremap <Leader>c :Cargo run<CR>

set shiftwidth=4
set softtabstop=4
