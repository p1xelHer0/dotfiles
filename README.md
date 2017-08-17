```
 ### 

 # -- p1xelHer0's dotfiles


 # dotfiles to setup my dev env on macOS (and Arch Linu wip)

 # macOS on my work MacBook Pro 15"
 # Arch Linux on my home desktop running on VirtualBox on Windows 10

 # I use symlinks from ~/dotfiles to the applications I use for configuration

 # bin          > contains scripts added to my $PATH
 # conf         > contains all the configuration
 # install      > contains all scripts to symlink the configuration


 # macOS + Arch Linux {{{

 # ~/dotfiles/conf

 zsh            > shell for intaractive use and powerful scripting
 oh-my-zsh      > community-driven framework for managing your zsh configuration
 tmux           > terminal multiplexer
 neovim         > literally the future of vim
 ranger         > file manager with vi bindings
 fzf            > fuzzy finder 
 nvm            > nodejs version manager
 stack          > haskell tool stack
 pyenv          > python version manager
 rbevn          > ruby version manager
 jenv           > java version manager
 rustup         > rust tool chain
 pywal          > generate and change colorschemes on the fly


 # ~/dotfiles/bin

 colortest      > test terminal colors 0-8 fg and bg

 # }}}


 # macOS-specific {{{
 
 # ~/dotfiles/conf/osx

 iterm2-nightly > terminal emulator
 alacritty      > faster terminal emulator, testing it
 brew           > package manager of macOS
 brew cask      > extends brew for applications and larger binaries alike
 chunkwm        > tiling window manager, alpha version, wip
 skhd           > hotkey daemon
 ubersicht      > create HTML5-widgets to display system information


 # ~/dotfiles/bin/osx

 wal-set        > sets wal colors for alacritty, chunkwm and ubersicht
 wal2iterm      > exports wal colors to .itermcolors for iTerm2
 
 # }}}

 
 # Arch Linux-specific wip {{{
 
 # ~/dotfiles/conf/arch

 urvxt          > terminal emulator
 i3-gaps        > i3 with more features
 dunst          > lightweight notification-daemon
 lemonbar       > featherweight, lemon-scented, bar based on xcb
 thunar         > file manager
 feh            > fast and light image viewer
 rofi           > window switcher, run dialog and dmenu replacement
 cava           > console-based audio visualizer
 maim           > screenshots, overcome shortcomings of scrot
 xbanish        > banish the mouse cursor when typing


 # ~/dotfiles/bin/arch

 bar            > actual lemonbar implementation
 wal-set        > sets wal colors for dunst and lemonbar


 }}}

```
