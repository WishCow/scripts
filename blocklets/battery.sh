#!/bin/bash -eu

BAT=${1:-}
acpi=$(acpi)
level=$(echo "$acpi" | sed 's/.*, \([0-9]*\)%.*/\1/ig')

# 0: full
# 1: discharging
# 2: charging
state=0
if echo "$acpi" | grep -q 'Full'; then
    state=1
elif echo "$acpi" | grep -q 'Discharging'; then
    state=2
fi

case "$state" in
    "1")
        echo -n ""
    ;;
    "0")
        echo -n ""
    ;;
    *)
        if [ "$level" -ge 80 ]; then
            echo -n ""
        elif [ "$level" -ge 60 ]; then
            echo -n ""
        elif [ "$level" -ge 40 ]; then
            echo -n ""
        elif [ "$level" -ge 20 ]; then
            echo -n ""
        elif [ "$level" -ge 0 ]; then
            echo -n ""
        fi
    ;;
esac

echo -n " $level%"
if [ "$state" -eq 2 ]; then
    echo -n "$acpi" | sed 's/.*, \(.*\) remaining.*/ (\1)/i'
elif [ "$state" -eq 0 ]; then
    echo -n "$acpi" | sed 's/.*, \(.*\) until.*/ (\1)/i'
fi

if cat /proc/acpi/bbswitch | grep -q ON; then
    echo -n " O"
fi
