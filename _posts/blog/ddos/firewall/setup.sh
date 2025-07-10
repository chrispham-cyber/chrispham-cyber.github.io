#!/bin/bash

set -e

echo "[+] Starting firewall configuration..."

# === CONFIGURABLE ===
SSH_PORT=22
SSH_WHITELIST_IP="127.0.0.1"  # 🔁 Replace this

# === Install UFW if missing ===
if ! command -v ufw &> /dev/null; then
    echo "[+] Installing UFW..."
    sudo apt-get update && sudo apt-get install ufw -y
fi

# === Default rules ===
sudo ufw default deny incoming
sudo ufw default allow outgoing

# === Allow essential ports ===
echo "[+] Allowing web traffic..."
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS

echo "[+] Allowing SSH only from $SSH_WHITELIST_IP..."
sudo ufw allow from $SSH_WHITELIST_IP to any port $SSH_PORT proto tcp

# === Enable UFW ===
echo "[+] Enabling firewall..."
sudo ufw --force enable

# === Advanced iptables rules ===
echo "[+] Applying iptables anti-DDoS rules..."

# 🔓 Allow loopback traffic (critical for localhost:5000)
sudo iptables -I INPUT 1 -i lo -j ACCEPT
sudo iptables -I OUTPUT 1 -o lo -j ACCEPT

# 🛑 Drop invalid packets
sudo iptables -A INPUT -m state --state INVALID -j DROP

# 🛡️ Drop TCP packets that are new but not SYN (basic SYN flood)
sudo iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

# 📉 Limit concurrent HTTP connections per IP
sudo iptables -A INPUT -p tcp --dport 80 -m connlimit --connlimit-above 20 -j REJECT

# ⛔ Rate limit HTTP new connections (30 hits/sec max)
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --update --seconds 1 --hitcount 30 -j DROP

# === Save iptables rules ===
if command -v netfilter-persistent &> /dev/null; then
    sudo netfilter-persistent save
else
    echo "[+] Installing iptables persistence..."
    sudo apt-get install iptables-persistent -y
    sudo netfilter-persistent save
fi

echo "[✓] Firewall rules applied successfully."
