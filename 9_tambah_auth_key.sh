#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
PUBLIC_KEY_FILE="$1"
USERNAME="$2"
AUTH_KEYS_FILE="/home/$USERNAME/.ssh/authorized_keys"

# Cek apakah file public key ada dan dapat diakses
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: File public key '$PUBLIC_KEY_FILE' tidak ditemukan."
    exit 1
fi

# Membuat direktori .ssh dan file authorized_keys jika belum ada
mkdir -p /home/$USERNAME/.ssh
touch "$AUTH_KEYS_FILE"

# Menambahkan public key ke authorized_keys
cat "$PUBLIC_KEY_FILE" >> "$AUTH_KEYS_FILE"
echo "Public key ditambahkan ke $AUTH_KEYS_FILE untuk user $USERNAME."
