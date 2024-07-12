#!/bin/bash

# Path untuk file log
LOG_FILE="/var/log/disk_monitor.log"

# Ambil penggunaan disk dan filter hanya baris yang mengandung mount point '/'
DISK_USAGE=$(df -h / | tail -n 1 | awk '{print $5}' | sed 's/%//')

# Threshold penggunaan disk (80%)
TRESHOLD=80

# Cek apakah penggunaan disk melebihi threshold
if [ "$DISK_USAGE" -gt "$TRESHOLD" ]; then
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "Penggunaan disk yang tinggi terdeteksi pada $TIMESTAMP - Penggunaan disk: $DISK_USAGE%" >> "$LOG_FILE"

    # Kirim notifikasi via email menggunakan sendmail
    echo "Subject: High Disk Usage Alert
    Penggunaan disk yang tinggi terdeteksi pada server.

    Penggunaan Disk: $DISK_USAGE%

    Mohon segera lakukan tindakan." | /usr/sbin/sendmail -v recipient@example.com
fi
