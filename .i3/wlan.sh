#!/usr/bin/bash

echo 
echo 
if ip addr | grep -P ".*inet.* w" &> /dev/null
then
    echo "#4E9A06"
else
    echo "#A52A2A"
fi
