#!/bin/fish

#--- Icons ---#
set SEPARATOR \ue621
set WIFI_ICON \uf1eb
set PROCESSOR_ICON \ue266
set MEMORY_ICON \uf85a
set CALENDAR_ICON \uf073

#--- Variables ---#

# CPU Usage
set CPU_USAGE (top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
set CPU_USAGE $PROCESSOR_ICON $CPU_USAGE"%"

# Memory Usage
set MEMORY_USAGE (free -m | awk 'NR==2{printf "%.2f/%.2f GB", $3/1024,$2/1024 }')
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
        if test $BATC -gt 90
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
            set BATC \uf582 $BATC"%"
        end

    case "Charging"    
        if test $BATC -gt 90
            set BATC \uf584 $BATC"%"
        else if test $BATC -le 90; and test $BATC -gt 80
            set BATC \uf58a $BATC"%"
        else if test $BATC -le 80; and test $BATC -gt 60
            set BATC \uf589 $BATC"%"
        else if test $BATC -le 60; and test $BATC -gt 50
            set BATC \uf588 $BATC"%"
        else if test $BATC -le 40; and test $BATC -gt 30
            set BATC \uf587 $BATC"%"
        else if test $BATC -le 30; and test $BATC -gt 20
            set BATC \uf586 $BATC"%"
        else if test $BATC -le 20
            set BATC \uf585 $BATC"%"
        end
end

# Wireless
set WIFI (iwgetid -r)
set WIFI \uf1eb $WIFI 

# Date and time
set DATE (date +"%a %d %b, %R")
set DATE $CALENDAR_ICON $DATE

# Status to be displayed
set STATUS $WIFI $SEPARATOR $CPU_USAGE $SEPARATOR $MEMORY_USAGE $SEPARATOR $BATC $SEPARATOR $DATE 

# Piping it to the root X window, which dwm uses as status bar
xsetroot -name "$STATUS"

# Just an arbitrary timer
sleep 3
