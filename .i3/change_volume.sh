#!/bin/bash

if $(hostname) == 'laptop-110':
then
   ALSA_CARD=PCH
fi

if pgrep pulseaudio > /dev/null
then
    if test "$1" = down
    then
        amixer -q -D pulse sset Master 2%-
        amixer -q sset Master 2%-
    elif test "$1" = up
    then
        amixer -q -D pulse sset Master 2%+
        amixer -q sset Master 2%+
    fi
else
    if test "$1" = down
    then
        amixer -q set PCM 2%-
    elif test "$1" = up
    then
        amixer -q set PCM 2%+
    fi
fi
