#!/bin/bash
# Notification utility library
# Provides abstraction layer for desktop notifications

# Check if notification system is available
_notify_available() {
    command -v notify-send &> /dev/null
}

# Send a notification
# Usage: notify "title" "message" [urgency] [timeout]
# urgency: low, normal, critical (default: normal)
# timeout: milliseconds (default: 2000)
notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    local timeout="${4:-2000}"
    
    if _notify_available; then
        notify-send -u "$urgency" -t "$timeout" \
            "$title" "$message"
    else
        echo "[$urgency] $title: $message" >&2
    fi
}

# Convenience functions
notify_info() {
    notify "$1" "$2" "normal" "${3:-2000}"
}

notify_warn() {
    notify "$1" "$2" "normal" "${3:-3000}"
}

notify_error() {
    notify "$1" "$2" "critical" "${3:-5000}"
}
