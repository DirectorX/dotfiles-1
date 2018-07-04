#!/bin/fish

#--- Variables ---#

# CPU Usage
set CPU_USAGE (top -b -n1 | grep "Cpu(s)" | awk '{printf "%2d%%", $2 + $4}')
set CPU_USAGE $PROCESSOR_ICON $CPU_USAGE 

# Memory Usage
set MEMORY_USAGE (free -m | awk 'NR==2{printf "%.2f GB", $3/1024}')
set MEMORY_USAGE $MEMORY_ICON $MEMORY_USAGE 

# Battery
set BATC (cat /sys/class/power_supply/BAT0/capacity)
set BATS (cat /sys/class/power_supply/BAT0/status)

switch $BATS
# Put the correct icon depending on how much batter there is left
# plus append the '%' because if added later, it's appended to
# all the variables that form a variable. Weird.
# NOTE: should have probably pasted the icons directly instead of the univode  oops
    case "Discharging"
        if test $BATC -le 100; and test $BATC -gt 90
            set BATC \uf578 $BATC"%" 
        else if test $BATC -le 90; and test $BATC -gt 80
            set BATC \uf581 $BATC"%" 
        else if test $BATC -le 80; and test $BATC -gt 70
            set BATC \uf580 $BATC"%" 
        else if test $BATC -le 70; and test $BATC -gt 60
            set BATC \uf57f $BATC"%" 
        else if test $BATC -le 60; and test $BATC -gt 50
            set BATC \uf57e $BATC"%" 
        else if test $BATC -le 50; and test $BATC -gt 40
            set BATC \uf57d $BATC"%" 
        else if test $BATC -le 40; and test $BATC -gt 30
            set BATC \uf57c $BATC"%" 
        else if test $BATC -le 30; and test $BATC -gt 20
            set BATC \uf57b $BATC"%" 
        else if test $BATC -le 20; and test $BATC -gt 10
            set BATC \uf57a $BATC"%" 
        else if test $BATC -le 10; and test $BATC -gt 0
            set BATC \x03\uf582 $BATC"%" \x02 # See STATUS
        end

    case "Charging"    
        if test $BATC -le 100; and test $BATC -gt 90
            set BATC \uf584 $BATC"%" 
        else if test $BATC -le 90; and test $BATC -gt 80
            set BATC \uf58a $BATC"%" 
        else if test $BATC -le 80; and test $BATC -gt 60
            set BATC \uf589 $BATC"%" 
        else if test $BATC -le 60; and test $BATC -gt 40
            set BATC \uf588 $BATC"%" 
        else if test $BATC -le 40; and test $BATC -gt 30
            set BATC \uf587 $BATC"%" 
        else if test $BATC -le 30; and test $BATC -gt 20
            set BATC \uf586 $BATC"%" 
        else if test $BATC -le 20
            set BATC \uf585 $BATC"%" 
        end

    case "Unknown"
        set BATC \uf590 $BATC"%" 
end

# Internet
set ACTIVE_INTERFACE (ip addr show | grep "state UP" | awk '{printf "%s", substr($2,1,length($2)-1)}')

if [ $ACTIVE_INTERFACE = "wlp3s0" ]
    # Wireless
    set WIFI (iwgetid -r) # User needs to be in network group to use without sudo

    # Change icon if connection isn't working
    ping -c 1 8.8.8.8 > /dev/null 2>&1; 
    and set WIFI $WIFI_ICON $WIFI ; 
    or set WIFI $WIFI_OFF_ICON $WIFI 

    set CONNECTION $WIFI

else if [ $ACTIVE_INTERFACE = "enp0s25"  ]
    # Ethernet
    # Change icon if connection isn't working
    ping -c 1 8.8.8.8 > /dev/null 2>&1;
	and set ETHERNET $ETHERNET_ICON ;
	or set ETHERNET $ETHERNET_OFF_ICON 

    set CONNECTION $ETHERNET
end

# Date and time
set DATE (date +"%a %d %b")
set DATE $CALENDAR_ICON $DATE 

# Time
set TIME (date +"%R")
set TIME $TIME_ICON $TIME" " # Adds a gap at the end of the bar

# Volume
set VOLUME (amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)
set VOLUME $VOLUME_ICON $VOLUME"%" 

# CPU Temp
set THERMAL (cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%s°C", $1/1000}')
set THERMAL $THERMAL_ICON $THERMAL 

# Status to be displayed

# \x02 means the icons, and the following ones, will use the colors in
# [SchemeSel] con dwm's config.h, making them lighter. This is done in case
# one parameter reaches dangerous values so we can change it with \x03
# without affecting the rest - yeah it's programmed in a weird way, don't ask.

set STATUS \x02$VOLUME "" $CONNECTION "" $CPU_USAGE "" $MEMORY_USAGE "" $THERMAL "" $BATC "" $DATE "" $TIME

# Piping it to the root X window, which dwm uses as status bar
xsetroot -name "$STATUS"

# Just an arbitrary timer
sleep 5
