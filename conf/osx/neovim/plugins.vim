"""

" -- plugins I use for my daily web development life


call plug#begin()

" syntax {{{

" JavaScript
Plug 'pangloss/vim-javascript',                { 'for': 'javascript.jsx' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript.jsx' }
Plug 'mxw/vim-jsx',                            { 'for': 'javascript.jsx' }
Plug 'fleischie/vim-styled-components',        { 'for': 'javascript.jsx' }
Plug 'ternjs/tern_for_vim',                    { 'for': 'javascript.jsx', 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs',               { 'for': 'javascript.jsx' }
Plug 'othree/jspc.vim',                        { 'for': 'javascript.jsx' }
Plug 'flowtype/vim-flow',                      { 'for': 'javascript.jsx' }

" HTML
Plug 'othree/html5.vim',                       { 'for': 'html' }

" CSS
Plug 'hail2u/vim-css3-syntax',                 { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim',              { 'for': 'scss' }

" JSON
Plug 'elzr/vim-json',                          { 'for': 'json' }

" XML
Plug 'othree/xml.vim',                         { 'for': 'xml' }

" Markdown
Plug 'tpope/vim-markdown',                     { 'for': 'markdown' }

" CoffeeScript
Plug 'kchmck/vim-coffee-script',               { 'for': 'coffescript' }

" Elm
Plug 'ElmCast/elm-vim',                        { 'for': 'elm' }

" PureScript
Plug 'raichoo/purescript-vim',                 { 'for': 'purescript' }
Plug 'frigoeu/psc-ide-vim',                    { 'for': 'purescript' }

" Reason
Plug 'reasonml/vim-reason-loader'
Plug 'MartinLafreniere/vim-PairTools'

" Haskell
Plug 'eagletmt/ghcmod-vim',                    { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',                      { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim',              { 'for': 'haskell' }
" Plug 'parsonsmatt/intero-neovim',              { 'for': 'haskell' }
Plug 'Shougo/vimproc.vim',                     { 'for': 'haskell', 'do' : 'make' }

" }}}


" utilis {{{

" autocompletion
Plug 'Shougo/deoplete.nvim',                   { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" linting
Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" editing
Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/switch.vim'

" file handling and searching
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " use brew fzf
Plug 'tpope/vim-repeat'

" styling
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'

" tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" other
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" }}}

call plug#end()
