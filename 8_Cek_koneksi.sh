#!/bin/bash

# Cek jumlah argumen yang diberikan
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <ip_address>"
    exit 1
fi

# Buat variabel untuk menyimpan argumen
USERNAME="$1"
IP_ADDRESS="$2"

# Mencoba melakukan koneksi SSH dan menangani pesan keluarannya
ssh -q -o BatchMode=yes -o ConnectTimeout=5 "$USERNAME@$IP_ADDRESS" "echo Koneksi SSH Berhasil" &> /dev/null

# Memeriksa kode keluar dari SSH
if [ $? -eq 0 ]; then
    echo "Koneksi SSH ke $USERNAME@$IP_ADDRESS berhasil."
else
    echo "Koneksi SSH ke $USERNAME@$IP_ADDRESS gagal."
fi
