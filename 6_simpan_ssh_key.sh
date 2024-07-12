#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Buat parameter direktori key
KEY_DIR="$1"

# Membuat direktori jika belum ada
mkdir -p "$KEY_DIR"

# Cek apakah direktori berhasil dibuat
if [ ! -d "$KEY_DIR" ]; then
    echo "Error: Gagal buat direktori '$KEY_DIR'."
    exit 1
fi

# Generate SSH key
ssh-keygen -t rsa -b 4096 -f "$KEY_DIR/id_rsa" -N ""

# Cek keberhasilan pembuatan kunci
if [ $? -ne 0 ]; then
    echo "Error: Gagal generate SSH key."
    exit 1
fi

echo "SSH key berhasil digenerate."
echo "Public key: $KEY_DIR/id_rsa.pub"
echo "Private key: $KEY_DIR/id_rsa"
