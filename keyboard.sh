#!/bin/bash

setxkbmap -layout hu,no,us -option grp:alt_shift_toggle,caps:swapescape
xmodmap ~/.xmodmap
killall xcape
xcape -e Control_L=Escape -t 110
