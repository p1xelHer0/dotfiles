"""

" -- themes, colors and everything that affects the look of the statusline

scriptencoding utf-8
set encoding=utf-8


set laststatus=2

" status line shows the mode, no need to show it
set noshowmode


" statusline {{{

let g:lightline = {
\ 'colorscheme': 'p1xelHer0',
\ 'active': {
\   'left':  [ [ 'mode', 'paste' ],
\              [ 'readonly', 'filename', 'modified' ] ],
\
\   'right': [ [ 'lineinfo' ],
\              [ 'fileformat', 'fileencoding', 'filetype' ] ],
\ },
\ 'inactive': {
\   'left':  [ [ 'filename' ] ],
\
\   'right': [ [ 'lineinfo' ],
\              [ 'filetype' ] ],
\ },
\ }


" colors
let s:color0  = [ '#181818',  0 ]
let s:color1  = [ '#181818',  1 ]
let s:color15 = [ '#181818', 15 ]
let s:color2  = [ '#181818',  2 ]
let s:color3  = [ '#181818',  3 ]
let s:color4  = [ '#181818',  4 ]
let s:color5  = [ '#181818',  5 ]
let s:color6  = [ '#181818',  6 ]
let s:color7  = [ '#181818',  7 ]
let s:color8  = [ '#181818',  8 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:color0, s:color6 ], [ s:color6, s:color0 ] ]
let s:p.insert.left     = [ [ s:color0, s:color5 ], [ s:color5, s:color0 ] ]
let s:p.visual.left     = [ [ s:color0, s:color1 ], [ s:color1, s:color0 ] ]
let s:p.replace.left    = [ [ s:color0, s:color1 ], [ s:color1, s:color0 ] ]
let s:p.inactive.left   = [ [ s:color0, s:color6 ], [ s:color6, s:color0 ] ]

let s:p.normal.middle   = [ [ s:color0, s:color0 ] ]
let s:p.insert.middle   = [ [ s:color0, s:color0 ] ]
let s:p.inactive.middle = [ [ s:color0, s:color0 ] ]

let s:p.normal.right    = [ [ s:color0, s:color6 ], [ s:color6, s:color0 ] ]
let s:p.insert.right    = [ [ s:color0, s:color5 ], [ s:color5, s:color0 ] ]
let s:p.visual.right    = [ [ s:color0, s:color1 ], [ s:color1, s:color0 ] ]
let s:p.replace.right   = [ [ s:color0, s:color1 ], [ s:color6, s:color0 ] ]
let s:p.inactive.right  = [ [ s:color0, s:color2 ] ]

let s:p.normal.error    = [ [ s:color7, s:color1 ] ]
let s:p.normal.warning  = [ [ s:color7, s:color1 ] ]

let s:p.tabline.left    = [ [ s:color7, s:color2 ] ]
let s:p.tabline.middle  = [ [ s:color7, s:color1 ] ]
let s:p.tabline.right   = [ [ s:color7, s:color2 ] ]
let s:p.tabline.tabsel  = [ [ s:color2, s:color3 ] ]


let g:lightline#colorscheme#p1xelHer0#palette = lightline#colorscheme#flatten(s:p)

" }}}
