#!/bin/sh
## run-dwm

# Cool visual stuff
xrdb -merge -I$HOME ~/.Xresources

# DWM-Status
while true; do
    BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
    STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
    DATE=$(date +"%a %d %b, %R")

    xsetroot -name "`echo $BATT\% $STATUS \| $DATE `" # status bar
    sleep 30
done &

# Font stuff
xset fp+ /usr/share/fonts/ &			 
xset fp rehash &

# Transparencies, shadows and transitions
compton --config compton.conf &

# Cool AF wallpaper
hsetroot -fill ~/Pictures/Wallpaper/minimalist_portal_wallpaper_by_younggeorge-d5rnf8r.png 			 

# Set brightness to 80%
xrandr --output LVDS-1 --brightness 0.8

# Spanish keyboard
setxkbmap -layout latam -variant deadtilde

# Start dwm
exec dwm
