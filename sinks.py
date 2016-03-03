#!/bin/python

from subprocess import call, check_output, Popen, PIPE, STDOUT
from pprint import pprint
import re, sys
from operator import itemgetter

mycall = lambda x: check_output(x, stderr=STDOUT).decode('utf-8').rstrip("\n")
dmenu = ['rofi', '-dmenu', '-p', 'Choose sink to migrate to: ']

contents = mycall(['pactl', 'list', 'sinks'])
matches = re.findall(r'^Sink #(\d+).*?Description: (.*?)$', contents, flags=re.M | re.DOTALL)

if not matches:
    print("No sinks found", file=sys.stderr)
    sys.exit(2)

sinks = { "{}. {}".format(k,v): k for (k, v) in matches }

pipe = Popen(dmenu, stdout=PIPE, stdin=PIPE)
out, err = pipe.communicate(input="\n".join(sorted(sinks.keys())).encode('utf-8'))

if err:
    print("Could not call rofi:", err, file=sys.stderr)

choice = out.decode("utf-8").strip()
sink_id = sinks.get(choice)
if not sink_id:
    valid_sinks = ", ".join(sorted(sinks.keys()))
    print("Selected choice {} is not a valid sink (valid sinks are: {})".format(choice, valid_sinks), file=sys.stderr)
    sys.exit(1)

call(['pactl', 'set-default-sink', sink_id], stderr=STDOUT)
for input in mycall(['pactl', 'list', 'short', 'sink-inputs']).split("\n"):
    id = input.split("\t")[0]
    call(['pactl', 'move-sink-input', id, sink_id])
