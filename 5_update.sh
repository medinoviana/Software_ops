#!/bin/bash

# Cek package manager yang tersedia
if command -v apt-get &> /dev/null; then
    PM="apt-get"
    UPDATE_CMD="update"
    UPGRADE_CMD="upgrade -y"
    LOG_FILE="/var/log/update_script.log"
elif command -v yum &> /dev/null; then
    PM="yum"
    UPDATE_CMD="check-update"
    UPGRADE_CMD="update -y"
    LOG_FILE="/var/log/update_script.log"
elif command -v dnf &> /dev/null; then
    PM="dnf"
    UPDATE_CMD="check-update"
    UPGRADE_CMD="upgrade -y"
    LOG_FILE="/var/log/update_script.log"
elif command -v zypper &> /dev/null; then
    PM="zypper"
    UPDATE_CMD="refresh"
    UPGRADE_CMD="update -y"
    LOG_FILE="/var/log/update_script.log"
else
    echo "Error: package manager tidak support."
    exit 1
fi

# Perbaharui paket menggunakan package manager yang sesuai
echo "Proses update dimulai pada $(date)" >> "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

sudo "$PM" "$UPDATE_CMD" >> "$LOG_FILE" 2>&1
sudo "$PM" "$UPGRADE_CMD" >> "$LOG_FILE" 2>&1

echo "==========================================" >> "$LOG_FILE"
echo "Proses update selesai pada $(date)" >> "$LOG_FILE"

echo "Update telah selesai."
echo "Detail proses: $LOG_FILE"
