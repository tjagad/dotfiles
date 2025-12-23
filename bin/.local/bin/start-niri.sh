#!/bin/bash

# 1. Set environment for headless mode
export WLR_BACKENDS=headless
export WLR_LIBINPUT_NO_DEVICES=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=niri

# 2. Start Niri in the background
# We use dbus-run-session to ensure apps like Waybar or DMS work correctly
dbus-run-session niri --session &
NIRI_PID=$!

# 3. Wait a moment for Niri to initialize the headless output
sleep 2

# 4. Start WayVNC
# 0.0.0.0 listens on all interfaces; use 127.0.0.1 for SSH tunneling
wayvnc 0.0.0.0 5900 &
VNC_PID=$!

echo "Niri VNC session started on port 5900 (PID: $NIRI_PID)"

# 5. Clean up both if the script is killed
trap "kill $NIRI_PID $VNC_PID" EXIT
wait
