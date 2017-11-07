"""

" -- themes, colors and everything that affects the look of Neovim

scriptencoding utf-8
set encoding=utf-8


highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'pxl9'


" save colors from Git
let g:GitAddColor = system('git config --list | grep added | grep -o -E "[0-8]"')
let g:GitChangeColor = system('git config --list | grep changed | grep -o -E "[0-8]"')
let g:GitUntrackedColor = system('git config --list | grep untracked | grep -o -E "[0-8]"')


highlight Normal ctermfg=7 ctermbg=NONE cterm=NONE
highlight NonText ctermfg=8 ctermbg=NONE cterm=NONE
highlight EndOfBuffer ctermfg=0 cterm=NONE
highlight Comment ctermfg=8 ctermbg=NONE cterm=italic
highlight Constant ctermfg=3 ctermbg=NONE cterm=NONE
highlight Error ctermfg=0 ctermbg=1 cterm=NONE
highlight ErrorMsg ctermfg=1 ctermbg=NONE cterm=NONE
highlight Identifier ctermfg=1 ctermbg=NONE cterm=NONE
highlight Ignore ctermfg=0 ctermbg=8 cterm=NONE
highlight PreProc ctermfg=3 ctermbg=NONE cterm=NONE
highlight Special ctermfg=6 ctermbg=NONE cterm=NONE
highlight Statement ctermfg=1 ctermbg=NONE cterm=NONE
highlight String ctermfg=2 ctermbg=NONE cterm=NONE
highlight Number ctermfg=3 ctermbg=NONE cterm=NONE
highlight Todo ctermfg=0 ctermbg=2 cterm=NONE
highlight Type ctermfg=3 ctermbg=NONE cterm=NONE
highlight Underlined ctermfg=1 ctermbg=NONE cterm=underline

highlight MatchParen ctermfg=0 ctermbg=4 cterm=reverse

highlight LineNr ctermfg=8 ctermbg=0 cterm=NONE
highlight CursorLineNr ctermfg=3 ctermbg=0 cterm=bold
highlight CursorLine ctermfg=0 ctermbg=8 cterm=NONE
  highlight link FoldColumn CursorLineNr

highlight Folded ctermfg=8 ctermbg=NONE cterm=NONE

highlight TermCursorNC ctermfg=0 ctermbg=3 cterm=NONE
highlight Title ctermfg=4 ctermbg=NONE cterm=NONE
highlight helpLeadBlank ctermfg=7 ctermbg=NONE cterm=NONE
highlight helpNormal ctermfg=7 ctermbg=NONE cterm=NONE
highlight Visual cterm=reverse ctermbg=0
highlight VisualNOS ctermfg=1 ctermbg=NONE cterm=NONE

highlight SpecialKey ctermfg=8 ctermbg=NONE cterm=NONE

execute 'highlight DiffAdd ctermfg=0 cterm=NONE ctermbg=' . g:GitAddColor
execute 'highlight DiffChange ctermfg=0 cterm=NONE ctermbg=' . g:GitChangeColor
execute 'highlight DiffDelete ctermfg=0 cterm=NONE ctermbg=' . g:GitUntrackedColor
highlight DiffText ctermfg=0 ctermbg=4 cterm=NONE

highlight Search ctermfg=0 ctermbg=3 cterm=NONE
  highlight! link SearchInc Search
  highlight! link WildMenu Search
  highlight! link TabLineSel Search
  highlight! link PmenuSel Search

highlight StatusLine ctermfg=0 ctermbg=8 cterm=NONE
highlight StatusLineNC ctermfg=0 ctermbg=8 cterm=NONE

highlight TabLine ctermfg=0 ctermbg=8 cterm=NONE
highlight! link TabLineFill StatusLine

highlight VertSplit ctermfg=8 ctermbg=8 cterm=NONE

highlight Pmenu ctermfg=7 ctermbg=8 cterm=NONE
highlight PmenuSbar ctermfg=NONE ctermbg=0 cterm=NONE
highlight PmenuThumb ctermfg=NONE ctermbg=4 cterm=NONE

highlight Directory ctermfg=4 ctermbg=NONE cterm=NONE
highlight ColorColumn ctermfg=0 ctermbg=4 cterm=NONE
highlight signColumn ctermfg=4 ctermbg=NONE cterm=NONE
highlight ModeMsg ctermfg=2 ctermbg=NONE cterm=NONE
highlight MoreMsg ctermfg=2 ctermbg=NONE cterm=NONE
highlight Question ctermfg=4 ctermbg=NONE cterm=NONE
highlight WarningMsg ctermfg=0 ctermbg=1 cterm=NONE
highlight Cursor ctermfg=8 ctermbg=NONE cterm=NONE
highlight Structure ctermfg=5 ctermbg=NONE cterm=NONE
highlight CursorColumn ctermfg=7 ctermbg=8 cterm=NONE
highlight ModeMsg ctermfg=7 ctermbg=NONE cterm=NONE
highlight SpellBad ctermfg=0 ctermbg=1 cterm=NONE
highlight SpellCap ctermfg=4 ctermbg=NONE cterm=underline
highlight SpellLocal ctermfg=5 ctermbg=NONE cterm=underline
highlight SpellRare ctermfg=6 ctermbg=NONE cterm=underline
highlight Boolean ctermfg=5 ctermbg=NONE cterm=NONE
highlight Character ctermfg=1 ctermbg=NONE cterm=NONE
highlight Conditional ctermfg=5 ctermbg=NONE cterm=NONE
highlight Define ctermfg=5 ctermbg=NONE cterm=NONE
highlight Delimiter ctermfg=5 ctermbg=NONE cterm=NONE
highlight Float ctermfg=5 ctermbg=NONE cterm=NONE
highlight Include ctermfg=4 ctermbg=NONE cterm=NONE
highlight Keyword ctermfg=5 ctermbg=NONE cterm=NONE
highlight Label ctermfg=3 ctermbg=NONE cterm=NONE
highlight Operator ctermfg=7 ctermbg=NONE cterm=NONE
highlight Repeat ctermfg=3 ctermbg=NONE cterm=NONE
highlight SpecialChar ctermfg=5 ctermbg=NONE cterm=NONE
highlight Tag ctermfg=3 ctermbg=NONE cterm=NONE
highlight Typedef ctermfg=3 ctermbg=NONE cterm=NONE

highlight vimUserCommand ctermfg=1 ctermbg=NONE cterm=BOLD
  highlight link vimMap vimUserCommand
  highlight link vimLet vimUserCommand
  highlight link vimCommand vimUserCommand
  highlight link vimFTCmd vimUserCommand
  highlight link vimAutoCmd vimUserCommand
  highlight link vimNotFunc vimUserCommand
highlight vimNotation ctermfg=4 ctermbg=NONE cterm=NONE
highlight vimMapModKey ctermfg=4 ctermbg=NONE cterm=NONE
highlight vimBracket ctermfg=7 ctermbg=NONE cterm=NONE
highlight vimCommentString ctermfg=8 ctermbg=NONE cterm=NONE

highlight htmlLink ctermfg=1 ctermbg=NONE cterm=underline
highlight htmlBold ctermfg=3 ctermbg=NONE cterm=NONE
highlight htmlItalic ctermfg=5 ctermbg=NONE cterm=NONE
highlight htmlEndTag ctermfg=7 ctermbg=NONE cterm=NONE
highlight htmlTag ctermfg=7 ctermbg=NONE cterm=NONE
highlight htmlTagName ctermfg=1 ctermbg=NONE cterm=BOLD
highlight htmlH1 ctermfg=7 ctermbg=NONE cterm=NONE
  highlight link htmlH2 htmlH1
  highlight link htmlH3 htmlH1
  highlight link htmlH4 htmlH1
  highlight link htmlH5 htmlH1
  highlight link htmlH6 htmlH1

highlight cssMultiColumnAttr ctermfg=2 ctermbg=NONE cterm=NONE
  highlight link cssFontAttr cssMultiColumnAttr
  highlight link cssFlexibleBoxAttr cssMultiColumnAttr
highlight cssBraces ctermfg=7 ctermbg=NONE cterm=NONE
  highlight link cssAttrComma cssBraces
highlight cssValueLength ctermfg=7 ctermbg=NONE cterm=NONE
highlight cssUnitDecorators ctermfg=7 ctermbg=NONE cterm=NONE
highlight cssValueNumber ctermfg=7 ctermbg=NONE cterm=NONE
  highlight link cssValueLength cssValueNumber
highlight cssNoise ctermfg=8 ctermbg=NONE cterm=NONE
highlight cssTagName ctermfg=1 ctermbg=NONE cterm=NONE
highlight cssFunctionName ctermfg=4 ctermbg=NONE cterm=NONE

highlight scssSelectorChar ctermfg=7 ctermbg=NONE cterm=NONE
highlight scssAttribute ctermfg=7 ctermbg=NONE cterm=NONE
highlight link scssDefinition cssNoise
highlight sassidChar ctermfg=1 ctermbg=NONE cterm=NONE
highlight sassClassChar ctermfg=5 ctermbg=NONE cterm=NONE
highlight sassInclude ctermfg=5 ctermbg=NONE cterm=NONE
highlight sassMixing ctermfg=5 ctermbg=NONE cterm=NONE
highlight sassMixinName ctermfg=4 ctermbg=NONE cterm=NONE

highlight javaScript ctermfg=7 ctermbg=NONE cterm=NONE
highlight javaScriptBraces ctermfg=7 ctermbg=NONE cterm=NONE
highlight javaScriptNumber ctermfg=5 ctermbg=NONE cterm=NONE

highlight markdownH1 ctermfg=7 ctermbg=NONE cterm=NONE
  highlight link markdownH2 markdownH1
  highlight link markdownH3 markdownH1
  highlight link markdownH4 markdownH1
  highlight link markdownH5 markdownH1
  highlight link markdownH6 markdownH1
highlight markdownAutomaticLink ctermfg=1 ctermbg=NONE cterm=underline
  highlight link markdownUrl markdownAutomaticLink
highlight markdownError ctermfg=7 ctermbg=NONE cterm=NONE
highlight markdownCode ctermfg=3 ctermbg=NONE cterm=NONE
highlight markdownCodeBlock ctermfg=3 ctermbg=NONE cterm=NONE
highlight markdownCodeDelimiter ctermfg=5 ctermbg=NONE cterm=NONE

highlight xdefaultsValue ctermfg=7 ctermbg=NONE cterm=NONE

highlight rubyInclude ctermfg=4 ctermbg=NONE cterm=NONE
highlight rubyDefine ctermfg=5 ctermbg=NONE cterm=NONE
highlight rubyFunction ctermfg=4 ctermbg=NONE cterm=NONE
highlight rubyStringDelimiter ctermfg=2 ctermbg=NONE cterm=NONE
highlight rubyInteger ctermfg=3 ctermbg=NONE cterm=NONE
highlight rubyAttribute ctermfg=4 ctermbg=NONE cterm=NONE
highlight rubyConstant ctermfg=3 ctermbg=NONE cterm=NONE
highlight rubyInterpolation ctermfg=2 ctermbg=NONE cterm=NONE
highlight rubyInterpolationDelimiter ctermfg=3 ctermbg=NONE cterm=NONE
highlight rubyRegexp ctermfg=6 ctermbg=NONE cterm=NONE
highlight rubySymbol ctermfg=2 ctermbg=NONE cterm=NONE
highlight rubyTodo ctermfg=8 ctermbg=NONE cterm=NONE
highlight rubyRegexpAnchor ctermfg=7 ctermbg=NONE cterm=NONE
  highlight link rubyRegexpQuantifier rubyRegexpAnchor

highlight pythonOperator ctermfg=5 ctermbg=NONE cterm=NONE
highlight pythonFunction ctermfg=4 ctermbg=NONE cterm=NONE
highlight pythonRepeat ctermfg=5 ctermbg=NONE cterm=NONE
highlight pythonStatement ctermfg=1 ctermbg=NONE cterm=Bold
highlight pythonBuiltIn ctermfg=4 ctermbg=NONE cterm=NONE

highlight phpMemberSelector ctermfg=7 ctermbg=NONE cterm=NONE
highlight phpComparison ctermfg=7 ctermbg=NONE cterm=NONE
highlight phpParent ctermfg=7 ctermbg=NONE cterm=NONE

highlight cOperator ctermfg=6 ctermbg=NONE cterm=NONE
highlight cPreCondit ctermfg=5 ctermbg=NONE cterm=NONE

highlight XmlEndTag ctermfg=2 cterm=NONE


" ALE {{{

highlight ALEError cterm=underline
highlight link ALEErrorSign Error
highlight ALEWarning cterm=underline
highlight link ALEWarningSign Search

" }}}


" GitGutter {{{

execute 'highlight GitGutterAdd ctermbg=NONE cterm=NONE ctermfg=' . g:GitAddColor
execute 'highlight GitGutterChange ctermbg=NONE cterm=NONE ctermfg=' . g:GitChangeColor
execute 'highlight GitGutterDelete ctermbg=NONE cterm=NONE ctermfg=' . g:GitUntrackedColor
execute 'highlight GitGutterChangeDelete ctermbg=NONE cterm=NONE ctermfg=' . g:GitUntrackedColor

" }}}


" NERDTree {{{

highlight NERDTreeDirSlash ctermfg=4 ctermbg=NONE cterm=NONE
highlight link NERDTreeBookmarksLeader NERDTreeDirSlash
highlight NERDTreeExecFile ctermfg=7 ctermbg=NONE cterm=NONE

highlight NERDTreeGitStatusStaged ctermfg=4 cterm=NONE

highlight link NERDTreeGitStatusModified GitGutterChange
highlight link NERDTreeGitStatusUntracked GitGutterChangeDelete
highlight link NERDTreeGitStatusRenamed GitGutterChangeDelete
highlight link NERDTreeGitStatusUnmerged GitGutterChangeDelete
highlight link NERDTreeGitStatusIgnored GitGutterChangeDelete

" }}}


" fzf {{{

highlight default fzf1 ctermfg=0 ctermbg=6 guifg=NONE guibg=NONE
highlight default fzf2 ctermfg=0 ctermbg=8 guifg=NONE guibg=NONE
highlight default fzf3 ctermfg=0 ctermbg=8 guifg=NONE guibg=NONE

" }}}
