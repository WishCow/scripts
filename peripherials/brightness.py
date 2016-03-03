#!/bin/python

import sys
from subprocess import call, check_output
from os.path import basename
from os import getenv

if len(sys.argv) < 3:
    sys.stderr.write("Usage: {} number|display".format(basename(__file__)))
    sys.exit(1)

icon = "info"
notification_id = 9999
dunstify = getenv('HOME') + "/bin/dunstify"

change, amount = sys.argv[1:]
args = ["light", '-A' if change == 'inc' else '-U', amount]
call(args)
new_value = float(check_output(['light']))
call([dunstify, "-t", "3", "-r", str(notification_id), "Brightness", "-i", icon, "{} / 100".format(new_value)])
