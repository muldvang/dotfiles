#!/usr/bin/bash

status=$(dropbox-cli status)

if test "$status" = "Up to date"
then
    exit
elif test "$status" = Unwatched
then
    echo $status
    echo "#f92672"
    echo "#f92672"
else
    echo $status
fi
