#!/bin/bash

# if ps aux | grep [.]clc > /dev/null
# then
#     ps aux | grep -v '/home/tandersen/.local/' | grep [.]clc | tr -s ' ' | cut -d ' ' -f 14- | rev | cut -d '.' -f 2 | rev | tr '\n' ' '
# fi

HEALTH_JSON=$(curl --connect-timeout 1 http://localhost:9089/health)
if echo $HEALTH_JSON | grep "YELLOW" > /dev/null
then
    echo 
    echo 
    echo "#A52A2A"
elif echo $HEALTH_JSON | grep "GREEN" > /dev/null
then
    echo 
    echo 
    echo "#4E9A06"
fi
