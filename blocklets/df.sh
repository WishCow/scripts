#!/bin/bash

free=$(btrfs filesystem usage -T "$1" 2>/dev/null | grep Free | awk '{ print $3 }' | sed 's/^\([0-9\.]*\).*/\1/')

printf "  %.$2f GB" "$free"
