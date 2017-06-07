call plug#begin()

" ## Syntax {{

" # JavaScript {
Plug 'pangloss/vim-javascript',                { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx',                            { 'for': ['javascript', 'javascript.jsx'] }
Plug 'fleischie/vim-styled-components',        { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim',                    { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim',                        { 'for': ['javascript', 'javascript.jsx'] }
Plug 'flowtype/vim-flow',                      { 'for': ['javascript', 'javascript.jsx'] }
" } JavaScript #

" # HTML {
Plug 'othree/html5.vim',                       { 'for': 'html' }
" } HTML #

" # CSS {
Plug 'hail2u/vim-css3-syntax',                 { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim',              { 'for': 'scss' }
" } CSS #

" # JSON {
Plug 'elzr/vim-json',                          { 'for': 'json' }
" } JSON #

" # XML {
Plug 'othree/xml.vim',                         { 'for': 'xml' }
" } XML #

" # Markdown {
Plug 'tpope/vim-markdown',                     { 'for': 'markdown' }
" } Markdown #

" # CoffeeScript {
Plug 'kchmck/vim-coffee-script',               { 'for': 'coffescript' }
" } CoffeeScript #

" # Elm {
Plug 'ElmCast/elm-vim',                        { 'for': 'elm' }
" } Elm #

" # PureScript {
Plug 'raichoo/purescript-vim',                 { 'for': 'purescript' }
Plug 'frigoeu/psc-ide-vim',                    { 'for': 'purescript' }
" } PureScript #

" # Reasonml {
Plug 'reasonml/vim-reason-loader',             { 'for': 'reason' }
Plug 'MartinLafreniere/vim-PairTools',         { 'for': 'reason' }
" } Reasonml #

" # Haskell {
Plug 'eagletmt/ghcmod-vim',                    { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',                      { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim',              { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim',              { 'for': 'haskell' }
Plug 'Shougo/vimproc.vim',                     { 'for': 'haskell', 'do' : 'make' }
" } Haskell #

" } Reasonml #
Plug 'reasonml/vim-reason-loader',             { 'for': 'reason' }
" } Reasonml #

" }} Syntax ##


" ## Utilis {{

" # Autocompletion {
Plug 'Shougo/deoplete.nvim',                   { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
" } Autocompletion #

" # Linting {
Plug 'w0rp/ale'
" } Linting #

" # Git {
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
" } Git #

" # Editing {
Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/switch.vim'
" } Editing #

" # File handling and searching {
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " use brew fzf
Plug 'tpope/vim-repeat'
" } File handling and searching #

" # Styling {
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
" } Styling #

" # Tmux integration {
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
" } Tmux integration #

" # Other {
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
" } Other #

" }} Utilis ##

call plug#end()
