""" hello 🤔

""" plugins
call plug#begin()

"" syntax

" javascript++
Plug 'pangloss/vim-javascript',                { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx',                            { 'for':                'javascript.jsx'  }
Plug 'ternjs/tern_for_vim',                    { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim',                        { 'for': ['javascript', 'javascript.jsx'] }
Plug 'flowtype/vim-flow',                      { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'benjie/neomake-local-eslint.vim'

" coffescript
Plug 'kchmck/vim-coffee-script',   { 'for': 'coffescript' }

" elm
Plug 'ElmCast/elm-vim',            { 'for': 'elm' }

" purescript
Plug 'raichoo/purescript-vim',     { 'for': 'purescript' }
Plug 'frigoeu/psc-ide-vim',        { 'for': 'purescript' }

" haskell
Plug 'eagletmt/ghcmod-vim',        { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',          { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim',  { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim',  { 'for': 'haskell' }
Plug 'Shougo/vimproc.vim',         { 'for': 'haskell', 'do' : 'make' }

" reasonml
Plug 'reasonml/vim-reason-loader'

" general
Plug 'hail2u/vim-css3-syntax',     { 'for': 'css' }
" Plug 'fleischie/vim-styled-components'
Plug 'elzr/vim-json',              { 'for': 'json' }
Plug 'othree/html5.vim',           { 'for': 'html' }
Plug 'othree/xml.vim',             { 'for': 'xml' }
Plug 'tpope/vim-markdown',         { 'for': 'markdown' }

"" autocompletion
Plug 'Shougo/deoplete.nvim',       { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

"" linting
Plug 'w0rp/ale'
" Plug 'neomake/neomake'

"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

"" edit utils
Plug 'editorconfig/editorconfig-vim'
" Plug 'Townk/vim-autoclose'
" Plug 'jiangmiao/auto-pairs'
" Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'MartinLafreniere/vim-PairTools'
Plug 'AndrewRadev/switch.vim'

"" file handling
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " point to homebrew fzf

"" styling
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

"" dependencies
Plug 'tmux-plugins/vim-tmux-focus-events'

"" other
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-repeat'
Plug 'tweekmonster/startuptime.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()


""" settings

" filetype indent plugin on - default neovim

" indention
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" set smarttab          - default neovim
" set autoindent        - default neovim
" set backspace=indent,eol,start  - default neovim

" set cursorline        " highlight current cursorline
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
set mouse-=a            " disable mouse, LEARN!
set number              " enable line numbers
set relativenumber      " enable relative line number
set ruler               " show the cursor position all the time
set scrolloff=5         " keep 5 lines above the cursor while scrolling

set visualbell          " disable error sound, enable the visual one instead
" set encoding=utf-8    " use utf-8 - default neovim
" set history=10000     " remember more commands - default neovim

set lazyredraw          " disable redraw while executing macros (perf)
set synmaxcol=0         " (everything for now) only syntax highligh so much (perf)

set showcmd             " show command on the last line (for learning)
set shortmess+=I        " no splash screen

set backupcopy=yes


""" ui
" syntax enable - default neovim

" load theme from base16-shell
" https://github.com/chriskempson/base16-shell
if filereadable(expand("$HOME/.vimrc_background"))
  let base16colorspace=256
  source $HOME/.vimrc_background
endif

" split border
" set fillchars+=vert:│
set fillchars+=vert: 
highlight VertSplit ctermfg=bg ctermbg=bg
highlight LineNr ctermbg=bg
highlight CursorLineNr cterm=bold ctermfg=3 ctermbg=bg

" gutter settings
highlight SignColumn ctermbg=bg
highlight GitGutterAdd ctermbg=bg
highlight GitGutterChange ctermbg=bg
highlight GitGutterDelete ctermbg=bg
highlight GitGutterChangeDelete ctermbg=bg

" wildmenu
highlight WildMenu ctermfg=19
highlight StatusLine ctermfg=fg

" error
highlight Error ctermbg=16
highlight ErrorMsg ctermfg=16

" make searches more readable
highlight Search ctermfg=bg

" NonText same color as bg, only shown at the current line in INSERT mode
highlight NonText ctermfg=bg
highlight EndOfBuffer ctermfg=bg

" italic for this and html attributes in jsx
highlight htmlArg cterm=italic
highlight jsThis cterm=italic
highlight xmlAttrib cterm=italic

" highlight ALEErrorSign cterm=none ctermfg=1 ctermbg=18
" highlight ALEWarningSign cterm=none ctermfg=1 ctermbg=18
" highlight link NeomakeError Error
highlight ALEWarning cterm=underline ctermfg=3
highlight ALEError cterm=underline ctermfg=16

" lightline matches base16
let g:lightline = {
\ 'colorscheme': 'base16'
\ }

" NERDTree
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "~",
\ "Staged"    : "▲",
\ "Untracked" : "▼",
\ "Renamed"   : "→",
\ "Unmerged"  : "=",
\ "Deleted"   : "-",
\ "Dirty"     : "~",
\ "Clean"     : "◆",
\ "Unknown"   : "?"
\ }

highlight NERDTreeGitStatusDirDirtytracked ctermfg=3
highlight NERDTreeGitStatusModified ctermfg=3
highlight link NERDTreeGitStatusDirClean DiffAdd
highlight link NERDTreeGitStatusStaged Special
highlight link NERDTreeGitStatusRenamed DiffLine
highlight link NERDTreeGitStatusUnmerged DiffLine
highlight link NERDTreeGitStatusUntracked DiffFile
highlight link NERDTreeGitStatusIgnored DiffFile

" autoresize windows on terminal resize
autocmd VimResized * execute "normal! \<c-w>="

" http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

" disable paste mode on leaving INSERT mode.
autocmd InsertLeave * set nopaste

"" focus
" keep it at 80
" let &l:colorcolumn="80"

" only show colorcolumn on focused window
" if exists('+colorcolumn')
"   autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn="80"
"   autocmd FocusLost,WinLeave * let &l:colorcolumn=""
" endif

" only show the colorcolumn if the width surpasses 80
highlight OverLength ctermbg=3 ctermfg=0
match OverLength /\%81v/

" only show cursorline on focused window
autocmd BufEnter,FocusGained,VimEnter,WinEnter * setlocal cursorline
autocmd FocusLost,WinLeave * setlocal nocursorline

" prettier + eslint
autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
" autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
"


" goyo
" function! s:goyo_enter()
"   silent !tmux set status off
"   silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
"   set noshowmode
"   set noshowcmd
"   set scrolloff=999
" endfunction
"
" function! s:goyo_leave()
"   silent !tmux set status on
"   silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
"   set showmode
"   set showcmd
"   set scrolloff=5
" endfunction
"
"   set showcmd
"   set scrolloff=5
" endfunction
"
"   set showcmd
"   set scrolloff=5
" endfunction
"
"   set showcmd
"   set scrolloff=5
" endfunction
"
" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()

" set curosor to | in INSERT - neovim specific
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" fix slight delay after pressing ESC then O (???)
" http://ksjoberg.com/vim-esckeys.html/
set timeout timeoutlen=500 ttimeoutlen=100

" paths to python2/3 envs - neovim specific
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'


""" keymappings + plugin settings

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

let mapleader="\<Space>"
" reload .vimrc
noremap <Leader><Leader>r :so $MYVIMRC<CR>

" universal mappings

" use ctrl-[hjkl] to move between splits
" using vim-tmux-navigator instead
" nmap <silent> <C-k> :wincmd k<CR>
" nmap <silent> <C-j> :wincmd j<CR>
" nmap <silent> <C-h> :wincmd h<CR>
" nmap <silent> <C-l> :wincmd l<CR>

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

" replace spaces with tabs or the other way around
" :nohl because NERDTree bugs after replacing as of now
nnoremap <Leader>r<Space>t :%s/  /\t/g<CR>:nohl<CR>
nnoremap <Leader>rt<Space> :%s/\t/  /g<CR>

" store relative line number jumps in the jumplist if they exceed a threshold
nnoremap <expr>k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr>j (v:count > 5 ? "m'" . v:count : '') . 'j'

" f10 prints the current highlight rules for cursor selection
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" toggle NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" ale
nmap <silent><Up> <Plug>(ale_previous_wrap)
nmap <silent><Down> <Plug>(ale_next_wrap)

" neomake
nnoremap <Leader>o :lopen<CR>           " open location window
nnoremap <Leader><Leader>o :lclose<CR>   " close location window
nnoremap <silent><Right> :ll<CR>         " go to current error/warning
" nnoremap <silent><Down> :lnext<CR>      " next error/warning
" knnoremap <silent><Up> :lprev<CR>        " previous error/warning

" tern
autocmd FileType javascript nnoremap <Leader>d :TernDef<CR>

"" insert mappings

" deoplete tab-complete
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

map <C-c> <CR><Esc>O

nnoremap <Leader><Leader>f gggqG\<C-o>\<C-o>


"" visual mappings

"" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" plugins settings

"" deoplete (automcompletion)
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" enter closes options if present and inserts linebreak
" apparently this has to be that complicated
" inoremap <silent> <CR> <C-r>=<SID>close_and_linebreak()<CR>
function! s:close_and_linebreak()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt-=preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1


"" ultisnips
let g:UltiSnipsSnippetsDir = $HOME . '/.config/nvim/'
let g:UltiSnipsEditSplit = 'vertical'


"" ternjs (javascript)
"  https://ternjs.net/
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 0
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif


"" elm
if exists('g:plugs["elm-vim"]')
  let g:deoplete#omni#functions.elm = ['elm#Complete']
  let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
endif

let g:elm_format_autosave = 1


"" purescript
if exists('g:plugs["purescript-vim"]')
  let g:deoplete#omni#input_patterns.purescript = '[^ \t]+'
endif


"" neco-ghc (haskell)
"  https://github.com/eagletmt/neco-ghc
if exists('g:plugs["neco-ghc"]')
  let g:haskellmode_completion_ghc = 1
  let g:necoghc_enable_detailed_browse = 1
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
endif


"" haskell-vim (haskell)
" https://github.com/neovimhaskell/haskell-vim
if exists('g:plugs["haskell-vim"]')
  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  let g:haskell_indent_case = 2             " two spaces for indentation
endif


"" reasonml
" use refmt instead of vims standard formatting
autocmd FileType reason map <buffer> <Leader><Leader>f :ReasonPrettyPrint<Cr>

autocmd FileType reason let g:pairtools_reason_pairclamp       = 1
autocmd FileType reason let g:pairtools_reason_tagwrench       = 0
autocmd FileType reason let g:pairtools_reason_jigsaw          = 1
autocmd FileType reason let g:pairtools_reason_autoclose       = 1
autocmd FileType reason let g:pairtools_reason_forcepairs      = 0
autocmd FileType reason let g:pairtools_reason_closepairs      = "(:),[:],{:}" . ',":"'
autocmd FileType reason let g:pairtools_reason_smartclose      = 1
autocmd FileType reason let g:pairtools_reason_smartcloserules = '\w,(,&,\*'
autocmd FileType reason let g:pairtools_reason_antimagic       = 1
autocmd FileType reason let g:pairtools_reason_antimagicfield  = "Comment,String,Special"
autocmd FileType reason let g:pairtools_reason_pcexpander      = 1
autocmd FileType reason let g:pairtools_reason_pceraser        = 1
autocmd FileType reason let g:pairtools_reason_tagwrenchhook   = 'tagwrench#BuiltinNoHook'
autocmd FileType reason let g:pairtools_reason_twexpander      = 0
autocmd FileType reason let g:pairtools_reason_tweraser        = 0
autocmd FileType reason let g:pairtools_reason_apostrophe      = 0


"" ale (linting)
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
" let g:ale_sign_error = emoji#for('collision')
" let g:ale_sign_warning = emoji#for('sparkles')

"" neomake (linting)
" autocmd! BufWritePost,InsertLeave * Neomake
" let g:neomake_open_list = 0

" let g:neomake_warning_sign = {
" \ 'text': '×',
" \ 'texthl': 'WarningMsg',
" \ }

" let g:neomake_error_sign = {
" \ 'text': '×',
" \ 'texthl': 'ErrorMsg',
" \ }


" eslint > jshint
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'haskell': ['ghci', 'hlint']
" \}
" let g:neomake_javascript_enabled_makers = ['eslint']

" allow jsx in normal js files
let g:jsx_ext_required = 0

"" flow
" I use eslint for flow, disable the plugin typechecking
let g:flow#enable = 0

" use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif


" css
" let g:neomake_css_enabled_makers = ['stylelint']


" purescript
let g:psc_ide_syntastic_mode = 2


"highlight NeomakeMessageSignDefault NONE
"highlight NeomakeWarningSignDefault NONE
"highlight NeomakeErrorSignDefault NONE

"highlight NeomakeMessageSignDefault ctermfg=2 ctermbg=18
"highlight link NeomakeMessageSign NeomakeMessageSignDefault
"highlight NeomakeWarningSignDefault ctermfg=3 ctermbg=18
"highlight link NeomakeWarningSign NeomakeWarningSignDefault
"highlight NeomakeErrorSignDefault ctermfg=6 ctermbg=18
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"" NERDTree
let NERDTreeBookmarksFile=expand("$HOME/.config/nvim/NERDTreeBookmarks")
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

" open NERDTree when opening a directory or just starting vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

