###

# --

! load .Xresources
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

! load .Xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

! start urxvt daemon
urxvtd -q -o -f &

compton --config /dev/null &

! start VirtualBox helpers
/usr/bin/VBoxClient-all &

! random wal conf then start lemonbar and dunst with wal colors
wal -i "$HOME/walls/fav" -o wal-set

! start xcape
xcape &

! start xbanish
xbanish &


exec i3
