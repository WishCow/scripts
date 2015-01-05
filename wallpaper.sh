#!/bin/bash

# Change wallpaper every X minutes
INTERVAL=$((30 * 60))

# Pull a random image from here
DIR=~/Dropbox/Photos/Wallpapers/

# Bash will strip NULL bytes (-print0) in variables, so we encode the file list
# in hex with xxd, and reverse it when we need to change the background
# This lets us cache the files on the first run, and avoids quoting problems
# with special characters in filenames
FILES=$(find "$DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) -print0 | xxd -p | tr -d '\n')

COUNTER=0

trap change_wallpaper USR1

change_wallpaper() {
    echo -ne "$FILES" | xxd -r -p | shuf -n1 -z | xargs -0 feh --bg-fill
    COUNTER=0
}

change_wallpaper
while true; do
    if [[ $COUNTER -ge $INTERVAL ]]; then
        change_wallpaper
    fi
    sleep 1
    COUNTER=$(( $COUNTER + 1 ))
done
