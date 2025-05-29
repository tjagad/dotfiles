#! /bin/bash

xrandr --output eDP --primary --mode 2880x1800 --dpi 192 \
	--scale 1x1 --pos 5120x0 \
	--output HDMI-A-0 --mode 2560x1080 --dpi 96 \
	--scale 2x2 --pos 0x0 --panning 5120x2160+0+0

exit 0
