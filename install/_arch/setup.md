# aur {{{

git clone https://aur.archlinux.org/aur-package.git
cd aur-package
makepkg -si

# }}}


# systemctl {{{

systemctl enable acpid
systemctl enable avahi
systemctl enable dbus
systemctl enable openntpd

# }}}


# screen {{{

# get dpi info
xdpyinfo | grep dots

# get screen info
gtf 2560 1440 60

# add the new mode
xrandr --newmode "2560x1440_60.00 <insert above info here, remove trailing -HSync +VSync(?)>"

# add the mode to the device
xrandr --addmode default 2560x1440_60.00

# set the new mode
xrandr --output default --mode 2560x1440_60.00

# }}}


# font {{{

# path to fonts (actually, update the font cache, but verbose, so it shows all the paths)
fc-cache -v

# find X font names
xfontsel

# font font family (pango name)
fc-query -f '%{family[0]}\n' /path/to/font

# }}}
