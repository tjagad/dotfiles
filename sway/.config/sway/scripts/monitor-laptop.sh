#!/bin/bash
# Laptop only

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

swaymsg "output HDMI-A-1 disable; output eDP-1 enable pos 0 0; \
workspace 1; move workspace to output eDP-1"
echo "laptop" > ~/.config/sway/monitor-state

notify_info "Monitor Setup" "External monitor disabled" 2000 "video-display"
