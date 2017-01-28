#!/usr/bin/bash


# status=$(dropbox-cli status)
status=$(echo -e 'get_dropbox_status\ndone' | socat - /home/muldvang/.dropbox/command_socket | grep status | cut -f 2)

if test "$status" = "Up to date"
then
    exit
elif test "$status" = Unwatched
then
    echo $status
    echo $status
    echo "#f92672"
else
    echo $status
fi
