#!/bin/sh
## run-dwm

# Cool visual stuff
xrdb -merge -I$HOME ~/.Xresources

# DWM-Status
while true; do
    ~/.status-info.fish
done &

# Transparencies, shadows and transitions
compton --config compton.conf &

# Cool AF wallpaper
hsetroot -fill ~/Pictures/Wallpaper/samus.jpg

# Set brightness to 80%
xrandr --output LVDS1 --brightness 0.8

# Spanish keyboard
setxkbmap -layout latam -variant deadtilde

# Start dwm
exec dwm
