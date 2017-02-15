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
elif echo "$status" | grep -E "Please update within the next [0-9][0-9]? days" > /dev/null
then
    echo "$status" | grep -E -o "Please update within the next [0-9][0-9]? days"
    echo "Update"
else
    echo $status
    echo $status
fi
