# Source notification library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

# Check if wpctl is installed
if ! command -v wpctl &> /dev/null; then
    notify_error "Audio Sink Toggle" \
        "wpctl not found! Please install wireplumber."
    echo "Error: wpctl not found. Install wireplumber." >&2
    exit 1
fi

# Get list of all available audio sinks
readarray -t sinks < <(wpctl status | \
    sed -n '/^Audio/,/^Video/p' | \
    sed -n '/^ ├─ Sinks:/,/^ ├─ Sources:/p' | \
    grep '^\s*│\s*\*\?\s*[0-9]\+\.\s' | \
    sed -E 's/^\s*│\s*\*?\s*([0-9]+)\..*$/\1/')

# Get current default sink ID
current_sink=$(wpctl status | \
    sed -n '/^Audio/,/^Video/p' | \
    sed -n '/^ ├─ Sinks:/,/^ ├─ Sources:/p' | \
    grep '^\s*│\s*\*' | \
    sed -E 's/^\s*│\s*\*\s*([0-9]+)\..*$/\1/')

# Exit if no sinks found or less than 2 sinks
if [ ${#sinks[@]} -lt 2 ]; then
    notify_info "Audio Sink" \
        "Need at least 2 audio sinks to toggle"
    exit 1
fi

# Find index of current sink
current_index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next sink index (cycle through list)
next_index=$(( (current_index + 1) % ${#sinks[@]} ))
next_sink="${sinks[$next_index]}"

# Set the new default sink
wpctl set-default "$next_sink"

# Get sink name for notification
sink_name=$(wpctl status | \
    sed -n '/^Audio/,/^Video/p' | \
    sed -n '/^ ├─ Sinks:/,/^ ├─ Sources:/p' | \
    grep "^\s*│\s*\*\?\s*${next_sink}\.\s" | \
    sed -E "s/^\s*│\s*\*?\s*${next_sink}\.\s*//; s/\s*\[.*\]\s*$//")

# Show notification
notify_info "Audio Sink" "Switched to: $sink_name"
