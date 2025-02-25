# az-projects
Azure projects created by me, showcasing my abilities to use the Azure Platform
Many of these (soon to be more) projects are proofs of concepts. It all starts with "if I could use Azure to do this, how could it be done?", then going from there.

# vmfleetcommander | Factorio
Automates the deployment of an Ubuntu VM in Azure and sets up a Factorio server. 
This script creates a resource group based on a given name (user prompt), a virtual network, separate subnets, NICs, NSG rules, dynamic IP address (for SSH access), and an auto power off at 2100 rule (9:00PM PST). UDP port 34197 is also opened publicly using an NSG rule. 

A user prompt: `$publicIp` is used to create an NSG rule that only allows for SSH access into your VM from your public IP address. 

On deployment, this runs a bash script `server_config.sh` and ensures the latest updates are available/installed. 
`fail2ban` and `net-tools` are also installed. 

Download the latest Factorio headless [server files](https://factorio.com/get-download/stable/headless/linux64) using `wget`.
Extract the downloaded folder contents and generate a new save file. Start the server and test connectivity. NOTE: `the mod_list.json` file in the `mods` folder may need to be tweaked. Some mods are on by default, though these are paid expansions.

Server specs:
- Standard B2s [2 vCPU]
- 4GB RAM
- 32GB Standard HDD LRS

*Skills Measured*:
- Automated VM deployment/configuration using Powershell. Specify VM size/SKU, disk size, and OS image.
- Server configuration and automation with Bash scripts.
- Understanding of networking principles, as Network Security Groups (NSG), Azure Virtual Networks (VNet), subnets, and network interfaces (NIC).
- Knowledge of cost optimization strategies: auto-shutting down VMs to save on resources and manage cloud expenses. 
- Infrastructure as Code (IaC) Concepts: Scripting infrastructure deployments instead of relying on Azure GUI. 
- Utilizing Git for version control and managing script versions. 

## TO DO
- Add SSH public key to Azure Key Vault for more secure access to VM. 
- Create an ARM Template to deploy multiple VMs
- Create a VM Scale Set to have better control on the number of VMs as needed. 
- Utilize if/else in Powershell or Bash script. For now, this is fine. 
