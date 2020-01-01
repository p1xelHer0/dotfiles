"""

" -- plugins I use for my daily web development life


" auto install plug if not found
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup PLUG
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif


call plug#begin()

" syntax {{{

" JavaScript
Plug 'pangloss/vim-javascript',                { 'for': 'javascript.jsx' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript.jsx' }
Plug 'mxw/vim-jsx',                            { 'for': 'javascript.jsx' }
Plug 'styled-components/vim-styled-components',{ 'for': 'javascript.jsx' }
Plug 'jxnblk/vim-mdx-js',                      { 'for': 'mdx' }

" TypeScript
Plug 'leafgarland/typescript-vim',             { 'for': 'typescript' }

" HTML
Plug 'othree/html5.vim',                       { 'for': 'html' }

" CSS
Plug 'hail2u/vim-css3-syntax',                 { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim',              { 'for': 'scss' }

" JSON
Plug 'elzr/vim-json',                          { 'for': 'json' }
Plug 'neoclide/jsonc.vim',                     { 'for': 'json' }

" GraphQL
Plug 'jparise/vim-graphql'

" XML
Plug 'othree/xml.vim',                         { 'for': 'xml' }

" Markdown
Plug 'plasticboy/vim-markdown',                { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown',              { 'for': 'markdown', 'do': 'yarn global add instant-markdown-d' }

" LaTeX
Plug 'lervag/vimtex',                          { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview',          { 'for': 'tex' }

" CoffeeScript
" Plug 'kchmck/vim-coffee-script',               { 'for': 'coffescript' }

" Elm
" Plug 'ElmCast/elm-vim',                        { 'for': 'elm' }

" OCaml/Reason
Plug 'reasonml-editor/vim-reason-plus'
Plug 'ocaml/merlin',
Plug 'jordwalke/vim-reasonml',
Plug 'rgrinberg/vim-ocaml',                    { 'for': 'ocaml' }

" PureScript
" Plug 'purescript-contrib/purescript-vim',      { 'for': 'purescript' }
" Plug 'FrigoEU/psc-ide-vim',                    { 'for': 'purescript' }

" Haskell
" Plug 'Shougo/vimproc.vim',                     { 'for': 'haskell', 'do' : 'make' }
" Plug 'eagletmt/ghcmod-vim',                    { 'for': 'haskell' }
" Plug 'eagletmt/neco-ghc',                      { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim',              { 'for': 'haskell' }
" Plug 'enomsg/vim-haskellConcealPlus',          { 'for': 'haskell' }
" Plug 'parsonsmatt/intero-neovim',              { 'for': 'haskell' }

" Rust
Plug 'rust-lang/rust.vim',                     { 'for': 'rust' }
Plug 'ron-rs/ron.vim',                         { 'for': 'rust' }

" C#
" Plug 'OmniSharp/omnisharp-vim'

" Lua
" Plug 'tbastos/vim-lua',                        { 'for': 'lua' }
" Plug 'davisdude/vim-love-docs',                { 'for': 'lua' }

" Godot
" Plug 'quabug/vim-gdscript'

" other
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'majutsushi/tagbar'

" }}}


" utilis {{{

" autocompletion
Plug 'neoclide/coc.nvim',                      { 'branch': 'release', 'do': { -> coc#util#install()} }
Plug 'ervandew/supertab'

" linting
Plug 'w0rp/ale'

" VCS
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'sodapopcan/vim-twiggy'
Plug 'tpope/vim-fugitive'

" editing
Plug 'AndrewRadev/switch.vim'
" Plug 'SirVer/ultisnips'
Plug 'sgur/vim-editorconfig'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Plug 'machakann/vim-sandwich'

" file handling and searching
" Plug 'scrooloose/nerdtree'
" Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf',                           { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'benmills/vimux'

" other
" Plug 'chriskempson/base16-vim'
" Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'auwsmit/vim-active-numbers'
" Plug 'xtal8/traces.vim'
" Plug 'nightsense/shoji'

" }}}

call plug#end()
