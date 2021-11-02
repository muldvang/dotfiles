#!/usr/bin/env sh

xrandr --dpi 192
sed -i 's/Xft.dpi: 96/Xft.dpi: 192/' .Xresources
sed -i 's/Xcursor.size: 8/Xcursor.size: 16/' .Xresources
xrdb ~/.Xresources
