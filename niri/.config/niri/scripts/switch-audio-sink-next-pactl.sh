#!/bin/bash

# 1. Get a list of all Sink Names (more reliable than IDs in PulseAudio)
SINKS=($(pactl list sinks short | awk '{print $2}'))

# 2. Get the current Default Sink Name
CURRENT=$(pactl get-default-sink)

# 3. Find the next sink in the array and switch
for i in "${!SINKS[@]}"; do
	if [ "${SINKS[$i]}" == "$CURRENT" ]; then
		NEXT_INDEX=$(( (i + 1) % ${#SINKS[@]} ))
		NEXT_SINK=${SINKS[$NEXT_INDEX]}

		# Set the new default sink
		pactl set-default-sink "$NEXT_SINK"

		# Move all currently playing streams to the new sink (optional but recommended)
		pactl list sink-inputs short | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$NEXT_SINK" 2>/dev/null

		# 4. Get the Description for the notification
		SINK_DESC=$(pactl list sinks | grep -A 20 "Name: $NEXT_SINK" | grep "Description:" | cut -d: -f2- | sed 's/^[ \t]*//')

		notify-send -a "Audio" -i "audio-card" "Audio Output" "$SINK_DESC"
		break
	fi
done
