# Calibrate monitor colors on laptop
if [ `hostname` = "Balder" ]; then
    $HOME/.monicarc
fi

# Keyboard settings
setxkbmap dk
xset r rate 250
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

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

# Block bluetooth and wireless wan on laptop
if [ `hostname` = "Balder" ]; then
    rfkill block bluetooth && rfkill block wwan
fi

# Execute window manager
exec dbus-launch awesome
