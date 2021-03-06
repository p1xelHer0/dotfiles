" vim: set foldmethod=marker foldlevel=0 nomodeline:
set encoding=utf-8
scriptencoding utf-8

" check if the system is macOS
let s:darwin = has('mac')

" =============================================================================
" plugins {{{
"
" NOTE:
" A lot of plugins are commented out!
" This is because I use nix and home-manager to install plenty of plugins.
" =============================================================================

call plug#begin('~/.config/nvim/plugged')

" -----------------------------------------------------------------------------
" Syntax and suppot for languages
" -----------------------------------------------------------------------------
" JavaScript
" Plug 'jxnblk/vim-mdx-js',                       { 'for': 'mdx' }
" Plug 'mxw/vim-jsx',                             { 'for': 'javascript.jsx' }
" Plug 'othree/javascript-libraries-syntax.vim',  { 'for': 'javascript.jsx' }
" Plug 'pangloss/vim-javascript',                 { 'for': 'javascript.jsx' }
" Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': 'javascript.jsx' }
Plug 'iamcco/coc-tailwindcss',                  { 'do': 'yarn install --frozen-lockfile'}

" TypeScript
" Plug 'leafgarland/typescript-vim',              { 'for': 'typescript' }
" Plug 'neoclide/coc-tsserver',                   { 'do': 'yarn install --frozen-lockfile'}

" HTML
" Plug 'othree/html5.vim',                        { 'for': 'html' }

" CSS
Plug 'cakebaker/scss-syntax.vim',               { 'for': 'scss' }
Plug 'hail2u/vim-css3-syntax',                  { 'for': 'css' }
Plug 'stephenway/postcss.vim',                  { 'for': 'css' }
" Plug 'neoclide/coc-css',                        { 'do': 'yarn install --frozen-lockfile'}

" JSON
" Plug 'elzr/vim-json',                           { 'for': 'json' }
Plug 'neoclide/jsonc.vim',                      { 'for': 'json' }
Plug 'neoclide/coc-json',                       { 'do': 'yarn install --frozen-lockfile' }

" GraphQL
Plug 'jparise/vim-graphql'

" XML
Plug 'othree/xml.vim',                          { 'for': 'xml' }

" Markdown
" Plug 'plasticboy/vim-markdown',                 { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown',               { 'for': 'markdown', 'do': 'yarn global add instant-markdown-d' }

" LaTeX
" Plug 'lervag/vimtex',                           { 'for': 'tex' }
" Plug 'xuhdev/vim-latex-live-preview',           { 'for': 'tex' }

" CoffeeScript
" Plug 'kchmck/vim-coffee-script',                { 'for': 'coffescript' }

" Elm
" Plug 'ElmCast/elm-vim',                         { 'for': 'elm' }

" OCaml
Plug 'ocaml/merlin',                        { 'for': 'ocaml' }
Plug 'ocaml/vim-ocaml',                     { 'for': 'ocaml' }

" Reason
Plug 'jordwalke/vim-reasonml',              { 'for': 'reason' }
Plug 'reasonml-editor/vim-reason-plus',     { 'for': 'reason' }

" ReScript
Plug 'rescript-lang/vim-rescript',          { 'for': 'rescript' }

" PureScript
" Plug 'FrigoEU/psc-ide-vim',                    { 'for': 'purescript' }
" Plug 'purescript-contrib/purescript-vim',      { 'for': 'purescript' }

" Haskell
" Plug 'neovimhaskell/haskell-vim',               { 'for': 'haskell' }

" Rust
" Plug 'rust-lang/rust.vim',                      { 'for': 'rust' }
Plug 'ron-rs/ron.vim',                          { 'for': 'rust' }
" Plug 'neoclide/coc-rls',                        { 'do': 'yarn install --frozen-lockfile'}

" Erlang

