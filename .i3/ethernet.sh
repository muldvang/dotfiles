#!/usr/bin/bash

IP=$(ip addr | grep -P "inet.* e" | grep -o -P "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1)

if test $IP != ""
then
    echo "$IP"
fi
