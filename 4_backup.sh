#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
SOURCE_DIR="$1"
BACKUP_DIR="$2"

# Cek apakah direktori sumber ada
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Direktori sumber '$SOURCE_DIR' tidak ditemukan."
    exit 1
fi

# Buat direktori backup jika belum ada
mkdir -p "$BACKUP_DIR"

# Direktori untuk backup harus ada
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Direktori backup '$BACKUP_DIR' tidak bisa dibuat atau diakses."
    exit 1
fi

# Nama file untuk backup dengan timestamp
BACKUP_NAME="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Lakukan backup dengan tar
tar -czf "$BACKUP_NAME" "$SOURCE_DIR"

# Cek apakah backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup sukse: $BACKUP_NAME"
else
    echo "Backup gagal."
    exit 1
fi

# Menghapus backup yang lebih tua dari 7 hari
find "$BACKUP_DIR" -type f -name 'backup_*.tar.gz' -mtime +7 -exec rm {} \;

# Informasi mengenai penghapusan backup lama
echo "Backup lama lebih dari 7 hari telah dihapus"

exit 0
