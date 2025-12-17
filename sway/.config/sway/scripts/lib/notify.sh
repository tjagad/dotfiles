#!/bin/bash
# Notification utility library
# Provides abstraction layer for desktop notifications

# Check if notification system is available
_notify_available() {
    command -v notify-send &> /dev/null
}

# Send a notification
# Usage: notify "title" "message" [urgency] [timeout] [icon]
# urgency: low, normal, critical (default: normal)
# timeout: milliseconds (default: 2000)
# icon: icon name or path (optional)
notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    local timeout="${4:-2000}"
    local icon="$5"
    
    if _notify_available; then
        if [ -n "$icon" ]; then
            notify-send -u "$urgency" -t "$timeout" -i "$icon" \
                "$title" "$message"
        else
            notify-send -u "$urgency" -t "$timeout" \
                "$title" "$message"
        fi
    else
        echo "[$urgency] $title: $message" >&2
    fi
}

# Convenience functions
notify_info() {
    notify "$1" "$2" "normal" "${3:-2000}" "$4"
}

notify_warn() {
    notify "$1" "$2" "normal" "${3:-3000}" "$4"
}

notify_error() {
    notify "$1" "$2" "critical" "${3:-5000}" "$4"
}
