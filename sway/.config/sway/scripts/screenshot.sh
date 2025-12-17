#!/bin/bash
# Screenshot utility script using grim and slurp

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/notify.sh"

# Create screenshots directory if it doesn't exist
SCREENSHOT_DIR="$HOME/Pictures/screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Generate filename with timestamp
FILENAME="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"

# Screenshot mode: full, region, or window
MODE="${1:-full}"

case "$MODE" in
    full)
        # Capture entire screen
        if grim "$FILENAME"; then
            notify_info "Screenshot saved" \
                "Screenshot saved to $FILENAME" 2000 "camera-photo"
        else
            notify_error "Screenshot failed" \
                "Failed to capture screenshot" 5000 "dialog-error"
            exit 1
        fi
        ;;

    region)
        # Capture selected region
        REGION=$(slurp 2>/dev/null)
        if [ -z "$REGION" ]; then
            # User cancelled selection
            exit 0
        fi

        if grim -g "$REGION" "$FILENAME"; then
            notify_info "Screenshot saved" \
                "Screenshot saved to $FILENAME" 2000 "camera-photo"
        else
            notify_error "Screenshot failed" \
                "Failed to capture screenshot" 5000 "dialog-error"
            exit 1
        fi
        ;;

    window)
        # Capture focused window
        GEOMETRY=$(swaymsg -t get_tree | \
            jq -r '.. | select(.focused?) | .rect |
                "\(.x),\(.y) \(.width)x\(.height)"')

        if [ -z "$GEOMETRY" ]; then
            notify_error "Screenshot failed" \
                "Could not find focused window" 5000 "dialog-error"
            exit 1
        fi

        if grim -g "$GEOMETRY" "$FILENAME"; then
            notify_info "Screenshot saved" \
                "Screenshot saved to $FILENAME" 2000 "camera-photo"
        else
            notify_error "Screenshot failed" \
                "Failed to capture screenshot" 5000 "dialog-error"
            exit 1
        fi
        ;;

    *)
        notify_error "Screenshot error" \
            "Invalid mode: $MODE" 5000 "dialog-error"
        echo "Usage: $0 [full|region|window]" >&2
        exit 1
        ;;
esac
