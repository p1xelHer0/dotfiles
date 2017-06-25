! load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

! set wal colors
! wal -i "$(< "${HOME}/.cache/wal/wal")" &

! start urxvt daemon
urxvtd -q -o -f &

! start VirtualBox helpers
/usr/bin/VBoxClient-all &

! set wallpaper
$HOME/.fehbg &

exec i3
