#!/bin/bash

function print_block {
    PAC=$(pacmd list-sinks | grep -P "\*" --after-context 36)
    VOLUME=$(echo "$PAC" | grep -P [0-9]+% -o | head -n 1 | tr -d '%')
    SINK=$(pacmd list-sinks | grep -P "\*" --after-context 1000| grep 'device.description' | head -n1 | cut -d '"' -f 2 | sed 's/ Audio Analog Stereo//g')
    echo -n "$SINK: $VOLUME %"
}

print_block

while read -r EVENT; do
    print_block
done < <(pactl subscribe | stdbuf -oL grep "'change' on sink")
