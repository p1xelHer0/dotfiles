" hello 🤔

""" plugins
call plug#begin()

"" syntax
" Plug 'ElmCast/elm-vim'
Plug 'gko/vim-coloresque'
Plug 'hail2u/vim-css3-syntax'
Plug 'leshill/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript'
" Plug 'tpope/vim-markdown'

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
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()


""" Settings

" filetype indent plugin on - default neovim

" indention
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" set smarttab          - default neovim
" set autoindent        - default neovim
" set backspace=indent,eol,start  - default neovim

set cursorline          " highlight current cursorline
set list                " display the listchars
set listchars+=tab:»\ ,trail:·,nbsp:×,eol:¬
set clipboard=unnamed   " normal OS clipboard interaction
set copyindent          " copy the previous indentation on autoindenting
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase
set showmatch           " automatically show matching brackets
" set autoread          " auto reload files changed - default neovim
" set laststatus=2      " display the status line always - default neovim
" set wildmenu          " enable the wildmenu - default neovim
" set incsearch         " show search matches as you type - default neovim
" set hlsearch          " highlight search terms - default neovim

set number              " enable line numbers
set relativenumber      " enable relative line number
set ruler               " show the cursor position all the time
set scrolloff=5         " keep 5 lines above the cursor while scrolling

set visualbell          " disable error sound, enable the visual one instead
" set encoding=utf-8    " use utf-8 - default neovim
" set history=10000     " remember more commands - default neovim

set lazyredraw          " disable redraw while executing macros (perf)
set synmaxcol=120       " only syntax highligh so much (perf)

set showcmd             " show command on the last line (for learning)
set shortmess+=I        " no splash screen


""" ui
" syntax enable - default neovim

" load theme from base16-shell
" https://github.com/chriskempson/base16-shell
if filereadable(expand("$HOME/.vimrc_background"))
  let base16colorspace=256
  source $HOME/.vimrc_background
endif

" split border
set fillchars+=vert:│
highlight VertSplit ctermbg=18
highlight CursorLineNr cterm=bold ctermfg=3

" NonText same color as bg, only shown at the current line in INSERT mode
highlight NonText ctermfg=bg

" italic for this and html attributes in jsx
highlight htmlArg cterm=italic
highlight jsThis cterm=italic
highlight xmlAttrib cterm=italic

" autoresize windows on terminal resize
autocmd VimResized * execute "normal! \<c-w>="

" keep it at 80
" let &l:colorcolumn='+' . join(range(0, 80), ',+')

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

" disable paste mode on leaving INSERT mode.
autocmd InsertLeave * set nopaste

" make current window more obvious
" colorcolumn
" if exists('+colorcolumn')
  " autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(0, 80), ',+')
  " autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(0, 255), ',')
" endif

" show cursorline only in NORMAL
" autocmd InsertLeave,VimEnter,WinEnter * setlocal cursorline
" autocmd InsertEnter,WinLeave * setlocal nocursorline

" set curosor to | in INSERT - neovim specific
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" fix slight delay after pressing ESC then O (???)
" http://ksjoberg.com/vim-esckeys.html/
set timeout timeoutlen=500 ttimeoutlen=100

" paths to python2/3 envs - neovim specific
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'


""" keymappings + plugin settings

let mapleader="\<Space>"

"" universal mappings

" switch windows with ctrl hjkl
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" yank to the end of the line with Y
noremap Y y$


"" normal mappings

" <Leader><Leader> -- open last buffer
nnoremap <Leader><Leader> <C-^>

" avoid unintentional switches to Ex mode.
nmap Q q

" I will probably missclick this as well...
nnoremap K <nop>

" repeat last macro if in a normal buffer
nnoremap <expr><CR> empty(&buftype) ? '@@' : '<CR>'

" quit, write and xit quicker
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" store relative line number jumps in the jumplist if they exceed a threshold
nnoremap <expr>k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>j (v:count > 5 ? "m'" . v:count : '') . 'j'

" f10 prints the current highlight rules for cursor selection
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" toggle NERDTree
nmap <leader>n :NERDTreeToggle<CR>

" neomake
nnoremap <Leader>o :lopen<CR>           " open location window
nnoremap <Leader><Leader>o :lclose<CR>  " close location window
nnoremap <silent><Right> :ll<CR>        " go to current error/warning
nnoremap <silent><Down> :lnext<CR>      " next error/warning
nnoremap <silent><Up> :lprev<CR>        " previous error/warning

" tern
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>

"" insert mappings

" deoplete tab-complete (except for UtilSnips, which is not used right now)
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


""" plugins settings

"" deoplete (automcompletion)
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
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1

"" tern
" https://ternjs.net/
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 0
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

"" neomake (linting)
autocmd! InsertLeave,BufWritePost * Neomake
let g:neomake_open_list = 0

"let g:neomake_warning_sign = {
"\ 'text': '×',
"\ 'texthl': 'WarningMsg',
"\ }

"let g:neomake_error_sign = {
"\ 'text': '×',
"\ 'texthl': 'ErrorMsg',
"\ }

" eslint > jshint
let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']

" allow jsx in normal js files
let g:jsx_ext_required = 0

"" flow
" use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

"highlight NeomakeMessageSignDefault NONE
"highlight NeomakeWarningSignDefault NONE
"highlight NeomakeErrorSignDefault NONE

"highlight NeomakeMessageSignDefault ctermfg=2 ctermbg=18
"highlight link NeomakeMessageSign NeomakeMessageSignDefault
"highlight NeomakeWarningSignDefault ctermfg=3 ctermbg=18
"highlight link NeomakeWarningSign NeomakeWarningSignDefault
"highlight NeomakeErrorSignDefault ctermfg=6 ctermbg=18
"highlight link NeomakeErrorSign NeomakeErrorSignDefault

" syntax highlighting for flow
let g:javascript_plugin_flow = 1

" libraries I tend to use
let g:used_javascript_libs = 'ramda,react'

"" NERDTree
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

" open NERDTree when opening a directory or just starting vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" let g:NERDTreeIndicatorMapCustom = {
    "\ "Modified"  : "M",
    "\ "Staged"    : "+",
    "\ "Untracked" : "A",
    "\ "Renamed"   : "R",
    "\ "Unmerged"  : "U",
    "\ "Deleted"   : "D",
    "\ "Dirty"     : "X",
    "\ "Clean"     : "✓",
    "\ "Unknown"   : "?"
    "\ }
