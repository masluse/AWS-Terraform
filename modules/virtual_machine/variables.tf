# Variable definitions with descriptions that need to be accurate and specific.

variable "name" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "type" {
  type        = string
  description = "The instance type of the Virtual Machine"
}

variable "image" {
  type        = string
  description = "The image ID or name for the Virtual Machine"
}

variable "disk_size" {
  type        = string
  description = "The size of the root disk for the Virtual Machine in GB"
}

variable "disk_type" {
  type        = string
  description = "The type of the root disk (e.g., gp2, io1)"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the Virtual Machine will be placed"
}

variable "key_pair" {
  type        = string
  description = "The name of the key pair for SSH access to the Virtual Machine"
}

variable "security_groups" {
  type        = string
  description = "The ID of the security group(s) associated with the Virtual Machine"
}

variable "ssh_user" {
  type        = string
  description = "The default SSH username for the Virtual Machine"
}
