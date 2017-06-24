# get info
gtf 2560 1440 60

# add the new mode
xrandr --newmode "2560x1440_60.00 <insert above info here, remove trailing -HSync +VSync>"


# add the mode to the device
xrandr --addmode default 2560x1440_60.00

# set the new mode
xrandr --output default --mode 2560x1440_60.00
