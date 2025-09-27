#!/usr/bin/env bash
#
# network.sh — show Wi-Fi SSID and IPv4 address for i3blocks

# find the first Wi-Fi interface (via `iw dev`)
iface=$(iw dev | awk '/Interface/ {print $2; exit}')
if [[ -z $iface ]]; then
  echo "睊 No Wi-Fi"
  exit 0
fi

# check if it's up
if ! ip link show "$iface" | grep -q "state UP"; then
  echo "睊 ${iface} down"
  exit 0
fi

# get SSID
ssid=$(iw dev "$iface" link | awk '/SSID:/ { $1=""; sub(/^ +/,""); print }')
if [[ -z $ssid ]]; then
  echo "睊 disconnected"
  exit 0
fi

# get IPv4 address
# ipaddr=$(ip -4 addr show dev "$iface" |
#   awk '/inet/ { sub(/\/.*/, "", $2); print $2 }')
#
# final output: Wi-Fi icon, SSID, IP
# echo " ${ssid} ${ipaddr}"

echo " ${ssid}"
