"""

" -- here be dragons

set encoding=utf-8
scriptencoding utf-8


" path where configs are stored
let s:NEOVIM_CONFIG = '$HOME/dotfiles/conf/neovim/'

" check if the system is macOS
function! g:IsMacOS()
  if has('unix')
    let s:uname = system('uname')
    if s:uname ==? "Darwin\n"
      return 1
    else
      return 0
    endif
  endif
endfunction


" configs split up according to functionality
let s:configs = [
\ 'plugins',
\ 'settings',
\ 'settings.plugins',
\ 'mappings',
\ 'mappings.plugins',
\ 'ui.colors',
\ 'ui',
\ 'ui.statusline',
\ 'ui.plugins',
\ 'commands',
\ ]

" load all configs
for s:config in s:configs
  let s:configPath = s:NEOVIM_CONFIG . s:config . '.vim'
  execute 'source ' . fnameescape(s:configPath)
endfor
