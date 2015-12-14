#!/bin/bash -eu

declare -A FOLDERS
FOLDERS["$HOME/mnt/tags/tags/mobile-video/"]="$HOME/mnt/phone/SD card/Video/incoming"
FOLDERS["$HOME/mnt/tags/tags/mobile-mp3/"]="$HOME/mnt/phone/SD card/Media/Audio/incoming"

TAGS="$HOME/mnt/tags"
SENTINEL="$HOME/mnt/phone"

fusermount -u "$SENTINEL" &>/dev/null

if ! mountpoint "$TAGS" &>/dev/null; then
    tmsu mount "$TAGS"
fi

if ! mountpoint "$SENTINEL" &>/dev/null; then
    echo "Phone is not mounted, mounting..."
    if ! simple-mtpfs "$SENTINEL"; then
        echo "Could not mount phone"
        exit 1
    fi
fi

# -r recurse
# -L transform symlinks to the files they point to
# --progress show some progress
# --update only overwrite files if they differ

for K in "${!FOLDERS[@]}"; do
    set +e
    rsync -r -L --progress=info2 --update "$K" "${FOLDERS[$K]}"
    set -e
done
