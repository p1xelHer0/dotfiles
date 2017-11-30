"""

" -- plugins I use for my daily web development life


" auto install plug if not found
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup PLUG
    autocmd!
    autocmd VimEnter * PlugInstall
  augroup END
endif


call plug#begin()

" syntax {{{

" JavaScript
Plug 'pangloss/vim-javascript',                { 'for': 'javascript.jsx' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript.jsx' }
Plug 'mxw/vim-jsx',                            { 'for': 'javascript.jsx' }
Plug 'styled-components/vim-styled-components',{ 'for': 'javascript.jsx' }
Plug 'ternjs/tern_for_vim',                    { 'for': 'javascript.jsx', 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs',               { 'for': 'javascript.jsx' }
Plug 'othree/jspc.vim',                        { 'for': 'javascript.jsx' }

" TypeScript
Plug 'leafgarland/typescript-vim',             { 'for': 'typescript' }
Plug 'mhartington/nvim-typescript',            { 'for': 'typescript' }

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
Plug 'plasticboy/vim-markdown',                { 'for': 'markdown' }
Plug 'suan/vim-instant-markdown',              { 'for': 'markdown', 'do': 'yarn global add instant-markdown-d' }

" CoffeeScript
Plug 'kchmck/vim-coffee-script',               { 'for': 'coffescript' }

" Elm
Plug 'ElmCast/elm-vim',                        { 'for': 'elm' }

" Reason
Plug 'reasonml-editor/vim-reason',             { 'for': 'reasonml' }

" PureScript
Plug 'purescript-contrib/purescript-vim',      { 'for': 'purescript' }
Plug 'FrigoEU/psc-ide-vim',                    { 'for': 'purescript' }

" Haskell
Plug 'Shougo/vimproc.vim',                     { 'for': 'haskell', 'do' : 'make' }
Plug 'eagletmt/ghcmod-vim',                    { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',                      { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim',              { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim',              { 'for': 'haskell' }

" other
Plug 'ap/vim-css-color'
Plug 'majutsushi/tagbar'

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
Plug 'AndrewRadev/switch.vim'
Plug 'SirVer/ultisnips'
Plug 'sgur/vim-editorconfig'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'

" file handling and searching
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" other
Plug 'junegunn/vim-peekaboo'
Plug 'haya14busa/is.vim'
Plug 'junegunn/vim-slash'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'auwsmit/vim-active-numbers'
Plug 'xtal8/traces.vim'

" }}}

call plug#end()
