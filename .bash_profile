# Environment variables.
export BROWSER=vimb
export EDITOR='emacsclient'
export QT_STYLE_OVERRIDE=gtk


# Start X.
if [ `hostname` = "Balder" ]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

if [ `hostname` = "Odin" ]; then
    /usr/bin/fish
    exit
fi

# If CS department computers.
HOSTNAME_START_LETTER=$(hostname | head -c 1)
if test $HOSTNAME_START_LETTER == "a" -o $HOSTNAME_START_LETTER == "l"
then
    export PATH=~/.local/bin:~/.local/usr/local/bin:$PATH
    export LD_LIBRARY_PATH=/users/muldvang/.local/lib:/usr/local/lib:/usr/lib:/lib
    fish; exit
fi
