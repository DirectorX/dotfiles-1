#!/bin/fish

#--- Icons ---#
set SEPARATOR \ue621
set WIFI_ICON \ufaa8
set WIFI_OFF_ICON \ufaa9
set ETHERNET_ICON \uf700
set ETHERNET_OFF_ICON \uf701
set PROCESSOR_ICON \ue266
set MEMORY_ICON \uf85a
set CALENDAR_ICON \uf073
set TIME_ICON \uf43a
set VOLUME_ICON \ufa7d
set THERMAL_ICON \uf2c7

#--- Variables ---#

# CPU Usage
set CPU_USAGE (top -b -n1 | grep "Cpu(s)" | awk '{printf "%2d%%", $2 + $4}')
set CPU_USAGE $PROCESSOR_ICON $CPU_USAGE $SEPARATOR

# Memory Usage
set MEMORY_USAGE (free -m | awk 'NR==2{printf "%.2f GB", $3/1024}')
set MEMORY_USAGE $MEMORY_ICON $MEMORY_USAGE $SEPARATOR

# Battery
set BATC (cat /sys/class/power_supply/BAT0/capacity)
set BATS (cat /sys/class/power_supply/BAT0/status)

switch $BATS
# Put the correct icon depending on how much batter there is left
# plus append the '%' because if added later, it's appended to
# all the variables that form a variable. Weird.
# NOTE: should have probably pasted the icons directly instead of the univode  oops
    case "Discharging"
        if test $BATC -gt 90
            set BATC \uf578 $BATC"%" $SEPARATOR
        else if test $BATC -le 90; and test $BATC -gt 80
            set BATC \uf581 $BATC"%" $SEPARATOR
        else if test $BATC -le 80; and test $BATC -gt 70
            set BATC \uf580 $BATC"%" $SEPARATOR
        else if test $BATC -le 70; and test $BATC -gt 60
            set BATC \uf57f $BATC"%" $SEPARATOR
        else if test $BATC -le 60; and test $BATC -gt 50
            set BATC \uf57e $BATC"%" $SEPARATOR
        else if test $BATC -le 50; and test $BATC -gt 40
            set BATC \uf57d $BATC"%" $SEPARATOR
        else if test $BATC -le 40; and test $BATC -gt 30
            set BATC \uf57c $BATC"%" $SEPARATOR
        else if test $BATC -le 30; and test $BATC -gt 20
            set BATC \uf57b $BATC"%" $SEPARATOR
        else if test $BATC -le 20; and test $BATC -gt 10
            set BATC \uf57a $BATC"%" $SEPARATOR
        else if test $BATC -le 10; and test $BATC -gt 0
            set BATC \uf582 $BATC"%" $SEPARATOR
            notify-send " Fucking hell, low battery! Connect this now!"
        end

    case "Charging"    
        if test $BATC -gt 90
            set BATC \uf584 $BATC"%" $SEPARATOR
        else if test $BATC -le 90; and test $BATC -gt 80
            set BATC \uf58a $BATC"%" $SEPARATOR
        else if test $BATC -le 80; and test $BATC -gt 60
            set BATC \uf589 $BATC"%" $SEPARATOR
        else if test $BATC -le 60; and test $BATC -gt 50
            set BATC \uf588 $BATC"%" $SEPARATOR
        else if test $BATC -le 40; and test $BATC -gt 30
            set BATC \uf587 $BATC"%" $SEPARATOR
        else if test $BATC -le 30; and test $BATC -gt 20
            set BATC \uf586 $BATC"%" $SEPARATOR
        else if test $BATC -le 20
            set BATC \uf585 $BATC"%" $SEPARATOR
        end

    case "Unknown"
        set BATC \uf590 $SEPARATOR
end

# Internet
set CONNECTION ""
set ACTIVE_INTERFACE (ip addr show | grep "state UP" | awk '{printf "%s", substr($2,1,length($2)-1)}')

if [ $ACTIVE_INTERFACE = "wlp3s0" ]
    # Wireless
    set WIFI (iwgetid -r) # User needs to be in network group to use without sudo

    # Change icon if connection isn't working
    ping -c 1 8.8.8.8 > /dev/null 2>&1; 
    and set WIFI $WIFI_ICON $WIFI $SEPARATOR; 
    or set WIFI $WIFI_OFF_ICON $WIFI $SEPARATOR

    set CONNECTION $WIFI

else if [ $ACTIVE_INTERFACE = "enp0s25"  ]
    # Ethernet
    set ETHERNET ""

    # Change icon if connection isn't working
    ping -c 1 8.8.8.8 > /dev/null 2>&1;
	and set ETHERNET $ETHERNET_ICON $SEPARATOR;
	or set ETHERNET $ETHERNET_OFF_ICON $SEPARATOR

    set CONNECTION $ETHERNET
end

# Date and time
set DATE (date +"%a %d %b")
set DATE $CALENDAR_ICON $DATE $SEPARATOR

# Time
set TIME (date +"%R")
set TIME $TIME_ICON $TIME

# Volume
set VOLUME (amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)
set VOLUME $VOLUME_ICON $VOLUME"%" $SEPARATOR

# CPU Temp
set THERMAL (cat /sys/class/thermal/thermal_zone0/temp | awk '{printf "%s°C", $1/1000}')
set THERMAL $THERMAL_ICON $THERMAL $SEPARATOR

# Status to be displayed
set STATUS $VOLUME $CONNECTION $CPU_USAGE $MEMORY_USAGE $THERMAL $BATC $DATE $TIME

# Piping it to the root X window, which dwm uses as status bar
xsetroot -name "$STATUS"

# Just an arbitrary timer
sleep 1
