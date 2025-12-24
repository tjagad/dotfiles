#!/bin/bash
# Toggle between laptop-only, external-right, and external-left

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STATE_FILE=~/.config/niri/monitor-state

# Read current state, default to "laptop" if file doesn't exist
if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="laptop"
fi

# Determine next state and execute corresponding script
case "$CURRENT_STATE" in
    "laptop")
        "$SCRIPT_DIR/monitor-right.sh"
        ;;
    "right")
        "$SCRIPT_DIR/monitor-left.sh"
        ;;
    "left"|*)
        "$SCRIPT_DIR/monitor-laptop.sh"
        ;;
esac

killall -9 gammastep 2>/dev/null
sleep 1
gammastep -O 3500 &
