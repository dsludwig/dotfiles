#!/bin/sh
# set up me colors/fonts

xrdb ~/.Xresources &
xsetroot -cursor_name left_ptr
xsetroot -gray

# restore the background
/bin/sh ~/.fehbg

# fix screens
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1

# start the wm
exec xmonad
