#!/bin/sh

# my stuff
while true; do
BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
DATE=$(date +"%I:%M | %d %m %y")

xsetroot -name "`echo $DATE \| $BATT\% $STATUS`" # status bar
sleep 30
done &

xset fp+ /usr/share/fonts/ &			 # font stuff
xset fp rehash &
compton --vsync opengl -cb &			 # nice shadows and transitions
hsetroot -solid '#98c379'			 # boring background
exec dwm
