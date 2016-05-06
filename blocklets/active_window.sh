#!/bin/bash -eu

while read window; do
    icon=""
    case "$window" in
        *WeeChat*)
            icon=""
        ;;
        *Firefox*)
            icon=""
        ;;
        *VIM*)
            icon=""
        ;;
        *VLC*)
            icon=""
        ;;
    esac
    echo "$icon   $window"
done < <(xtitle -s)
