#!/usr/bin/fish

set screen (xrandr | grep -C 1 "*" | head -n 1 | cut -f 1 -d " ")
echo $screen
if test $screen = "eDP1"
        echo "Switching to DP1-1"
        xrandr --output eDP1 --off --output DP1-1  --mode 1920x1080
else
        echo "Switching to eDP1"
        xrandr --output eDP1 --mode 1600x900 --output DP1-1 --off
end
