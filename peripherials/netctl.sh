#!/bin/bash

SELECTED=$(netctl list | sed 's/^[ \*]*//' | dmenu)

notify-send "Wireless [$SELECTED]" "Connecting..."
if sudo netctl start "$SELECTED"; then
    notify-send "Wireless [$SELECTED]" "Link up"
else
    notify-send "Wireless failure [$SELECTED]" "$(journalctl -r -n -o cat -u netctl@$SELECTED)"
fi
