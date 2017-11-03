#!/usr/bin/bash

if ip addr | grep -P ".*inet.* w" &> /dev/null
then
    exit
else
    echo 
    echo 
    echo "#cc0000"
fi
