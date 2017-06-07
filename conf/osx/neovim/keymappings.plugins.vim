" ## Universal mappings {{

" # UltiSnips {
let g:UltiSnipsExpandTrigger = "<C-j>"
" } UltiSnips #

"}} Universal mappings ##


" ## Normal mappings {{

" # ALE {
nmap <silent><Up> <Plug>(ale_previous_wrap)
nmap <silent><Down> <Plug>(ale_next_wrap)
" } ALE #


" # Neoformat {
nnoremap <Leader><Leader>f :Neoformat<CR>
" } Neoformat #


" # EasyAlign {
nmap ga <Plug>(EasyAlign)
" } EasyAlign #


" # NERDTree {
nnoremap <Leader>n :NERDTreeToggle<CR>
" } NERDTree #


" # tern {
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>
" } tern #


" # ReasonPrettyPrint {
autocmd FileType reason nnoremap <buffer> <Leader><Leader>f :ReasonPrettyPrint<Cr>
" } ReasonPrettyPrint #

" }} Normal mappings ##


" ## Insert mappings {{

" # SuperTab {
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enter closes options if present and inserts linebreak
" Apparently this has to be that complicated
inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" } SuperTab #


" ## Visual select mappings {{

" }} Visual select mappings ##


" ## Visual mappings {{

" # EasyAlign {
xmap ga <Plug>(EasyAlign)
" } EasyAlign #

" }} Visual mappings ##
