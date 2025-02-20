# variables.tf
variable "admin_username" {
  description = "Admin username for the VM"
}

variable "admin_password" {
  description = "Admin password for the VM"
  sensitive   = true
}

variable "vm_name" {
  description = "Name of the virtual machine"
}

variable "location" {
  description = "Azure Location for resources"
  default     = "westus2"
}

variable "public_ip" {
  description = "Public IP address for SSH access"
  default     = null
}

variable "init_script" {
  description = "User data script for initializing the VM"
  default     = "init_script.sh"
}