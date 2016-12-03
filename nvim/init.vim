" I dont even use vim but I still have all this shit 🤔 tool-o-holic
" I'm trying to learn!

call plug#begin()

" syntax
Plug 'vim-scripts/SyntaxComplete'
Plug 'pangloss/vim-javascript'
Plug '1995eaton/vim-better-javascript-completion'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'moll/vim-node'
Plug 'mxw/vim-jsx'
Plug 'leshill/vim-json'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'leafgarland/typescript-vim'
Plug 'ElmCast/elm-vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'

Plug 'Raimondi/delimitMate'
Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'

" utils
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " point to homebrew fzf
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-emoji'

call plug#end()

filetype plugin indent on

" fix slight delay after pressing ESC then O http://ksjoberg.com/vim-esckeys.html
set timeout timeoutlen=500 ttimeoutlen=100

set t_Co=256
set tabstop=2
set backspace=indent,eol,start
                      " allow backspacing over everything in insert mode

set list              " display tabs and trailing spaces
set listchars+=tab:›·,trail:·,nbsp:×,eol:¬
set hidden

set hlsearch          " highlight search terms
set ignorecase        " ignore case when searching
set incsearch         " show search matches as you type
set smartcase         " ignore case if search pattern is all lowercase,
                      "   case-sensitive otherwise

set autoindent        " always set autoindenting on
set softtabstop=2     " when hitting <BS>, pretend like a tab is removed, even if spaces

set clipboard=unnamed " normal OS clipboard interaction
set copyindent        " copy the previous indentation on autoindenting

set ai                " set auto-indenting on for programming
set autoread          " automatically reload files changed outside of Vim
set laststatus=2      " display the status line always
set showmatch         " automatically show matching brackets

set number            " line numbers
set tw=79             " text width
set ruler             " show the cursor position all the time

set encoding=utf-8
set history=1000
set modelines=0
set nomodeline
syntax on

let mapleader=","

map <Leader>cw :%s/[ <tab>]*$//<CR>:retab!<CR>:noh<CR>

" make swapping windows easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let g:python_host_prog = '/Users/pontusnagy/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/pontusnagy/.pyenv/versions/neovim3/bin/python'

" lint settings
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 1
let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']

" allow JSX in normal JS files
let g:jsx_ext_required = 0

let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1

" https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/
" has to go after all theme declarations
highlight Comment cterm=italic
autocmd FileType javascript.jsx highlight xmlAttrib cterm=italic
