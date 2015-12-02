# Calibrate monitor colors on laptop
if [ `hostname` = "Balder" ]; then
    $HOME/.monicarc
fi

if [ `hostname` = "Tor" ]; then
    xrandr --output DVI-I-1 --mode 1280x1024 --pos 0x0 --output DVI-I-2 --mode 1920x1080 --pos 1280x0
fi

if [ `hostname` = "Freja" ]; then
    xrandr --output LVDS --off --output DVI-0 --mode 1920x1080
fi

# Keyboard settings
~/.i3/switch_keyboard_layout.fish
xset r rate 250

# GTK2 theme
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Block bluetooth and wireless wan on laptop
if [ `hostname` = "Balder" ]; then
    rfkill block bluetooth && rfkill block wwan
fi

# Disable dpms
xset -dpms

# Read .Xresources
xrdb ~/.Xresources &

# Disable screensaver
xset s off

# Execute window manager
exec dbus-launch i3
