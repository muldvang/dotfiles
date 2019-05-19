#!/usr/bin/bash

function print_block {
    # status=$(dropbox-cli status)
    status=$(echo -e 'get_dropbox_status\ndone' | socat - ~/.dropbox/command_socket | grep status | cut -f 2)

    if test "$status" = "Up to date"
    then
        echo ' '
    elif echo "$status" | grep -E "Please update within the next [0-9][0-9]? days" > /dev/null
    then
        echo  "$status" | grep -E -o "Please update within the next [0-9][0-9]? days"
        echo  "Update"
    else
        echo  "$status"
    fi
}

while read -r EVENT; do
    print_block
done < <(socat - ~/.dropbox/iface_socket)
