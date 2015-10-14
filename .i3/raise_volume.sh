#!/bin/sh

if pgrep pulseaudio > /dev/null
then
    amixer -q -D pulse sset Master 1%+
else
    amixer -q set PCM 1%+
fi
