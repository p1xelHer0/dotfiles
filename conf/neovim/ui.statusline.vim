"""

" -- themes, colors and everything that affects the look of the statusline


set laststatus=2

" status line shows the mode, no need to show it
" set noshowmode

" lightline {{{

" let g:lightline = {
" \ 'colorscheme': 'base16',
" \
" \ 'separator':    { 'left': '▓░', 'right': '░▓' },
" \ 'subseparator': { 'left': '░', 'right': '░' }
" \ }

" colors
" credit to: https://github.com/daviesjamie/vim-base16-lightline
" let s:color00 = [ '0', 0 ]   " base 00 - default background
" let s:color18 = [ '18', 18 ] " base 01 - lighter background (Used for status bars)

" let s:color19 = [ '19', 19 ] " base 02 - selection background

" let s:color08 = [ '8',  8 ]  " base 03 - comments, invisibles, line highlighting
" let s:color20 = [ '20', 20 ] " base 04 - dark foreground (used for status bars)
" let s:color07 = [ '7',  7 ]  " base 05 - default foreground, caret, delimiters, operators

" let s:color21 = [ '21', 21 ] " base 06 - light foreground (not often used)
" let s:color15 = [ '15', 15 ] " base 07 - light background (not often used)

" let s:color01 = [ '1',  1 ]  " base 08 - variables, XML tags, markup link text, markup lists, diff deleted
" let s:color16 = [ '16', 16 ] " base 09 - integers, boolean, constants, XML attributes, markup link url
" let s:color03 = [ '3',  3 ]  " base 0A - classes, markup bold, search text background
" let s:color02 = [ '2',  2 ]  " base 0B - strings, inherited class, markup code, diff inserted
" let s:color06 = [ '6',  6 ]  " base 0C - support, regular expressions, escape characters, markup quotes
" let s:color04 = [ '4',  4 ]  " base 0D - functions, methods, attribute IDs, headings
" let s:color05 = [ '5',  5 ]  " base 0E - keywords, storage, selector, markup italic, diff changed
" let s:color17 = [ '17', 17 ] " base 0F - deprecated, opening/closing embedded language tags e.g. <?php ?>

" let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" let s:p.normal.left     = [ [ s:color18, s:color08 ], [ s:color07, s:color19 ] ]
" let s:p.insert.left     = [ [ s:color00, s:color04 ], [ s:color07, s:color19 ] ]
" let s:p.visual.left     = [ [ s:color00, s:color16 ], [ s:color07, s:color19 ] ]
" let s:p.replace.left    = [ [ s:color00, s:color01 ], [ s:color07, s:color19 ] ]
" let s:p.inactive.left   = [ [ s:color19, s:color00 ] ]

" let s:p.normal.middle   = [ [ s:color15, s:color18 ] ]
" let s:p.inactive.middle = [ [ s:color18, s:color00 ] ]

" let s:p.normal.right    = [ [ s:color18, s:color08 ], [ s:color08, s:color19 ] ]
" let s:p.inactive.right  = [ [ s:color18, s:color00 ] ]

" let s:p.normal.error    = [ [ s:color15, s:color01 ] ]
" let s:p.normal.warning  = [ [ s:color15, s:color16 ] ]

" let s:p.tabline.left    = [ [ s:color07, s:color19 ] ]
" let s:p.tabline.middle  = [ [ s:color07, s:color18 ] ]
" let s:p.tabline.right   = [ [ s:color07, s:color19 ] ]
" let s:p.tabline.tabsel  = [ [ s:color19, s:color03 ] ]

" let g:lightline#colorscheme#base16#palette = lightline#colorscheme#flatten(s:p)

" }}}
