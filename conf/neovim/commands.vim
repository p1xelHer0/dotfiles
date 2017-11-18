"""

" -- custom commands to enhance or speed up the way Neovim works

scriptencoding utf-8
set encoding=utf-8


" F command {{{

" fuzzy finder of file contents
" utilizes fzf and ripgrep
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* F call fzf#vim#grep('rg --column --line-number --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)

" }}}
