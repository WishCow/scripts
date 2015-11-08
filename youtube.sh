#!/bin/bash -eu

# Download a video from youtube, extract the audio stream to MP3
# and add ID3 tags on it. Needs youtube-dl to work, and id3v2 to tag.

usage() {
    printf 'Usage: %s URL [ARTIST] [SONG]' "$0"
    exit 1
}

URL="${1:-}"
shift
[ -z "$URL" ] && usage

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
