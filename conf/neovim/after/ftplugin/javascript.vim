let g:neoformat_enabled_javascript = ['prettier']

" allow jsx in normal JavaScript files
let g:jsx_ext_required = 0

" deoplete
let g:deoplete#omni#functions.javascript = ['tern#Complete', 'jspc#omni']
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']

" tern
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 0

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

augroup filetype_javascript
  autocmd!
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript nnoremap <buffer> <Leader>d :TernDef<CR>
  autocmd FileType javascript nnoremap <buffer> <Leader>w :Neoformat<CR>:write<CR>
augroup END
