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

# XBMC is only started on my desktop pc
if [ `hostname` = "Tor" ]; then
    xbmc &
fi

# Execute window manager
exec dbus-launch awesome
