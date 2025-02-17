#!/bin/bash

# Check for new updates and install net-tools & fail2ban
sudo apt update
sudo apt install net-tools -y
sudo apt install fail2ban -y

# Output public IP address of VM in blue text
LB='\033[1;34m'
NC='\033[0m'
publicIP="$(curl https://ipinfo.io/ip)"
echo -e "Public IP address is: ${LB}$publicIP${NC}"

# Factorio headless server link
# Download the server files as a TAR file, then extract it.
# The extracted folder is named 'factorio'
url='https://factorio.com/get-download/stable/headless/linux64'
filename='factorio_headless.tar.gz'
wget -O $filename $url  
tar -xf $filename

# Create factorio save file
./factorio/bin/x64/factorio --create saves/my-save.zip

# Run the server
./factorio/bin/x64/factorio --start-server saves/my-save.zip