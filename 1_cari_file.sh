#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <extension>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
DIR="$1"
EXTENSION="$2"

# Cek apakah direktori ada
if [ ! -d "$DIR" ]; then
    echo "Error: Direktori '$DIR' tidak ditemukan."
    exit 1
fi

# Mencari file dengan ekstensi yang diberikan di dalam direktori
find "$DIR" -type f -name "*.$EXTENSION" -printf "%f\n"

exit 0
