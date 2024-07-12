#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 3 ]; then
    echo "Usage: $0 <file_source> <username> <ip_address>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
FILE_SOURCE="$1"
USERNAME="$2"
IP_ADDRESS="$3"

# Cek apakah file source ada
if [ ! -f "$FILE_SOURCE" ]; then
    echo "Error: File '$FILE_SOURCE' tidak ditemukan."
    exit 1
fi

# Melakukan transfer file menggunakan scp
scp "$FILE_SOURCE" "$USERNAME@$IP_ADDRESS:~"

# Memeriksa keberhasilan transfer
if [ $? -eq 0 ]; then
    echo "File '$FILE_SOURCE' berhasil disalin ke $USERNAME@$IP_ADDRESS:~"
else
    echo "Error: Gagal untuk menyalin file '$FILE_SOURCE' ke $USERNAME@$IP_ADDRESS"
fi
