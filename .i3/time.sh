#!/bin/bash

while true
do
    date '+%a, %b %d, %H:%M'
    date '+%a, %b %d, %H:%M'
    sleep $((60 - $(date +%s) % 60))
done
