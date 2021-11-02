#!/bin/sh

xset r rate 250
setxkbmap -layout dk -option -option lv3:caps_switch -option ctrl:swap_lalt_lctl -option ctrl:rctrl_ralt -option ctrl:ralt_rctrl
killall -q xcape
xcape -e 'Shift_L=Multi_key;Shift_R=Multi_key;Control_L=Escape;Control_R=Escape;Super_L=Tab;Super_R=Tab'
