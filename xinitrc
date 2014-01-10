#!/bin/sh
# set up me colors/fonts

if [ -f ~/.Xresources ]; then
  xrdb ~/.Xresources &
fi

if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

xsetroot -cursor_name left_ptr
xsetroot -gray

# shut up the bell
xset -b

# restore the background
/bin/sh ~/.fehbg

# start displaying new bgs
rotate-background &

# fix screens
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1

# start the wm
exec xmonad
