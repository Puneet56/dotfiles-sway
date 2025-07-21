#!/usr/bin/env bash
# show used/total in GB
read -r _ total used _ < <(free -g | awk '/^Mem:/ {print}')
echo "RAM ${used}/${total}G"
