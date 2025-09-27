#!/usr/bin/env bash
# power.sh - i3blocks script to display and control power profiles

# Detect current mode
current=$(powerprofilesctl get 2>/dev/null)

# If command not found
if [ $? -ne 0 ]; then
  echo "No powerprofilesctl"
  exit 0
fi

# Handle clicks
case $BLOCK_BUTTON in
1) # Left click → cycle between modes
  if [ "$current" = "power-saver" ]; then
    powerprofilesctl set balanced
    current="balanced"
  elif [ "$current" = "balanced" ]; then
    powerprofilesctl set performance
    current="performance"
  else
    powerprofilesctl set power-saver
    current="power-saver"
  fi
  ;;
3) # Right click → reset to balanced
  powerprofilesctl set balanced
  current="balanced"
  ;;
esac

# Icon + text based on mode
case "$current" in
"power-saver") icon="" ;; # (battery icon)
"balanced") icon="" ;;    # (balance scales)
"performance") icon="" ;; # (lightning bolt)
*) icon="?" ;;
esac

# Output for i3blocks (text | short_text | color)
echo "$icon $current"
echo "$icon $current"
case "$current" in
"power-saver") echo "#a6e3a1" ;; # greenish
"balanced") echo "#f9e2af" ;;    # yellowish
"performance") echo "#f7768e" ;; # reddish
esac
