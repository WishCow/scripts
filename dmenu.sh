#!/bin/bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

dmenu "$@" $(cat "$DIR"/dmenu.rc)
