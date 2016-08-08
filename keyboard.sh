#!/bin/bash

if [ "$1" == "ergo" ]; then
    setxkbmap -layout hu,no,us -option grp:alt_shift_toggle,caps:escape
    xmodmap ~/.xmodmap.ergo
else
    setxkbmap -layout hu,no,us -option grp:alt_shift_toggle
    xmodmap ~/.xmodmap
fi

killall xcape
xcape -e 'Control_L=Escape' -t 110
xcape -e 'Shift_L=parenleft;Shift_R=parenright;Alt_L=Shift_L|1'
