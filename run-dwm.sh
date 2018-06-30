#!/bin/sh
## run-dwm
xrdb -merge -I$HOME ~/.Xresources

# my stuff
while true; do
    BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
    STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
    DATE=$(date +"%a %d %b, %R")

    xsetroot -name "`echo $BATT\% $STATUS \| $DATE `" # status bar
    sleep 30
done &

xset fp+ /usr/share/fonts/ &			 # font stuff
xset fp rehash &
compton --config compton.conf &
hsetroot -fill ~/Pictures/Wallpaper/5000237-metroid-prime-wallpapers.jpg 			 # cool af wallpaper
xrandr --output LVDS-1 --brightness 0.8
setxkbmap -layout latam -variant deadtilde
exec dwm
