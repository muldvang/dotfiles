# Environment variables.
export BROWSER=vimb
export EDITOR='emacsclient -t -a=""'


# Start X.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
