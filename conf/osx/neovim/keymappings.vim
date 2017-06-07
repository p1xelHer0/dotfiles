" ## Default keymappings {{

" # Universal mappings {

" Don't use arrows!
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Leader
let mapleader="\<Space>"

" Reload init.vim
noremap <Leader><Leader>r :so $MYVIMRC<CR>

" use ctrl-[hjkl] to move between splits
" using vim-tmux-navigator instead, see .tmux.conf
" nmap <silent> <C-h> :wincmd h<CR>
" nmap <silent> <C-j> :wincmd j<CR>
" nmap <silent> <C-k> :wincmd k<CR>
" nmap <silent> <C-l> :wincmd l<CR>

" Yank the whole line with Y
noremap Y 0y$
" } Univeral mappings #

" # Normal mappings {

" <Leader><Leader> -- open last buffer
nnoremap <Leader><Leader> <C-^>

" Avoid unintentional switches to Ex mode.
nmap Q q

" I will probably missclick this as well...
nnoremap K <nop>

" Repeat last macro if in a normal buffer
nnoremap <expr><CR> empty(&buftype) ? '@@' : '<CR>'

" Quit, write and xit quicker
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Replace spaces with tabs or the other way around
" :nohl because NERDTree bugs after replacing as of now
nnoremap <Leader>r<Space>t :%s/  /\t/g<CR>:nohl<CR>
nnoremap <Leader>rt<Space> :%s/\t/  /g<CR>

" Store relative line number jumps in the jumplist if they exceed a threshold
nnoremap <expr>k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>j (v:count > 5 ? "m'" . v:count : '') . 'j'

" F10 prints the current highlight rules for cursor selection
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Errors
nnoremap <Leader>o :lopen<CR>           " open location window
nnoremap <Leader><Leader>o :lclose<CR>  " close location window
nnoremap <silent><Right> :ll<CR>        " go to current error/warning

" ALE
nmap <silent><Up> <Plug>(ale_previous_wrap)
nmap <silent><Down> <Plug>(ale_next_wrap)

" Toggle NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" tern
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>

" } Normal mappings #


" Insert mappings {

" Deoplete tab-complete
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-j>"

map <C-c> <CR><Esc>O

" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>

" } Insert mappings #


" # Visual mappings {

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" } Visual mappings #
