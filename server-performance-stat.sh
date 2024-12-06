#!/bin/bash
while true; do
PREVIOUS=($(head -n 1 /proc/stat | awk '{for (i=2;i<=NF;i++) print $i}'))

sleep 1

CURRENT=($(head -n 1 /proc/stat | awk '{for (i=2;i<=NF;i++) print $i}'))

TOTAL=0
IDLE=0

for i in "${!CURRENT[@]}"; do
  DIFF[i]=$((CURRENT[i] - PREVIOUS[i]))
  TOTAL=$((TOTAL + DIFF[i]))
  [[ $i -eq 3 ]] && IDLE=${DIFF[i]}
done

CPU=$((100 * (TOTAL - IDLE) / TOTAL))

MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))

PERCENT_USED=$((MEM_USED * 100 / MEM_TOTAL))

echo "CPU Usage: $CPU%"

echo "Memory total : $((MEM_TOTAL / 1024)) MB"
echo "Memory used : $((MEM_USED / 1024)) MB"
echo "Memory free : $((MEM_AVAILABLE / 1024)) MB"
echo "Percentage of memory used : $PERCENT_USED%"
done
