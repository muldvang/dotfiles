#!/bin/bash

status=$(mpc --host $1 | grep -o -P '\[[a-z]*\]' | grep -o -P '[a-z]*')
if test "$status" = playing
then
    mpc --host $1 current
    echo "Playing"
elif test "$status" = stopped
then
    exit
else
    status=$(echo ${status:0:1} | tr  '[a-z]' '[A-Z]')${status:1}
    echo $status
    echo $status
fi
