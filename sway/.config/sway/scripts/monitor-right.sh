#!/bin/bash
# External monitor to the right

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

# Get list of connected outputs
OUTPUTS=$(swaymsg -t get_outputs -r)

# Check if external monitor (HDMI-A-1) exists
if ! echo "$OUTPUTS" | jq -e '.[] | select(.name == "HDMI-A-1")' \
    > /dev/null; then
    notify_error "Monitor Setup" \
        "External monitor HDMI-A-1 not found"
    exit 1
fi

# Check if laptop display (eDP-1) exists
if ! echo "$OUTPUTS" | jq -e '.[] | select(.name == "eDP-1")' \
    > /dev/null; then
    notify_error "Monitor Setup" "Laptop display eDP-1 not found"
    exit 1
fi

# Get laptop display width (accounting for scaling)
LAPTOP_WIDTH=$(echo "$OUTPUTS" | \
    jq -r '.[] | select(.name == "eDP-1") | .rect.width')

# Enable both outputs and position them
swaymsg "output HDMI-A-1 enable; output eDP-1 enable pos 0 0; \
output HDMI-A-1 pos ${LAPTOP_WIDTH} 0; workspace 1; \
move workspace to output eDP-1"
echo "right" > ~/.config/sway/monitor-state

notify_info "Monitor Setup" "External monitor to the right"
