#!/bin/bash

DIR=~/Dropbox/Photos/Wallpapers/
NEWPAPER=$(find "$DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | shuf -n1)

if feh --bg-fill "$NEWPAPER"; then
    echo "Changed wallpaper to $NEWPAPER"
fi
