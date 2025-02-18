# Written by saperez for use of automating Azure resource deployment via Azure CLI
az login

# Create variables
$adminUsername = Read-Host -Prompt "Enter an admin username to use"
$adminPassword = Read-Host -Prompt "Enter an admin password to use" 
$resourceGroup = "$adminUsername-rg"
$vnetName = “$adminUsername-vnet-1”
$vmName = Read-Host -Prompt "Enter a name for the VM"
$location = "westus2"
# If publicIp is empty, there is no entry for public IP SSH access 
$publicIp = Read-Host -Prompt "Enter your public IP address for SSH access"
$vmSize = "Standard_B2s" # 2vCPU, 4GB RAM Azure VM

# create resource group in the given location "westus2"
az group create -g $resourceGroup --location $location

# new virtual network
az network vnet create -g $resourceGroup -n "$adminUsername-vnet-1" --subnet-name "subnet-1"

# adds 4 network address ranges, though we won't be using them all
az network vnet update -g $resourceGroup -n $vnetName --address-prefixes 10.0.0.0/16 10.10.0.0/16 10.20.0.0/16 10.30.0.0/16

# Assign subnet 2 to 10.10.0.0/16
az network vnet subnet create -n "subnet-2" -g $resourceGroup --vnet-name $vnetName --address-prefixes 10.10.0.0/16

# network security group
az network nsg create -g $resourceGroup -n $vmname-nsg --location $location

# NSG rule that allows SSH only from source IP address
az network nsg rule create --resource-group $resourceGroup --nsg-name "$vmname-nsg" --name "AllowSSH" --protocol "TCP" --priority 1000 --destination-port-ranges 22 --access "Allow" --source-address-prefixes $publicIp --destination-address-prefixes "*"

# NSG rule that opens UDP port 34197 to allow connectivity
az network nsg rule create --resource-group $resourceGroup --nsg-name "$vmname-nsg" --name "AllowFactorio" --protocol "UDP" --priority 1010 --destination-port-ranges 34197 --access "Allow" --source-address-prefixes "*" --destination-address-prefixes "*"

# Create NIC based on vnet settings and newly created subnet 2
az network nic create -g $resourceGroup -n "$vmName-nic" --vnet-name "$adminUsername-vnet-1" --subnet "subnet-2" --network-security-group "$vmName-nsg"

# We need a dynamic public IP address
az network public-ip create -g $resourceGroup -n “$adminUsername-publicIP” --version IPv4 --sku Standard # will need to specify zones in the near future

# associate the public IP address with the nic
az network nic ip-config update -g $resourceGroup --nic-name "$vmName-nic" --name "ipconfig1" --public-ip-address "$adminUsername-publicIP"

# Since the created nic has the specified network, subnet, and nsg rules, just attach the nic to this VM. 
# Specify storage sku and storage size (premium ssd is default)
az vm create `
-g $resourceGroup `
-n $vmName `
--size $vmSize `
--nics "$vmName-nic" `
--image "Ubuntu2204" `
--storage-sku Standard_LRS `
--os-disk-size-gb 32 `
--admin-username $adminUsername `
--admin-password $adminPassword `
--generate-ssh-keys `
--custom-data init_script.sh `

# Auto shutdown VM at 9:00PM
az vm auto-shutdown -g $resourceGroup -n $vmName --time 2100

# Get the public IP address of the VM for use with SSH
$publicIpAddress = az vm show --resource-group $resourceGroup --name $vmName -d --query publicIps -o tsv
Write-Output "Public IP Address for SSH: $publicIpAddress"
Write-Output "Login using: $adminUsername@$publicIPAddress"

# Power off and stop the VM with the following command:
Write-Output "If you wish to stop the VM, use: az vm deallocate -g $resourceGroup -n $vmName"
