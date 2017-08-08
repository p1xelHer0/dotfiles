###

# --

! load .Xresources
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

! start urxvt daemon
urxvtd -q -o -f &

! start VirtualBox helpers
/usr/bin/VBoxClient-all &

! random wal conf then start lemonbar and dunst with wal colors
wal -i "$HOME/walls/rot/fav" -o wal-set

! start xbanish
xbanish &


exec i3
