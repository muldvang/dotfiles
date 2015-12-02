#!/bin/bash

actions="Lock
Suspend
Hybrid sleep
Reboot
Poweroff"
action=$(echo "$actions" | dmenu -p 'Choose action:' -nb '#171b1c' -nf '#FFFFFF' -sb '#5D8C00' -sf '#FFFFFF' -i -fn 'sans-9' -h 18 -b)
case $action in
    "Lock")
        systemctl --user start i3lock.service;;
    "Suspend")
        systemctl suspend;;
    "Hybrid sleep")
        systemctl hybrid-sleep;;
    "Reboot")
        systemctl reboot;;
    "Poweroff")
        systemctl poweroff;;
esac
