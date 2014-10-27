# Calibrate monitor colors on laptop
if [ `hostname` = "Balder" ]; then
    $HOME/.monicarc
fi

if [ `hostname` = "Tor" ]; then
    xrandr --output DVI-I-1 --mode 1280x1024 --pos 0x0 --output DVI-I-2 --mode 1920x1080 --pos 1280x1024
fi

# Keyboard settings
setxkbmap dk
xset r rate 250

# Make all fonts available
xset +fp /usr/share/fonts/local
xset fp rehash

# QGtkStyle requires this variable to be set
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Block bluetooth and wireless wan on laptop
if [ `hostname` = "Balder" ]; then
    rfkill block bluetooth && rfkill block wwan
fi

# Set the keyboard layout as defined in ~/.xmodmap
xmodmap .xmodmap

# Set the background image
feh --bg-fill Pictures/wallpapers/IMG_2339.JPG

xset -dpms

# Execute window manager
exec dbus-launch i3
