#!/bin/sh

sleep 1
while true; do
    find ~/Dropbox/Pics/Wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z | xargs -0 feh --bg-fill
    sleep 15m
done
