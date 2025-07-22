#!/usr/bin/env bash
#
# volume.sh — show & adjust PulseAudio volume for i3blocks

# If you click or scroll, adjust first:
case "$BLOCK_BUTTON" in
1) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
4) pactl set-sink-volume @DEFAULT_SINK@ +2% ;;
5) pactl set-sink-volume @DEFAULT_SINK@ -2% ;;
esac

# Now fetch the current volume and mute state:
vol=$(pactl get-sink-volume @DEFAULT_SINK@ |
  awk '/^Volume:/ { print $5; exit }')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ |
  awk '{ print $2 }')

# Choose an icon and output:
if [[ $mute == "yes" ]]; then
  echo " MUTE"
else
  echo " ${vol}"
fi
