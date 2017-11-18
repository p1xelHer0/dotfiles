"""

" -- default settings, everything that affects how default Neovim works

scriptencoding utf-8
set encoding=utf-8


" Indentation {{{

set expandtab           " insert space characters whenever the tab key is pressed
set tabstop=2           " 2 space characters
set shiftwidth=2        " set to 2 according to tabstop
set softtabstop=2       " set to 2 according to tabstop
set linebreak
set breakindent
set showbreak=\ → 


" commands that are default for Neovim, kept here for documentation
" filetype indent plugin on -- default Neovim
" set smarttab          " -- default Neovim
" set autoindent        " -- default Neovim
" set backspace=indent,eol,start  -- default Neovim

" }}}


" lines {{{

set number              " enable line numbers
set relativenumber      " enable relative line number
set ruler               " show the cursor position all the time
set scrolloff=5         " keep 5 lines above the cursor while scrolling

" }}}


" search {{{

set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase
set showmatch           " automatically show matching brackets


" commands that are default for Neovim, kept here for documentation
" set incsearch         " show search matches as you type -- default Neovim
" set hlsearch          " highlight search terms -- default Neovim

" }}}


" other {{{

set list                " display the listchars
set listchars+=tab:»\ ,trail:·,nbsp:×

if IsMacOS()
  set clipboard=unnamed " normal OS clipboard interaction
else                    " use xsel on Linux
  set clipboard+=unnamedplus
endif

set copyindent          " copy the previous indentation on autoindenting
set mouse=a             " it's okay to be lazy sometimes
set visualbell          " disable error sound, enable the visual one instead
" set lazyredraw          " disable redraw while executing macros -- perf
" set showcmd             " show command on the last line == default Vim
set shortmess+=I        " no splash screen
set backupcopy=yes      " make a copy of the file and overwrite the original one
set foldmethod=syntax   " fold where you would expect folds, e.g. like in Atom
set foldlevelstart=999  " make everything unfolded upon open
set inccommand=nosplit  " preview substitute, e.g. using `%s/foo/bar`

let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20


" commands that are default for Neovim, kept here for documentation
" set encoding=utf-8    " use utf-8 -- default Neovim
" set autoread          " auto reload files changed -- default Neovim
" set laststatus=2      " display the status line always -- default Neovim
" set wildmenu          " enable the wildmenu -- default Neovim

" fix slight delay after pressing ESC then O (???)
" http://ksjoberg.com/vim-esckeys.html/
set timeout timeoutlen=500 ttimeoutlen=100

" augroup set_cwd_to_file
"   autocmd!
"   autocmd BufEnter * silent! lcd %:p:h
" augroup END

" http://learnvimscriptthehardway.stevelosh.com/chapters/18.html
augroup dotfiles_foldmarker
  autocmd!
  autocmd FileType conf,vim setlocal foldmethod=marker
augroup END


if IsMacOS()
" python provider configuration
" virtualenvs with pyenv
  let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

" ruby provider configuration
" rbenv
  let g:ruby_host_prog = $HOME . '/.rbenv/versions/2.4.1/bin/neovim-ruby-host'
else
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
endif

" }}}
