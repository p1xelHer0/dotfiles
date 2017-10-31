"""

" -- keymapping that uses functionality of default Neovim

scriptencoding utf-8
set encoding=utf-8


" universal mappings {{{

" leader - space masterrace
let g:mapleader = "\<Space>"

" don't use arrows!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" reload .vimrc
noremap <Leader><Leader>r :so $MYVIMRC<CR>


" use <C-h/j/k/l> to move between splits
" using vim-tmux-navigator instead, see .tmux.conf
" this way we can move between tmux splits and Neovim splits
" nmap <silent> <C-h> :wincmd h<CR>
" nmap <silent> <C-j> :wincmd j<CR>
" nmap <silent> <C-k> :wincmd k<CR>
" nmap <silent> <C-l> :wincmd l<CR>

" }}}


" normal mappings {{{

" <Leader><Leader> -- open last buffer
nnoremap <Leader><Leader> <C-^>

" yank the whole line with Y
" nnoremap Y 0y$

" avoid unintentional switches to ex mode
" nmap Q q

" I will probably missclick this as well
" nnoremap K <nop>

" show and hide listchars
nnoremap <Leader>lch :set listchars=<CR>:set listchars+=tab:»\ ,trail:·,nbsp:×<CR>
nnoremap <Leader>lcs :set listchars+=tab:»\ ,trail:·,nbsp:×,eol:¬<CR>

" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" quit, quit!, write and xit quicker
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :quit!<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" replace spaces with tabs or the other way around
" :nohl because NERDTree bugs after replacing as of now
nnoremap <Leader>r<Space>t :%s/  /\t/g<CR>:nohl<CR>
nnoremap <Leader>rt<Space> :%s/\t/  /g<CR>

" store relative line number jumps in the jumplist if they exceed a threshold
" make j and k use strict linewise movements
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" f10 prints the current highlight rules for cursor selection
nnoremap <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

" errors
nnoremap <Leader>o :lopen<CR>
nnoremap <Leader><Leader>o :lclose<CR>
nnoremap <silent> <Right> :ll<CR>

" }}}


" insert mappings {{{

" }}}


" visual select mappings {{{

" }}}


" visual mappings {{{

" }}}
