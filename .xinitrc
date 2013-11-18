# Calibrate monitor colors on laptop
if [ `hostname` = "Balder" ]; then
    $HOME/.monicarc
fi

if [ `hostname` = "Tor" ]; then
    xrandr --output DVI-1 --mode 1920x1080 --pos 1280x1024 --output DVI-0 --mode 1280x1024
fi

# Keyboard settings
setxkbmap dk
xset r rate 250

# Make all fonts available
xset +fp /usr/share/fonts/local
xset fp rehash

# QGtkStyle requires this variable to be set
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Auto start applications
dropboxd &
emacs --daemon
mpd

# XBMC is only started on my desktop pc
if [ `hostname` = "Tor" ]; then
    xbmc &
fi

# Execute window manager
exec dbus-launch awesome
