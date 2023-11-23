# Variable definitions with descriptions that need to be accurate and specific.

variable "name" {
  type        = string
  description = "The name of the Virtual Machine"
}

variable "type" {
  type        = string
  description = "The type of the Virtual Machine (e.g., t2.micro)"
}

variable "image" {
  type        = string
  description = "The AMI ID of the Virtual Machine"
}

variable "disk_size" {
  type        = string
  description = "The size of the root disk in GB"
}

variable "disk_type" {
  type        = string
  description = "The type of the root disk (e.g., gp2)"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet in which the Virtual Machine will be deployed"
}

variable "key_pair" {
  type        = string
  description = "The name of the key pair used to access the Virtual Machine"
}

variable "security_groups" {
  type        = string
  description = "The security groups assigned to the Virtual Machine"
}

variable "ssh_user" {
  type        = string
  description = "The SSH user used to access the Virtual Machine"
}
