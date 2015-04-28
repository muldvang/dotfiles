#!/bin/bash

actions="Lock
Suspend
Hybrid sleep
Reboot
Poweroff"
action=$(echo "$actions" | dmenu -p 'Choose action:' -nb '#171b1c' -nf '#FFFFFF' -sb '#5E801A' -sf '#FFFFFF' -i -fn 'sans-9' -h 18 -b)
case $action in
    "Lock")
        i3lock -i $(shuf -n 1 -e ~/Pictures/wallpapers/Van_Gogh/*);;
    "Suspend")
        systemctl suspend;;
    "Hybrid sleep")
        systemctl hybrid-sleep;;
    "Reboot")
        systemctl reboot;;
    "Poweroff")
        systemctl poweroff;;
esac
