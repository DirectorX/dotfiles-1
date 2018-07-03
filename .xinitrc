#!/bin/sh
## run-dwm

# Cool visual stuff
xrdb -merge -I$HOME ~/.Xresources

# DWM-Status
while true; do
    ~/.status-info.fish
done &

# Change background
while true; do
    ~/.change-wallpaper.fish
done &

# Transparencies, shadows and transitions
compton --config compton.conf &

# Cool AF wallpaper
hsetroot -fill ~/Pictures/Wallpaper/samus.jpg

# Set brightness to 80%
xrandr --output LVDS1 --brightness 0.7

# Spanish keyboard
setxkbmap -layout latam -variant deadtilde

# Automount USBs and shit
#sudo udiskie --automount --notify &

# Start dwm
exec dwm
