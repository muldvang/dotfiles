#!/bin/bash

status=$(mpc --host $1 | grep -o -P '\[[a-z]*\]' | grep -o -P '[a-z]*')
if test "$status" = stopped
then
    exit
else
    current=$(mpc --host $1 current)
    if test "$status" = playing
    then
        echo -n ' '
    elif test "$status" = paused
    then
        echo -n ' '
    fi
    echo $current
fi
