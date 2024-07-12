#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 1 ]; then
    echo "Usage: $0 <script_name>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
SCRIPT_NAME="$1"
SERVICE_NAME="${SCRIPT_NAME%.*}"  # Mengambil nama service dari nama script tanpa ekstensi

# Cek apakah script Python ada
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "Error: Script '$SCRIPT_NAME' tidak ditemukan."
    exit 1
fi

# Path menuju direktori systemd
SYSTEMD_DIR="/etc/systemd/system"

# Path menuju service file
SERVICE_FILE="$SYSTEMD_DIR/$SERVICE_NAME.service"

# Buat file systemd service
cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Python Service: $SERVICE_NAME
After=network.target

[Service]
ExecStart=/usr/bin/env python3 $SCRIPT_NAME
WorkingDirectory=$(dirname $(realpath $SCRIPT_NAME))
StandardOutput=inherit
StandardError=inherit
Restart=always
User=nobody

[Install]
WantedBy=multi-user.target
EOF

# Memberikan izin untuk file systemd service
chmod 644 "$SERVICE_FILE"

echo "File systemd service untuk $SERVICE_NAME telah dibuat di $SERVICE_FILE"
