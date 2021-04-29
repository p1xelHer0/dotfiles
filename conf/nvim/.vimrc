" vim: set foldmethod=marker foldlevel=0 nomodeline:
set encoding=utf-8
scriptencoding utf-8

color ttwnty

" =============================================================================
" plugins {{{
"
" NOTE:
" This is because I use nix and home-manager to install plenty of plugins.
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

" -----------------------------------------------------------------------------
" Syntax and suppot for languages
" --------------------------------------------------------------------------
" XML
Plug 'othree/xml.vim',                  { 'for': 'xml' }

" Markdown
Plug 'plasticboy/vim-markdown',         { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown',       { 'for': 'markdown', 'do': 'yarn global add instant-markdown-d' }

" OCaml
Plug 'ocaml/merlin',                    { 'for': 'ocaml' }

" Reason
Plug 'jordwalke/vim-reasonml',          { 'for': 'reason' }
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reason' }

" ReScript
Plug 'rescript-lang/vim-rescript',      { 'for': 'rescript' }

" Lua
Plug 'tbastos/vim-lua',                 { 'for': 'lua' }


" -----------------------------------------------------------------------------
"  Utilities
" -----------------------------------------------------------------------------

" editing
Plug 'AndrewRadev/switch.vim'

" writing
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-litecorrect'

" improvements
Plug 'auwsmit/vim-active-numbers'

call plug#end()


" }}}
" =============================================================================
" basic settings {{{
" =============================================================================

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

set expandtab
set modelines=2
set completeopt=menuone,noinsert,noselect

" indentation
set shiftwidth=2
set softtabstop=2
set linebreak
set breakindent
" set showbreak=\ └

" line numbers
set number          " enable line numbers
set relativenumber  " enable relative line number
set ruler           " show the cursor position all the time
set scrolloff=5     " keep 5 lines above the cursor while scrolling

" searching
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase
set showmatch       " automatically show matching brackets

augroup insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

set clipboard=unnamed " normal OS clipboard interaction

set copyindent          " copy the previous indentation on autoindenting
set visualbell          " disable error sound, enable the visual one instead
set shortmess+=I        " no splash screen
set backupcopy=yes      " make a copy of the file and overwrite the original one
set inccommand=nosplit  " preview substitute, e.g. using `%s/foo/bar`

set foldenable
set foldlevelstart=10   " open most but not all folds
set foldnestmax=10      " never fold deeper than 10 levels
set foldmethod=manual

let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

" http://ksjoberg.com/vim-esckeys.html/
set timeout timeoutlen=500 ttimeoutlen=100

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" enable jsx/tsx
augroup jsx_and_tsx
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END


" }}}
" =============================================================================
" lsp settings {{{
" =============================================================================

" see the ./lua folder
lua require('lsp')


" }}}
" =============================================================================
" ui {{{
" =============================================================================

" split border
set fillchars+=vert: 

" display the listchars
set listchars+=tab:→\ ,trail:·,nbsp:×
set list

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
augroup vim_enter
  autocmd!
  autocmd VimEnter * autocmd vim_enter WinEnter * let w:created = 1
augroup END

" autoresize windows on terminal resize
augroup vim_resize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup END


" only show the colorcolumn if the width surpasses 80 on that specific line
highlight OverLength ctermfg=0 ctermbg=3
match OverLength /\%82v/


" }}}
" =============================================================================
" statusline {{{
" =============================================================================

lua require('plugins.statusline')


" }}}
" =============================================================================
" plugin settings {{{
" =============================================================================

" -----------------------------------------------------------------------------
" goyo.vim
" -----------------------------------------------------------------------------
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux set pane-border-status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set nocursorline
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set nocursorline
  Limelight!
endfunction

augroup goyo
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" fzf
set runtimepath+=/usr/local/opt/fzf

" limelight
let g:limelight_conceal_guifg = '#333333'

" -----------------------------------------------------------------------------
" Neoformat
" -----------------------------------------------------------------------------
" use formatprg if possible
let g:neoformat_try_formatprg = 1
let g:neoformat_verbose = 0

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------

let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1

" git status icons
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  : '~',
\ 'Staged'    : '^',
\ 'Untracked' : '+',
\ 'Renamed'   : '=',
\ 'Unmerged'  : '"',
\ 'Deleted'   : '-',
\ 'Dirty'     : '~',
\ 'Clean'     : '*',
\ 'Unknown'   : '?'
\ }

" -----------------------------------------------------------------------------
" vim-active-numbers
" -----------------------------------------------------------------------------
let g:actnum_exclude = ['nerdtree', 'unite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m']

" -----------------------------------------------------------------------------
" vim-litecorrect
" -----------------------------------------------------------------------------
augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile call litecorrect#init()
augroup END

" -----------------------------------------------------------------------------
" vim-lexical
" -----------------------------------------------------------------------------
let g:lexical#thesaurus = ['$HOME/dotfiles/thesaurus/moby.txt',]

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

" -----------------------------------------------------------------------------
" vim-signify
" -----------------------------------------------------------------------------
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" }}}
" =============================================================================
" mappings {{{
" =============================================================================

" leader
let g:mapleader = "\<Space>"

" dont go into ex mode
noremap Q <NOP>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" reload settings
nnoremap <Leader><Leader>r :so $HOME/Dev/Repo/Private/ttwnty.vim/colors/ttwnty.vim<CR>:so $HOME/dotfiles/conf/nvim/.vimrc<CR>

" yank the whole line with Y
nnoremap Y 0y$

" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" clear search
nnoremap <Leader>/ :nohl<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" store relative line number jumps in the jumplist if they exceed a threshold
" make j and k use strict linewise movements
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" EasyAlign
nnoremap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" fzf
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" goyo.vim
nnoremap <Leader>gv :Goyo<CR>

" Neoformat
nnoremap <Leader><Leader>f :Neoformat<CR>

" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>N :NERDTreeFind<CR>


" }}}

