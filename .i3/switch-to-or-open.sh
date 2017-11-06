#!/bin/bash

xdotool search --name "$1" windowactivate
if test $? != 0
then
    i3-msg "workspace $2; exec $3"
fi
