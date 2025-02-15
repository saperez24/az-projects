# az-projects
Azure projects created by me, showcasing the power of the Azure Platform

# vmfleetcommander | Factorio
Automates the deployment of an Ubuntu VM in Azure and sets up a Factorio server. 
This script creates a resource group based on a given name (user prompt), a virtual network, separate subnets, NICs, NSG rules, dynamic IP address (for SSH access), and an auto power off at 2100 rule (9:00PM PST). UDP port 34197 is also opened publicly using an NSG rule. 

A user prompt: `$publicIp` is used to create an NSG rule that only allows for SSH access into your VM from your public IP address. 

On deployment, this runs a bash script `server_config.sh` and ensures the latest updates are available/installed. 
`fail2ban` is also installed. 

Download the latest Factorio headless [server files](https://factorio.com/get-download/stable/headless/linux64) using `wget`.
Extract the downloaded folder contents and generate a new save file. Start the server and test connectivity. 

Server specs:
- Standard B2s [2 vCPU]
- 4GB RAM
- 32GB Standard HDD LRS

*Skills Measured*:
- Networking
- Server configuration and automation with scripts

## TO DO
Add SSH private key (or public key) to Azure Key Vault for more secure access to VM. 