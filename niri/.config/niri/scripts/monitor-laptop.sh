#!/bin/bash
# Laptop only - disable external monitors

STATE_FILE=~/.config/niri/monitor-state

# Get laptop display (eDP-*)
LAPTOP=$(niri msg --json outputs | jq -r '.[] | select(.name | test("eDP-[0-9]+")) | .name' | head -1)

# Get all external monitors
mapfile -t EXTERNALS < <(niri msg --json outputs | jq -r '.[] | select(.name | test("eDP-[0-9]+") | not) | .name')

# Disable external monitors
for EXTERNAL in "${EXTERNALS[@]}"; do
    niri msg output "$EXTERNAL" off
done

# Enable laptop with scaling and position at 0,0
niri msg output "$LAPTOP" on
niri msg output "$LAPTOP" scale 1.8
niri msg output "$LAPTOP" position set 0 0

echo "laptop" > "$STATE_FILE"
notify-send -a "Display" -i "video-display" "Monitor Setup" "Laptop only"
