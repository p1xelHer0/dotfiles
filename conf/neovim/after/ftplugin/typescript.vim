g:nvim_typescript#type_info_on_hold = 1

" definitions
autocmd FileType typescript nnoremap <buffer> <Leader>d :TSDef<CR>
autocmd FileType typescript nnoremap <buffer> <Leader>dp :TSDefPreview<CR>
autocmd FileType typescript nnoremap <buffer> <Leader>dr :TSRefs<CR>

" types
autocmd FileType typescript nnoremap <buffer> tt :TSType<CR>
autocmd FileType typescript nnoremap <buffer> ti :TSImport<CR>
autocmd FileType typescript nnoremap <buffer> td :TSTypeDef<CR>
autocmd FileType typescript nnoremap <buffer> tr :TSRename<CR>

" forat on save
autocmd FileType typescript nnoremap <buffer> <Leader>w :Neoformat<CR>:write<CR>
