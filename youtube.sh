#!/bin/bash -eu

URL="$1"
shift

ARTIST="${1:-}"
if [ -n "$ARTIST" ]; then
    shift;
    SONG="${1:-}"
    if [ -n "$SONG" ]; then
        shift;
    fi
fi

ID3LINE="id3v2 -c Youtube"
if [ -n "$ARTIST" ]; then
    ID3LINE+=" -a '$ARTIST'"
fi
if [ -n "$SONG" ]; then
    ID3LINE+=" -t '$SONG'"
fi
ID3LINE+=" {}"

(
    cd ~/Downloads
    youtube-dl -f bestaudio -x --audio-format mp3 "$URL" "$@" --exec "$ID3LINE"
)
