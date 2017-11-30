"""

" -- themes, colors and everything that affects the look of plugins


" NERDTree {{{

let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowFiles=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0

" Git status icons
let g:NERDTreeIndicatorMapCustom = {
\ 'Modified'  : '~',
\ 'Staged'    : '▲',
\ 'Untracked' : '+',
\ 'Renamed'   : '→',
\ 'Unmerged'  : '=',
\ 'Deleted'   : '_',
\ 'Dirty'     : '~',
\ 'Clean'     : '◆',
\ 'Unknown'   : '?'
\ }

" }}}
