#!/usr/bin/bash

INTERFACE=$(ip addr | grep "^5: " | cut -d " " -f 2 | cut -d ":" -f 1)
if test "$INTERFACE" != ""
then
    IP=$(ip addr | grep -P ".*inet.*$INTERFACE" | grep -o -P "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1)
    if test "$IP" != ""
    then
        echo "$IP"
    fi
fi
