#!/usr/bin/sh

ACPI=$(acpi -b)

no_support=$(echo $ACPI | grep "No support")
if test "no_support" != ""
then
    exit
fi

full=$(echo $ACPI | grep -P "Unknown|Full|99%")

if test "$full" != ""
then
   echo "Full"
else
    state=$(echo $ACPI | cut -d " " -f 3 | cut -d "," -f 1)
    hours=$(echo $ACPI | cut -d " " -f 5 | cut -d ":" -f 1)
    minutes=$(echo $ACPI | cut -d " " -f 5 | cut -d ":" -f 2)

    echo $hours:$minutes $state
    echo $hours:$minutes
    if test $state == "Discharging" -a $hours -eq 0 -a $minutes -lt 10
    then
        echo "#f92672"
    fi
fi
