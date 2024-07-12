#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <action> <service_name>"
    echo "Actions: start, stop, status"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
ACTION="$1"
SERVICE_NAME="$2"

# Cek apakah service name valid
if ! systemctl list-unit-files --type=service | grep -q "^$SERVICE_NAME.service"; then
    echo "Error: Service '$SERVICE_NAME' tidak ditemukan."
    exit 1
fi

# Fungsi untuk memulai service
start_service() {
    sudo systemctl start "$SERVICE_NAME"
}

# Fungsi untuk menghentikan service
stop_service() {
    sudo systemctl stop "$SERVICE_NAME"
}

# Fungsi untuk memeriksa status service
check_status() {
    sudo systemctl status "$SERVICE_NAME"
}

# Memproses tindakan berdasarkan argumen
case "$ACTION" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        check_status
        ;;
    *)
        echo "Invalid. Aksi yang didukung: start, stop, status"
        exit 1
        ;;
esac

exit 0
