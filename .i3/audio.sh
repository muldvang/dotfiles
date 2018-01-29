#!/bin/bash

# pidof pulseaudio > /dev/null
# if test $? -eq 0
# then
#     PAC=$(pacmd list-sinks | grep -P "\*" --after-context 36)
#     VOLUME=$(echo "$PAC" | grep -P [0-9]+% -o | head -n 1)
#     SINK=$(echo "$PAC" | tail -n 1 | cut -d '"' -f 2 )
#     echo $SINK": "$VOLUME
#     echo $VOLUME
# else
#     VOLUME=$(amixer get PCM | grep -E -o '[0-9][0-9]?[0-9]?%' | head -1)
#     echo $VOLUME
# fi

if $(hostname) == 'laptop-110':
then
    VOLUME=$(env ALSA_CARD=PCH amixer get PCM | grep -E -o '[0-9][0-9]?[0-9]?%' | head -1 | grep -E -o '[0-9]+')
else
    VOLUME=$(env amixer get PCM | grep -E -o '[0-9][0-9]?[0-9]?%' | head -1 | grep -E -o '[0-9]+')
fi

SVOL=$(($VOLUME / 5))

echo -n "<span font_desc='monospace' size='4000' rise='3000' strikethrough='true'>"

i=0
while test $i -lt $SVOL
do
    i=$((i + 1))
    echo -n █
done

if test $VOLUME == 100
then
    echo -n █
elif test $VOLUME == 0
then
    echo -n ' '
else
    SMALL=$(($VOLUME - $SVOL * 5))
    if test $SMALL -lt 3
    then
        echo -n ▌
    else
        echo -n █
    fi
fi

while test $i -lt 20
do
    i=$((i + 1))
    echo -n ' '
done

echo "</span>"
