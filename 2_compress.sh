#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# Buat parameter direktori sumber dan lokasi penyimpanan backup
SOURCE_DIR="$1"
BACKUP_DIR="$2"

# Cek apakah direktori sumber ada
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Direktori sumber '$SOURCE_DIR' tidak ditemukan."
    exit 1
fi

# Nama file untuk backup dengan timestamp
BACKUP_NAME="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Lakukan backup dengan tar
tar -czvf "$BACKUP_NAME" "$SOURCE_DIR"

# Cek apakah backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup sukse: $BACKUP_NAME"
else
    echo "Backup gagal."
    exit 1
fi

exit 0
