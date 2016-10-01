#!/bin/bash

setxkbmap -layout hu,no,us -option grp:alt_shift_toggle
xmodmap ~/.xmodmap

killall xcape
xcape -e 'Control_L=Escape' -t 110
xcape -e 'Shift_L=parenleft;Shift_R=parenright;Alt_L=Shift_L|1'
