#!/bin/fish

for pic in (ls ~/Pictures/Wallpaper/)
   feh --bg-scale ~/Pictures/Wallpaper/$pic
   sleep 60
end

