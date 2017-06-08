let NEOVIM_CONFIG = '$HOME/dotfiles/conf/osx/neovim/'

let configs = [
  \ 'plugins',
  \ 'settings',
  \ 'settings.plugins',
  \ 'mappings',
  \ 'mappings.plugins',
  \ 'ui',
  \ 'ui.statusline',
  \ 'ui.plugins',
  \ 'commands'
\]

" load all configs
for config in configs
  let configPath = NEOVIM_CONFIG . config . '.vim'
  execute 'source ' . fnameescape(configPath)
endfor
