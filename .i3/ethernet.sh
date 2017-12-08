#!/usr/bin/bash

IP=$(ip addr | grep -P "inet.* e" | grep -o -P "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n1)

if test $IP != ""
then
    echo 
    echo 
    echo "#4E9A06"
fi

# TODO: Black if cable not plugged

# TODO: Red if cable is plugged but no IP assigned
