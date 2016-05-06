#!/bin/bash

if ponymix is-muted; then
    echo "  OFF"
    exit 0
fi

vol=$(ponymix get-volume)
echo "  $vol"
