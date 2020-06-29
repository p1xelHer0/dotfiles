nnoremap <silent> <Leader>mt :MerlinTypeOf<CR>
nnoremap <silent> <Leader>mg :MerlinGrowEnclosing<CR>
nnoremap <silent> <Leader>ms :MerlinShrinkEnclosing<CR>
nnoremap <silent> <Leader>mc :MerlinClearEnclosing<CR>

nnoremap <Leader>2r :!refmt --parse=ml --print=re % > %.re<CR>:vsp %.re<CR>
nnoremap <Leader>2o :!refmt --parse=re --print=ml % > %.ml<CR>:vsp %.ml<CR>
