"
"              ██
"             ░░
"     ██    ██ ██ ██████████  ██████  █████
"    ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"    ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"     ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"  ██  ░░██   ░██ ███ ░██ ░██░███   ░░█████
" ░░    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░

" -- here be dragons


" path where configs are stored
let NEOVIM_CONFIG = '$HOME/dotfiles/conf/osx/neovim/'

" configs split up according to functionality
let configs = [
  \ 'plugins',          " plugins I use for my daily web development life
  \ 'settings',         " default settings, everything that affects how default Neovim works
  \ 'settings.plugins', " plugin settings, everything that affects how plugins work
  \ 'mappings',         " keymapping that uses functionality of default Neovim
  \ 'mappings.plugins', " keymapping that uses functionality of plugins
  \ 'ui',               " themes, colors and everything that affects the look of Neovim
  \ 'ui.statusline',    " themes, colors and everything that affects the look of the statusline
  \ 'ui.plugins',       " themes, colors and everything that affects the look of plugins
  \ 'commands'          " custom commands to enhance or speed up the way Neovim works
\]

" load all configs
for config in configs
  let configPath = NEOVIM_CONFIG . config . '.vim'
  execute 'source ' . fnameescape(configPath)
endfor
