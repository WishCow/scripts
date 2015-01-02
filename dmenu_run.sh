#!/bin/bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

dmenu_run -q -p Run $(cat "$DIR"/dmenu.rc)
