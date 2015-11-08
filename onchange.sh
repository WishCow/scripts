#!/bin/bash -eu

# Watch for changes on a given file, or for files matching a pattern, in a given folder
# When a change happens, run the given command

DIR="${1:-}"
PATTERN="${2:-}"

usage() {
    local basename=$(basename "$0")
    printf 'Usage:\n%s FILE COMMAND [...args]\n--- or ---\n%s DIR PATTERN COMMAND [...args]\nPattern is a regex, not a glob\n' "$basename" "$basename"
    exit 1
}

[[ -z $DIR || -z $PATTERN ]] && usage

if [ -f "$DIR" ]; then
    PATTERN=^$(basename "$DIR")$
    DIR=$(dirname "$DIR")
    shift
elif [ -d "$DIR" ]; then
    shift 2
else
    echo "The given directory does not exist: $DIR"
    usage
fi

COMMAND="$1"
shift

printf "Watching %s for changes in files matching %s\nRunning: %s %s\n" "$DIR" "$PATTERN" "$COMMAND" "$*"
while read changed_file; do
    if [[ $changed_file =~ $PATTERN ]]; then
        "$COMMAND" "$@"
    fi
done < <(inotifywait --format "%f" -qmre modify "$DIR")
