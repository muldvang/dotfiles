#!/usr/bin/bash

count=$(echo $(transmission-remote -l || exit | wc -l) - 2 | bc)
if test $count -gt 0
then
    stats=$(transmission-remote -l | tail -n 1 | column -t)
    down=$(echo $stats | cut -d " " -f 5)
    up=$(echo $stats | cut -d " " -f 4)
    if $(transmission-remote -si | grep 'Enabled turtle' > /dev/null)
    then
        echo "$count ‒ $down / $up (turtle)"
    else
        echo "$count ‒ $down / $up"
    fi
fi
