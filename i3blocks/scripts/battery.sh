#!/usr/bin/env bash
# supports BAT0; adapt if needed
capacity=$(</sys/class/power_supply/BAT1/capacity)
status=$(</sys/class/power_supply/BAT1/status)

case $status in
Charging) icon="" ;;
Discharging) icon="" ;;
*) icon="" ;;
esac

echo "${icon} ${capacity}%"
