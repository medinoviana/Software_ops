#!/bin/bash

# IP Address, Gateway, dan DNS Servers
IP_ADDRESS="192.168.1.100/24"
GATEWAY="192.168.1.1"
DNS_SERVERS="8.8.8.8 8.8.4.4"

# Path menuju file konfigurasi netplan
NETPLAN_FILE="/etc/netplan/01-netcfg.yaml"

# Membuat atau mengedit file konfigurasi netplan
cat << EOF > "$NETPLAN_FILE"
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - $IP_ADDRESS
      gateway4: $GATEWAY
      nameservers:
        addresses:
          - $DNS_SERVERS
EOF

# Menjalankan perintah netplan untuk menerapkan konfigurasi baru
netplan apply

echo "Konfigurasi IP address, gateway, dan DNS pada eth0 telah diterapkan."
