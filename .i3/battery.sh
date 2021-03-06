#!/usr/bin/env bash

function print_block {
    ACPI=$(acpi -b 2>&1 | tail -n 1)

    full=$(echo $ACPI | grep -P "Full|99%|zero")

    if test "$full" != ""
    then
        return
    fi

    pct=$(cat /sys/class/power_supply/BAT0/capacity)
    state=$(cat /sys/class/power_supply/BAT0/status)

    if test $pct -lt 10
    then
        if test "$state" == "Discharging"
        then
            hours=$(echo $ACPI | cut -d " " -f 5 | cut -d ":" -f 1)
            minutes=$(echo $ACPI | cut -d " " -f 5 | cut -d ":" -f 2)
            echo  $hours:$minutes
            echo 
            echo "#A52A2A"
        else
            echo 
            echo 
        fi
    elif test $pct -lt 30
    then
        echo 
        echo 
    elif test $pct -lt 60
    then
        echo 
        echo 
    elif test $pct -lt 90
    then
        echo 
        echo 
    else
        echo 
        echo 
    fi

    if test $state == "Charging"
    then
        echo "#4E9A06"
    fi
}

while true
do
    print_block
    while read -r EVENT
    do
        print_block
    done < <(timeout 30s udevadm monitor | stdbuf -oL grep "power_supply")
done
