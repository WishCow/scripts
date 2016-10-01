#!/bin/bash -eu

(
cd "$2"
rsync -v --files-from="$1" --delete-missing-args --delete -m ./ "$3"
)
