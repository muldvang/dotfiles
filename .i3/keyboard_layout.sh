#!/bin/bash

ALT_GR=$(xmodmap -pke | grep 108 | rev | cut -d " " -f 1 | rev)

if test "$ALT_GR" = "Control_R"
then
    echo Enhanced
elif test "$ALT_GR" = "ISO_Level3_Shift"
then
    echo Standard
else
    echo Error
    echo Error
    echo "#f92672"
fi
