#!/bin/bash

actions="Lock
Suspend
Hybrid sleep
Reboot
Poweroff"
action=$(echo "$actions" | dmenu -p 'Choose action:' -nb '#ededed' -nf '#313739' -sb '#4A90D9' -sf '#313739' -i -fn 'sans-9' -h 18 -b)
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
