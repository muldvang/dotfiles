#!/usr/bin/bash

NETWORK=$(iwconfig | grep ESSID | cut -d \" -f 2)
IP=$(ip addr | grep -P ".*inet.* w" | grep -o -P "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1)

if test "$IP" != ""
then
    echo "$IP at $NETWORK"
    echo "$NETWORK"
fi
