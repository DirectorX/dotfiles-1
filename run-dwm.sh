ool visual stuff
xrdb -merge -I$HOME ~/.Xresources

# DWM-Status
~/.dwmstatus/init-status.fish

while true; do
    ~/.dwmstatus/status-info.fish
done &

# Cool AF wallpaper
while true; do
    ~/.change-wallpaper.fish
done &

# Transparencies, shadows and transitions
compton --config compton.conf &

# Set brightness to 80%
xrandr --output LVDS1 --brightness 0.7

# Spanish keyboard
setxkbmap -layout latam -variant deadtilde

# Automount USBs and shit
#sudo udiskie --automount --notify &

# Relaunch DWM if the binary changes, otherwise bail
csum=$(sha1sum $(which dwm))
new_csum=""
while true
do
    if [ "$csum" != "$new_csum" ]
    then
        csum=$new_csum
        dwm
    else
        exit 0
    fi
    new_csum=$(sha1sum $(which dwm))
    sleep 0.5
done

