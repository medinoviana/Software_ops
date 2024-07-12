#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <ip_address>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
PUBLIC_KEY_FILE="$1"
USERNAME="$2"
IP_ADDRESS="$3"

# Cek apakah file public key ada dan dapat diakses
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: File public key '$PUBLIC_KEY_FILE' tidak ditemukan."
    exit 1
fi

# Menyalin public key ke server remote menggunakan ssh-copy-id
ssh-copy-id -i "$PUBLIC_KEY_FILE" "$USERNAME@$IP_ADDRESS"

# Memeriksa keberhasilan
if [ $? -ne 0 ]; then
    echo "Error: Gagal menyalin public key ke server remote."
    exit 1
fi

echo "Public key berhasil disalin ke server remote."
