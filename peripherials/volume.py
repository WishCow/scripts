#!/bin/python

import sys
from subprocess import call, check_output
from os.path import basename
from os import getenv

if len(sys.argv) < 2:
    sys.stderr.write("Usage: {} number|toggle|display\n".format(basename(__file__)))
    sys.exit(1)

notification_id = 9998
dunstify = "{}/local/dunstify".format(getenv('HOME'))
max_volume = 100

def notif(message, icon=None):
    if icon is None:
        icon = "audio-volume-high"
    call([dunstify, "-t", "3", "-r", str(notification_id), "Volume", "-i", icon, message])

def show_volume():
    volume = int(check_output(["ponymix", "get-volume"]))
    notif("{} / {}".format(volume, max_volume))

delta = sys.argv[1]
current = int(round(float(check_output(['ponymix', 'get-volume'])), 0))
new_value = current
if delta == "display":
    show_volume()
elif delta == "toggle":
    muted = call(["ponymix", "is-muted"]) == 0
    call(["ponymix", "toggle"])
    if not muted:
        notif("MUTED", "audio-volume-muted")
    else:
        show_volume()
    sys.exit(0)
else:
    try:
        new_value = min(max_volume, current + int(delta))
        call(["ponymix", "set-volume", str(new_value)])
        show_volume()
    except ValueError:
        sys.stderr.write("{} is not a number".format(sys.argv[1]))
        sys.exit(1)
