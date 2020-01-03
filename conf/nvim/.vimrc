" vim: set foldmethod=marker foldlevel=0
set encoding=utf-8
scriptencoding utf-8

" check if the system is macOS
let s:darwin = has('mac')

" =============================================================================
" plugins {{{
" =============================================================================

" auto install `plug` if not installed
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup PLUG
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif


call plug#begin()

" -----------------------------------------------------------------------------
" Syntax and suppot for languages
" -----------------------------------------------------------------------------
" JavaScript
Plug 'jxnblk/vim-mdx-js',                      { 'for': 'mdx' }
Plug 'mxw/vim-jsx',                            { 'for': 'javascript.jsx' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript.jsx' }
Plug 'pangloss/vim-javascript',                { 'for': 'javascript.jsx' }
Plug 'styled-components/vim-styled-components',{ 'for': 'javascript.jsx' }

" TypeScript
Plug 'leafgarland/typescript-vim',             { 'for': 'typescript' }

" HTML
Plug 'othree/html5.vim',                       { 'for': 'html' }

" CSS
Plug 'cakebaker/scss-syntax.vim',              { 'for': 'scss' }
Plug 'hail2u/vim-css3-syntax',                 { 'for': 'css' }

" JSON
Plug 'elzr/vim-json',                          { 'for': 'json' }
Plug 'neoclide/jsonc.vim',                     { 'for': 'json' }

" GraphQL
Plug 'jparise/vim-graphql'

" XML
Plug 'othree/xml.vim',                         { 'for': 'xml' }

" Markdown
Plug 'plasticboy/vim-markdown',                { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown',              { 'for': 'markdown', 'do': 'yarn global add instant-markdown-d' }

" LaTeX
Plug 'lervag/vimtex',                          { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview',          { 'for': 'tex' }

" CoffeeScript
Plug 'kchmck/vim-coffee-script',               { 'for': 'coffescript' }

" Elm
Plug 'ElmCast/elm-vim',                        { 'for': 'elm' }

" OCaml/Reason
Plug 'jordwalke/vim-reasonml',
Plug 'ocaml/merlin',
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rgrinberg/vim-ocaml',                    { 'for': 'ocaml' }

" PureScript
Plug 'FrigoEU/psc-ide-vim',                    { 'for': 'purescript' }
Plug 'purescript-contrib/purescript-vim',      { 'for': 'purescript' }

" Haskell
Plug 'neovimhaskell/haskell-vim',              { 'for': 'haskell' }

" Rust
Plug 'rust-lang/rust.vim',                     { 'for': 'rust' }
Plug 'ron-rs/ron.vim',                         { 'for': 'rust' }

" C#
Plug 'OmniSharp/omnisharp-vim'

" Lua
Plug 'tbastos/vim-lua',                        { 'for': 'lua' }
Plug 'davisdude/vim-love-docs',                { 'for': 'lua' }

" Godot
Plug 'quabug/vim-gdscript'


" -----------------------------------------------------------------------------
"  Utilities
" -----------------------------------------------------------------------------
" LSP support and autocomplete
Plug 'neoclide/coc.nvim',                      { 'branch': 'release', 'do': { -> coc#util#install()} }

" linting
Plug 'w0rp/ale'

" VCS
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'sodapopcan/vim-twiggy'
Plug 'tpope/vim-fugitive'

" editing
Plug 'AndrewRadev/switch.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'
Plug 'sgur/vim-editorconfig'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" file handling and searching
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

" tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

" improvements
Plug 'auwsmit/vim-active-numbers'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()


" }}}
" =============================================================================
" basic settings {{{
" =============================================================================

set expandtab

" indentation
set shiftwidth=2
set softtabstop=2
set linebreak
set breakindent
set showbreak=\ ↣ 

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

if s:darwin
  set clipboard=unnamed " normal OS clipboard interaction
else
  set clipboard+=unnamedplus " use xsel on Linux
endif

set copyindent          " copy the previous indentation on autoindenting
set visualbell          " disable error sound, enable the visual one instead
set shortmess+=I        " no splash screen
set backupcopy=yes      " make a copy of the file and overwrite the original one
set inccommand=nosplit  " preview substitute, e.g. using `%s/foo/bar`

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
" ui {{{
" =============================================================================
colorscheme p1xelHer0

" split border
set fillchars+=vert: 

" display the listchars
set list
set listchars+=tab:→\ ,trail:·,nbsp:×

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
match OverLength /\%81v/


" }}}
" =============================================================================
" statusline {{{
" =============================================================================

set laststatus=2


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
set rtp+=/usr/local/opt/fzf

" limelight
let g:limelight_conceal_guifg = '#333333'

" -----------------------------------------------------------------------------
" Neoformat
" -----------------------------------------------------------------------------
" use formatprg if possible
let g:neoformat_try_formatprg = 1

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------
" bookmarks
let NERDTreeBookmarksFile = expand('$HOME/.config/nvim/NERDTreeBookmarks')

" Open NERDTree when opening a directory or just starting Neovim
augroup NERDTree_open
  autocmd!
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END

let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeHighlightCursorline = 0

" Git status icons
let g:NERDTreeIndicatorMapCustom = {
\ 'Modified'  : '~',
\ 'Staged'    : '▲',
\ 'Untracked' : '+',
\ 'Renamed'   : '→',
\ 'Unmerged'  : '=',
\ 'Deleted'   : '_',
\ 'Dirty'     : '~',
\ 'Clean'     : '◆',
\ 'Unknown'   : '?'
\ }

" -----------------------------------------------------------------------------
" SuperTab
" -----------------------------------------------------------------------------
let g:SuperTabCrMapping = 1
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'

" -----------------------------------------------------------------------------
" vim-active-numbers
" -----------------------------------------------------------------------------
let g:actnum_exclude = ['nerdtree', 'unite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m']

" -----------------------------------------------------------------------------
" vim-signify
" -----------------------------------------------------------------------------
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
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

" reload .vimrc
nnoremap <Leader><Leader>r :so $MYVIMRC<CR>

" open last buffer by double tapping <Leader>
nnoremap <Leader><Leader> <C-^>

" yank the whole line with Y
nnoremap Y 0y$

" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" quit, quit!, write and xit quicker
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>Q :quit!<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" clear search
nnoremap <Leader>/ :nohl<CR>

" store relative line number jumps in the jumplist if they exceed a threshold
" make j and k use strict linewise movements
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" f10 prints the current highlight rules for cursor selection
nnoremap <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" ALE
nmap [W <Plug>(ale_first)
nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)
nmap ]W <Plug>(ale_last)

" -----------------------------------------------------------------------------
" coc.nvim
" -----------------------------------------------------------------------------
" gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gt <Plug>(coc-type-definition)

" change text
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lR <Plug>(coc-refactor)
nmap <silent> <leader>lq <Plug>(coc-fix-current)
nmap <silent> <leader>la <Plug>(coc-codeaction)
nmap <silent> <leader>lf <Plug>(coc-format-selected)
vmap <silent> <leader>lf <Plug>(coc-format-selected)

" diagnostics
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [g <Plug>(coc-diagnostic-prev)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use K for LSP hover and normal K
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" SuperTab
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


" }}}

