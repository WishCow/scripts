#!/bin/bash -eu

FILE="${1:-}"

if [ ! -f "$FILE" ]; then
    exit 1
fi

DIR="$(dirname "$FILE")"

feh -Tshow --start-at "$FILE" "$DIR"
