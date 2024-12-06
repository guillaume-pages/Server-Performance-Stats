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

    df_output=$(df -B1 --total | tail -1)

    total_space=$(echo $df_output | awk '{print $2}')
    used_space=$(echo $df_output | awk '{print $3}')
    free_space=$(echo $df_output | awk '{print $4}')

    percent_used=$(awk "BEGIN {print ($used_space / $total_space) * 100}")

    total_space_human=$(echo "$total_space" | awk '{printf "%.2f", $1 / (1024^3)}')
    used_space_human=$(echo "$used_space" | awk '{printf "%.2f", $1 / (1024^3)}')
    free_space_human=$(echo "$free_space" | awk '{printf "%.2f", $1 / (1024^3)}')

    echo -e "CPU Usage: $CPU%\n"
    echo -e "Memory total : $((MEM_TOTAL / 1024)) MB"
    echo -e "Memory used : $((MEM_USED / 1024)) MB"
    echo -e "Memory free : $((MEM_AVAILABLE / 1024)) MB"
    echo -e "Percentage memory used : $PERCENT_USED%\n"
    echo -e "Total Disk Space: $total_space_human GB"
    echo -e "Used Disk Space: $used_space_human GB"
    echo -e "Free Disk Space: $free_space_human GB"
    echo -e "Disk Usage: $percent_used%\n"

    echo -e "\n==== Top 5 Processes by CPU Usage ===="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6

    echo -e "\n==== Top 5 Processes by Memory Usage ===="
    ps -eo pid,comm,%mem --sort=-%mem | head -6

    echo -e "============================="

    sleep 1
done
