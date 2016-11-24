#!/bin/bash -eu

IFACE=${1:-}

if [[ -n "$BLOCK_BUTTON" ]]; then
    urxvt -title "WiFi menu" -e sh -c "sudo wifi-menu"
fi

[[ ! -e /sys/class/net/$IFACE ]] && (
    echo "Interface $IFACE does not exist"
    exit 1
)

[[ $(cat /sys/class/net/$IFACE/operstate) != "up" ]] && echo "N/A"

ssid=$(iwconfig "$IFACE" | grep ESSID | sed 's/.*ESSID:"\(.*\)".*/\1/')

if [[ ! -n $ssid ]]; then
    ssid="N/A"
fi

echo $ssid
