#!/bin/bash

DIR="${1:-}"
PATTERN="${2:-}"

[ ! -d "$DIR" ] && {
    echo "File $DIR does not exist"
    exit 1
}

shift 2
COMMAND="$1"
shift

echo "Watching: $DIR"
while read changed_file; do
    if [[ $changed_file =~ $PATTERN ]]; then
        "$COMMAND" "$@"
    fi
done < <(inotifywait --format "%f" -qmre modify "$DIR")
