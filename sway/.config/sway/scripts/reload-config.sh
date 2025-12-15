#!/bin/bash

# Save current workspace state
STATE_FILE="/tmp/sway-workspace-state-$$"

# Get current workspaces per output
swaymsg -t get_workspaces | jq -r '.[] | select(.focused == true) | "\(.output) \(.name)"' > "$STATE_FILE"

# Reload Sway configuration
swaymsg reload

# Wait a moment for reload to complete
sleep 0.2

# Restore workspace focus for each output
while read -r output workspace; do
    swaymsg "workspace --no-auto-back-and-forth $workspace"
done < "$STATE_FILE"

# Clean up
rm -f "$STATE_FILE"
