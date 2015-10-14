#!/bin/sh

pidof pulseaudio > /dev/null
if test $? -eq 0
then
    PAC=$(pacmd list-sinks | grep -P "\*" --after-context 36)
    VOLUME=$(echo "$PAC" | grep -P [0-9]+% -o | head -n 1)
    SINK=$(echo "$PAC" | tail -n 1 | cut -d '"' -f 2 )
    echo $SINK": "$VOLUME
else
    VOLUME=$(amixer get PCM | grep -E -o '[0-9][0-9]?[0-9]?%' | head -1)
    echo $VOLUME
fi
