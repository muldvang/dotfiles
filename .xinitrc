if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

for sd_cmd in systemctl systemd-analyze systemd-run; do
    alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus" '$sd_cmd
done

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

# LibreOffice should use gtk3
SAL_USE_VCLPLUGIN=gtk3

# Block bluetooth and wireless wan on laptop
if [ `hostname` = "Balder" ]; then
    rfkill block bluetooth && rfkill block wwan
fi

# Read .Xresources
xrdb ~/.Xresources &

# xrandr --dpi 120

# Disable at-spi-* process
export NO_AT_BRIDGE=1

# Execute window manager
exec dbus-launch i3
