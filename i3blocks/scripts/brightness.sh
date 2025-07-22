#!/usr/bin/env bash
#
# brightness.sh — show & adjust backlight brightness

# pick the first backlight interface
BL=$(ls /sys/class/backlight | head -n1)
if [[ -z $BL ]]; then
  echo " N/A"
  exit
fi

# change brightness on scroll:
#   BLOCK_BUTTON=4 → scroll up
#   BLOCK_BUTTON=5 → scroll down
STEP=5%
case "$BLOCK_BUTTON" in
4) brightnessctl set +"$STEP" >/dev/null ;;
5) brightnessctl set "$STEP"-% >/dev/null ;;
esac

# now read current & max
cur=$(brightnessctl get)
max=$(brightnessctl max)
pct=$((cur * 100 / max))

echo " ${pct}%"
