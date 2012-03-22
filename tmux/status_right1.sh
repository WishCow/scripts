#!/bin/bash

PLAYING="$(mpc -f "%artist% - %title%" current)"

echo "[MPD] ${PLAYING:-Nothing playing}"

# ♫♬♪
