#!/usr/bin/bash

INTERFACE=$(ip addr | grep "^2: " | cut -d " " -f 2 | cut -d ":" -f 1)
IP=$(ip addr | grep -P ".*inet.*$INTERFACE" | grep -o -P "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1)

if test $IP != ""
then
    echo "$IP"
fi
