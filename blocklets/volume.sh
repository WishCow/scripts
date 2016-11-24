#!/bin/bash

if [[ -n "$BLOCK_BUTTON" ]]; then
    cmd=""
    case "$BLOCK_BUTTON" in
        2)
            cmd="toggle"
            ;;
        4)
            cmd="10"
            ;;
        5)
            cmd="-10"
            ;;
        *)
            echo "$BLOCK_BUTTON"
            ;;
    esac
    ~/bin/peripherials/volume.py "$cmd" > /dev/null
fi

if ponymix is-muted; then
    echo "  OFF"
    exit 0
fi

vol=$(ponymix get-volume)
echo "  $vol"
