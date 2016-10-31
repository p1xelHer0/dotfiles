" I dont even use vim but I still have all this shit 🤔 tool-o-holic

call plug#begin()

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()

set tabstop=2         " a tab is two spaces
set backspace=indent,eol,start
                      " allow backspacing over everything in insert mode
set hidden
set ignorecase        " ignore case when searching
set smartcase         " ignore case if search pattern is all lowercase,
                      "   case-sensitive otherwise
set autoindent        " always set autoindenting on
set hlsearch          " highlight search terms
set softtabstop=2     " when hitting <BS>, pretend like a tab is removed, even if spaces
set incsearch         " show search matches as you type
set copyindent        " copy the previous indentation on autoindenting
set clipboard=unnamed " normal OS clipboard interaction
set autoread          " automatically reload files changed outside of Vim
set ai                " set auto-indenting on for programming
set laststatus=2      " display the status line always
set nocompatible      " vi compatible is LAME
set number            " line numbers
set ruler             " show the cursor position all the time
set showmatch         " automatically show matching brackets
set tw=79             " text width
set vb                " turn on the 'visual bell' - which is much quieter than the 'audio blink'
set visualbell        " don't beep
set noerrorbells      " don't beep
set history=1000      " remember more commands and search history
set undolevels=1000   " use many muchos levels of undo
if v:version >= 730
    set undofile      " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup          " do not keep backup files, it's 70's style cluttering
set noswapfile        " do not write annoying intermediate swap files
set directory=~/.vim/.tmp,~/tmp,/tmp
                      " store swap files in one of these directories
                      "   (in case swapfile is ever turned on)
set viminfo='20,\"80  " read/write a .viminfo file, don't store more
                      "   than 80 lines of registers
set nomodeline        " disable mode lines (security measure)
syntax on             " turn syntax highlighting on by default

let mapleader=","

map <Leader>cw :%s/[ <tab>]*$//<CR>:retab!<CR>:noh<CR>

" Make swapping windows easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let &t_Co=256
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

let NERDTreeHighlightCursorline=1
