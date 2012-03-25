#!/bin/bash

PLAYING="$(ncmpcpp --now-playing "%a - %t")"

echo "[MPD] ${PLAYING:-Nothing playing}"

# ♫♬♪
