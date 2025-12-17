#!/bin/bash
# External monitor to the left

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

# Get list of connected outputs
OUTPUTS=$(swaymsg -t get_outputs -r)

# Check if external monitor (HDMI-A-1) exists
if ! echo "$OUTPUTS" | \
    jq -e '.[] | select(.name == "HDMI-A-1")' > /dev/null; then
    notify_error "Monitor Setup" \
        "External monitor HDMI-A-1 not found" 5000 "dialog-error"
    exit 1
fi

# Check if laptop display (eDP-1) exists
if ! echo "$OUTPUTS" | \
    jq -e '.[] | select(.name == "eDP-1")' > /dev/null; then
    notify_error "Monitor Setup" "Laptop display eDP-1 not found" 5000 "dialog-error"
    exit 1
fi

# Get external monitor width (accounting for scaling)
EXTERNAL_WIDTH=$(echo "$OUTPUTS" | \
    jq -r '.[] | select(.name == "HDMI-A-1") | .rect.width')

# Enable both outputs and position them
swaymsg "output HDMI-A-1 enable; output HDMI-A-1 pos 0 0; \
output eDP-1 enable pos ${EXTERNAL_WIDTH} 0; workspace 1; \
move workspace to output eDP-1"
echo "left" > ~/.config/sway/monitor-state

notify_info "Monitor Setup" "External monitor to the right" 2000 "video-display"
