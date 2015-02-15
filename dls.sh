#!/bin/bash -eu

FORMAT="%f"
DIR=~/Downloads
NOTIFY="$HOME/bin/dunstify -a 'DLWatch'"
XARGS="xargs -t bash -c eval"

notify() {
    FILE="$1"
    shift
    echo "$@"
    RET=$(dunstify -a DLWatch -A "$@" "New download" "$FILE")
    eval "$RET"
}

unzip() {
    TEMP=$(mktemp -d)
    thunar "$TEMP" &
    (
    cd "$TEMP"
    7z x "$1"
    )
}

inotifywait -q -m -e CREATE --format "$FORMAT" "$DIR" | while read FILE; do
    EXT="${FILE##*.}"
    if [[ $EXT == $FILE ]]; then
        continue
    fi
    FP="$DIR/$FILE"
    case "$EXT" in
        txt|php)
            notify "$FILE" "gvim --remote-silent-tab '$FP',Open in gvim"
            ;;
        zip|rar)
            notify "$FILE" "unzip '$FP',unzip"
            ;;
    esac
done
