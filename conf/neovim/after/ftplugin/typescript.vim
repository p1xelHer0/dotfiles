g:nvim_typescript#type_info_on_hold = 1

" definitions
nnoremap <buffer> <Leader>dd :TSDef<CR>
nnoremap <buffer> <Leader>dp :TSDefPreview<CR>
nnoremap <buffer> <Leader>dr :TSRefs<CR>

" types
nnoremap <buffer> <Leader>tt :TSType<CR>
nnoremap <buffer> <Leader>ti :TSImport<CR>
nnoremap <buffer> <Leader>td :TSTypeDef<CR>
nnoremap <buffer> <Leader>tr :TSRename<CR>

" forat on save
nnoremap <buffer> <Leader>w :Neoformat<CR>:write<CR>
