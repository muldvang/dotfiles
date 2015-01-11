# Environment variables.
export BROWSER=vimb
export EDITOR='emacsclient'


# Start X.
if [ `hostname` = "Balder" ]; then
    [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

if [ `hostname` = "Odin" ]; then
    /usr/bin/fish
    exit
fi
