#!/bin/bash

# Make sure updates are installed and install fail2ban
sudo apt update && apt upgrade -y
sudo apt install fail2ban -y

# Factorio headless server link
# Download the server files as a TAR file, then extract it.
# The extracted folder is named 'factorio'
url='https://factorio.com/get-download/stable/headless/linux64'
filename='factorio_headless.tar.gz'
wget -O $filename $url  
tar -xf $filename

# Create factorio save file
./factorio/bin/x64/factorio --create ./saves/my-save.zip

# Run the server
./factorio/bin/x64/factorio --start-server ./saves/my-save.zip