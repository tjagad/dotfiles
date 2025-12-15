#!/bin/bash
# Restore last monitor configuration
STATE_FILE=~/.config/sway/monitor-state

if [ -f "$STATE_FILE" ]; then
    STATE=$(cat "$STATE_FILE")
    case "$STATE" in
        right)
            ~/.config/sway/scripts/monitor-right.sh
            ;;
        left)
            ~/.config/sway/scripts/monitor-left.sh
            ;;
        laptop)
            ~/.config/sway/scripts/monitor-laptop.sh
            ;;
    esac
fi
