#!/bin/bash
# Laptop only
swaymsg "output HDMI-A-1 disable; output eDP-1 enable pos 0 0; workspace 1; move workspace to output eDP-1"
echo "laptop" > ~/.config/sway/monitor-state
