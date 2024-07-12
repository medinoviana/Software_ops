#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
DIRECTORY="$1"

# Cek apakah direktori ada
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Direktori '$DIRECTORY' tidak ditemukan."
    exit 1
fi

# Header untuk tabel hasil
printf "%-30s | %-10s | %-10s | %-10s\n" "File" "Baris" "Kata" "Karakter"
printf "%-30s | %-10s | %-10s | %-10s\n" "------------------------------" "----------" "----------" "----------"

# Loop untuk menghitung statistik untuk setiap file teks di dalam direktori
for file in "$DIRECTORY"/*.txt; do
    if [ -f "$file" ]; then
        line=$(wc -l < "$file")
        word=$(wc -w < "$file")
        char=$(wc -m < "$file")
        printf "%-30s | %-10s | %-10s | %-10s\n" "$(basename "$file")" "$line" "$word" "$char"
    fi
done

exit 0
