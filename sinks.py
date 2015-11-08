#!/bin/python

from subprocess import call, check_output, Popen, PIPE
from pprint import pprint
import re, sys
from collections import OrderedDict

mycall = lambda x: check_output(x).decode('utf-8').rstrip("\n").split("\n")
dmenu = ['rofi', '-dmenu', '-format', 'i', '-p', 'Choose sink to migrate to: ']

choices = OrderedDict()
l_sink, c_id = True, None

for line in mycall(['pactl', 'list', 'sinks']):
    line = line.strip()
    if l_sink:
        match = re.match(r'^Sink #(\d+)$', line)
        if match:
            l_sink, c_id = False, match.group(1)
    else:
        match = re.match(r'^Description: (.*)$', line)
        if match:
            choices[c_id] = "{}. {}".format(c_id, match.group(1))
            l_sink, c_id = True, None

if not choices:
    sys.exit(2)

pipe = Popen(dmenu, stdout=PIPE, stdin=PIPE)
out, err = pipe.communicate(input="\n".join(choices.values()).encode('utf-8'))

choice = out.decode("utf-8").strip()
if not choice or choice not in choices:
    sys.exit(1)

call(['pactl', 'set-default-sink', choice])
for input in mycall(['pactl', 'list', 'short', 'sink-inputs']):
    id = input.split("\t")[0]
    call(['pactl', 'move-sink-input', id, choice])
