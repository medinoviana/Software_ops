#!/bin/bash

# Path untuk file log
LOG_FILE="/var/log/cpu_monitor.log"

# Ambil penggunaan CPU rata-rata dalam 1 menit
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $1}' | awk '{$1=$1};1')

# Ambil nilai load average sebagai float
LOAD_AVG_FLOAT=$(echo $LOAD_AVG | awk '{print $1}')

# Ambil nilai threshold untuk log (75% dari jumlah core CPU)
TRESHOLD=$(grep -c ^processor /proc/cpuinfo)
TRESHOLD_FLOAT=$(echo "scale=2; $TRESHOLD * 0.75" | bc)

# Cek apakah load average melebihi threshold
if (( $(echo "$LOAD_AVG_FLOAT > $TRESHOLD_FLOAT" | bc -l) )); then
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "Penggunaan CPU tinggi terdeteksi pada $TIMESTAMP - 1 minute load average: $LOAD_AVG_FLOAT (Threshold: $TRESHOLD_FLOAT)" >> "$LOG_FILE"
fi
