#!/bin/bash

msg() {
    notify-send --icon=/usr/share/icons/NITRUX/devices/scalable/drive-harddisk.svg "uDevil" "$@"
}

CMD="$1"
MOUNT="$2"
DEV="$3"
LABEL="$4"

case "$CMD" in
    "MOUNT")
        msg "Mounted $LABEL\n$DEV -> $MOUNT"
        thunar $MOUNT
        ;;
    "UMOUNT")
        msg "Unmounted $LABEL\n$DEV"
        ;;
    "REMOVEALL")
        devmon -ug
        ;;
    *)
    devmon --exec-on-drive "$0 MOUNT %d %f %l" --exec-on-unmount "$0 UMOUNT %d %f %l" &
esac
