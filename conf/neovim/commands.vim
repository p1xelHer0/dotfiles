"""

" -- custom commands to enhance or speed up the way Neovim works

scriptencoding utf-8
set encoding=utf-8


" fuzzy finder of file contents with fzf and ripgrep {{{

" --line-number:     show the line-number in the results
" --fixed-strings:   search term as a literal string
" --ignore-case:     case insensitive search
" --hidden:          search hidden files and folders
" --follow:          follow symlinks
" --glob:            addition glob matching
command! -bang -nargs=* F call fzf#vim#grep('rg --line-number --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)
" }}}
