#!/bin/bash
# Laptop only

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

swaymsg "output HDMI-A-1 disable; output eDP-1 enable pos 0 0; \
workspace 1; move workspace to output eDP-1"
echo "laptop" > ~/.config/sway/monitor-state

# Force audio to laptop speakers when external monitor is disconnected
if command -v wpctl &> /dev/null; then
    sleep 0.5  # Give sinks time to update
    laptop_sink=$(wpctl status | \
        sed -n '/^Audio/,/^Video/p' | \
        sed -n '/^ ├─ Sinks:/,/^ ├─ Sources:/p' | \
        grep -i 'built-in\|laptop\|internal' | \
        sed -E 's/^\s*│\s*\*?\s*([0-9]+)\..*$/\1/' | head -n1)
    [ -n "$laptop_sink" ] && wpctl set-default "$laptop_sink" 2>/dev/null
fi

notify_info "Monitor Setup" "External monitor disabled" 2000 "video-display"