" Plug 'hyhugh/coc-erlang_ls',                    { 'do': 'yarn install --frozen-lockfile'}
" Plug 'vim-erlang/vim-erlang-compiler',          { 'for': 'erlang' }
" Plug 'vim-erlang/vim-erlang-omnicomplete',      { 'for': 'erlang' }
" Plug 'vim-erlang/vim-erlang-runtime',           { 'for': 'erlang' }
" Plug 'vim-erlang/vim-erlang-tags',              { 'for': 'erlang' }

" Elixir
" Plug 'elixir-editors/vim-elixir',               { 'for': 'elixir' }
" Plug 'slashmili/alchemist.vim',                 { 'for': 'elixir' }

" C#
" Plug 'OmniSharp/omnisharp-vim'

" Lua
" Plug 'tbastos/vim-lua',                         { 'for': 'lua' }
" Plug 'davisdude/vim-love-docs',                 { 'for': 'lua' }

" Godot
" Plug 'quabug/vim-gdscript'


" -----------------------------------------------------------------------------
"  Utilities
" -----------------------------------------------------------------------------
" LSP support and autocomplete
" Plug 'neoclide/coc.nvim',                       { 'branch': 'release', 'do': { -> coc#util#install() } }

" linting
" Plug 'dense-analysis/ale'

" VCS
" Plug 'junegunn/gv.vim'
" Plug 'mhinz/vim-signify'
" Plug 'sodapopcan/vim-twiggy'
" Plug 'tpope/vim-fugitive'

" editing
Plug 'AndrewRadev/switch.vim'
" Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'
" Plug 'junegunn/vim-easy-align'
" Plug 'sbdchd/neoformat'
" Plug 'sgur/vim-editorconfig'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-repeat'
" Plug 'liuchengxu/vim-which-key'

" writing
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-litecorrect'

" file handling and searching
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'majutsushi/tagbar'
" Plug 'scrooloose/nerdtree'
" Plug 'xuyuanp/nerdtree-git-plugin'

" tmux
" Plug 'benmills/vimux'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'tmux-plugins/vim-tmux-focus-events'

" improvements
Plug 'auwsmit/vim-active-numbers'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Plug 'junegunn/vim-peekaboo'
" Plug 'junegunn/vim-slash'
" Plug 'norcalli/nvim-colorizer.lua'

" Plug 'p1xelHer0/ttwnty.vim',                         { 'branch': 'dev' }

call plug#end()


" }}}
" =============================================================================
" basic settings {{{
" =============================================================================

set expandtab
set modelines=2

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
set runtimepath+=/usr/local/opt/fzf

" limelight
let g:limelight_conceal_guifg = '#333333'

" -----------------------------------------------------------------------------
" Neoformat
" -----------------------------------------------------------------------------
" use formatprg if possible
let g:neoformat_try_formatprg = 1
let g:neoformat_verbose = 0

" augroup neoformat
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------
" bookmarks
" let NERDTreeBookmarksFile = expand('$HOME/.config/nvim/NERDTreeBookmarks')

" open NERDTree when opening a directory or just starting Neovim
" augroup NERDTree_open
"   autocmd!
"   autocmd StdinReadPre * let s:std_in = 1
"   autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"   autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" augroup END

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

" which-key
" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

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

" reload .vimrc
" nnoremap <Leader><Leader>r :so $MYVIMRC<CR>
nnoremap <Leader><Leader>r :so $HOME/Dev/Repo/Private/ttwnty.vim/colors/ttwnty.vim<CR>

" open last buffer by double tapping <Leader>
" nnoremap <Leader><Leader> <C-^>

" yank the whole line with Y
nnoremap Y 0y$

" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" quit, quit!, write and xit quicker
" nnoremap <Leader>q :quit<CR>
" nnoremap <Leader>Q :quit!<CR>
" nnoremap <Leader>w :write<CR>
" nnoremap <Leader>x :xit<CR>

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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR  :call CocAction('runCommand', 'editor.action.organizeImport')

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

" SuperTab
" inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


" }}}

