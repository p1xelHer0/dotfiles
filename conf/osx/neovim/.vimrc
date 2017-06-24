"""

" -- here be dragons


" path where configs are stored
let s:NEOVIM_CONFIG = '$HOME/dotfiles/conf/osx/neovim/'

" configs split up according to functionality
let s:configs = [
\ 'plugins',
\ 'settings',
\ 'settings.plugins',
\ 'mappings',
\ 'mappings.plugins',
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
