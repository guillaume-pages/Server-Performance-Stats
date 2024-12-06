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

echo "CPU Usage: $CPU%"
done