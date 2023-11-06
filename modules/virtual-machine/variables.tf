variable "name" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "type" {
  type        = string
  description = "Virtual Machine type"
}

variable "image" {
  type        = string
  description = "Image of Virtual Machine"
}

variable "disk_size" {
  type        = string
  description = "Disk size of disk"
}

variable "disk_type" {
  type        = string
  description = "Disk type"
}

variable "subnet_id" {
  type        = string
  description = "Disk type"
}

variable "key_pair" {
  type        = string
  description = "Disk type"
}