#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
UNIQUE_STRING="$1"
USERNAME="$2"
AUTH_KEYS_FILE="/home/$USERNAME/.ssh/authorized_keys"

# Cek apakah file authorized_keys ada dan dapat diakses
if [ ! -f "$AUTH_KEYS_FILE" ]; then
    echo "Error: File authorized_keys untuk user $USERNAME tidak ditemukan."
    exit 1
fi

# Backup original authorized_keys file
cp "$AUTH_KEYS_FILE" "$AUTH_KEYS_FILE.bak"

# Menghapus public key yang mengandung unique string dari authorized_keys
grep -v "$UNIQUE_STRING" "$AUTH_KEYS_FILE" > "$AUTH_KEYS_FILE.tmp"
mv "$AUTH_KEYS_FILE.tmp" "$AUTH_KEYS_FILE"

echo "Public key yang mengandung '$UNIQUE_STRING' telah dihapus dari $AUTH_KEYS_FILE untuk user $USERNAME."
