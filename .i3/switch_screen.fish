#!/usr/bin/fish

set screen (xrandr | grep -C 1 "*" | head -n 1 | cut -f 1 -d " ")
echo $screen
if test $screen = "LVDS1"
        echo "Switching to HDMI1"
        xrandr --output LVDS1 --off --output HDMI1 --mode 1920x1200
else
        echo "Switching to LVDS1"
        xrandr --output LVDS1 --mode 1440x900 --output HDMI1 --off
end
