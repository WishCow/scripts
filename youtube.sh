#!/bin/bash

(
    cd ~/Downloads
    youtube-dl -f bestaudio -x --audio-format mp3 "$@"
)
