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

# QGtkStyle requires this variable to be set
# export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK2_RC_FILES=/usr/share/gtk-2.0/gtkrc

# Block bluetooth and wireless wan on laptop
if [ `hostname` = "Balder" ]; then
    rfkill block bluetooth && rfkill block wwan
fi

xset -dpms

i3lock -i $(shuf -n 1 -e ~/Pictures/wallpapers/Van_Gogh/*)

# Set the background image
wallpaperd

# Read .Xresources
xrdb ~/.Xresources &

# Execute window manager
exec dbus-launch i3
# exec dbus-launch startxfce4
