#!/bin/bash
# External monitor to the left (physically)
# Position external at 0, laptop with scaling after it

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

# Enable external at position 0
niri msg output "$EXTERNAL" on
niri msg output "$EXTERNAL" position set 0 0

# Get external monitor width
EXTERNAL_WIDTH=$(niri msg --json outputs | jq -r ".[] | select(.name == \"$EXTERNAL\") | .logical.width")

# Enable laptop with scaling and position after external (to the right in logical space)
niri msg output "$LAPTOP" on
niri msg output "$LAPTOP" scale 1.8
niri msg output "$LAPTOP" position set "$EXTERNAL_WIDTH" 0

echo "left" > "$STATE_FILE"
notify-send -a "Display" -i "video-display" "Monitor Setup" "External monitor enabled (left side)"
