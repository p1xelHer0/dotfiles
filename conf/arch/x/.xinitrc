! load .Xresources
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

! start urxvt daemon
urxvtd -q -o -f &

! start VirtualBox helpers
/usr/bin/VBoxClient-all &

! set wallpaper
$HOME/.fehbg &

exec i3
