#!/bin/bash
# External monitor to the right (physically)
# Position laptop at 0 with scaling, external after it to the right

STATE_FILE=~/.config/niri/monitor-state

# Get outputs as JSON
OUTPUTS=$(niri msg --json outputs)

# Get laptop display
LAPTOP=$(echo "$OUTPUTS" | jq -r '.[] | select(.name | test("eDP-[0-9]+")) | .name' | head -1)

# Get first external monitor
EXTERNAL=$(echo "$OUTPUTS" | jq -r '.[] | select(.name | test("eDP-[0-9]+") | not) | .name' | head -1)

if [ -z "$EXTERNAL" ]; then
    notify-send -a "Display" -i "dialog-error" "Monitor Setup" "No external monitor found"
    exit 1
fi

# Enable laptop with scaling at position 0
niri msg output "$LAPTOP" on
niri msg output "$LAPTOP" scale 1.8
niri msg output "$LAPTOP" position set 0 0

# Get laptop logical width after scaling
LAPTOP_WIDTH=$(niri msg --json outputs | jq -r ".[] | select(.name == \"$LAPTOP\") | .logical.width")

# Enable external monitor and position it after laptop (to the right)
niri msg output "$EXTERNAL" on
niri msg output "$EXTERNAL" position set "$LAPTOP_WIDTH" 0

echo "right" > "$STATE_FILE"
notify-send -a "Display" -i "video-display" "Monitor Setup" "External monitor enabled (right side)"
