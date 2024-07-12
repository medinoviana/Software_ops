#!/bin/bash

# Membersihkan aturan-aturan iptables yang ada
iptables -F
iptables -X

# Mengizinkan semua koneksi keluar
iptables -P OUTPUT ACCEPT

# Mengizinkan koneksi masuk ke port 22 (SSH), 80 (HTTP), dan 443 (HTTPS)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Menolak semua koneksi masuk lainnya
iptables -P INPUT DROP

# Menyimpan konfigurasi iptables
iptables-save > /etc/iptables/rules.v4

echo "Konfigurasi firewall berhasil diterapkan."
