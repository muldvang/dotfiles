#!/usr/bin/bash

if transmission-remote 192.168.1.33 -l &> /dev/null
then
    count=$(echo $(transmission-remote 192.168.1.33 -l | wc -l) - 2 | bc)
    if test $count -gt 0
    then
        stats=$(transmission-remote 192.168.1.33 -l | tail -n 1 | column -t)
        down=$(echo $stats | cut -d " " -f 5 | cut -d '.' -f 1)
        up=$(echo $stats | cut -d " " -f 4 | cut -d '.' -f 1)
        if $(transmission-remote 192.168.1.33 -si | grep 'Enabled turtle' > /dev/null)
        then
            echo "$count ‒ $down / $up (turtle)"
        else
            echo "$count ‒ $down / $up"
        fi
    fi
fi
