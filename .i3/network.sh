#!/usr/bin/bash

IP_ADDR=$(ip addr show $1 | grep inet | head -n1 | cut -d " " -f 6 | cut -d "/" -f 1)
WLAN=$(iwconfig | grep wls1)

if [ -z "$WLAN" ]
then
    echo "$IP_ADDR"
else
        echo "$IP_ADDR at $WLAN"
fi
