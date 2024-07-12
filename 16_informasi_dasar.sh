#!/bin/bash

# Menampilkan nama host
HOST_NAME=$(hostname)
echo "Hostname: $HOST_NAME"

# Menampilkan waktu sistem saat ini
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current Time: $CURRENT_TIME"

# Menampilkan jumlah pengguna yang sedang login
LOGIN_USER=$(who | wc -l)
echo "Log in users: $LOGIN_USER"
