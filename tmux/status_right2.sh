#!/bin/bash -eu

case "$(hostname)" in
    archer)
        ACPI=$(acpitool | head -n1)
        PATTERN=": (.*?), ([0-9]+)\..*, (.*)"
        echo -n "[BAT] "
        if [[ $ACPI =~ $PATTERN ]]; then
            case "${BASH_REMATCH[1]}" in
                Charging)
                    echo -n "${BASH_REMATCH[2]}%"
                ;;
                Discharging)
                    echo -n "${BASH_REMATCH[3]} (${BASH_REMATCH[2]}%)"
                ;;
                Unknown)
                    echo -n "100%"
                ;;
            esac
        fi
        ;;
esac
