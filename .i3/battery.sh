#!/bin/sh


ACPI=$(acpi -b 2>&1)
if test "$no_support" != ""
then
    exit
fi

full=$(echo $ACPI | grep -P "Unknown|Full|99%|zero")

if test "$full" != ""
then
   exit
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
