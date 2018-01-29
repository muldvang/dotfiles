#
# ~/.bash_profile
#

# Source .bashrc at login.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Environment variables.
export BROWSER=qutebrowser
export EDITOR='emacsclient -c'
export QT_STYLE_OVERRIDE=gtk
export PATH=~/.local/bin:~/.local/usr/local/bin:~/.composer/vendor/bin:$PATH
export PAGER=~/.local/bin/less-pygments
# export SAL_USE_VCLPLUGIN=gtk3   # Make libreoffice use gtk3. Does not work as of May, 2016.
export _JAVA_OPTIONS='-Djava.io.tmpdir=/var/tmp/ -Dawt.useSystemAAFontSettings=on'
export NO_AT_BRIDGE=1 # Delay ATK bridge initialization (some GNOME program)

# Start X.
if [ `hostname` = "Balder" ]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

if [ `hostname` = "Odin" ]; then
    /usr/bin/fish
    exit
fi

# # If CS department computers.
HOSTNAME_START_LETTER=$(hostname | sed "s/(none)/a016xx/" | head -c 1)
if test "$HOSTNAME_START_LETTER" = "a" -o "$HOSTNAME_START_LETTER" = "l"
then
    export LD_LIBRARY_PATH=/users/muldvang/.local/lib:/usr/local/lib:/usr/lib:/lib
    # fish; exit
fi
