#!/bin/bash

name=$(echo | dmenu -p 'Window name' -nb '#ededed' -nf '#313739' -sb '#4A90D9' -sf '#313739' -i -fn 'sans-9' -h 18 -b)
current_window_id=$(xdotool getactivewindow)
xdotool set_window -name "$name" $current_window_id
