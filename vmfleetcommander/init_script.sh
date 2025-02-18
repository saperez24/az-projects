#!/bin/bash

# Check for new updates and install net-tools & fail2ban
sudo apt update
sudo apt install -y net-tools fail2ban

# Output public IP address of VM in blue text
LB='\033[1;34m'
NC='\033[0m'
publicIP="$(curl https://ipinfo.io/ip)"
echo -e "Public IP address is: ${LB}$publicIP${NC}"

# Factorio headless server link
# Download the server files as a TAR file in folder "/opt/", then extract it.
# The extracted folder is named 'factorio'
cd /opt/
url='https://factorio.com/get-download/stable/headless/linux64'
filename='factorio_headless.tar.gz'
sudo wget -O $filename $url  
sudo tar -xf $filename

# Create factorio user and assign the new directory to it
useradd factorio
chown -R factorio:factorio /opt/factorio

# Run the server to create save file
./factorio/bin/x64/factorio --create saves/my-save.zip

# Go Home
cd 
# Server binary is located at /opt/factorio/bin/x64/factorio
# Save command to a startup script
echo "/opt/factorio/bin/x64/factorio --start-server /opt/saves/my-save.zip" >> server_start.sh
chmod +x server_start.sh