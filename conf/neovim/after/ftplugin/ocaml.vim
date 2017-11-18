augroup filetype_ocaml
  autocmd!
  autocmd FileType ocaml,reason nnoremap <buffer> <Leader>d :MerlinLocate<CR>
  autocmd FileType ocaml,reason nnoremap <buffer><silent> tt :MerlinTypeOf<CR>
augroup END
