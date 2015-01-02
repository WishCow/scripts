#!/bin/bash -eu

set -o pipefail
CONF=/etc/php/conf.d/xdebug.ini
RESTART="systemctl restart php-fpm.service"

ENABLE=0
if [ "${1:-}" == 'toggle' ]; then
    if php -m | grep -qi xdebug; then
        ENABLE=0
    else
        ENABLE=1
    fi
elif [ "${1:-}" == "on" ]; then
    ENABLE=1
fi

if [ ! -f "$CONF" ]; then
    echo "Cannot find config file $CONF"
    exit 1
fi

PATTERN='s/^/;/'
ISON=OFF
if [ "$ENABLE" -eq 1 ]; then
    PATTERN='s/^;//'
    ISON=ON
fi

if sudo sed -i "$PATTERN" "$CONF" && sudo $RESTART; then
    notify-send -t 1500 "XDebug is now $ISON"
fi
