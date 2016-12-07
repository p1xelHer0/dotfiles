" hello 🤔

call plug#begin()

" syntax
" Plug 'ElmCast/elm-vim'
Plug 'gko/vim-coloresque'
Plug 'hail2u/vim-css3-syntax'
Plug 'leshill/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-markdown'

" autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'SirVer/ultisnips'
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ervandew/supertab'
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }

" linting
Plug 'benjie/neomake-local-eslint.vim'
Plug 'neomake/neomake'

" utils
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " point to homebrew fzf
Plug 'Raimondi/delimitMate'
Plug 'Townk/vim-autoclose'
Plug 'Valloric/MatchTagAlways'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

" ui
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()

" filetype indent plugin on - default neovim

" indention
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" set smarttab          - default neovim
" set autoindent        - default neovim
" set backspace=indent,eol,start  - default neovim

set hidden
set list                " display tabs and trailing spaces
set listchars+=tab:»\ ,trail:·,nbsp:×,eol:¬

set clipboard=unnamed   " normal OS clipboard interaction
set copyindent          " copy the previous indentation on autoindenting
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase
" set wildmenu          - default neovim
" set incsearch         - show search matches as you type - default neovim
" set hlsearch          " highlight search terms - default neovim

set showmatch           " automatically show matching brackets
" set autoread          " automatically reload files changed outside of Vim  - default neovim
" set laststatus=2      " display the status line always - default neovim

set number              " line numbers
set relativenumber
set ruler               " show the cursor position all the time
set scrolloff=5

set visualbell
" set encoding=utf-8    - default neovim
" set history=10000     - default neovim

set lazyredraw
set synmaxcol=120

" theme

" theme and style related
" syntax enable - default neovim

" load theme from base16-shell
" https://github.com/chriskempson/base16-shell
if filereadable(expand("$HOME/.vimrc_background"))
  let base16colorspace=256
  source $HOME/.vimrc_background
endif

" italic for this and html attributes in jsx
hi htmlArg cterm=italic
hi jsThis cterm=italic
hi xmlAttrib cterm=italic

" keep it at 80
let &colorcolumn=join(range(80,999),",")

" only show cursor line in current active window
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" | line cursor in --INSERT-- - neovim specific
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" lightline

" fix slight delay after pressing ESC then O http://ksjoberg.com/vim-esckeys.html
set timeout timeoutlen=500 ttimeoutlen=100

" keymappings
let mapleader=","

" F10 prints the current highlight rules for cursor selection
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" neomake
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

let g:python_host_prog = '/Users/pontusnagy/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/pontusnagy/.pyenv/versions/neovim3/bin/python'

" autocompletion
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" deoplete tab-complete (except for UtilSnips)
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" lint settings
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 1

let g:neomake_warning_sign = {
\ 'text': ' ',
\ 'texthl': 'WarningMsg',
\ }

let g:neomake_error_sign = {
\ 'text': ' ',
\ 'texthl': 'ErrorMsg',
\ }

let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']

" allow jsx in normal js files
let g:jsx_ext_required = 0

" flow
" use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" syntax highlighting for flow
let g:javascript_plugin_flow = 1

let g:used_javascript_libs = 'ramda,react'

" NERDTree
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "+",
    \ "Untracked" : "A",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "U",
    \ "Deleted"   : "D",
    \ "Dirty"     : "X",
    \ "Clean"     : "C",
    \ "Unknown"   : "?"
    \ }
