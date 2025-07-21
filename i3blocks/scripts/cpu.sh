#!/usr/bin/env bash
#
# cpu.sh — show total CPU usage in percent for i3blocks

# read the first “cpu” line into an array
read -ra cpu_prev </proc/stat
# cpu_prev[0] is the literal “cpu”, fields 1…n are times
# idle = idle + iowait = fields 4 + 5
prev_idle=$((cpu_prev[4] + cpu_prev[5]))
# total_prev = sum of all time fields (exclude the label)
prev_total=0
for val in "${cpu_prev[@]:1}"; do
  prev_total=$((prev_total + val))
done

# wait a bit
sleep 0.5

# read again
read -ra cpu_now </proc/stat
idle=$((cpu_now[4] + cpu_now[5]))
total=0
for val in "${cpu_now[@]:1}"; do
  total=$((total + val))
done

# compute deltas
idle_delta=$((idle - prev_idle))
total_delta=$((total - prev_total))

# avoid division by zero
if ((total_delta > 0)); then
  usage=$(((total_delta - idle_delta) * 100 / total_delta))
else
  usage=0
fi

echo "CPU ${usage}%"
