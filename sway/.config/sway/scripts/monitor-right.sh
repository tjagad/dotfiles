#!/bin/bash
# External monitor to the right
swaymsg "output HDMI-A-1 enable; output eDP-1 enable pos 0 0; output HDMI-A-1 pos 1440 0; workspace 1; move workspace to output eDP-1"
echo "right" > ~/.config/sway/monitor-state
