#!/bin/bash
# External monitor to the left
swaymsg "output HDMI-A-1 enable; output HDMI-A-1 pos 0 0; output eDP-1 enable pos 2560 0; workspace 1; move workspace to output eDP-1"
echo "left" > ~/.config/sway/monitor-state
