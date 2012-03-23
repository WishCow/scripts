#!/bin/bash -eu

case "$(hostname)" in
    archer)
        ACPI=$(acpitool -b)
        IFS=$', '
        set -- ${ACPI#*:}
        echo -n "[BAT] "
        case "$1" in
            Charging)
                echo -n "$2"
            ;;
            Discharging)
                echo -n "$3 ($2)"
            ;;
            Unknown|Full)
                echo -n "100%"
            ;;
    esac
esac
