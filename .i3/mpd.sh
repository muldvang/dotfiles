#!/bin/bash

status=$(mpc | grep -o -P '\[[a-z]*\]' | grep -o -P '[a-z]*')
if test "$status" = playing
then
    mpc current
elif test "$status" = stopped
then
    exit
else
    status=$(echo ${status:0:1} | tr  '[a-z]' '[A-Z]')${status:1}
    echo $status
fi
