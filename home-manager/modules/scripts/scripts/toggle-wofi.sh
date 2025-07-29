#!/usr/bin/env bash

MODE="${1:-drun}"

WOFI_COUNT=$(pgrep -c "wofi")

if [ "$WOFI_COUNT" -gt 0 ]; then
    if [ "$WOFI_COUNT" -eq 2 ]; then
        CURRENT_MODE="power"
    elif [ "$WOFI_COUNT" -eq 1 ]; then
        CURRENT_MODE="drun"
    else
        pkill wofi
        sleep 0.1
    fi

    if [ "$CURRENT_MODE" = "$MODE" ]; then
        pkill wofi
        exit 0
    else
        pkill wofi
        sleep 0.1
    fi
fi

case "$MODE" in
"drun")
    wofi --show drun --normal-window &
    ;;
"power")
    wofi-power-menu &
    ;;
*)
    echo "Usage: $0 [drun|power]"
    exit 1
    ;;
esac
