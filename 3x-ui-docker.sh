#!/bin/bash
#based on https://openode.ru/topic/529-3x-ui-xray-shadowsocks-kak-zamena-wireguard-docker-edition/?do=findComment&comment=1783&_rid=574

# Ask for domain name
read -p "Please enter your domain name: " domain_name

# Install docker-compose
apt install docker-compose -y

# Clone the YML file from GitHub
mkdir -p 3x-ui
wget -P 3x-ui https://github.com/MHSanaei/3x-ui/raw/main/docker-compose.yml

# Edit docker-compose.yml file parameters
cat > 3x-ui/docker-compose.yml << EOF
version: '3'
services:
  3x-ui:
    image: ghcr.io/mhsanaei/3x-ui:latest
    container_name: 3x-ui
    hostname: $domain_name
    volumes:
      - "./db/:/etc/x-ui/"
      - "/etc/letsencrypt/live/$domain_name/fullchain.pem:/root/cert/fullchain.pem"
      - "/etc/letsencrypt/live/$domain_name/privkey.pem:/root/cert/privkey.pem"
    environment:
      XRAY_VMESS_AEAD_FORCED: "false"
    tty: true
    network_mode: host
    restart: unless-stopped
EOF

# Create symlinks to the certificate files
mkdir -p 3x-ui/cert
ln -s /etc/letsencrypt/live/$domain_name/fullchain.pem 3x-ui/cert/fullchain.pem
ln -s /etc/letsencrypt/live/$domain_name/privkey.pem 3x-ui/cert/privkey.pem

# Install certbot
apt install certbot -y

# Download and make the script executable
wget https://github.com/joohoi/acme-dns-certbot-joohoi/raw/master/acme-dns-auth.py
chmod +x acme-dns-auth.py

# Start the certificate acquisition process with certbot
certbot certonly --manual --manual-auth-hook ./acme-dns-auth.py --preferred-challenges dns --debug-challenges -d $domain_name

# Get Python version
python_version=$(python3 --version | awk '{print $2}')

# Update shebang in the script
if [[ -n "$python_version" ]]; then
    sed -i "1s|.*|#!/usr/bin/env python$python_version|" /etc/letsencrypt/acme-dns-auth.py
else
    echo "Python is not installed. Please install Python and try again."
fi

# Set file permissions in the keys folder
chmod -R 0644 /etc/letsencrypt/live/$domain_name

# Start the container
cd 3x-ui
docker-compose up -d
