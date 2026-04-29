#!/bin/bash
SINKS=($(wpctl status | sed -n '/├─ Sinks:/,/├─ Sources:/p' | grep -E '^\s+│\s+[\*]?\s+[0-9]+\.' | sed 's/[│*]//g' | awk '{print $1}' | tr -d '.'))
CURRENT=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep '^id' | awk '{print $2}' | tr -d ',')
for i in "${!SINKS[@]}"; do
    if [ "${SINKS[$i]}" == "$CURRENT" ]; then
        NEXT_INDEX=$(( (i + 1) % ${#SINKS[@]} ))
        NEXT_SINK=${SINKS[$NEXT_INDEX]}
        wpctl set-default $NEXT_SINK
        SINK_NAME=$(wpctl inspect $NEXT_SINK | grep 'node.description' | cut -d'"' -f2)
        notify-send -a "Audio" -i "audio-card" "Audio Output" "$SINK_NAME"
        break
    fi
done
