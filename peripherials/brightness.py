#!/bin/python

import sys
from subprocess import call, check_output
from os.path import basename
from os import getenv

if len(sys.argv) < 2:
    sys.stderr.write("Usage: {} number|display".format(basename(__file__)))
    sys.exit(1)

icon = "info"
notification_id = 9999
dunstify = "{}/local/dunstify".format(getenv('HOME'))

try:
    delta = sys.argv[1]
    current = int(round(float(check_output('xbacklight')), 0))
    new_value = current
    if delta != "display":
        new_value = min(100, current + int(delta))
        call(["xbacklight", "-inc", str(delta)])
    call([dunstify, "-t", "3", "-r", str(notification_id), "Brightness", "-i", icon, "{} / 100".format(new_value)])
except ValueError:
    sys.stderr.write("{} is not a number".format(sys.argv[1]))
    sys.exit(1)
