#!/bin/bash
# External monitor to the left

# Get list of connected outputs
OUTPUTS=$(swaymsg -t get_outputs -r)

# Check if external monitor (HDMI-A-1) exists
if ! echo "$OUTPUTS" | jq -e '.[] | select(.name == "HDMI-A-1")' > /dev/null; then
    swayosd-client --custom-message="External monitor HDMI-A-1 not found" --custom-icon=dialog-error
    exit 1
fi

# Check if laptop display (eDP-1) exists
if ! echo "$OUTPUTS" | jq -e '.[] | select(.name == "eDP-1")' > /dev/null; then
    swayosd-client --custom-message="Laptop display eDP-1 not found" --custom-icon=dialog-error
    exit 1
fi

# Get external monitor width (accounting for scaling)
EXTERNAL_WIDTH=$(echo "$OUTPUTS" | jq -r '.[] | select(.name == "HDMI-A-1") | .rect.width')

# Enable both outputs and position them
swaymsg "output HDMI-A-1 enable; output HDMI-A-1 pos 0 0; output eDP-1 enable pos ${EXTERNAL_WIDTH} 0; workspace 1; move workspace to output eDP-1"
echo "left" > ~/.config/sway/monitor-state

swayosd-client --custom-message="External monitor to the left" --custom-icon=video-display
