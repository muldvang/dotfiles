#!/bin/fish

xset r rate 250
set ALT_GR (xmodmap -pke | grep 108 | rev | cut -d " " -f 1 | rev)
if test "$ALT_GR" = "Control_R"
        echo "Switching to standard layout."
        setxkbmap -layout dk -option
        killall -q xcape
else
        echo "Making Caps Lock AltGr and swapping Ctrl and Alt."
        setxkbmap -layout dk -option -option lv3:caps_switch -option ctrl:swap_lalt_lctl -option ctrl:rctrl_ralt -option ctrl:ralt_rctrl -option compose:menu
        killall -q xcape
        xcape -e 'Shift_L=Multi_key;Shift_R=Multi_key'
end
