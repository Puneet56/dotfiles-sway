#!/bin/bash

# Get the identifier of the first touchpad device
touchpad=$(swaymsg -t get_inputs | jq -r '.[] | select(.type == "touchpad") | .identifier' | head -n1)

if [ -z "$touchpad" ]; then
  notify-send "Error" "No touchpad device found!"
  exit 1
fi

# Get the current tap state (enabled or disabled)
current_state=$(swaymsg -t get_inputs | jq -r --arg id "$touchpad" '.[] | select(.identifier == $id) | .libinput.tap')

if [ "$current_state" = "enabled" ]; then
  notify-send "Mouse mode" "Tap to click disabled"
  swaymsg input "$touchpad" tap disabled
else
  notify-send "Mouse mode" "Tap to click enabled"
  swaymsg input "$touchpad" tap enabled
fi
