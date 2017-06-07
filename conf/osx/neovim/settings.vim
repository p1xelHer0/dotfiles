" ## Settings {{

" # Indentation {
" filetype indent plugin on - Default Neovim
set expandtab " Insert space characters whenever the tab key is pressed
set tabstop=2 " 2 space characters
set shiftwidth=2 " Set to 2 according to tabstop
set softtabstop=2 " Set to 2 according to tabstop
" set smarttab " - Default Neovim
" set autoindent " - Default Neovim
" set backspace=indent,eol,start  - Default Neovim
" } Indentation #

" # List
set list                " display the listchars
set listchars+=tab:»\ ,trail:·,nbsp:×,eol:¬
set number              " enable line numbers
set relativenumber      " enable relative line number
set ruler               " show the cursor position all the time
set scrolloff=5         " keep 5 lines above the cursor while scrolling
" } List #

" # Search {
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase
set showmatch           " automatically show matching brackets
" set incsearch         " show search matches as you type - Default Neovim
" set hlsearch          " highlight search terms - Default Neovim
" } Search #

" # Other {
set clipboard=unnamed   " normal OS clipboard interaction
set copyindent          " copy the previous indentation on autoindenting
" set autoread          " auto reload files changed - Default Neovim
" set laststatus=2      " display the status line always - Default Neovim
" set wildmenu          " enable the wildmenu - Default Neovim
set mouse-=a            " disable mouse, LEARN!
set visualbell          " disable error sound, enable the visual one instead
" set encoding=utf-8    " use utf-8 - Default Neovim
" set history=10000     " remember more commands - Default Neovim
set lazyredraw          " disable redraw while executing macros (perf)
set showcmd             " show command on the last line (for learning)
set shortmess+=I        " no splash screen
set backupcopy=yes      " make a copy of the file and overwrite the original one
" set curosor to | in INSERT - neovim specific
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 enabled by Default in 0.2
" Use ':set guicursor=' instead
"
" Fix slight delay after pressing ESC then O (???)
" http://ksjoberg.com/vim-esckeys.html/
set timeout timeoutlen=500 ttimeoutlen=100

" Paths to python2/3 envs - Neovim specific
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
" } Other #

" }} Settings ##
