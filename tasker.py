#!/bin/python

from subprocess import check_output, Popen, PIPE, STDOUT, call
from os.path import dirname
import re

matcher = re.compile(r'^(.*?)\s+(\d+)\s+(.*?)\s+(.*?)\s+(.*)$')

out = check_output(['wmctrl', '-lx'])

windows = {}
for line in out.splitlines():
    columns = matcher.match(line.decode('utf-8'))
    id, klass, title = columns.group(1, 3, 5)
    use = title if title != 'N/A' else klass
    if not use in windows.keys():
        windows[use] = id

dmenu_sh = "{}/dmenu.sh".format(dirname(__file__))
dmenu = Popen([dmenu_sh, '-i', '-p', 'Switch:'], stdin=PIPE, stdout=PIPE)
choices = bytes("\n".join(windows.keys()), 'utf-8')
selected = dmenu.communicate(input=choices)[0].decode('utf-8').strip()

if selected in windows:
    print("Switching to {}".format(windows.get(selected)))
    call(['wmctrl', '-i', '-a', windows.get(selected)])
